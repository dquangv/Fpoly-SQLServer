-- Lab 5

-- Bài 1: Viết stored-procedure
-- In ra dòng ‘Xin chào’ + @ten với @ten là tham số đầu vào là tên Tiếng Việt có dấu của bạn
create or alter proc lab5Bai1Caua 
	@ten nvarchar(15)
as
begin
	print N'Xin chào ' + @ten;
end;
go

exec lab5Bai1Caua N'Vũ Đăng Quang';
go

-- Nhập vào 2 số @s1,@s2. In ra câu ‘Tổng là : @tg’ với @tg=@s1+@s2
create or alter proc lab5Bai1Caub 
	@s1 int, @s2 int
as
begin
	declare @tg int;

	set @tg = @s1 + @s2;

	print N'Tổng là: ' + cast(@tg as char(5));
end;
go

exec lab5Bai1Caub 7, 9;
go

-- Nhập vào số nguyên @n. In ra tổng các số chẵn từ 1 đến @n
create or alter proc lab5Bai1Cauc
	@n int
as
begin
	declare @i int = 2, @tong int = 0;
	
	while (@i <= @n)
	begin
		set @tong += @i;
		set @i += 2;
	end;

	select @tong as TongSoChan;
end;
go

exec lab5Bai1Cauc 79;
go

-- Nhập vào 2 số. In ra ước chung lớn nhất của chúng
create or alter proc lab5Bai1Caud
	@s1 int, @s2 int, @ucln int out
as
begin
	if (@s1 > @s2)
		begin
			set @s1 = @s1 + @s2;
			set @s2 = @s1 - @s2;
			set @s1 = @s1 - @s2;
		end;
	
	begin
		while (@s1 <> 0)
		begin
			set @s1 = @s1 + @s2;
			set @s2 = @s1 - @s2;
			set @s1 = (@s1 - @s2) % @s2;
		end;

		set @ucln = @s2;
	end;
end;
go

declare @ucln int;
exec lab5Bai1Caud 36, 24, @ucln out;
select @ucln as UocChungLonNhat;
go

-- Bài 2: Sử dụng cơ sở dữ liệu QLDA, viết các proc
use QLDA;
go

-- Nhập vào @Manv, xuất thông tin các nhân viên theo @Manv.
create or alter proc lab5Bai2Caua
	@manv nvarchar(9)
as
begin
	select *
	from nhanvien
	where manv = @manv;
end;
go

exec lab5Bai2Caua '007';
go

-- Nhập vào @MaDa (mã đề án), cho biết số lượng nhân viên tham gia đề án đó
create or alter proc lab5Bai2Caub
	@mada int
as
begin
	select mada as MaDeAn, count(ma_nvien) as SoLuongNhanVienThamGia
	from phancong
	where mada = @mada
	group by mada;
end;
go

exec lab5Bai2Caub 20;
go

-- Nhập vào @MaDa và @Ddiem_DA (địa điểm đề án), cho biết số lượng nhân viên tham gia đề án có mã đề án là @MaDa và địa điểm đề án là @Ddiem_DA
create or alter proc lab5Bai2Cauc
	@mada int, @ddiem_da nvarchar(15)
as
begin
	select da.mada as MaDeAn, ddiem_da as DiaDiemDeAn, count(pc.ma_nvien) as SoLuongNhanVienThamGia
	from dean da
	join congviec cv on da.mada = cv.mada
	join phancong pc on cv.mada = pc.mada
	where da.mada = @mada and ddiem_da = @ddiem_da
	group by da.mada, ddiem_da;
end;
go

exec lab5Bai2Cauc 3, 'TP HCM';
go

-- Nhập vào @Trphg (mã trưởng phòng), xuất thông tin các nhân viên có trưởng phòng là @Trphg và các nhân viên này không có thân nhân.
create or alter proc lab5Bai2Caud
	@trphg nvarchar(9)
as
begin
	select concat(nv.honv, ' ', nv.tenlot, ' ', nv.tennv) as HoTenTruongPhong, concat(nhanvien.honv, ' ', nhanvien.tenlot, ' ', nhanvien.tennv) as HoTenNhanVien
	from nhanvien
	join phongban pb on nhanvien.phg = pb.maphg
	join nhanvien nv on pb.trphg = nv.manv
	where pb.trphg = @trphg
		and pb.trphg <> nhanvien.manv
		and nhanvien.manv not in (
			select ma_nvien
			from thannhan);
end;
go

exec lab5Bai2Caud '008';
go

-- Nhập vào @Manv và @Mapb, kiểm tra nhân viên có mã @Manv có thuộc phòng ban có mã @Mapb hay không
create or alter proc lab5Bai2Caue
	@manv nvarchar(9), @mapb int
