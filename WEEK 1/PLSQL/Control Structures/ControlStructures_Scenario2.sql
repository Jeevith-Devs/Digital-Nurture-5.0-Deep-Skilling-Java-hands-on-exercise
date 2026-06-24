-- Scenario 2: Promote a customer to VIP status if their balance is over $10,000.
SET SERVEROUTPUT ON;

DECLARE
    -- Cursor to iterate through all customers
    CURSOR c_customers IS
        SELECT CustomerID, Name, Balance, IsVIP
        FROM Customers;
        
    v_updated_count NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Executing Scenario 2: VIP Status Promotion (Balance > $10,000) ---');
    
    FOR r_cust IN c_customers LOOP
        IF r_cust.Balance > 10000 THEN
            -- Promote to VIP if not already VIP
            IF r_cust.IsVIP IS NULL OR r_cust.IsVIP <> 'TRUE' THEN
                UPDATE Customers
                SET IsVIP = 'TRUE',
                    LastModified = SYSDATE
                WHERE CustomerID = r_cust.CustomerID;
                
                DBMS_OUTPUT.PUT_LINE('Customer Promoted to VIP: ' || r_cust.Name || 
                                     ' | CustomerID: ' || r_cust.CustomerID || 
                                     ' | Balance: $' || r_cust.Balance);
                v_updated_count := v_updated_count + 1;
            END IF;
        ELSE
            -- Ensure non-VIP status if balance is not above $10,000
            IF r_cust.IsVIP = 'TRUE' THEN
                UPDATE Customers
                SET IsVIP = 'FALSE',
                    LastModified = SYSDATE
                WHERE CustomerID = r_cust.CustomerID;
                
                DBMS_OUTPUT.PUT_LINE('Customer Removed from VIP: ' || r_cust.Name || 
                                     ' | CustomerID: ' || r_cust.CustomerID || 
                                     ' | Balance: $' || r_cust.Balance);
                v_updated_count := v_updated_count + 1;
            END IF;
        END IF;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('Scenario 2 Completed. Total VIP status modifications: ' || v_updated_count);
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------------------------------');
    COMMIT;
END;
/
