-- Scenario 3: Secure fund transfer between accounts with balance validation.
SET SERVEROUTPUT ON;

-- Create Stored Procedure
CREATE OR REPLACE PROCEDURE TransferFunds (
    p_source_account_id IN NUMBER,
    p_dest_account_id IN NUMBER,
    p_amount IN NUMBER
) AS
    v_source_balance NUMBER;
    v_dummy NUMBER;
    insufficient_funds EXCEPTION;
    invalid_amount EXCEPTION;
    same_account EXCEPTION;
BEGIN
    -- Check for positive amount
    IF p_amount <= 0 THEN
        RAISE invalid_amount;
    END IF;
    
    -- Check that source and destination are different
    IF p_source_account_id = p_dest_account_id THEN
        RAISE same_account;
    END IF;

    -- Verify source account exists and lock row
    BEGIN
        SELECT Balance INTO v_source_balance
        FROM Accounts
        WHERE AccountID = p_source_account_id
        FOR UPDATE;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20002, 'Source account ' || p_source_account_id || ' does not exist.');
    END;

    -- Verify destination account exists and lock row
    BEGIN
        SELECT 1 INTO v_dummy
        FROM Accounts
        WHERE AccountID = p_dest_account_id
        FOR UPDATE;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20003, 'Destination account ' || p_dest_account_id || ' does not exist.');
    END;

    -- Validate sufficient balance
    IF v_source_balance < p_amount THEN
        RAISE insufficient_funds;
    END IF;

    -- Debit source account
    UPDATE Accounts
    SET Balance = Balance - p_amount,
        LastModified = SYSDATE
    WHERE AccountID = p_source_account_id;

    -- Credit destination account
    UPDATE Accounts
    SET Balance = Balance + p_amount,
        LastModified = SYSDATE
    WHERE AccountID = p_dest_account_id;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Transfer Successful: $' || p_amount || ' transferred from Account ID ' || p_source_account_id || ' to Account ID ' || p_dest_account_id);
EXCEPTION
    WHEN insufficient_funds THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20001, 'Insufficient funds in Source Account ID ' || p_source_account_id || 
                                '. Balance: $' || v_source_balance || ', Requested: $' || p_amount);
    WHEN invalid_amount THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20004, 'Invalid Transfer Amount: $' || p_amount || '. Amount must be greater than zero.');
    WHEN same_account THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20005, 'Transfer failed: Source and destination accounts must be different.');
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/

-- Verification / Test Block
DECLARE
    v_balance_before_src NUMBER;
    v_balance_before_dst NUMBER;
    v_balance_after_src NUMBER;
    v_balance_after_dst NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Executing Scenario 3: Stored Procedure TransferFunds ---');
    
    -- Test Case 1: Successful Transfer of $200 from Account 1 to Account 2
    SELECT Balance INTO v_balance_before_src FROM Accounts WHERE AccountID = 1;
    SELECT Balance INTO v_balance_before_dst FROM Accounts WHERE AccountID = 2;
    
    DBMS_OUTPUT.PUT_LINE('TEST CASE 1: Successful Transfer');
    DBMS_OUTPUT.PUT_LINE('Before Transfer - Account 1: $' || v_balance_before_src || ' | Account 2: $' || v_balance_before_dst);
    
    TransferFunds(p_source_account_id => 1, p_dest_account_id => 2, p_amount => 200);
    
    SELECT Balance INTO v_balance_after_src FROM Accounts WHERE AccountID = 1;
    SELECT Balance INTO v_balance_after_dst FROM Accounts WHERE AccountID = 2;
    DBMS_OUTPUT.PUT_LINE('After Transfer  - Account 1: $' || v_balance_after_src || ' | Account 2: $' || v_balance_after_dst);
    
    -- Test Case 2: Unsuccessful Transfer due to Insufficient Funds (try transferring $5000 from Account 1 to Account 2)
    DBMS_OUTPUT.PUT_LINE('TEST CASE 2: Insufficient Funds');
    BEGIN
        TransferFunds(p_source_account_id => 1, p_dest_account_id => 2, p_amount => 5000);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Caught Expected Error: ' || SQLERRM);
    END;
    
    -- Test Case 3: Unsuccessful Transfer due to Invalid Account ID
    DBMS_OUTPUT.PUT_LINE('TEST CASE 3: Non-existent Account');
    BEGIN
        TransferFunds(p_source_account_id => 999, p_dest_account_id => 2, p_amount => 100);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Caught Expected Error: ' || SQLERRM);
    END;

    DBMS_OUTPUT.PUT_LINE('Scenario 3 Stored Procedure Execution Completed.');
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------------------------------');
END;
/
