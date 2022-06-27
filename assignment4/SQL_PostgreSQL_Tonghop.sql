CREATE DATABASE QLKH
GO
USE QLKH
CREATE TABLE GiangVien
(
	GV# NVARCHAR(10) NOT NULL,
	Hoten NVARCHAR(30) NOT NULL,
	DiaChi NVARCHAR(50) NOT NULL,
	NgaySinh Date NOT NULL,
	CONSTRAINT khoachinh1 PRIMARY KEY(GV#)
)
GO
CREATE TABLE DeTai
(
	DT# NVARCHAR(10) NOT NULL,
	TenDT NVARCHAR(50) NOT NULL,
	Cap NVARCHAR(10) NOT NULL,
	KinhPhi int NOT NULL,
	CONSTRAINT khoachinh2 PRIMARY KEY(DT#)
)
GO
CREATE TABLE ThamGia
(
		GV# NVARCHAR(10) NOT NULL,
		DT# NVARCHAR(10) NOT NULL,
		SoGio int NOT NULL,
)

GO
INSERT INTO GiangVien 
(GV#,HoTen,DiaChi,NgaySinh)
VALUES ('GV01',N'Vũ Tuyết Trinh',N'Hoàng Mai, Hà Nội','1975-10-10'),
	   ('GV02',N'Nguyễn Nhật Quang',N'Hai Bà Trưng, Hà Nội','1976-11-03'),
	   ('GV03',N'Nguyễn Đức Khánh',N'Đống Đa,Hà Nội','1977-06-04'),
	   ('GV04',N'Nguyễn Hồng Phương',N'Tây Hồ,Hà Nội','1983-12-10'),
	   ('GV05',N'Lê Thanh Hương',N'Hai Bà Trưng,Hà Nội','1976-10-10');
GO
INSERT INTO DeTai
(DT#,TenDT,Cap,KinhPhi)
VALUES('DT01',N'Tính Toán Lưới',N'Nhà Nước',700),
	  ('DT02',N'Phát hiện tri thức',N'Bộ',300),
	  ('DT03',N'Phân loại văn bản',N'Bộ',270),
	  ('DT04',N'Dịch tự động Anh Việt',N'Trường',30);
GO
INSERT INTO ThamGia
(GV#,DT#,SoGio)
VALUES('GV01','DT01',100),
	  ('GV01','DT02',80),
	  ('GV01','DT03',80),
	  ('GV02','DT01',120),
	  ('GV02','DT03',140),
	  ('GV03','DT03',150),
	  ('GV04','DT04',180);
GO

ALTER TABLE ThamGia ADD FOREIGN KEY(GV#) REFERENCES GiangVien(GV#);
ALTER TABLE ThamGia ADD FOREIGN KEY(DT#) REFERENCES DeTai(DT#);



SELECT * FROM GiangVien WHERE DiaChi LIKE'Hai Bà Trưng%' ORDER BY HoTen DESC ;


SELECT Hoten,DiaChi,NgaySinh FROM GiangVien g INNER JOIN (SELECT t.GV#,t.DT# FROM ThamGia t INNER JOIN DeTai d on d.DT# = t.DT# WHERE d.DT# LIKE 'Tính toán lưới%') k on k.GV# = g.GV#

-- 2. Đưa ra danh sách gồm họ tên, địachỉ, ngày sinh của giảng viên có tham gia vào đề tài “Tính toán lưới”.

SELECT * FROM THAMGIA,DETAI WHERE THAMGIA.DT# = DETAI.DT#

SELECT Hoten,DiaChi,NgaySinh FROM GiangVien AS GV INNER JOIN 
(SELECT TG.GV#,DT.DT#,DT.TenDT FROM ThamGia as TG INNER JOIN DETAI AS DT on TG.DT# = DT.DT# WHERE DT.TENDT LIKE N'Tính toán lưới') k on k.GV# = GV.GV#
-- TRONG INNER JOIN MUỐN THÊM ĐIỀU KIỆN DÙNG AND HOẶC WHERE ĐỀU ĐƯỢC 
-- 3. Đưa ra danh sách gồm họ tên, địa chỉ, ngày sinh của giảng viên có tham gia vào đề tài “Phân loại văn bản” hoặc “Dịch tự động Anh Việt”.
SELECT Hoten,DiaChi,NgaySinh FROM GIANGVIEN AS GV INNER JOIN 
(SELECT TG.* FROM DETAI AS DT INNER JOIN THAMGIA TG ON TG.DT# = DT.DT# AND ( DT.TENDT LIKE N'Phân loại văn bản' OR DT.TENDT LIKE N'Dịch tự động Anh Việt' )) K
ON K.GV# = GV.GV#
-- Không dùng được SELECT * vì không biết lấy hết dữ liệu từ bảng THAMGIA hay bảng DETAI ( nếu dùng phải dùng TG.*)
-- SELECT * FROM DETAI AS DT INNER JOIN THAMGIA TG ON TG.DT# = DT.DT# AND ( DT.TENDT LIKE N'Phân loại văn bản' )

-- 4.Cho biết thông tin giảng viên tham gia ít nhất 2 đề tài
SELECT * FROM GIANGVIEN AS GV WHERE 2 <= 
(SELECT COUNT (*) FROM THAMGIA AS TG WHERE GV.GV# = TG.GV# )
-- 5 . Cho biết tên giảng viên tham gia nhiều đề tài nhất.
SELECT * FROM GIANGVIEN
SELECT * FROM DETAI
SELECT * FROM THAMGIA

-- 
SELECT HOTEN, COUNT(B.GV#)  FROM GIANGVIEN AS GV INNER JOIN
(SELECT TG.GV#  FROM THAMGIA as TG INNER JOIN DETAI AS D ON TG.DT# = D.DT# ) AS B ON B.GV# = GV.GV#  group by gv.HOTEN  order by COUNT(B.GV#) desc 

/*
SELECT TOP 1 HOTEN ,SOLAN  FROM GIANGVIEN AS GV  INNER JOIN 
(SELECT GV.GV#,COUNT(*) AS SOLAN FROM GiangVien AS GV,THAMGIA AS TG WHERE GV.GV# = TG.GV# GROUP BY GV.GV#) AS B ON GV.GV# = B.GV# ORDER BY SOLAN DESC 
*/

--  6.Đề tài nào tốn ít kinh phí nhất?

SELECT TOP 1 DT.DT#,DT.TENDT,DT.KINHPHI FROM DETAI AS DT INNER JOIN THAMGIA AS TG ON DT.DT# = TG.DT# GROUP BY DT.DT#,DT.KINHPHI,DT.TENDT ORDER BY KINHPHI ASC

SELECT TOP 1 TENDT,MIN(KINHPHI) FROM DETAI GROUP BY TENDT
select TOP 1 tendt,min(kinhphi) from detai 
group by tendt

-- 7.Cho biết tên và ngày sinh của giảng viên sống ở quận Tây Hồ và tên các đề tài mà giảng viên này tham gia.
SELECT HOTEN,NGAYSINH,DIACHI,B.TENDT FROM GIANGVIEN AS GV INNER JOIN
(SELECT DT.DT#,DT.TENDT,TG.GV# FROM DETAI AS DT INNER JOIN THAMGIA AS TG ON DT.DT# = TG.DT#) AS B ON B.GV# = GV.GV# WHERE GV.DIACHI LIKE N'Tây Hồ%'
-- 8.Cho biết tên những giảng viên sinh trước năm 1980 và có tham gia đề tài “Phân loại văn bản”
-- Tìm bảng giảng viên sinh trước năm 1980 có tham gia đề tài Phân loại văn bản
SELECT HOTEN FROM GIANGVIEN AS GV INNER JOIN 
(
SELECT TG.GV#,DT.DT# FROM THAMGIA AS TG INNER JOIN DETAI AS DT ON TG.DT# = DT.DT# WHERE DT.TENDT = N'Phân loại văn bản'
) AS B ON GV.GV# = B.GV# AND YEAR(GV.NGAYSINH ) < 1980
SELECT * FROM GIANGVIEN
-- 9 .Đưa ra mã giảng viên, tên giảng viên và tổng số giờ tham gia nghiên cứu khoa học của từng giảng viên.
SELECT GV.GV# ,GV.HOTEN,B.SOGIO  FROM GIANGVIEN AS GV INNER JOIN
(SELECT TG.GV#,SUM(TG.SOGIO) AS SOGIO FROM THAMGIA AS TG GROUP BY TG.GV#) AS B ON GV.GV# = B.GV#
-- Các hàm SUM,COUNT sẽ thực hiện theo từng nhóm GROUP BY

--10.Giảng viên Ngô Tuấn Phong sinh ngày 08/09/1986 địa chỉ Đống Đa, Hà Nội mới tham gia nghiên cứu đề tài khoa học. Hãy thêm thông tin giảng viên này vào bảng GiangVien.
	INSERT INTO GIANGVIEN 
	 VALUES  ('GV06',N'Ngô Tuấn Phong',N'Đống Đa,Hà Nội','19860908');
-- 11.Giảng viên Vũ Tuyết Trinh mới chuyển về sống tại quận Tây Hồ, Hà Nội. Hãy cập nhật thông tin này.
UPDATE GIANGVIEN SET DIACHI =N'Tây Hồ, Hà Nội' WHERE HOTEN = N'Vũ Tuyết Trinh'

--12 . Giảng viên có mã GV02không tham gia bất kỳ đề tài nào nữa. Hãy xóa tất cả thông tin liên quan đến giảng viên này trong CSDL.
DELETE THAMGIA WHERE GV# ='GV02'
DELETE GIANGVIEN WHERE GV# = 'GV02'

--C. Sao lưu và phục hồi CSDL trên
backup database QLKH to disk = 'C:\BACKUP\qlkh.bak'
drop database qlkh

restore database QLKH from disk = 'C:\BACKUP\qlkh.bak'
/*
D. 
1. Hãy tạo tài khoản đăng nhập cho Ngô Tuấn Phong (đặt tên là PhongNT, mật khẩu là 
phong123), Nguyễn Hồng Phương (đặt tên là PhuongNH, mật khẩu là phuong123)
 Hai giảng viên này đều có quyền truy cập vào CSDL QLKH với quy định như sau:

*/
create login PhongNT with password ='phong123'
create user NgôTuấnPhong for login PhongNT

create login PhuongNH with password = 'phuong123'
create user NguyễnHồngPhương for login PhuongNH
-- Giảng viên Ngô Tuấn Phong có quyền SELECT trên bảng GiangVien và bảng ThamGia.
grant select on GiangVien to NgôTuấnPhong
grant select on ThamGia to NgôTuấnPhong
-- Giảng viên Nguyễn Hồng Phương có quyền tạo bảng, tạo khung nhìn trên CSDL
grant create table ,create view to NguyễnHồngPhương
--2. Hãy tạo nhóm quyền CSDL gồm 2 giảng viên Vũ Tuyết Trinh và Trần Đức Khánh với tất 
-- cả các quyền trên các đối tượng của CSDL
create role role_1;
create login TrinhTV with password ='trinh123'
create user VũTuyếtTrinh for login TrinhTV

create login KhanhDT with password ='khanh123'
create user TrầnĐứcKhánh for login KhanhDT
alter role role_1 add member VũTuyếtTrinh 
alter role role_1 add member TrầnĐứcKhánh


grant create table,create rule,create view,create procedure,create function,backup database to role_1