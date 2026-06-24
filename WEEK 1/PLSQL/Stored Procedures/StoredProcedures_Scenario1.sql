-- Scenario 1: Process monthly interest for all savings accounts.
SET SERVEROUTPUT ON;

-- Create Stored Procedure
CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest AS
    v_rows_updated NUMBER := 0;
BEGIN
    -- Update balance of all savings accounts by applying 1% interest
    UPDATE Accounts
    SET Balance = Balance * 1.01,
        LastModified = SYSDATE
    WHERE AccountType = 'Savings';
    
    v_rows_updated := SQL%ROWCOUNT;
    DBMS_OUTPUT.PUT_LINE('Procedure ProcessMonthlyInterest completed. Savings accounts updated: ' || v_rows_updated);
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error processing monthly interest: ' || SQLERRM);
        RAISE;
END;
/

-- Verification / Test Block
DECLARE
    CURSOR c_savings IS
        SELECT AccountID, CustomerID, Balance, LastModified
        FROM Accounts
        WHERE AccountType = 'Savings';
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Executing Scenario 1: Stored Procedure ProcessMonthlyInterest ---');
    
    DBMS_OUTPUT.PUT_LINE('Balances BEFORE running ProcessMonthlyInterest:');
    FOR r IN c_savings LOOP
        DBMS_OUTPUT.PUT_LINE('Account ID: ' || r.AccountID || ' | CustomerID: ' || r.CustomerID || ' | Balance: $' || r.Balance);
    END LOOP;
    
    -- Call the procedure
    ProcessMonthlyInterest;
    
    DBMS_OUTPUT.PUT_LINE('Balances AFTER running ProcessMonthlyInterest:');
    FOR r IN c_savings LOOP
        DBMS_OUTPUT.PUT_LINE('Account ID: ' || r.AccountID || ' | CustomerID: ' || r.CustomerID || ' | Balance: $' || r.Balance);
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('Scenario 1 Stored Procedure Execution Completed.');
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------------------------------');
END;
/
