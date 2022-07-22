use dell_store
go

alter table orderlines add constraint fk_orderlines foreign key(prod_id) references products(prod_id)

alter table products add constraint fk_products foreign key(category) references categories(category)

alter table reorder add constraint fk_reorder foreign key(prod_id) references products(prod_id)

alter table products add constraint fk_products_inven foreign key(prod_id) references inventory(prod_id)

create nonclustered index index_customer2 on customers(country)
select country from customers where country ='Canada'
drop index index_customer1 on customers
drop index customers_pkey on customers

ALTER INDEX customers_pkey 
ON customers 
DISABLE;

ALTER INDEX customers_pkey 
ON customers 
REBUILD;
--2.
create nonclustered index index_order on orders(totalamount)
select * from orders where totalamount >= 300
drop index index_order on orders

--3.
select customers.* from customers inner join (select customerid,sum(totalamount)as total from orders group by (customerid) having sum(totalamount) > 1500) as a 
on a.customerid = customers.customerid;
select * from orderlines

--4:Đưa ra danh sách sản phẩm và số sản phẩm đã đặt 

select * from inventory
select * from orders
select * from orderlines where prod_id = 9990
select * from cust_hist

create index index_orderlines on orderlines(prod_id)
select products.*,a.quantity from products inner join
(select prod_id,sum(quantity) as quantity from orderlines group by (prod_id)) as a 
on a.prod_id = products.prod_id

--5:Viết câu lệnh đưa ra danh sách những khách hàng đã từng đặng hàng 
 select * from customers where customerid in (select customerid from orders)
--6: Viết câu lệnh đưa ra danh sách các sản phẩm chưa từng được đặt 
select * from products where prod_id not in (select prod_id from cust_hist)

--7:Tính tổng giá trị các đơn hàng của mỗi khách hàng 
 select customerid,sum(totalamount) as total from orders group by(customerid)
--8: Tính tổng số lượng mỗi sản phẩm đã được bán 
create nonclustered index index_orderlines_2 on orderlines(prod_id)
select prod_id, sum(quantity) as quantity from orderlines group by(prod_id) order by prod_id ASC


select prod_id,quan_in_stock from inventory 
