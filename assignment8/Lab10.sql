
CREATE DATABASE my_data
go
use my_data
go
-- Bang 1: NHANVIEN
create table NHANVIEN(
	HONV varchar(15) not null,
	TENLOT varchar(15) not null,
	TEN varchar(15) not null,
	MANV varchar(15) not null primary key,
	NGSINH date not null,
	DCHI varchar(50) not null,
	PHAI varchar(5) not null,
	LUONG int not null,
	MA_NQL varchar(15),
	PHG int not null
)

go
-- BANG2: PHONGBAN
create table PHONGBAN
(
	TENPHG varchar(15) not null,
	MAPH int not null,
	TRPHG varchar(15) not null,
	NG_NHANCHUC date not null,
)
go
--  BANG3:DIADIEM_PHG
create table DIADIEM_PHG(
	MAPHG int not null ,
	DIADIEM varchar(15) not null primary key,
)
go
--BANG4:THANNHAN
create table THANNHAN(
	MA_NVIEN varchar(15) not null ,
	TENTN varchar(15) not null,
	PHAI varchar(5) not null,
	NGSINH date not null,
	QUANHE varchar(15) not null,
	primary key(MA_NVIEN,TENTN)
)
go
--BANG5:DEAN
create table DEAN(
	TENDA varchar(20) not null,
	MADA int not null,
	DDIEM_DA varchar(15),
	PHONG int not null,

)
go
--BANG6:PHANCONG
create table PHANCONG
(
	MA_NVIEN varchar(15) not null,
	SODA int not null,
	THOIGIAN float ,
	primary key(MA_NVIEN,SODA)
)
go
-- Foreign key
alter table phongban add constraint fk_phongban1 foreign key(trphg) references nhanvien(manv)
insert into NHANVIEN
VALUES ('Dinh','Ba','Tien','123456789','19950109','731 Tran Hung Dao,Q1,TPHCM','Nam',30000,'333445555',5),
       ('Nguyen','Thanh','Tung','333445555','19451208','638 Nguyen Van Cu,Q5,TPHCM','Nam',40000,'888665555',5),
	   ('Bui','Thuy','Vu','999887777','19580719','332 Nguyen Thai Hoc,Q1,TPHCM','Nam',25000,'987654321',4),
	   ('Le','Thi','Nhan','987654321','19310620','291 Ho Van Hue,QPN,TPHCM','Nu',43000,'888665555',4),
	   ('Nguyen','Manh','Hung','666884444','19520915','975 Ba Ria,Vung Tau','Nam',38000,'333445555',5),
	   ('Tran','Thanh','Tam','453453453','19620731','543 Mai Thi Luu,Q1,TPHCM','Nam',25000,'333445555',5),
	   ('Tran','Hong','Quan','987987987','19590329','980 Le Hong Phong, Q10,TPHCM','Nam',25000,'987654321',4)
insert into NHANVIEN(HONV,TENLOT,TEN,MANV,NGSINH,DCHI,PHAI,LUONG,PHG)
values  ('Vuong','Ngoc','Quyen','888665555','19271010','450 Trung Vuong,Ha Noi','Nu',55000,1)

SELECT * FROM NHANVIEN

insert into PHONGBAN
values
('Nghien cuu',5,'333445555','19780522'),
('Dieuhanh',4,'987987987','19850101'),
('Quan ly',1,'8886655555','19710619')
go
insert into DIADIEM_PHG
values(1,'TP HCM'),
(4,'HA NOI'),
(5,'VUNG TAU'),
(5,'NHA TRANG'),
(5,'TP HCM')
insert into THANNHAN
values ('333445555','Quang','Nu','19760405','Con gai'),
('333445555','Khang','Nam','19731025','Con trai'),
('333445555','Duong','Nam','19480503','Vo chong'),
('997854321','Dang','Nam','19320229','Vo chong'),
('123456789','Duy','Nam','19780101','Con trai'),
('123456789','Chau','Nu','19781231','Con gai')

--BANG4:THANNHAN
create table THANNHAN(
	MA_NVIEN int not null ,
	TENTN varchar(15) not null,
	PHAI varchar(5) not null,
	NGSINH date not null,
	QUANHE varchar(15) not null,
	primary key(MA_NVIEN,TENTN)
)
go
--BANG5:DEAN
create table DEAN(
	TENDA varchar(20) not null,
	MADA int not null,
	DDIEM_DA varchar(15),
	PHONG int not null,

)
go
--BANG6:PHANCONG
create table PHANCONG
(
	MA_NVIEN int not null,
	SODA int not null,
	THOIGIAN float ,
	primary key(MA_NVIEN,SODA)
)

       


