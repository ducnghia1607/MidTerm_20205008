
--1.Câu1
create nonclustered index index_customer2 on customers(country)
select country from customers where country ='Canada'
--2.Câu 2
create nonclustered index index_order on orders(totalamount)
select * from orders where totalamount >= 300
drop index index_order on orders
--3.Câu 3
select customers.* from customers inner join (select customerid,sum(totalamount)as total from orders group by (customerid) having sum(totalamount) > 1500) as a 
on a.customerid = customers.customerid;
select * from orderlines

--4:Đưa ra danh sách sản phẩm và số sản phẩm đã đặt 

create index index_orderlines on orderlines(prod_id)
select products.*,a.quantity from products inner join
(select prod_id,sum(quantity) as quantity from orderlines group by (prod_id)) as a 
on a.prod_id = products.prod_id
