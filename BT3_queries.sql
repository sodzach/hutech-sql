--USE BAITAP3;
--GO
select * from CTPX;
go

create function F4(@MaNV varchar(5))
returns @Tonghop table
(
	MaPX int,
	MaNV varchar(5)
)

as
begin
	if (@MaNV is NULL) insert into @Tonghop
		select MaPX, MaNV from PhieuXuat --picks all
	else insert into @Tonghop
		select MaPX, N.MaNV from NhanVien N, PhieuXuat P
		where N.MaNV = P.MaNV and N.MaNV = @MaNV
	return
end


select * from F4('NV01')
select * from F4(NULL)

create function dbo.HienThiNV(@MaNV varchar(5))
returns table
as
return
	(select MaNV, HoTen, Phai, NgaySinh
	from NhanVien
	where MaNV like @MaNV)

drop function HienThiNV

select * from dbo.HienThiNV('NV01')

create function dbo.HienThiNV()
returns table
as
	return (select * from NhanVien)

select * from HienThiNV()
