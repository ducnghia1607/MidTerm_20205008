CREATE DATABASE Production
GO
CREATE TABLE categories
(	
	category_id INT  PRIMARY KEY,
	category_name VARCHAR(30) NOT NULL,
)
GO

CREATE TABLE brands
(
	brand_id INT  PRIMARY KEY,
	brand_name VARCHAR(30) NOT NULL
)
go
CREATE TABLE products
(
	product_id INT PRIMARY KEY,
	product_name VARCHAR(30) NOT NULL,
	brand_id INT NOT NULL,
	category_id int not null,
	model_year smallint not null,
	list_price int not null
)
go

ALTER TABLE products ADD CONSTRAINT FK_1 FOREIGN KEY(category_id) REFERENCES categories(category_id)
ALTER TABLE products ADD CONSTRAINT FK_2 FOREIGN KEY(brand_id) REFERENCES brands(brand_id)

INSERT INTO categories(category_id,category_name) VALUES(1,'Children Bikes')
INSERT INTO categories(category_id,category_name) VALUES(2,'Comfort Bikes')
INSERT INTO categories(category_id,category_name) VALUES(3,'Cruisers Bikes')
INSERT INTO categories(category_id,category_name) VALUES(4,'Woman Bikes')
INSERT INTO categories(category_id,category_name) VALUES(5,'Electric Bikes')
INSERT INTO categories(category_id,category_name) VALUES(6,'Mountain Bikes')
INSERT INTO categories(category_id,category_name) VALUES(7,'Road Bikes')
INSERT INTO categories(category_id,category_name) VALUES(8,'Dirt Bikes')
INSERT INTO categories(category_id,category_name) VALUES(9,'Motor Scooter')
INSERT INTO categories(category_id,category_name) VALUES(10,'Sport Bikes')

INSERT INTO brands(brand_id,brand_name) VALUES(1,'SYM')
INSERT INTO brands(brand_id,brand_name) VALUES(2,'Honda')
INSERT INTO brands(brand_id,brand_name) VALUES(3,'Suzuki')
INSERT INTO brands(brand_id,brand_name) VALUES(4,'Toyata')
INSERT INTO brands(brand_id,brand_name) VALUES(5,'Kia')

INSERT INTO products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(1,'Dream',1,6,2022,10000000)
INSERT INTO products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(2,'Vario',2,2,2022,2000000)
INSERT INTO products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(3,'Vision',3,1,2021,3000000)
INSERT INTO products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(4,'Winner',4,3,2022,200000)
INSERT INTO products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(5,'Sh mode 125',5,7,2016,300000)
INSERT INTO products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(6,'Airblack 150',2,9,2017,700000)
INSERT INTO products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(7,'Exciter 150',3,10,2018,1000000)
INSERT INTO products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(8,'Wave Alpha',4,2,2019,4000000)
INSERT INTO products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(9,'Sirius',1,5,2022,1500000)
INSERT INTO products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(10,'Future',2,4,2023,600000)
INSERT INTO products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(11,'Vespa',3,8,2015,1200000)
INSERT INTO products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(12,'133S',4,9,2016,500000)
INSERT INTO products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(13,'Xmen',5,10,2016,1000000)
INSERT INTO products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(14,'Nouvu',2,2,2017,2100000)
INSERT INTO products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(15,'Jasus',3,3,2016,5000000)
INSERT INTO products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(16,'SYM Star',5,7,2016,3000000)
INSERT INTO products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(17,'Mio',3,6,2016,2700000)
INSERT INTO products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(18,'Passing',2,5,2016,500000)
INSERT INTO products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(19,'UNIQLO',4,1,2016,1300000)
INSERT INTO products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(20,'Xsr 155',4,4,2016,1800000)
UPDATE PRODUCTS SET PRODUCT_NAME ='UNIQLO' WHERE PRODUCT_ID = 19
--------------
-- Tạo  view  có  tên v_product để đưa ra các thông  tin  gồm:product_id, product_name, models_year, list_price, brand_name, category_name.
CREATE VIEW v_product AS
SELECT p.product_id,p.product_name,p.model_year,p.list_price,b.brand_name,c.category_name
FROM products as p,brands as b,categories as c where p.category_id=c.category_id and p.brand_id=b.brand_id
-- Sử dụng view vừa tạo cho biết thông tin các sản phẩm có năm sản xuất là 2022
SELECT * FROM v_product where model_year=2022
-- Sửa đổi view v_product với điều kiện list_price>100000
ALTER VIEW v_product AS 
SELECT p.product_id,p.product_name,p.model_year,p.list_price,b.brand_name,c.category_name
FROM products as p,brands as b,categories as c where p.category_id=c.category_id and p.brand_id=b.brand_id and p.list_price >100000

SELECT * FROM v_product

-- Tạo transaction có tên Viết câu lệnh đưa ra danh sách các khách hàng ở một cơ quan nào đó.
-- Tạo save point có tên SP01 trước khi sử dụng transaction
-- Thực hiện việc cập nhật thêm 100000 vào giá mỗi sản phẩm  product_name có tên UNIQLO và lưu save point có tên SP02

BEGIN TRANSACTION TRAN1
SAVE TRANSACTION SP01

UPDATE products 
SET list_price = list_price + 100000
WHERE product_name ='UNIQLO'
SAVE TRANSACTION SP02
ROLLBACK TRANSACTION SP01
