USE BAITAP4;
GO

select * from KhachHang;
go

create proc DSKH @X int
as set rowcount @X 
select TenKH
from KhachHang;
GO

exec DSKH 100;
go



create proc Cau6a  @Ngay datetime
AS
select K.TenKH, DC, NgayDat
from KhachHang K, DonDH D
where K.MaKH = D.MaKH
and NgayDat = @Ngay

GO

exec Cau6a '20040315';
GO

select * from DonDH;
--drop proc Cau6a;
--go

--drop proc Cau7a;

create proc Cau7a @MaSo char(5)
AS 
select S.MaSP, TenKH, DC
from KhachHang K, DonDH D, SanPham S, CTDDH C
where K.MaKH = D.MaKH
and D.SoDDH = C.SoDDH
and C.MaSP = S.MaSP
and S.MaSP = @MaSo
;
GO

select * from SanPham;

exec Cau7a 'SP01';


select K.MaKH, TenKH, DC, TenSP, SoLuong, sum(Gia) as TongGia
from
KhachHang K, SanPham S, DonDH D, CTDDH C
where
K.MaKH = D.MaKH
and D.SoDDH = C.SoDDH
and C.MaSP = S.MaSP
group by K.MaKH
;

create proc TongTien @X int
as

select S.MaSP, K.MaKH, TenKH, DC, Gia*SoLuong as TongGia--, sum(Gia*SoLuong) as TongGia
from KhachHang K, DonDH D, SanPham S, CTDDH C
where K.MaKH = D.MaKH
and D.SoDDH = C.SoDDH
and C.MaSP = S.MaSP
--and Gia*SoLuong = @X
--group by S.MaSP, K.MaKH, TenKH, DC;

exec TongTien 3000000;

select 
S.MaSP, SoDDH, count(SoLuong) as TSL
from 
SanPham S, CTDDH C
group by S.MaSP, SoDDH




