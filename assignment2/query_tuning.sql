--1.Hiển thị Title, FirstName, MiddleName, LastNametừ bảng Person.Person
SELECT Title, FirstName, MiddleName, LastName FROM Person.person

--2.Hiển thị Title, FirstName, LastName như là một chuỗi nối nhằm dễ đọc và cung cấp tiêu đề cho cột tên (PersonName). 
SELECT rtrim(concat(FirstName + ' ', MiddleName + ' ', LastName + ' ')) as PersonName FROM Person.Person

--3.Hiển thị chi tiết địa chỉ của tất cả các nhân viên trong bảng Person.Address
select * from Person.Address

--4.Liệt kê tên của các thành phố từ bảng Person.Address và bỏ đi phần lặp lại. 
select distinct city from Person.Address

--5.Hiển thị chi tiết của 10 bảng ghi đầu tiên của bảng Person.Address. 
select top 10 * from Person.Address

--6.Hiển thị trung  bình của tỷ giá (Rate) từ bảng HumanResources.EmployeePayHistory.
select avg(rate) from HumanResources.EmployeePayHistory

--7.Hiển thị tổng số nhân viên từ bảng HumanResources.Employee 
select count(*) from HumanResources.Employee

--8.Đưa ra danh sách các khách hàng có trên 10 đơn hàng
select * from Person.Person as e inner join (select d.BusinessEntityID, count(a.OrderQty) as quantity from Sales.SalesOrderDetail as a
inner join Sales.SalesOrderHeader as b on a.SalesOrderID = b.SalesOrderID
inner join Sales.Customer as c on c.CustomerID = b.CustomerID
inner join Person.Person as d on c.PersonID = d.BusinessEntityID
group by d.BusinessEntityID having count(a.OrderQty) > 10) as f on e.BusinessEntityID = f.BusinessEntityID

--9.Đưa ra danh sách các mặt hàng chưa từng được đặt hàng
select * from Production.Product as c inner join (select count(b.OrderQty) as quantity, a.ProductID from Production.Product as a 
 full outer join Sales.SalesOrderDetail as b
 on a.ProductID = b.ProductID group by a.ProductID
having count(b.OrderQty) < 1) as d on c.ProductID = d.ProductID

--11.Sử dụng index trên 1 bảng nào đấy, xem xét hiệu năng thực thi các câu truy vấn trên bảng đấy.
create index Idx_Person on Person.Person(BusinessEntityID);
go
