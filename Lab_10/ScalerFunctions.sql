/* ====================================Part A ======================================*/

--Statement1: List each customer's name with leading and trailing spaces removed, alongside the original. Show CustID, original CustName, CleanedName.

--Query1 select CustID, CustName As Original_Name, Trim(CustName) As Cleaned_Name from Customer;

--Statement2: Display every customer name in UPPERCASE and the same name in lowercase. Show CustID, UpperName, LowerName.

--Query2: select CustID, upper(CustName) As UpperName, lower(CustName) As LowerName from customer;

--Statement3: For each customer, show their trimmed name and the number of characters in it.

--Query3: select trim(CustName) as Trimmed_Name , char_length(CustName) As Lenth from customer;

--Statement4: Build a greeting column for each customer: 'Dear <trimmed name>, welcome!'

--Query4: select concat('Dear ', trim(CustName), ' ,welcome!') from customer;

--Statement5: For customers who have an email, extract the part before the '@' (the username). Show CustName and Username.

--Query5: select custName, substring(Email, locate('@', Email) -5) AS Username from Customer;

--Statement6: For customers who have an email, extract the domain (everything after '@'). Show CustName and Domain.

--Query6:  select custName, Email, substring(Email, locate('@', Email) +1) AS Domain from Customer;

--Statement7: Show each customer's name with the first 3 characters only. (Hint: LEFT.)

--Query7: select left(CustName, 3) from Customer;

--Statement8: Mask each phone number: show the country/area code (first 4 chars), then 'XXX-XXXX'. Skip customers with no phone.

--Query8: select concat(left(phone,4), 'XXXXXXX') As Masked_Phone from Customer where phone is not null;

--Statement9: Show each product name with all spaces replaced by hyphens. Show ProdID and SlugName.

--Query9: select ProdID, Replace(ProdName,' ','-') As Slug_Name from Product;

--Statement10: Show each ProdID padded to 5 digits with leading zeros (e.g. 101 -> '00101').

--Query10: select LPAD(CUSTID, 5, 0) FROM Customer;

--Statement11:  Show product names that contain the word 'Pro' anywhere (use LIKE OR LOCATE) along with the position of 'Pro'.
--Query11: select ProdName , locate('Pro', ProdName) from Product;

--Statement12:  Display every customer's first name only (the part before the first space in the trimmed name). (Hint: SUBSTRING with LOCATE.)
--Query12: SELECT CustID, SUBSTRING(TRIM(CustName), 1, LOCATE(' ', TRIM(CustName)) - 1) AS FirstName FROM Customer WHERE LOCATE(' ', TRIM(CustName)) > 0;