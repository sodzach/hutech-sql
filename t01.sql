﻿--CAU 2: DANH SACH KHACH HANG KHONG DAT HANG TRONG THANG 3/2004(TEKH,DIACHI)
SELECT KH.MAKH,TENKH,DIACHI
FROM KHACHHANG KH,DONDH D 
WHERE KH.MAKH=D.MAKH
 AND KH.MAKH NOT IN(SELECT MAKH
					FROM DONDH 
					WHERE MONTH(NGAYDAT)=3
						AND YEAR(NGAYDAT)=2004)

--CAU 3: DSKH DAT NHIEU DON HANG NHAT TRONG THANG 3/2004(TENKH,DIACHI)
SELECT TOP 1 WITH TIES KH.MAKH,TENKH,DIACHI
FROM KHACHHANG KH,DONDH D 
WHERE KH.MAKH=D.MAKH
	AND MONTH(NGAYDAT)=3
	AND YEAR(NGAYDAT)=2004
GROUP BY KH.MAKH,TENKH,DIACHI
ORDER BY COUNT(*)DESC



--CAU 5: DSKH CO DAT TREN 10 CAI TU DDA(TENKH,DIACHI,TONGSOLUONG)
create view cau5
as
SELECT DISTINCT TENKH,DIACHI,SUM(SOLUONG)AS TONG
FROM KHACHHANG KH,DONDH D,CHITIETDDH CT,SANPHAM S
WHERE CT.SODDH=D.SODDH
	AND KH.MAKH=D.MAKH
	AND CT.MASP=S.MASP
	AND TENSP=N'Tủ DDA'
GROUP BY KH.MAKH,TENKH,DIACHI
HAVING SUM(SOLUONG)>10

--CAU 7: DS CAC SAN PHAM CO GIA THANH SX TREN 1TRIEU(TENSP,GIATHANHSX)
SELECT  TENSP,SUM(L.SOLUONG*NL.GIA)  AS  GIATHANHSX
FROM  SANPHAM SP,LAM L,NGUYENLIEU NL 
WHERE  SP.MASP=L.MASP 
	AND  NL.MANL=L.MANL
GROUP  BY  TENSP,L.MASP
HAVING  SUM(L.SOLUONG*NL.GIA)>1000000

-- CAU 8: DANH SACH NHUNG SAN PHAM CO LAI >20%
SELECT TENSP,S.GIA,SUM(SOLUONG*N.GIA)AS GIATHANHSP,(S.GIA-SUM(SOLUONG*N.GIA))/SUM(SOLUONG*N.GIA)*100 AS PHANTRAM
FROM SANPHAM S,NGUYENLIEU N,LAM L
WHERE N.MANL=L.MANL
	AND L.MASP=S.MASP
GROUP BY S.MASP,TENSP,S.GIA
HAVING ((S.GIA-SUM(SOLUONG*N.GIA))/SUM(SOLUONG*N.GIA)*100)>20

--CAU 9: DS DON DAT HANG CO TONG SO TIEN LON HON 100 TRIEU (SODDH,NGAYDAT,TONGTIEN)
SELECT D.SODDH,NGAYDAT,SUM(SOLUONG*S.GIA)AS TONGTIEN
FROM SANPHAM S,DONDH D,CHITIETDDH CT
WHERE S.MASP=CT.MASP
	AND D.SODDH=CT.SODDH
GROUP BY D.SODDH,NGAYDAT
HAVING SUM(SOLUONG*S.GIA)>100000000

-- CAU 11:DANH SACH KHACH HANG CO DAT TAT CA CAC SAN PHAM(TENKH,DC)
--CHU Y KHACH HANG CO THE MUA HANG TRUNG NEN PHAI COUNT(DISTINCT)
SELECT TENKH,DIACHI
FROM KHACHHANG K,DONDH D,CHITIETDDH C
WHERE K.MAKH=D.MAKH
	AND D.SODDH=C.SODDH
GROUP BY K.MAKH,TENKH,DIACHI
HAVING COUNT(DISTINCT MASP)=(SELECT COUNT(*)
FROM SANPHAM)



------------ TRIGGER ----------
-- CAU 1: MOI NGAY KHACH HANG CHI DAT TOI DA 2 DON HANG
CREATE TRIGGER T1 ON DONDH
FOR INSERT,UPDATE
AS
IF EXISTS(SELECT MAKH,NGAYDAT
			FROM DONDH
			GROUP BY MAKH,NGAYDAT
			HAVING COUNT(*)>2)
BEGIN
	PRINT 'MOI NGAY CHI DAT TOI DA 2 DON HANG'
	ROLLBACK TRAN
END

DROP TRIGGER T1
INSERT INTO DONDH
VALUES('DH009','15/03/2004','KH001');

-- CAU 2: MOI DON DAT HANG CO TONG SO LUONG SAN PHAM KHONG QUA 100
CREATE TRIGGER T2 ON CHITIETDDH
FOR INSERT,UPDATE
AS
IF EXISTS(SELECT SODDH
			FROM CHITIETDDH
			GROUP BY SODDH
			HAVING SUM(SOLUONG)>100)
BEGIN
	PRINT 'MOI DON DAT HANG CO TONG SO LUONG SAN PHAM KHONG QUA 100'
	ROLLBACK TRAN
END