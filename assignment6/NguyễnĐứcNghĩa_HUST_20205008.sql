CREATE DATABASE DBHousing
GO
CREATE TABLE Customer
(	
	MAKH VARCHAR(10) NOT NULL PRIMARY KEY,
	HOTEN NVARCHAR(30) NOT NULL,
	SDT VARCHAR(20) NOT NULL,
	COQUAN NVARCHAR(20) NOT NULL
)
GO
CREATE TABLE RentalHouse
(
	MAN VARCHAR(10) NOT NULL PRIMARY KEY,
	DIACHI NVARCHAR(30) NOT NULL,
	GIATHUE BIGINT NOT NULL,
	TENCHUNHA NVARCHAR(30) NOT NULL
)

GO
CREATE TABLE HD
(
	MAN VARCHAR(10) NOT NULL ,
	MAKH VARCHAR(10) NOT NULL ,
	StartDate DATE NOT NULL,
	EndDate	DATE NOT NULL,
)
GO

ALTER TABLE HD ADD CONSTRAINT FK_HD PRIMARY KEY(MAN,MAKH)
ALTER TABLE HD ADD CONSTRAINT FK_HD1 FOREIGN KEY(MAKH) REFERENCES CUSTOMER(MAKH)
ALTER TABLE HD ADD CONSTRAINT FK_HD2 FOREIGN KEY(MAN) REFERENCES RENTALHOUSE(MAN) 

INSERT INTO CUSTOMER
VALUES('01',N'Nguyễn Vĩnh An','0337840985',N'FPT'),
	  ('02',N'Vũ Đức Lương','0337840985',N'VNPT'),
	  ('03',N'Dương Duy Kiên','0337840985',N'Viettel'),
	  ('04',N'Hoàng Thi Hòa','0337840985',N'FPT'),
	  ('05',N'Lưu Khắc Đăng Dương','0337840985',N'FPT'),
	  ('06',N'Vũ Đình Hoài','0337840985',N'FPT'),
	  ('07',N'Lê Vương Khánh','0337840985',N'Viettel'),
	  ('08',N'Ngũ Duy Vinh','0337840985',N'HUST'),
	  ('09',N'Hoàng Văn Thể','0337840985',N'FPT'),
	  ('10',N'Phùng Khoa Học','0337840985',N'UNETI'),
	  ('11',N'Nguyễn Tùng Lâm','0337840985',N'FPT'),
	 ('12',N'Hán Thế Chiến','0337840985',N'NEU'),
	 ('13',N'Nguyễn Thị Hòa','0337840985',N'CANON'),
	 ('14',N'Nguyễn Kim Anh','0337840985',N'Kokomi'),
	 ('15',N'Nguyễn Công Tuấn','0337840985',N'Oishi')
UPDATE CUSTOMER SET HOTEN=N'Trần Thái Linh' WHERE MAKH='03'
GO
INSERT INTO RentalHouse
VALUES
('A',N'Thanh Lương','12000000',N'Nông Văn Dền'),
('B',N'Kim Ngưu','2000000',N'Dương Thùy Linh'),
('C',N'Trương Định','3000000',N'Lê Chiến'),
('D',N'Thanh Lương','3500000',N'Lê Minh'),
('E',N'Hai Bà Trưng','1000000',N'Nông Văn Dền'),
('F',N'Lê Thanh Nghị','2500000',N'Nguyễn Đức Mạnh'),
('G',N'Hồ Tây','5000000',N'Hoàng Văn Kiên'),
('H',N'Tiên Du','1500000',N'Nguyễn Văn Đức'),
('I',N'Thuận Thành','100000',N'Dương Thùy Linh'),
('J',N'Liên Bão','11000000',N'Lê Minh')
GO
INSERT INTO HD
VALUES
('A','02','20210305','20220305'),
('A','01','20200305','20200305'),
('A','03','20190305','20190305'),
('C','06','20200101','20210101'),
('C','04','20200101','20210101'),
('D','10','20200101','20210101'),
('E','11','20200101','20210101'),
('B','12','20200101','20210101'),
('B','05','20200101','20210101'),
('I','15','20200101','20210101'),
('J','02','20200101','20210101')
GO
-- B.
-- Đưa ra danh sách (Địachỉ, Tênchủnhà) của những ngôi nhà có giá thuê ít hơn 10 triệu
SELECT DIACHI,TENCHUNHA FROM RENTALHOUSE WHERE GIATHUE < 10000000