INSERT into Dean(Tenda,Mada,DDiem_da,Phong)
VALUES  ('San pham X',1,'Vung Tau',5),
        ('San pham Y',2,'Nha Trang',5),
        ('San pham Z',3,'TP HCM',5),
        ('Tin học hoa',10,'Ha Noi',4),
        ('Cap quang',20,'TP HCM',1),
        ('Đao tao',30,'Ha Noi',4);

INSERT into Phancong(Ma_Nvien,Soda,Thoigian)
VALUES  ('123456789',1,32.5),
        ('123456789',2,7.5),
        ('666884444',3,40),
        ('453453453',1,20),
        ('453453453',2,20),
        ('333445555',3,10),
        ('333445555',10,10),
        ('333445555',20,10),
        ('999887777',30,30),
        ('999887777',10,10),
        ('987987987',10,35),
        ('987987987',30,5),
        ('987654321',30,20),
        ('987654321',20,15);
       
INSERT into Phancong(Ma_Nvien,Soda)
VALUES  ('888665555',20);

/*1. List all information of employees (code, name, entered date, supervisor’s id, 
supervisor’s name) that were employed from s to f. S and f are date value that were 
been input parameters. */
create procedure SP_1
@s date ,@f date
AS 
begin
SELECT * FROM NHANVIEN WHERE NGSINH BETWEEN @s and @f
end

exec SP_1 '1955-07-05' ,'1962-04-05'



/* list all employees (code, name, salary) whose salary more than the average salary 
of the department that they work in. */
create procedure SP_2
as
begin
	select nv.* from nhanvien as nv ,(select phg,avg(luong) as luongtb from nhanvien group by phg)as a 
	where luong > a.luongtb and a.phg=nv.phg
end

exec SP_2

/* List N employees that have the highest salary. N is the input parameter. */create procedure SP_3@N intAS beginselect top (@N) a.*from (select manv,ten,luong from nhanvien  where luong > (select avg(luong) from nhanvien)) as aendexec sp_3 2SELECT *  from nhanvien  order by luong desc	select count(*)  from nhanvien /* 4. Increase 10% for salary of all employees in the city A. A is the input parameter. */
alter procedure SP_4
@A varchar(15)
as
begin	
	update NHANVIEN set luong = luong * 110/100 where DCHI like '%'+ @A
end

select * from nhanvien
exec SP_4 @A='TPHCM'

-- 5. Delete all no personnel departments. 
create procedure SP_5 
as 
begin
	delete from PHONGBAN where MAPH not in (select distinct phg from nhanvien)
end

exec SP_5
-- II. Write triggers to ensure:
-- 1. The average salary of each department must be fewer than 50000
alter trigger trigger_1  
on nhanvien
for insert
as
begin
	declare @luong int
	declare @phongban int
	select @phongban = phg from inserted;
	select @luong = avg(luong) from nhanvien where phg = @phongban
	if @luong < 50000
	begin
		print 'Khong them duoc'
		rollback tran
	end
end

insert into nhanvien
VALUES ('Dinh','Ba','Tien','1920022992','19950109','731 Tran Hung Dao,Q1,TPHCM','Nam',10000,'333445555',4)

-- 2. The salary of the head of each department must be greater than or equal to salary of all employees in this department.
create trigger trigger_2 
on nhanvien 
for insert,update
as
begin
	declare @matrphong varchar(15)
	declare @luongnv int
	declare @luongtp int
	declare @phongban int
	select @phongban =phg,@luongnv =luong from inserted
	select @matrphong = trphg from phongban where maph = @phongban
	select @luongtp = luong from nhanvien where manv = @matrphong
	if @luongtp < @luongnv
	begin
		print 'The salary of the head of each department must be greater than or equal to salary of all employees'
		rollback tran
	end
end

-- 3. The different between average salary of employees in HCM and HN must fewer than 10000.
create trigger_3 
on nhanvien
for insert,update,delete
as 
begin
	declare @luonghn int
	declare @luonghcm int
	select @luonghn = avg(luong) from nhanvien where DCHI like '%Ha Noi'
	select @luonghcm = avg(luong) from nhanvien where DCHI like '%TPHCM'
	declare @n = abs(@luonghn - @luonghcm)
	if @n < 10000
	begin
	print 'The different between average salary of employees in HCM and HN must fewer than 10000.'
	rollback tran
	end
end

-- There is not group that have more than five employees that are in the same family.


select * from nhanvien
select avg(luong) from nhanvien where phg = 4
select avg(luong) from nhanvien group by phg





