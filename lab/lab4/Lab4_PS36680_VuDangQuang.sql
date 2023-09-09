-- Lab 4
use QLDA;
go

-- Bài 1: Sử dụng if... else và case
-- Viết chương trình xem xét có tăng lương cho nhân viên hay không. Hiển thị cột thứ 1 là TenNV, cột thứ 2 nhận giá trị
-- “TangLuong” nếu lương hiện tại của nhân viên nhở hơn trung bình lương trong phòng mà nhân viên đó đang làm việc.
-- “KhongTangLuong “ nếu lương hiện tại của nhân viên lớn hơn trung bình lương trong phòng mà nhân viên đó đang làm việc.
declare @LuongTrungBinh table
	(phongban int, luongTB float);

insert into @LuongTrungBinh
select phg, avg(luong)
from nhanvien
group by phg;

select tennv, iif(luong < luongTB, 'TangLuong', 'KhongTangLuong') as TinhTrang
from nhanvien nv
join @LuongTrungBinh ltb on nv.phg = ltb.phongban;
go

-- Viết chương trình phân loại nhân viên dựa vào mức lương.
-- Nếu lương nhân viên nhỏ hơn trung bình lương mà nhân viên đó đang làm việc thì xếp loại “nhanvien”, ngược lại xếp loại “truongphong”
select tennv,
	iif(luong <
		(select avg(luong)
		from nhanvien), 'nhanvien', 'truongphong') as PhanLoai
from nhanvien;
go

-- Viết chương trình hiển thị TenNV như hình bên dưới, tùy vào cột phái của nhân viên
select tennv = case
when phai like 'Nam' then 'Mr. ' + tennv
when phai like N'Nữ' then 'Ms. ' + tennv
else 'FreeSex. ' + tennv
end
from nhanvien;
go

-- Viết chương trình tính thuế mà nhân viên phải đóng theo công thức
select tennv, luong, thue = case
when luong between 0 and 25000 then luong * 0.1
when luong between 25000 and 30000 then luong * 0.12
when luong between 30000 and 40000 then luong * 0.15
when luong between 40000 and 50000 then luong * 0.2
else luong * 0.25
end
from nhanvien;
go

-- Bài 2: Sử dụng vòng lặp
-- Cho biết thông tin nhân viên (HONV, TENLOT, TENNV) có MaNV là số chẵn
declare @i int = 2, @soCuoi int = (select max(cast(manv as int)) from nhanvien);
while (@i <= @soCuoi)
begin
	if exists (
		select honv, tenlot, tennv, manv
		from nhanvien
		where cast(manv as int) = @i)
			begin
				select honv, tenlot, tennv, manv
				from nhanvien
				where cast(manv as int) = @i;
			end;

	set @i += 2;
end;
go

-- Cho biết thông tin nhân viên (HONV, TENLOT, TENNV) có MaNV là số chẵn nhưng không tính nhân viên có MaNV là 4
declare @i int = 0, @soCuoi int = (select max(cast(manv as int)) from nhanvien)
while (@i <= @soCuoi)
begin
	set @i += 2;

	if (@i = 4)
		continue;

	if exists (
		select honv, tenlot, tennv, manv
		from nhanvien
		where cast(manv as int) = @i)
			begin
				select honv, tenlot, tennv, manv
				from nhanvien
				where cast(manv as int) = @i;
			end;

end;
go

-- Bài 3: Quản lý lỗi chương trình
-- Thực hiện chèn thêm một dòng dữ liệu vào bảng PhongBan theo 2 bước
-- Nhận thông báo “ thêm dư lieu thành cong” từ khối Try
begin try
	insert into phongban values
	(N'Nhân sự', 7, '007', '2023-09-07');
	print N'Thêm dữ liệu thành công';
end try
begin catch
	print N'Thêm dữ liệu thất bại';
end catch
go

-- Chèn sai kiểu dữ liệu cột MaPHG để nhận thông báo lỗi “Them dư lieu that bai” từ khối Catch
begin try
	insert into phongban values
	(N'Bảo trì', 'ABC', '008', '2023-07-25');
	print N'Thêm dữ liệu thành công';
end try
begin catch
	print N'Thêm dữ liệu thất bại';
end catch
go

-- Viết chương trình khai báo biến @chia, thực hiện phép chia @chia cho số 0 và dùng RAISERROR để thông báo lỗi
declare @chia int = 7;
begin try
	set @chia = @chia / 0;
end try
begin catch
	declare @ErMessage nvarchar(2048), @ErSeverity int, @ErState int
	select @ErMessage = ERROR_MESSAGE(), @ErSeverity = ERROR_SEVERITY(), @ErState = ERROR_STATE();
raiserror(@ErMessage, @ErSeverity, @ErState)
end catch
go