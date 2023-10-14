-- Lab 7
use QLDA;
go

-- Bài 1: Viết các hàm
-- Nhập vào MaNV cho biết tuổi của nhân viên này.
create function fAge(@manv nvarchar(9))
returns int
as
begin
	return (select year(getdate()) - year(ngsinh) from nhanvien where manv like @manv);
end;
go

print N'Tuổi của nhân viên này là: ' + convert(nvarchar, dbo.fAge('001'));
go

-- Nhập vào Manv cho biết số lượng đề án nhân viên này đã tham gia
create function fCountStaffProject(@manv nvarchar(9))
returns int
as
begin
	return (select count(mada) from phancong where ma_nvien like @manv);
end;
go

print N'Số lượng đề án mà nhân viên này tham gia: ' + cast(dbo.fCountStaffProject('001') as nvarchar);
go

-- Truyền tham số vào phái nam hoặc nữ, xuất số lượng nhân viên theo phái
create function fCountStaffSex(@phai nvarchar(3))
returns int
as
begin
	return (select count(manv) from nhanvien where phai = @phai);
end;
go

print N'Số lượng nhân viên của phái này là: ' + cast(dbo.fCountStaffSex(N'Nữ') as nvarchar);
go

-- Truyền tham số đầu vào là tên phòng, tính mức lương trung bình của phòng đó, Cho biết họ tên nhân viên (HONV, TENLOT, TENNV) có mức lương trên mức lương trung bình của phòng đó.
create function fAve_TenPhg(@tenphg nvarchar(15))
returns table
as
return (
	select concat(honv, ' ', tenlot, ' ', tennv) as HoVaTen, luong
	from nhanvien join phongban on nhanvien.phg = phongban.maphg
	where luong > (
					select avg(luong)
					from nhanvien join phongban on nhanvien.phg = phongban.maphg
					where tenphg = @tenphg)
);
go

select *
from fAve_TenPhg(N'Điều Hành');
go

-- Tryền tham số đầu vào là Mã Phòng, cho biết tên phòng ban, họ tên người trưởng phòng và số lượng đề án mà phòng ban đó chủ trì
create function fTrPhong_DAn(@maphg int)
returns table
as
return (
	select tenphg as TenPhongBan, concat(honv, ' ', tenlot, ' ', tennv) as HoTenTruongPhong, count(mada) as SoLuongDeAn
	from phongban pb join nhanvien nv on pb.trphg = nv.manv join dean da on pb.maphg = da.phong
	where maphg = @maphg
	group by tenphg , concat(honv, ' ', tenlot, ' ', tennv)
);
go

select *
from fTrPhong_DAn(5);
go

-- Bài 2: Tạo các view
-- Hiển thị thông tin HoNV,TenNV,TenPHG, DiaDiemPhg.
create view view_NhVien_Phong
as
select honv, tennv, tenphg, diadiem
from nhanvien nv join phongban pb on nv.phg = pb.maphg join diadiem_phg ddphg on ddphg.maphg = pb.maphg;
go

select *
from view_NhVien_Phong;
go

-- Hiển thị thông tin TenNv, Lương, Tuổi.
create view view_NhVien_Luong_Tuoi
as
select tennv, luong, year(getdate()) - year(ngsinh) as Tuoi
from nhanvien;
go

select *
from view_NhVien_Luong_Tuoi;
go
-- Hiển thị tên phòng ban và họ tên trưởng phòng của phòng ban có đông nhân viên nhất
create view view_PhongDongNhat_TrPhong
as
select tenphg as TenPhongBan, concat(nv.honv, ' ', nv.tenlot, ' ', nv.tennv) as HoTenTruongPhong, count(nhanvien.manv) as SoLuongNhanVien
from phongban pb 
join nhanvien nv on pb.trphg = nv.manv
join nhanvien on pb.maphg = nhanvien.phg
group by tenphg, concat(nv.honv, ' ', nv.tenlot, ' ', nv.tennv)
having count(nhanvien.manv) >= (
	select top 1 count(manv)
	from nhanvien
	group by phg
	order by count(manv) desc);
go

select *
from view_PhongDongNhat_TrPhong;
go

-- Bài 3
-- Tạo View hiển thị thông tin MaNV, HoTenNV, TenPHG, Tổng thời gian tham gia vào các dự án.
create view Lab7Bai3Caua
as
select manv, concat(honv, ' ', tenlot, ' ', tennv) as HoTenNV, tenphg, sum(thoigian) as TongThoiGianDuAn
from nhanvien nv
join phongban pb on nv.phg = pb.maphg
join phancong pc on nv.manv = pc.ma_nvien
group by manv, concat(honv, ' ', tenlot, ' ', tennv), tenphg;
go

select *
from Lab7Bai3Caua;
go

-- Tạo View cho phép cập nhật thông tin DeAn, gồm: MaDA, TenDA, DDIEM_DA, PHONG. Thực hiện thêm 1 đề án mới vào View vừa tạo.
create view Lab7Bai3Caub
as
select mada, tendean, ddiem_da, phong
from dean;
go

insert into Lab7Bai3Caub values
(4, N'Sản phẩm A', N'Đà Lạt', 4);
go

-- Viết hàm cho nhập vào MaDA, tính tổng thời gian làm việc của các nhân nhiên tham gia đề án đó.
create function fLab7Bai3Cauc(@mada int)
returns table
as
return (
	select mada, sum(thoigian) as TongThoiGianLamViec
	from phancong
	where mada = @mada
	group by mada
);
go

select *
from fLab7Bai3Cauc(20);
go

-- Viết hàm cho nhập vào MaDA, đếm số nhân nhiên tham gia đề án đó.
create function fLab7Bai3Caud(@mada int)
returns table
as
return (
	select mada, count(ma_nvien) as SoLuongNhanVienThamGia
	from phancong
	where mada = @mada
	group by mada
);
go

select *
from fLab7Bai3Caud(1);
go

-- Viết truy vấn hiển thị thông tin: MaDA, TenDA, TenPB chủ trì, số nhân viên tham gia đề án, Tổng thời gian tham gia. (sử dụng 2 hàm đã tạo ở câu trên)
select fc.mada, da.tendean, pb.tenphg, fd.SoLuongNhanVienThamGia, fc.TongThoiGianLamViec
from fLab7Bai3Cauc(1) fc
join fLab7Bai3Caud(1) fd on fc.mada = fd.mada
join dean da on fc.mada = da.mada
join phongban pb on da.phong = pb.maphg;
go