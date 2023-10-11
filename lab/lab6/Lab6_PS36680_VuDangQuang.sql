-- Lab 6
use QLDA;
go

-- Bài 1: Trigger DML
-- Ràng buộc khi thêm mới nhân viên thì mức lương phải lớn hơn 15000, nếu vi phạm thì xuất thông báo “luong phải >15000’
create trigger check_insertLuong on nhanvien
for insert
as
if (select luong from inserted) < 15000
	begin
		print N'lương phải > 15000';
		rollback transaction
	end;
go

insert into nhanvien values
(N'Vũ', N'Hoàng', N'Long', '019', '1999-07-01', '39 ĐN, TP HCM', 'Nam', 5000, '006', 1);
go

-- Ràng buộc khi thêm mới nhân viên thì độ tuổi phải nằm trong khoảng 18 <= tuổi <=65.
create trigger check_insertTuoi on nhanvien
for insert
as
declare @age int = (select year(getdate()) - year(ngsinh) from inserted);
if @age < 18 or @age > 65
	begin
		print N'Ngoài độ tuổi lao động (18 đến 65)';
		rollback transaction
	end;
go

insert into nhanvien values
(N'Vũ', N'Thế', 'Vinh', '020', '1957-12-07', '29 ĐN, TP HCM', 'Nam', 16000, '006', 1);
go

-- Ràng buộc khi cập nhật nhân viên thì không được cập nhật những nhân viên ở TP HCM
create trigger check_updateDChi on nhanvien
for update
as
if (select dchi from inserted) like '%TP HCM'
	begin
		print N'Không cập nhật những nhân viên thuộc khu vực TP HCM';
		rollback transaction
	end;
go

update nhanvien
set tennv = 'Long'
where manv = '009';
go

-- Bài 2: Trigger After
-- Hiển thị tổng số lượng nhân viên nữ, tổng số lượng nhân viên nam mỗi khi có hành động thêm mới nhân viên.
create trigger count_NV on nhanvien
after insert
as
begin
	declare @nvNu int;
	declare @nvNam int;

	set @nvNu = (select count(manv) from nhanvien where phai like N'Nữ');
	set @nvNam = (select count(manv) from nhanvien where phai like N'Nam');

	print N'Tổng số lượng nhân viên nữ sau khi thêm nhân viên: ' + cast(@nvNu as nvarchar);
	print N'Tổng số lượng nhân viên nam sau khi thêm nhân viên: ' + cast(@nvNam as nvarchar);
end;
go

insert into nhanvien values
(N'Nguyễn', N'Thị Ánh', N'Tuyết', '021', '1967-07-20', '19 ĐN, TP HCM', N'Nữ', 17000, '005', 1);
go

-- Hiển thị tổng số lượng nhân viên nữ, tổng số lượng nhân viên nam mỗi khi có hành động cập nhật phần giới tính nhân viên
create trigger count_NV_Phai on nhanvien
after update
as
begin
	if (update (phai))
		begin
			declare @nvNu int = 
				(select count(manv) from nhanvien where phai like N'Nữ');
			declare @nvNam int = 
				(select count(manv) from nhanvien where phai like N'Nam');

			print N'Tổng số lượng nhân viên nữ sau khi thêm nhân viên: ' + cast(@nvNu as nvarchar);
			print N'Tổng số lượng nhân viên nam sau khi thêm nhân viên: ' + cast(@nvNam as nvarchar);
		end;
end;
go

update nhanvien
set phai = N'Nữ'
where manv = '004';
go

-- Hiển thị tổng số lượng đề án mà mỗi nhân viên đã làm khi có hành động xóa trên bảng DEAN
create trigger count_dean on dean
after delete
as
begin
	select ma_nvien, count(mada) as SoLuongDeAn
	from phancong
	group by ma_nvien;
end;
go

delete dean where mada = 22;
go

-- Bài 3: Trigger iNSTEAD OF
-- Xóa các thân nhân trong bảng thân nhân có liên quan khi thực hiện hành động xóa nhân viên trong bảng nhân viên.
create trigger del_ThanNhan on nhanvien
instead of delete
as
begin
	delete from thannhan where ma_nvien in
		(select manv from deleted);
	delete from nhanvien where manv in
		(select manv from deleted);
end;
go

delete from nhanvien where manv = '017';
go

-- Khi thêm một nhân viên mới thì tự động phân công cho nhân viên làm đề án có MADA là 1.
create trigger add_PhanCong on nhanvien
instead of insert
as
begin
	insert into nhanvien values
	((select honv from inserted), (select tenlot from inserted), (select tennv from inserted), (select manv from inserted), (select ngsinh from inserted), (select dchi from inserted), (select phai from inserted), (select luong from inserted), (select ma_nql from inserted), (select phg from inserted));
	insert into phancong values
	((select manv from inserted), 1, 2, 10);
end;
go

insert into nhanvien values
(N'Trương', N'Thị Minh', N'Ngọc', '018', '2001-07-25', '9 ĐN, TP HCM', N'Nữ', 18000, '005', 1);
go