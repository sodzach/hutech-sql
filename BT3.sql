use master  
go 
if exists (
	select name from sys.databases where name='BAITAP3'
)
drop database BAITAP3
go 

create database BAITAP3
go
SET DATEFORMAT 'DMY'
GO
USE BAITAP3
GO
create table Loai (
	MaLoai char (5)primary key,
	TenLoai nvarchar(50)
);

create table NhanVien (
	MaNV char(5) primary key,
	HoTen nvarchar(50),
	NgaySinh smalldatetime check(year(getdate())-year(NgaySinh) between 18 and 55 ),
	Phai int default 1
);
create table SanPham(
	MaSP char(5) primary key ,
	TenSP nvarchar(50)unique,
	MaLoai char(5)
constraint fk1 foreign key(MaLoai) references Loai(MaLoai)  on update cascade
);
create table PhieuXuat(
	MaPX int primary key identity ,
	NgayLap smalldatetime ,
	MaNV char(5)
constraint fk2 foreign key(MaNV) references NhanVien(MaNV) on update cascade
);
create table CTPX(
	MaPX int ,
	Masp char(5),
	soluong int
constraint fk3 foreign key(MaPX) references PhieuXuat(MaPX) on update cascade,
constraint fk4 foreign key(Masp) references SanPham(Masp) on update cascade
);
create table PX(
	MaPX int identity primary key  ,
	NgayLap smalldatetime ,
	MaNV char(5)
);

INSERT INTO Loai
	VALUES(1,'VAT LIEU XAY DUNG');
INSERT INTO Loai
	VALUES(2,'HANG TIEU DUNG');
INSERT INTO Loai
	VALUES(3,'NGU COC');


INSERT INTO SanPham
	VALUES(1,'XI MANG',1);
INSERT INTO SanPham
	VALUES(2,'GACH',1);
INSERT INTO SanPham
	VALUES(3,'GAO NANG HUONG',3);
INSERT INTO SanPham
	VALUES(4,'BOT MI',3);
INSERT INTO SanPham
	VALUES(5,'KE CHEN',2);
INSERT INTO SanPham
	VALUES(6,'DAU XANH',3);
INSERT INTO NhanVien
	VALUES('NV01','NGUYEN MAI THI','15/5/1982',0);
INSERT INTO NhanVien
	VALUES('NV02','TRAN DINH CHIEN','12/2/1980',1);
INSERT INTO NhanVien
	VALUES('NV03','LE THI CHI','23/1/1979',0);

INSERT INTO PhieuXuat(NgayLap, MaNV)
	VALUES('3/12/2010','NV01');
INSERT INTO PhieuXuat(NgayLap, MaNV)
	VALUES('2/3/2010','NV02');
INSERT INTO PhieuXuat(NgayLap, MaNV)
	VALUES('6/1/2010','NV03');
INSERT INTO PhieuXuat(NgayLap, MaNV)
	VALUES('16/6/2010','NV01');
INSERT INTO CTPX
	VALUES(1,1,10);
INSERT INTO CTPX
	VALUES(1,2,15);
INSERT INTO CTPX
	VALUES(1,3,5);
INSERT INTO CTPX
	VALUES(2,2,20);
INSERT INTO CTPX
	VALUES(3,1,20);
INSERT INTO CTPX
	VALUES(3,3,25);
INSERT INTO CTPX
	VALUES(4,5,12);
