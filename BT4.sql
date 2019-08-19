use master
go
if exists (
Select name from sys.databases where name='BAITAP4'
)
drop database BAITAP4
go

Create database BAITAP4
go
SET DATEFORMAT 'DMY'
GO
Alter Authorization On Database::BAITAP4 TO"SA"
GO
Use BAITAP4
GO
Create Table LoaiSP(
MaLoai Char(3) Primary Key,
TenLoai Nvarchar(50)
);
Create Table SanPham(
MaSP Char(5) Primary key,
TenSP Nvarchar(50) unique,
MoTa Nvarchar(50),
Gia Float,
MaLoai Char(3),
Constraint fk1 foreign key(MaLoai) references LoaiSP(MaLoai) on update cascade
);
Create Table KhachHang(
MaKH char(5)primary key,
TenKH nvarchar(50),
DC nvarchar(30),
DT char(12),
);

CREATE TABLE DonDH(
SoDDH char(5) primary key,
NgayDat Datetime,
MaKH char(5),
Constraint fk2 foreign key(MaKH) references KhachHang(MaKH) on update cascade 
);
CREATE TABLE CTDDH(
SoDDH char(5),
MaSP char(5), 
SoLuong float,
Constraint fk3 primary key(SoDDH,MaSP),
Constraint fk4 foreign key(SoDDH) references DonDH(SoDDH) on update cascade,
Constraint fk5 foreign key(MaSP) references SanPham(MaSP) on update cascade 
);
CREATE TABLE NguyenLieu(
MaNL char(4) primary key,
TenNL nvarchar(50),
DVT char (5),
Gia float,
);
CREATE TABLE Lam(
MaNL char(4),
MaSP char(5), 
SoLuong FLoat,
Constraint fk8 primary key(MaNL,MaSP),
constraint fk6 foreign key(MaNL) references NguyenLieu(MaNL) on update cascade,
    constraint fk7 foreign key(MaSP) references SanPham(MaSP) on update cascade
);

INSERT INTO LoaiSP
VALUES('L01',N'T?');
INSERT INTO LoaiSP
VALUES('L02',N'Bàn');
INSERT INTO LoaiSP
VALUES('L03',N'Giu?ng');

INSERT INTO SANPHAM
VALUES('SP01',N'T? trang di?m',N'Cao 1.4m, r?ng 2.2m','1000000','L01');
INSERT INTO SANPHAM
VALUES('SP02',N'Giu?ng don Cali',N'R?ng 1.4m','1500000','L03');
INSERT INTO SANPHAM
VALUES('SP03',N'T? DDA',N'Cao 1.6m, r?ng 2.0m, c?a ki?ng','800000','L01');
INSERT INTO SANPHAM
VALUES('SP04',N'Bàn nh?u','1m x 1.5m','650000','L02');
INSERT INTO SANPHAM
VALUES('SP05',N'Bàn u?ng trà',N'Tròn, 1.8m','1100000','L02');


INSERT INTO KHACHHANG
VALUES('KH001','TRAN HAI CUONG','731 TRAN HUNG DAO Q1 TPHCM ','089776655');
INSERT INTO KHACHHANG
VALUES('KH002','NGUYEN THI BE','638 NGUYEN VAN CU Q5 TPHCM','0913666123');
INSERT INTO KHACHHANG
VALUES('KH003','TRAN THI MINH HOA','543 MAI THI LUU BA DINH HA NOI','049238777');
INSERT INTO KHACHHANG
VALUES('KH004','PHAM DINH TUAN','975 LE LAI P3 VUNG TAU','064543678');
INSERT INTO KHACHHANG
VALUES('KH005','LE XUAN NGUYEN','450 TRUONG VUONG MY THO TG','073987123');
INSERT INTO KHACHHANG
VALUES('KH006','VAN HUNG DUNG','291 HO VAN HUE Q.PN TPHCM','088222111');
INSERT INTO KHACHHANG
VALUES('KH012','LE THI HUONG HOA','980 LE HONG PHONG VUNG TAU','064452100');
INSERT INTO KHACHHANG
VALUES('KH016','HA MINH TRI','332 NGUYEN THAI HOC QUY NHON','056565656');

INSERT INTO DonDH
VALUES('DH001','15/03/2004','KH001');
INSERT INTO DonDH
VALUES('DH002','15/03/2004','KH016');
INSERT INTO DonDH
VALUES('DH003','16/03/2004','KH003');
INSERT INTO DonDH
VALUES('DH004','16/03/2004','KH012');
INSERT INTO DonDH
VALUES('DH005','17/03/2004','KH001');
INSERT INTO DonDH
VALUES('DH006','1/04/2004','KH002');

INSERT INTO CTDDH
VALUES('DH001','SP01',5);
INSERT INTO CTDDH
VALUES('DH001','SP03',1);
INSERT INTO CTDDH
VALUES('DH002','SP02',2);
INSERT INTO CTDDH
VALUES('DH003','SP01',2);
INSERT INTO CTDDH
VALUES('DH003','SP04',10);
INSERT INTO CTDDH
     VALUES('DH004','SP02',2);
INSERT INTO CTDDH
VALUES('DH004','SP05',2);
INSERT INTO CTDDH
VALUES('DH005','SP03',3);
INSERT INTO CTDDH
VALUES('DH006','SP02',4);
INSERT INTO CTDDH
VALUES('DH006','SP04',3);
INSERT INTO CTDDH
VALUES('DH006','SP05',6);

INSERT INTO NguyenLieu
VALUES('NL01',N'G? lim XP','m3',1200000);
INSERT INTO NguyenLieu
VALUES('NL02',N'G? sao NT','m3',1000000);
INSERT INTO NguyenLieu
VALUES('NL03',N'G? t?p','m3',500000);
INSERT INTO NguyenLieu
VALUES('NL04',N'Ðinh l?n','kg',40000);
INSERT INTO NguyenLieu
VALUES('NL05',N'dinh nh?','kg',30000);
INSERT INTO NguyenLieu
VALUES('NL06',N'Ki?ng','m2',350000);

INSERT INTO Lam
VALUES('NL01','SP01',1.2);
INSERT INTO Lam
VALUES('NL03','SP01',0.3);
INSERT INTO Lam
VALUES('NL06','SP01',2.5);
INSERT INTO Lam
VALUES('NL02','SP02',1.1);
INSERT INTO Lam
VALUES('NL04','SP02',2.2);
INSERT INTO Lam
VALUES('NL02','SP03',0.9);
INSERT INTO Lam
VALUES('NL05','SP03',2.1);
INSERT INTO Lam
VALUES('NL02','SP04',1.3);
INSERT INTO Lam
VALUES('NL04','SP04',1.7);
INSERT INTO Lam
VALUES('NL03','SP05',0.8);
INSERT INTO Lam
VALUES('NL05','SP05',0.5);
INSERT INTO Lam
VALUES('NL06','SP05',2.4);