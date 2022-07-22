CREATE DATABASE lab12
go
use lab12
go
CREATE TABLE customers (
    customerid integer NOT NULL,
    firstname character varying(50) NOT NULL,
    lastname character varying(50) NOT NULL,
    address1 character varying(50) NOT NULL,
    address2 character varying(50),
    city character varying(50) NOT NULL,
    state character varying(50),
    zip integer,
    country character varying(50) NOT NULL,
    region smallint NOT NULL,
    email character varying(50),
    phone character varying(50),
    creditcardtype integer NOT NULL,
    creditcard character varying(50) NOT NULL,
    creditcardexpiration character varying(50) NOT NULL,
    username character varying(50) NOT NULL,
    "password" character varying(50) NOT NULL,
    age smallint,
    income integer,
    gender character varying(2)
);
go
CREATE TABLE orders (
    orderid integer NOT NULL,
    orderdate date NOT NULL,
    customerid integer,
    netamount numeric(12,2) NOT NULL,
    tax numeric(12,2) NOT NULL,
    totalamount numeric(12,2) NOT NULL
);
go

CREATE TABLE orderlines (
    orderlineid integer NOT NULL,
    orderid integer NOT NULL,
    prod_id integer NOT NULL,
    quantity smallint NOT NULL,
    orderdate date NOT NULL
);
go
CREATE TABLE products (
    prod_id integer NOT NULL,
    category integer NOT NULL,
    title character varying(50) NOT NULL,
    actor character varying(50) NOT NULL,
    price numeric(12,2) NOT NULL,
    special smallint,
    common_prod_id integer NOT NULL
);
go
CREATE TABLE reorder (
    prod_id integer NOT NULL,
    date_low date NOT NULL,
    quan_low integer NOT NULL,
    date_reordered date,
    quan_reordered integer,
    date_expected date
);
go

CREATE TABLE inventory (
    prod_id integer NOT NULL,
    quan_in_stock integer NOT NULL,
    sales integer NOT NULL
);

CREATE TABLE cust_hist (
    customerid integer NOT NULL,
    orderid integer NOT NULL,
    prod_id integer NOT NULL
);
CREATE TABLE categories (
    category integer NOT NULL,
    categoryname character varying(50) NOT NULL
);

CREATE FUNCTION new_customer(@firstname_in	varchar(50), @lastname_in varchar(50), @address1_in varchar(50), @address2_in varchar(50), @city_in varchar(50), @state_in varchar(50), @zip_in integer, @country_in varchar(50), @region_in integer, @email_in varchar(50), @phone_in varchar(50), @creditcardtype_in integer, @creditcard_in varchar(50), @creditcardexpiration_in varchar(50), @username_in varchar(50), @password_in varchar(50), @age_in integer, @income_in integer, @gender_in varchar(2)) 
RETURNS integer
BEGIN
  DECLARE
    rows_returned INT;
  BEGIN
    SELECT COUNT(*) INTO rows_returned FROM CUSTOMERS WHERE USERNAME = username_in;
    IF rows_returned = 0 THEN
	    INSERT INTO CUSTOMERS
	      (
	      FIRSTNAME,
	      LASTNAME,
	      EMAIL,
	      PHONE,
	      USERNAME,
	      PASSWORD,
	      ADDRESS1,
	      ADDRESS2,
	      CITY,
	      STATE,
	      ZIP,
	      COUNTRY,
	      REGION,
	      CREDITCARDTYPE,
	      CREDITCARD,
	      CREDITCARDEXPIRATION,
	      AGE,
	      INCOME,
	      GENDER
	      )
	    VALUES
	      (
	      @firstname_in,
	      @lastname_in,
	      @email_in,
	      @phone_in,
	      @username_in,
	      @password_in,
	      @address1_in,
	      @address2_in,
	      @city_in,
	      @state_in,
	      @zip_in,
	      @country_in,
	      @region_in,
	      @creditcardtype_in,
	      @creditcard_in,
	      @creditcardexpiration_in,
	      @age_in,
	      @income_in,
	      @gender_in
	      )
	     ;
    select currval(pg_get_serial_sequence(''customers'', ''customerid'')) into customerid_out;
  ELSE 
  	customerid_out := 0;
  END IF;
END
COPY categories (category , categoryname) FROM stdin;
1	Action
2	Animation
3	Children
4	Classics
5	Comedy
6	Documentary
7	Drama
8	Family
9	Foreign
10	Games
11	Horror
12	Music
13	New
14	Sci-Fi
15	Sports
16	Travel