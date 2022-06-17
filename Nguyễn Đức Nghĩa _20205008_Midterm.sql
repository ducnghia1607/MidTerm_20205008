CREATE DATABASE THIGK
go

use THIGK
GO
CREATE TABLE GIANGVIEN(
	GV# VARCHAR(10) not null primary key,
	HoTen nvarchar(30) not null,
	NamSinh int not null,
	DiaChi nvarchar(50) not null
)
GO
CREATE TABLE DETAI(
	DT# varchar(10) not null primary key,
	TenDT nvarchar(50) not null,
	TheLoai nvarchar(20)not null
)
go
CREATE TABLE SINHVIEN(
	SV# varchar(10)not null primary key,
	TenSV nvarchar(30) not null,
	NgaySinh date not null ,
	QueQuan nvarchar(20)not null,
	Lop nvarchar(20) not null,
)

go
CREATE TABLE HUONGDAN(
	GV# varchar(10) not null,
	DT# varchar(10) not null,
	SV# varchar(10) not null,
	NamThucHien int,
	KetQua float
	CONSTRAINT KHOACHINH PRIMARY KEY(GV#,DT#,SV#),
	CONSTRAINT FK_10 FOREIGN KEY(GV#) REFERENCES GIANGVIEN(GV#),
	CONSTRAINT FK_11 FOREIGN KEY(DT#) REFERENCES DETAI(DT#),
	CONSTRAINT FK_12 FOREIGN KEY(SV#) REFERENCES SINHVIEN(SV#),
)
GO

--Nhập data cho bảng GIANGVIEN
	Insert Into GIANGVIEN
	values ('GV001',N'Nguyễn Hoài An',1973,N'Q.10,TP HCM')
	Insert Into GIANGVIEN
	values ('GV002',N'Trần Trà Hương',1960,N'Q.1, TP HCM')
	Insert Into GIANGVIEN
	values ('GV003',N'Nguyễn Ngọc Ánh',1975,N'Thủ Đức, TP HCM')
	Insert Into GIANGVIEN
	values ('GV004',N'Trương Nam Sơn',1959,N'Lý Thường Kiệt,TP Biên Hòa')
	Insert Into GIANGVIEN
	values ('GV005',N'Lý Hoàng Hà',1954,N'Hai Bà Trưng,Hà Nội')
	Insert Into GIANGVIEN
	values ('GV006',N'Trần Bạch Tuyết',1980,N'Kim Ngưu,Hà Nội')
	Insert Into GIANGVIEN
	values ('GV007',N'Nguyễn An Trung',1976,N'Thanh Nhàn,Hà Nội')
	Insert Into GIANGVIEN
	values ('GV008',N'Trần Trung Hiếu',1977,N'Lê Thanh Nghị,Hà Nội')
	Insert Into GIANGVIEN
	values ('GV009',N'Trần Hoàng nam',1975,N'Giải Phóng,Hà Nội')
	Insert Into GIANGVIEN
	values ('GV010',N'Phạm Nam Thanh',1980,N'Giải Phóng,Hà Nội')
	Insert Into GIANGVIEN
	values ('GV011',N'Phạm Nam Kim',1982,N'Giải Phóng,Hà Nội')
	Insert Into GIANGVIEN
	values ('GV012',N'Phạm Nam Hoa',1983,N'Giải Phóng,Hà Nội')
	go
select * from detai
--Nhập data cho bảng DETAI

	Insert Into DETAI
	values ('DT001',N'HTTT quản lý các trường ĐH',N'Quản lí trường')

	Insert Into DETAI
	values ('DT002',N'HTTT quản lý giáo vụ cho một Khoa',N'Ứng dụng')
	Insert Into DETAI
	values ('DT003',N'Nghiên cứu chế tạo sợi ',N'Sinh Học')
	Insert Into DETAI
	values ('DT004',N'Tạo vật liệu sinh học bằng màng ',N'Sinh Học')
	Insert Into DETAI
	values ('DT005',N'Ứng dụng hóa học xanh',N'Sinh Học')
	Insert Into DETAI
	values ('DT006',N'Nghiên cứu tế bào gốc',N'Nhà nước')
	Insert Into DETAI
	values ('DT007',N'HTTT quản lý thư viện ở các trường ĐH',N'Quản lí trường')
	Insert Into DETAI
	values ('DT008',N'Cung cấp nước sạch',N'Ứng dụng')
	Insert Into DETAI
	values ('DT009',N'Rác thải',N'Ứng dụng')
	Insert Into DETAI
	values ('DT010',N'Động vật',N'Quản lí môi trường')
	GO
--Nhập data cho bảng SINHVIEN
	INSERT INTO SINHVIEN 
	values('SV001',N'Nguyễn Văn Anh','20020813',N'Bắc Ninh',N'Việt Nhật 01')
		INSERT INTO SINHVIEN 
	values('SV002',N'Nguyễn Văn Bi','20020813',N'Bắc Ninh',N'Việt Nhật 01')
		INSERT INTO SINHVIEN 
	values('SV003',N'Nguyễn Văn Chi','20020813',N'Bắc Ninh',N'Việt Nhật 01')
		INSERT INTO SINHVIEN 
	values('SV004',N'Nguyễn Văn Do','20020813',N'Bắc Ninh',N'Việt Nhật 01')
		INSERT INTO SINHVIEN 
	values('SV005',N'Nguyễn Văn Em','20020813',N'Bắc Ninh',N'Việt Nhật 01')
		INSERT INTO SINHVIEN 
	values('SV006',N'Nguyễn Văn Kha','20020813',N'Bắc Ninh',N'Việt Nhật 01')
		INSERT INTO SINHVIEN 
	values('SV007',N'Nguyễn Văn Gan','20020813',N'Bắc Ninh',N'Việt Nhật 01')
		INSERT INTO SINHVIEN 
	values('SV008',N'Nguyễn Đức Hoan','20020813',N'Bắc Ninh',N'Việt Nhật 01')
		INSERT INTO SINHVIEN 
	values('SV009',N'Nguyễn Văn In','20020813',N'Bắc Ninh',N'Việt Nhật 01')
		INSERT INTO SINHVIEN 
	values('SV010',N'Nguyễn Văn An','20020813',N'Hải Phòng',N'Việt Nhật 01')
			INSERT INTO SINHVIEN 
	values('SV011',N'Nguyễn Đức Kim','20020813',N'Hải Phòng',N'Việt Nhật 01')
			INSERT INTO SINHVIEN 
	values('SV012',N'Nguyễn Đức Ong','20020813',N'Bắc Ninh',N'Việt Nhật 01')
			INSERT INTO SINHVIEN 
	values('SV013',N'Nguyễn Đức Minh','20020813',N'Hải Phòng',N'Việt Nhật 01')
				INSERT INTO SINHVIEN 
	values('SV014',N'Nguyễn Đức N','20020813',N'Bắc Ninh',N'Việt Nhật 01')
				INSERT INTO SINHVIEN 
	values('SV015',N'Nguyễn Đức K','20020813',N'Hải Phòng',N'Việt Nhật 01')
			INSERT INTO SINHVIEN 
	values('SV016',N'Nguyễn Xuân Dũng','20020813',N'Hà Nội',N'Việt Nhật 01')
	

	select * from sinhvien
--Nhập data cho bảng HUONGDAN
		INSERT INTO HUONGDAN
		VALUES ('GV001','DT001','SV001',2022,9)
				INSERT INTO HUONGDAN
		VALUES ('GV002','DT002','SV002',2021,9)
				INSERT INTO HUONGDAN
		VALUES ('GV003','DT005','SV004',2022,3)
				INSERT INTO HUONGDAN
		VALUES ('GV004','DT003','SV006',2023,9)
				INSERT INTO HUONGDAN
		VALUES ('GV005','DT001','SV007',2020,4)
				INSERT INTO HUONGDAN
		VALUES ('GV006','DT002','SV010',2020,9)
				INSERT INTO HUONGDAN
		VALUES ('GV007','DT006','SV012',2020,6)
				INSERT INTO HUONGDAN
		VALUES ('GV012','DT007','SV011',2021,9)
		INSERT INTO HUONGDAN
		VALUES ('GV002','DT007','SV009',2022,8)
		INSERT INTO HUONGDAN
		VALUES ('GV012','DT008','SV015',2020,3)
		INSERT INTO HUONGDAN
		VALUES ('GV011','DT009','SV012',2022,3)
		INSERT INTO HUONGDAN
		VALUES ('GV012','DT010','SV013',2020,3)


--2)Biểu diễn các yêu cầu bằng SQL 
-- Đưa ra thông tin về giảng viên có mã gv là "GV001"
SELECT * FROM GIANGVIEN WHERE GV#='GV001'
-- CHo biết có bao nhiêu đề tài thuộc the loai ứng dụng
SELECT COUNT(*) AS N'Số Lượng' FROM DETAI WHERE TheLoai =N'Ứng dụng'
-- Cho biết giảng viên có mã GV012 đã hướng dẫn bao nhiêu sinh viên có quê quán ở hải phòng
SELECT COUNT(*) AS N'Số Lượng'  FROM HUONGDAN AS HD,SINHVIEN AS SV WHERE HD.SV#=SV.SV# AND HD.GV#='GV012' AND QUEQUAN ='Hải Phòng'
-- Cho biết tên đề tài chưa có sinh viên nào thực hiện
SELECT  * FROM DeTai as DT
EXCEPT 
SELECT DT1.*from DeTai as DT1 inner join HuongDan as HD on HD.DT#=DT1.DT#
-- Do sơ xuất thông tin ..........
UPDATE SINHVIEN
SET NgaySinh='19911112' WHERE TENSV=N'Nguyễn Xuân Dũng' AND QueQuan=N'Hà Nội'
-- Vì lí do khách quan .........
DELETE FROM SINHVIEN WHERE TENSV=N'Nguyễn Văn Nam' AND QueQuan=N'Bắc Giang'
-- Tạo view để đưa ra các thôn tin về các đề tài hướng dẫn năm 2022
CREATE VIEW TEST_1 AS SELECT * FROM HUONGDAN WHERE NAMTHUCHIEN=2022
-- Sử dụng view vừa tạo
SELECT * FROM TEST_1
--

---------------


---3.Sao luu va backup database

backup database THIGK  to disk = 'C:\BACKUP\THIGK.bak'
-- Phục hồi dữ liệu 
restore database THIGK from disk = 'C:\BACKUP\THIGK.bak'
---------------

---------------
--4) Thực hiện phân quyền
----a.
CREATE LOGIN ThuyNV WITH PASSWORD ='thuy123'
create user NguyễnVănThủy for login ThuyNV

CREATE LOGIN QuanTL  WITH PASSWORD ='quan123'
create user  TrầnLâmQuân for login QuanTL
GRANT SELECT ON HUONGDAN  TO NguyễnVănThủy
GRANT SELECT ON GIANGVIEN  TO NguyễnVănThủy



---b

CREATE LOGIN TienDN  WITH PASSWORD ='1'
CREATE LOGIN CuongPV  WITH PASSWORD ='1'
create user  NguyễnDuyTiến for login TienDN
create user  PhạmViệtCường for login CuongPV

Create Role NHOM_1
Sp_AddRoleMember NHOM_1, NguyễnDuyTiến
Sp_AddRoleMember NHOM_1, PhạmViệtCường

Grant ALL On database THiGK To NHOM_1
Grant ALL On  HUONGDAN To NHOM_1
Grant ALL On  DETAI To NHOM_1
Grant ALL On  SINHVIEN To NHOM_1



