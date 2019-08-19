﻿USE BAITAP5

--CAU 1: LIET KE SP CO NHIEU SAN PHAM NHAT
SELECT TOP 1 WITH TIES TENLOAI,COUNT(*)AS SOSP
FROM SANPHAM SP,LOAISP L
WHERE SP.MALOAI=L.MALOAI
GROUP BY L.MALOAI,TENLOAI
ORDER BY COUNT(*) DESC 

--CAU 2: DANH SACH KHACH HANG KHONG DAT HANG TRONG THANG 3/2004(TEKH,DIACHI)
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

--CAU 4: DS CAC SAN PHAM KHONG DUOC DAT TRONG THANG 3/2004(TENSP,MOTA)
SELECT DISTINCT TENSP,MOTA
FROM DONDH D,CHITIETDDH CT,SANPHAM S
WHERE D.SODDH=CT.SODDH
	AND CT.MASP=S.MASP
	AND S.MASP NOT IN(SELECT CT.MASP
						FROM DONDH D,CHITIETDDH CT
						WHERE D.SODDH=CT.SODDH
							AND MONTH(NGAYDAT)=3
							AND YEAR(NGAYDAT)=2004)

--CAU 5: DSKH CO DAT TREN 10 CAI TU DDA(TENKH,DIACHI,TONGSOLUONG)
SELECT DISTINCT TENKH,DIACHI,SUM(SOLUONG)AS TONG
FROM KHACHHANG KH,DONDH D,CHITIETDDH CT,SANPHAM S
WHERE CT.SODDH=D.SODDH
	AND KH.MAKH=D.MAKH
	AND CT.MASP=S.MASP
	AND TENSP=N'Tủ DDA'
GROUP BY KH.MAKH,TENKH,DIACHI
HAVING SUM(SOLUONG)>10


--CAU 6: DS CAC SAN PHAM DUOC LAM TU NHIEU LOAI NGUYEN LIEU NHAT(TENSP,GIA,SOLOAI)
SELECT  TOP 1 WITH TIES TENSP,S.GIA,COUNT(*) AS SOLOAI
FROM SANPHAM S,LAM L,NGUYENLIEU NL
WHERE S.MASP=L.MASP
	AND NL.MANL=L.MANL
GROUP BY S.MASP,TENSP,S.GIA
ORDER BY COUNT(*)DESC

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

-- CAU 10: CAC NL LAM RA TAT CA CA SP(TENNL,GIA)
SELECT TENNL,N.GIA
FROM LAM L,NGUYENLIEU N
WHERE L.MANL=N.MANL
GROUP BY L.MANL,TENNL,N.GIA
HAVING COUNT(*)=(SELECT COUNT(*)
					FROM SANPHAM)

-- CAU 11:DANH SACH KHACH HANG CO DAT TAT CA CAC SAN PHAM(TENKH,DC)
--CHU Y KHACH HANG CO THE MUA HANG TRUNG NEN PHAI COUNT(DISTINCT)
SELECT TENKH,DIACHI
FROM KHACHHANG K,DONDH D,CHITIETDDH C
WHERE K.MAKH=D.MAKH
	AND D.SODDH=C.SODDH
GROUP BY K.MAKH,TENKH,DIACHI
HAVING COUNT(DISTINCT MASP)=(SELECT COUNT(*)
							FROM SANPHAM)

--CAU 12: DS CAC SAN PHAM TAT CA CAC KHACH HANG DEU DAT(TENSP,MOTA)
SELECT TENSP,MOTA
FROM SANPHAM S,KHACHHANG K,DONDH D,CHITIETDDH C
WHERE S.MASP=C.MASP
	AND C.SODDH=D.SODDH
	AND K.MAKH=D.MAKH
GROUP BY S.MASP,TENSP,MOTA
HAVING COUNT(K.MAKH)=(SELECT COUNT(*)
					FROM KHACHHANG)

--CAU 13: DS KH LAU NHAT CHUA DAT  HANG
SELECT TOP 1 WITH TIES MAKH
FROM DONDH 
GROUP BY MAKH
ORDER BY MAX(NGAYDAT)
