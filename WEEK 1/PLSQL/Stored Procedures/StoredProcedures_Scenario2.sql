-- Scenario 2: Implement a bonus scheme for employees based on department.
SET SERVEROUTPUT ON;

-- Create Stored Procedure
CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus (
    p_department IN VARCHAR2,
    p_bonus_percentage IN NUMBER
) AS
    v_rows_updated NUMBER := 0;
BEGIN
    -- Validate inputs
    IF p_bonus_percentage IS NULL OR p_bonus_percentage < 0 THEN
        DBMS_OUTPUT.PUT_LINE('Error: Bonus percentage cannot be negative or null.');
        RETURN;
    END IF;
    
    -- Update salaries for employees in the given department
    UPDATE Employees
    SET Salary = Salary * (1 + p_bonus_percentage / 100)
    WHERE Department = p_department;
    
    v_rows_updated := SQL%ROWCOUNT;
    DBMS_OUTPUT.PUT_LINE('Procedure UpdateEmployeeBonus completed. Employees in ' || p_department || ' department updated: ' || v_rows_updated);
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error updating employee bonus: ' || SQLERRM);
        RAISE;
END;
/

-- Verification / Test Block
DECLARE
    CURSOR c_employees IS
        SELECT EmployeeID, Name, Salary, Department
        FROM Employees
        WHERE Department = 'IT';
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Executing Scenario 2: Stored Procedure UpdateEmployeeBonus ---');
    
    DBMS_OUTPUT.PUT_LINE('IT Department Salaries BEFORE running UpdateEmployeeBonus (10% bonus):');
    FOR r IN c_employees LOOP
        DBMS_OUTPUT.PUT_LINE('Employee ID: ' || r.EmployeeID || ' | Name: ' || r.Name || ' | Salary: $' || r.Salary);
    END LOOP;
    
    -- Call the procedure
    UpdateEmployeeBonus('IT', 10);
    
    DBMS_OUTPUT.PUT_LINE('IT Department Salaries AFTER running UpdateEmployeeBonus:');
    FOR r IN c_employees LOOP
        DBMS_OUTPUT.PUT_LINE('Employee ID: ' || r.EmployeeID || ' | Name: ' || r.Name || ' | Salary: $' || r.Salary);
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('Scenario 2 Stored Procedure Execution Completed.');
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------------------------------');
END;
/
