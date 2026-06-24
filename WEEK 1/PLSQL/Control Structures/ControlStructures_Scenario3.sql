-- Scenario 3: Send reminders to customers whose loans are due within the next 30 days.
SET SERVEROUTPUT ON;

DECLARE
    -- Cursor to fetch loans due within the next 30 days and the corresponding customer's name
    CURSOR c_due_loans IS
        SELECT l.LoanID, l.CustomerID, c.Name, l.EndDate, l.LoanAmount
        FROM Loans l
        JOIN Customers c ON l.CustomerID = c.CustomerID
        WHERE l.EndDate BETWEEN SYSDATE AND SYSDATE + 30;
        
    v_reminders_count NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Executing Scenario 3: Loan Due Reminders (Next 30 Days) ---');
    
    FOR r_loan IN c_due_loans LOOP
        DBMS_OUTPUT.PUT_LINE('REMINDER: Dear ' || r_loan.Name || ' (CustomerID: ' || r_loan.CustomerID || '), ' ||
                             'your Loan (ID: ' || r_loan.LoanID || ') of amount $' || r_loan.LoanAmount || 
                             ' is due on ' || TO_CHAR(r_loan.EndDate, 'YYYY-MM-DD') || '. Please arrange for payment.');
        v_reminders_count := v_reminders_count + 1;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('Scenario 3 Completed. Total reminders generated: ' || v_reminders_count);
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------------------------------');
END;
/
