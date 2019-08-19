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
create table sanpham(
	MaSP char(5) primary key ,
	TenSP nvarchar(50)unique,
	MaLoai char(5)
constraint fk1 foreign key(MaLoai) references loai(MaLoai)  on update cascade
);
create table phieuxuat(
	MaPX int primary key identity ,
	NgayLap smalldatetime ,
	MaNV char(5)
constraint fk2 foreign key(MaNV) references nhanvien(MaNV) on update cascade
);
create table ctpx(
	MaPX int ,
	Masp char(5),
	soluong int
constraint fk3 foreign key(MaPX) references phieuxuat(MaPX) on update cascade,
constraint fk4 foreign key(Masp) references sanpham(Masp) on update cascade
);
create table px(
	MaPX int identity primary key  ,
	NgayLap smalldatetime ,
	MaNV char(5)
);

INSERT INTO LOAI
	VALUES(1,'VAT LIEU XAY DUNG');
INSERT INTO LOAI
	VALUES(2,'HANG TIEU DUNG');
INSERT INTO LOAI
	VALUES(3,'NGU COC');


INSERT INTO SANPHAM
	VALUES(1,'XI MANG',1);
INSERT INTO SANPHAM
	VALUES(2,'GACH',1);
INSERT INTO SANPHAM
	VALUES(3,'GAO NANG HUONG',3);
INSERT INTO SANPHAM
	VALUES(4,'BOT MI',3);
INSERT INTO SANPHAM
	VALUES(5,'KE CHEN',2);
INSERT INTO SANPHAM
	VALUES(6,'DAU XANH',3);
INSERT INTO NHANVIEN
	VALUES('NV01','NGUYEN MAI THI','15/5/1982',0);
INSERT INTO NHANVIEN
	VALUES('NV02','TRAN DINH CHIEN','12/2/1980',1);
INSERT INTO NHANVIEN
	VALUES('NV03','LE THI CHI','23/1/1979',0);

INSERT INTO PHIEUXUAT(NgayLap, MaNV)
	VALUES('3/12/2010','NV01');
INSERT INTO PHIEUXUAT(NgayLap, MaNV)
	VALUES('2/3/2010','NV02');
INSERT INTO PHIEUXUAT(NgayLap, MaNV)
	VALUES('6/1/2010','NV03');
INSERT INTO PHIEUXUAT(NgayLap, MaNV)
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


--drop view Cau32;
--Cau3.2 
GO
create view Cau32
AS
select S.MaSP, TenSP, TenLoai, NgayLap
from sanpham S, Loai L, ctpx C, phieuxuat P
where S.MaLoai = L.MaLoai
and S.MaSP = C.Masp
and C.MaPX = P.MaPX
and NgayLap between '01/01/2010' and '30/06/2010';
--and NgayLap >= '01/01/2010' and NgayLap <= '30/06/2010';
GO

select * from Cau32;

--Cau 3.5
GO
create view Cau35
AS
select P.MaNV, HoTen, NgaySinh, Phai, MaPX, NgayLap
from phieuxuat P, NhanVien N
where P.MaNV = N.MaNV
and N.MaNV = 'NV01';
GO

select * from Cau35;

drop view Cau36;
--Cau 3.6
GO
create view Cau
as
select MaNV, HoTen, NgaySinh, Phai
from NhanVien
where Phai = 1
and year(getdate()) - year(NgaySinh) between 25 and 40;  
GO

select * from Cau3

select HoTen, year(getdate()) - year(NgaySinh) as Tuoi from NhanVien
 ;

 GO
 create view cau3x7
 as
 select P.MaNV, HoTen, count(MaPX) as TSL
 from NhanVien N, phieuxuat P 
 where N.MaNV = P.MaNV
 
 group by P.MaNV, HoTen
 ;
 GO