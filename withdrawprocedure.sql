CREATE OR REPLACE PROCEDURE
withdraw(p_accno accounts.accno %TYPE, p_amount number)
AS
  v_balance accounts.balance %type;
BEGIN
   SELECT balance INTO v_balance FROM accounts
   WHERE accno = p_accno;
 
  IF p_amount > v_balance THEN
    raise_application_error(-20050, 'Insufficient Funds');
END if;

UPDATE accounts SET 
balance = balance - p_amount
WHERE accno = p_accno;

commit;
dbms_output.put_line('Withdrawl Successful');
 
dbms_output.put_line('Remaining Balance : ' || (v_balance - p_amount));

  exception
    WHEN no_data_found THEN

      dbms_output.put_line('Invalid accno' || p_accno);

      
   
end;
/
