use QLDA;

-- 1. T�m c�c nh�n vi�n l�m vi?c ? ph�ng s? 4
select *
from nhanvien
where phg = 4;

-- 2. T�m c�c nh�n vi�n c� m?c l??ng tr�n 30000
select *
from nhanvien
where luong > 30000;

-- 3. T�m c�c nh�n vi�n c� m?c l??ng tr�n 25,000 ? ph�ng 4 ho?c c�c nh�n vi�n c� m?c l??ng tr�n 30,000 ? ph�ng 5
select *
from nhanvien
where (luong > 25000 and phg = 4) or (luong > 30000 and phg = 5);

-- 4. Cho bi?t h? t�n ??y ?? c?a c�c nh�n vi�n ? TP HCM
select concat(honv, ' ', tenlot, ' ', tennv) as HoTen
from nhanvien
where dchi like N'%TP HCM%' or dchi like N'%TP H? Ch� Minh%';

select *
from nhanvien;


-- 5. Cho bi?t h? t�n ??y ?? c?a c�c nh�n vi�n c� h? b?t ??u b?ng k� t? 'N'
select concat(honv, ' ', tenlot, ' ', tennv) as HoTen
from nhanvien
where honv like N'N%';

-- 6. Cho bi?t ng�y sinh v� ??a ch? c?a nh�n vi�n Dinh Ba Tien
select concat(honv, '', tenlot, '', tennv) as HoTen, ngsinh, dchi
from nhanvien
where honv = N'?inh' and tenlot = N'B�' and tennv = N'Ti�n';