--Đưa ra danh sách (MãKH, Họtên, Cơquan) của những người đã từng thuê nhà của chủ nhà có tên là "Nông Văn Dền"
SELECT C.MAKH,C.HOTEN,C.COQUAN FROM Customer AS C INNER JOIN (SELECT HD.MAN,HD.MAKH 
FROM RentalHouse AS RH, HD WHERE HD.MAN= RH.MAN AND RH.TENCHUNHA =N'Nông Văn Dền') AS A ON  A.MAKH = C.MAKH

--Đưa ra danh sách các ngôi nhà chưa từng được ai thuê
SELECT * FROM RentalHouse AS RH1
EXCEPT
SELECT RH2.* FROM RentalHouse AS RH2 INNER JOIN HD ON RH2.MAN = HD.MAN 


--Đưa ra giá thuê cao nhất trong số các giá thuê của các ngôi nhà đã từng ít nhất một lần được thuê.
SELECT MAX(RH.GIATHUE) AS GIANHADUOCTHUEMAX FROM RentalHouse AS RH INNER JOIN HD ON HD.MAN=RH.MAN 


-- C.
DROP INDEX INDEX_1
CREATE INDEX INDEX_1 ON CUSTOMER(MAKH)
CREATE INDEX INDEX_3 ON CUSTOMER(COQUAN)
--Viết câu lệnh đưa ra danh sách các khách hàng ở một cơ quan nào đó.
SELECT * FROM CUSTOMER WHERE COQUAN ='FPT'

SELECT * FROM CUSTOMER WHERE COQUAN ='HUST'

 
CREATE INDEX INDEX_2 ON RENTALHOUSE(MAN)
-- Đưa ra danh sách các Chủ nhà cho thuêvàtổng sốlượng Nhà cho thuê.
SELECT TENCHUNHA,COUNT(*) AS SL_NHACHOTHUE FROM RentalHouse GROUP BY TENCHUNHA ORDER BY SL_NHACHOTHUE DESC

-- D.Tạo procedure
-- Đưa ra danh sách các Hợp đồng có giá  thuê  lớn hơn một ngưỡng  cho trước.
CREATE PROCEDURE pHOPDONG
@GIATHUE INT 
AS 
BEGIN
	SELECT HD.* FROM HD,RentalHouse AS RH WHERE RH.GIATHUE > @GIATHUE AND RH.MAN=HD.MAN  
END
-- Hợp đồng có giá  thuê  lớn hơn 5 TRIEU
EXEC pHOPDONG @GIATHUE =5000000
-- Đưa ra danh sách khách hàng có tổng giá trịhợp đồng lớn hơn một ngưỡng cho trước.

CREATE PROCEDURE pCustomer
@TienNha INT
AS BEGIN
SELECT CUSTOMER.*,A.SUM1 FROM Customer INNER JOIN (SELECT HD.MAKH,SUM(RH.GIATHUE) AS SUM1 FROM RentalHouse AS RH ,HD WHERE RH.MAN = HD.MAN GROUP BY HD.MAKH ) 
AS A ON A.MAKH = Customer.MAKH AND A.SUM1 > @TienNha
END

-- Đưa ra danh sách khách hàng có tổng giá trịhợp đồng lớn hơn 3 triệu 
EXEC pCustomer @TienNha = 3000000



