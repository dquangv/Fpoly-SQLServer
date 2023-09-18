use QLDA;
go

-- 1. Tìm các nhân viên làm vi?c ? phòng s? 4
select *
from nhanvien
where phg = 4;
go

-- 2. Tìm các nhân viên có m?c l??ng trên 30000
select *
from nhanvien
where luong > 30000;
go

-- 3. Tìm các nhân viên có m?c l??ng trên 25,000 ? phòng 4 ho?c các nhân viên có m?c l??ng trên 30,000 ? phòng 5
select *
from nhanvien
where (luong > 25000 and phg = 4) or (luong > 30000 and phg = 5);
go

-- 4. Cho bi?t h? tên ??y ?? c?a các nhân viên ? TP HCM
select concat(honv, ' ', tenlot, ' ', tennv) as HoTen
from nhanvien
where dchi like N'%TP HCM%' or dchi like N'%TP H? Chí Minh%';
go

select *
from nhanvien;
go

-- 5. Cho bi?t h? tên ??y ?? c?a các nhân viên có h? b?t ??u b?ng ký t? 'N'
select concat(honv, ' ', tenlot, ' ', tennv) as HoTen
from nhanvien
where honv like N'N%';
go

-- 6. Cho bi?t ngày sinh và ??a ch? c?a nhân viên Dinh Ba Tien
select concat(honv, ' ', tenlot, ' ', tennv) as HoTen, ngsinh, dchi
from nhanvien
where concat(honv, ' ', tenlot, ' ', tennv) = N'Đinh  Bá  Tiên';
go