as
begin
	if exists (
		select *
		from nhanvien
		where manv = @manv and phg = @mapb)
		print N'Nhân viên có mã ' + @manv + N' thuộc phòng ban ' + cast(@mapb as nvarchar);
	else
		print N'Nhân viên có mã ' + @manv + N' không thuộc phòng ban ' + cast(@mapb as nvarchar);
end;
go

exec lab5Bai2Caue '007', 4;
go

-- Bài 3: Sử dụng cơ sở dữ liệu QLDA, viết các proc
-- Thêm phòng ban có tên CNTT vào csdl QLDA, các giá trị được thêm vào dưới dạng tham số đầu vào, kiếm tra nếu trùng Maphg thì thông báo thêm thất bại
create or alter proc lab5Bai3Caua
	@tenpb nvarchar(15), @mapb int, @trpb nvarchar(9), @ngaync date
as
begin
	if exists (select maphg from phongban where maphg = @mapb)
		print N'Thêm thất bại';
	else
		begin
			insert into phongban values
			(@tenpb, @mapb, @trpb, @ngaync);
		end;
end;
go

exec lab5Bai3Caua 'CNTT', 9, '009', '2023-09-07';
go

-- Cập nhật phòng ban có tên CNTT thành phòng IT
create or alter proc lab5Bai3Caub
as
begin
	if exists (select tenphg from phongban where tenphg = 'CNTT')
		begin
			update phongban
			set tenphg = 'IT'
			where tenphg = 'CNTT'
		end
	else
		print N'Không tồn tại phòng ban CNTT';
end;
go

exec lab5Bai3Caub;
go
	
-- Thêm một nhân viên vào bảng NhanVien, tất cả giá trị đều truyền dưới dạng tham số đầu vào với điều kiện
-- nhân viên này trực thuộc phòng IT
-- Nhận @luong làm tham số đầu vào cho cột Luong, nếu @luong<25000 thì nhân viên này do nhân viên có mã 009 quản lý, ngươc lại do nhân viên có mã 005 quản lý
-- Nếu là nhân viên nam thi nhân viên phải nằm trong độ tuổi 18-65, nếu là nhân viên nữ thì độ tuổi phải từ 18-60
create or alter proc lab5Bai3Cauc
	@honv nvarchar(15), @tenlot nvarchar(15), @tennv nvarchar(15), @manv nvarchar(9), @ngsinh datetime, @dchi nvarchar(30), @phai nvarchar(3), @luong float, @phg int
as
begin
	declare @ma_nql nvarchar(9);

	if @phg in (select maphg from phongban where tenphg = 'IT')
		begin
			if (@luong < 25000)
				set @ma_nql = '009'
			else
				set @ma_nql = '005'

			if (@phai = 'Nam' and year(getdate()) - year(@ngsinh) between 18 and 65
			or @phai = N'Nữ' and year(getdate()) - year(@ngsinh) between 18 and 60)
				insert into nhanvien values
				(@honv, @tenlot, @tennv, @manv, @ngsinh, @dchi, @phai, @luong, @ma_nql, @phg)
			else
				print N'Không thuộc độ tuổi lao động'
		end
	else
		print N'Không thuộc phòng ban IT';
end;
go

exec lab5Bai3Cauc N'Vũ', N'Đăng', N'Quang', '018', '1998-09-07', '49 ĐN, TP HCM', 'Nam', 50000, 9;
go

-- Bài 4:
-- Viết SP thêm một phân công công việc mới vào bảng phân công, tất cả giá trị đều truyền dưới dạng tham số đầu vào. Có kiểm tra rỗng và các ràng buộc khóa chính, khóa ngoại.
create or alter proc lab5Bai4Caua
	@manv nvarchar(9), @mada int, @stt int, @thoigian float
as
begin
	if (@manv is not null
	and @mada is not null
	and @stt is not null)
		begin
			if exists (select *
						from phancong
						where ma_nvien = @manv)
			and exists (select *
						from nhanvien
						where manv = @manv)
				begin
					if exists (select *
								from phancong
								where mada = @mada and stt = @stt)
					and exists (select *
								from congviec
								where mada = @mada and stt = @stt)
						begin
							if not exists (select *
											from phancong
											where ma_nvien = @manv and mada = @mada and stt = @stt)
								begin
									insert into phancong values
									(@manv, @mada, @stt, @thoigian);
								end
							else
								begin
									print N'Đã tồn tại thực thể này';
								end
						end
					else
						begin
							print N'Lỗi khoá ngoại không trùng khớp (bảng phân công và bảng công việc)';
						end
				end
			else
				begin
					print N'Lỗi khoá ngoại không trùng khớp (bảng phân công và bảng nhân viên)';
				end
		end
	else
		begin
			print N'Mã nhân viên, mã dự án và stt không được để rỗng';
		end
end;
go

exec lab5Bai4Caua '003', 20, 1, 20;
go