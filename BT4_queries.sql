USE BAITAP4;
GO

---------CREATE VIEW---------
CREATE VIEW CAU01
AS
SELECT TOP(1) S.TENSP, SOLUONG
FROM SANPHAM S, CTDDH C
WHERE S.MASP=C.MASP
GROUP BY TENSP,SOLUONG

CREATE VIEW CAU02
AS
SELECT K.TENKH, DC
FROM KHACHHANG K, DONDH D
WHERE K.MAKH=D.MAKH
AND NOT MONTH(NGAYDAT)='3' OR NOT YEAR(NGAYDAT)='2010'

CREATE VIEW CAU03
AS
SELECT TOP(1) K.TENKH, DC
FROM KHACHHANG K, DONDH D
WHERE K.MAKH=D.MAKH
AND MONTH(NGAYDAT)='3' AND YEAR(NGAYDAT)='2010'
GROUP BY K.TENKH,DC

CREATE VIEW CAU04
AS
SELECT S.TENSP,MOTA
FROM SANPHAM S,CTDDH C,DONDH D
WHERE S.MASP=C.MASP
AND C.SODDH=D.SODDH
AND MONTH(NGAYDAT)='3' OR YEAR(NGAYDAT)='2010'

--xxx
CREATE VIEW CAU05
AS
SELECT K.TENKH, DC,SOLUONG
FROM KHACHHANG K, DONDH D, CTDDH C,SANPHAM S
WHERE K.MAKH=D.MAKH
AND D.SODDH=C.SODDH
AND S.MASP=C.MASP
AND SOLUONG > 10
AND TENSP='Tu DDA'

CREATE VIEW CAU06
AS
SELECT TOP(1) S.TENSP, N.GIA,COUNT(N.MANL) AS SOLOAI 
FROM SANPHAM S, NGUYENLIEU N, LAM L
WHERE S.MASP=L.MASP
AND N.MANL=L.MANL
GROUP BY TENSP,N.GIA
ORDER BY TENSP,GIA

--xxx
CREATE VIEW CAU07
AS
SELECT TENSP, SUM(N.GIA) AS GIATHANHSX
FROM SANPHAM S, NGUYENLIEU N, LAM L
WHERE L.MANL=N.MANL
AND L.MASP=S.MASP
AND N.GIA > 10000000
GROUP BY S.TENSP



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

select * from KhachHang;

create function Cong(@A int, @B int)
returns int
as
begin
return(@A + @B)
end

print 'Tong: ' + STR(dbo.Cong(5,5))


create function test(@MaKH char(5))
returns char
as
begin 
return(select DC from KhachHang
where MaKH = @MaKH)
end

drop function test;

--print 'SDT: ' + STR((dbo.test('KH001'))
select dbo.test('KH002')


