use master;
go

drop database QlNhaTro_ps36680;
go

create database QlNhaTro_ps36680;
go

use QlNhaTro_ps36680;
go

create table loainha (
maloainha int not null,
tenloainha nvarchar(50) not null,
constraint pk_loainha
primary key (maloainha)
);
go

create table nguoidung (
manguoidung int not null,
tennguoidung nvarchar(50) not null,
gioitinh nchar(3),
dienthoai varchar(12) not null,
diachi nvarchar(50) not null,
quan nvarchar(20) not null,
email varchar(50)
constraint pk_nguoidung
primary key (manguoidung)
);
go

create table nhatro (
manhatro int not null,
dientich float not null,
giaphong money not null,
diachi nvarchar(50) not null,
quan nvarchar(20) not null,
mota nvarchar(50),
maloainha int not null,
ngaydangtin date not null,
manguoilienhe int not null,
constraint pk_nhatro
primary key (manhatro)
);
go

create table danhgia (
manguoidanhgia int not null,
manhatro int not null,
danhgia bit not null,
noidung nvarchar(250),
constraint pk_danhgia
primary key (manguoidanhgia, manhatro)
);
go

alter table nhatro
add constraint fk_nhatro_loainha 
		foreign key (maloainha)
		references loainha(maloainha),
	constraint fk_nhatro_nguoidung
		foreign key (manguoilienhe)
		references nguoidung(manguoidung),
	constraint chk_dientich 
		check (dientich > 0),
	constraint chk_giaphong 
		check (giaphong > 0);
go

alter table danhgia
add constraint fk_danhgia_nguoidung 
		foreign key (manguoidanhgia)
		references nguoidung(manguoidung),
	constraint fk_danhgia_nhatro 
		foreign key (manhatro)
		references nhatro(manhatro);
go

insert into loainha values
(1, N'Chung cư'),
(2, N'Nhà đất'),
(3, N'Nhà trọ'),
(4, N'Biệt thự');
go

insert into nguoidung values
(1, N'Nguyễn Thị Ánh Tuyết', N'Nữ', '02666332262', 
N'2 Trường Chinh, phường 12', N'Quận Tân Bình', 'nguyenthianhtuyet@gmail.com'),
(2, N'Vũ Thế Vinh', 'Nam', '03666333363', 
N'3 Quang Trung, phường 8', N'Quận Gò Vấp', null),
(3, N'Vũ Hoàng Long', 'Nam', '04666334464', 
N'4 Điện Biện Phủ, phường 4', N'Quận 3', 'vuhoanglong@gmail.com'),
(4, N'Vũ Đăng Quang', 'Nam', '01666331161', 
N'1 Lê Trọng Tấn, phường Tây Thạnh', N'Quận Tân Phú', null),
(5, N'Trương Thị Minh Ngọc', N'Nữ', '05666335565', 
N'5 Tân Kỳ Tân Quý, phường Bình Hưng Hoà', N'Quận Bình Tân', 'truongthiminhngoc@gmail.com'),
(6, N'Phạm Đức Hải Duy', null, '06666336666', 
N'6 Phạm Ngũ Lão, phường Nguyễn Thái Bình', N'Quận 1', null),
(7, N'Nguyễn Tuấn Quỳnh', 'Nam', '07666337767', 
N'7 Vĩnh Khánh, phường 8', N'Quận 4', 'nguyentuanquynh@gmail.com'),
(8, N'Nguyễn Anh Điền Độ', 'Nam', '08666338868', 
N'8 Hà Huy Giáp, phường Thạnh Lộc', N'Quận 12', 'nguyenanhdiendo@gmail.com'),
(9, N'Nguyễn Thiện Thông', 'Nam', '09666339969', 
N'9 Vĩnh Viễn, phường 8', N'Quận 10', null),
(10, N'Dương Trung Nghĩa', null, '0066330060', 
N'10 Kha Vạn Cân, phường Linh Chiểu', N'Quận 9', 'duongtrungnghia@gmail.com'),
(11, N'Trần Trọng Nhân', N'Nữ', '0177330070',
N'11 Lê Trọng Tấn, phường 3', N'Quận 2', null),
(12, N'Nguyễn Văn Bắc', null, '0277330071',
N'12 Dương Đức Hiền, phường 12', N'Quận 7', null),
(13, N'Nguyễn Anh Quân', null, '0377330073',
N'13 Nguyễn Cửu Đàm, phường 7', N'Quận Tân Phú', 'nguyenanhquan@gmail.com'),
(14, N'Nguyễn Việt Hoà', 'Nam', '0777330073',
N'14 Tân Quý, phường 1', N'Quận Bình Tân', 'nguyenviethoa@gmail.com'),
(15, N'Trần Trọng Thân', N'Nữ', '08777330083',
N'15 Gò Dầu, phường 8', N'Quận Tân Bình', null),
(16, N'Nguyễn Văn A', 'Nam', '09777330093',
N'16 Tân Kỳ Tân Quý, phường 3', N'Quận Tân Phú', null),
(17, N'Nguyễn Văn B', N'Nữ', '01888330083',
N'17 Tây Thạnh, phường 4', N'Quận Tân Bình', null),
(18, N'Nguyễn Văn C', 'Nam', '02888330082',
N'18 Nguyễn Cửu Đàm, phường 7', N'Quận Tân Phú', null),
(19, N'Nguyễn Văn D', N'Nữ', '03888330083',
N'19 Dương Đức Hiền, phường 5', N'Quận Tân Bình', null),
(20, N'Nguyễn Văn E', 'Nam', '04888330084',
N'20 Tân Thắng, phường 12', N'Quận Bình Tân', null);
go

insert into nhatro values
(1, 54.2, 5500000000, N'1 Hương Lộ 2, phường Bình Trị Đông', 
N'Quận Bình Tân', N'5 phòng ngủ, 6 phòng vệ sinh', 2, '2023-09-07', 7),
(2, 200.5, 25900000000, N'2 Đường số 8, phường An Phú', N'Quận 2', 
N'5 phòng ngủ, 6 phòng vệ sinh, sân vườn', 2, '2023-07-25', 4),
(3, 35.7, 1850000000, N'3 Dương Thị Mười, phường Tân Chánh Hiệp', 
N'Quận 12', N'2 phòng ngủ, 2 phòng vệ sinh', 2, '2023-01-25', 6),
(4, 80, 3800000000, N'4 Võ Văn Kiệt, phường An Lạc', 
N'Quận Bình Tân',null, 1, '2023-08-22', 1),
(5, 92, 4500000, N'5 Võ Văn Kiệt, phường An Lạc', 
N'Quận Bình Tân', N'3 phòng ngủ, 2 phòng vệ sinh', 1, '2023-07-01', 9),
(6, 47.8, 1650000000, N'6 Nguyễn Xiển, phường Long Thạnh Mỹ', 
N'Quận 9', N'1 phòng ngủ', 1, '2023-07-20', 3),
(7, 35, 6500000, N'7 Đặng Văn Ngữ, phường 14', 
N'Quận Phú Nhuận', N'ban công, giữ xe miễn phí', 3, '2023-12-07', 8),
(8, 50, 12000000, N'8 Sông Đà, phường 2', 
N'Quận Tân Bình', null, 3, '2023-01-01', 10),
(9, 284.25, 34000000000, N'9 Lê Lai, phường 3', 
N'Quận Gò Vấp', N'1 trệt, 3 lầu, mặt tiền', 4, '2023-05-05', 5),
(10, 100, 15000000000, N'10 Quốc Lộ 13, phường Hiệp Bình Phước', 
N'Quận 9', N'1 hầm, 4 lầu, gần trường học, công viên, hồ bơi', 4, '2023-10-10', 2),
(11, 15.5, 2000000, N'11 Gò Dầu, phường 8',
N'Quận Tân Bình', null, 3, '2023-02-03', 14),
(12, 79, 4200000000, N'12 Sơn kỳ, phường Sơn Kỳ',
N'Quận Tân Phú', N'3 phòng ngủ, 2 phòng vệ sinh', 2, '2023-07-09', 14),
(13, 130.65, 18500000000, N'13 Trường Chinh, phường 8',
N'Quận Tân Bình', null, 4, '2023-08-10', 11),
(14, 97, 1200000000, N'14 Lý Thường Kiệt, phường 9',
N'Quận 10', N'ban công, 2 lầu', 1, '2023-07-26', 13),
(15, 20.7, 10000000, N'15 Võ Văn Ngân, phường Linh Phương',
N'Quận 9', null, 3, '2023-12-20', 15);
go

insert into danhgia values
(7, 10, 1, N'Tạm được'),
(10, 1, 1, null),
(2, 2, 0, N'Dơ'),
(9, 6, 0, N'Nhỏ'),
(4, 8, 0, N'Hôi'),
(1, 3, 1, N'Rộng'),
(5, 4, 0, N'An ninh kém'),
(6, 5, 0, null),
(7, 9, 1, N'Mát'),
(8, 7, 0, N'Bẩn'),
(14, 15, 1, N'Làm ăn được'),
(11, 8, 1, N'Không thơm lắm nhưng ở được'),
(13, 13, 0, N'Phòng bé như lỗ mũi'),
(2, 14, 0, N'Không nên ở'),
(10, 15, 1, null),
(8, 8, 1, N'Chán'),
(3, 10, 0, N'Như chuồng heo'),
(2, 4, 1, null),
(5, 12, 0, null),
(13, 7, 1, N'Như biệt thự'),
(9, 7, 0, null),
(1, 8, 1, N'Như đồn điền'),
(7, 3, 0, null),
(4, 8, 1, null),
(8, 4, 0, N'Oke'),
(7, 7, 0, N'Có moaa'),
(9, 9, 1, N'Có mèo'),
(10, 10, 0, N'Scam');
go

-- Y3. CÁC YÊU CẦU VỀ CHỨC NĂNG
-- Tạo ba Stored Procedure (SP) với các tham số đầu vào phù hợp.
-- SP thứ nhất thực hiện chèn dữ liệu vào bảng NGUOIDUNG
if object_id('nguoidung_insert', 'sp') is not null
drop function nguoidung_insert
go

create proc nguoidung_insert
	@manguoidung int, @tennguoidung nvarchar(50), @gioitinh nchar(3),
	@dienthoai varchar(12), @diachi nvarchar(50), @quan nvarchar(20), @email varchar(50)
as
begin
	if (@manguoidung is null) or (@tennguoidung is null) or 
	(@dienthoai is null) or (@diachi is null) or (@quan is null)
		begin
			print N'Yêu cầu nhập đầy đủ dữ liệu';
		end;
	else
		begin
			insert into nguoidung values
			(@manguoidung, @tennguoidung, @gioitinh, @dienthoai, @diachi, @quan, @email);

			select *
			from nguoidung;
		end;
end;
go

exec nguoidung_insert 16, N'Trần Trọng Đăng Khoa', null, '01111111111',
N'1 Quang Trung, phường 1', N'Quận 12', null;
go

exec nguoidung_insert 17, null, N'Nữ', '01222331121',
N'2 Quang trung, phường 1', N'Quận 12', 'nguyenanhdiendo@gmail.com';
go

-- SP thứ hai thực hiện chèn dữ liệu vào bảng NHATRO
if object_id('nhatro_insert', 'sp') is not null
drop function nhatro_insert
go

create proc nhatro_insert
	@manhatro int, @dientich float, @giaphong money, @diachi nvarchar(50), @quan nvarchar(20), 
	@mota nvarchar(50), @maloainha int, @ngaydangtin date, @manguoilienhe int
as
begin
	if (@manhatro is null) or (@dientich is null) or (@giaphong is null) or (@diachi is null) or
		(@quan is null) or (@maloainha is null) or (@ngaydangtin is null) or (@manguoilienhe is null)
		begin
			print N'Yêu cầu nhập liệu đầy đủ';
		end
	else
		begin
			insert into nhatro values
			(@manhatro, @dientich, @giaphong, @diachi, @quan, @mota, @maloainha, @ngaydangtin, @manguoilienhe);

			select *
			from nhatro;
		end
end;
go

exec nhatro_insert 16, 250, 30000000000, N'16 Đoàn Thị Điểm,
phường 12', N'Quận Tân Phú', null, 4, '2023-10-10', 10;
go

exec nhatro_insert 17, 500, 10, null, N'Quận Bình Tân', 
null, 4, null, 15;
go

-- SP thứ ba thực hiện chèn dữ liệu vào bảng DANHGIA
if object_id('danhgia_insert', 'sp') is not null
drop function danhgia_insert
go

create proc danhgia_insert
	@manguoidanhgia int, @manhatro int, @danhgia bit, @noidung nvarchar(250)
as
begin
	if (@manguoidanhgia is null) or (@manhatro is null) or (@danhgia is null)
		begin
			print N'Yêu cầu nhập liệu đầy đủ';
		end
	else
		begin
			insert into danhgia values
			(@manguoidanhgia, @manhatro, @danhgia, @noidung);
			
			select *
			from danhgia;
		end
end
go

exec danhgia_insert 12, 14, 1, null;
go

exec danhgia_insert null, 15, null, N'Đẹp';
go

-- Viết 1 SP với các tham số đầu vào phù hợp, thực hiện tìm kiếm thông tin các phòng trọ thoả mãn đk tìm kiếm theo: quận, phạm vi diện tích, phạm vi ngày đăng tin, khoảng giá tiền, loại hình nhà trọ.
if object_id('timkiem_phongtro', 'sp') is not null
drop function timkiem_phongtro
go

create proc timkiem_phongtro
	@quan nvarchar(20), @dientichMin float = null, @dientichMax float = null, @ngaydangtinMin date = null,
	@ngaydangtinMax date = null, @giaphongMin money = null, @giaphongMax money = null, @loainhatro nvarchar(50)
as
begin
	if (@dientichMin is null)
		select @dientichMin = min(dientich) from nhatro;
	if (@dientichMax is null)
		select @dientichMax = max(dientich) from nhatro;
	if (@ngaydangtinMin is null)
		select @ngaydangtinMin = min(ngaydangtin) from nhatro;
	if (@ngaydangtinMax is null)
		select @ngaydangtinMax = max(ngaydangtin) from nhatro;
	if (@giaphongMin is null)
		select @giaphongMin = min(giaphong) from nhatro;
	if (@giaphongMax is null)
		select @giaphongMax = max(giaphong) from nhatro;

	select N'Cho thuê phòng trọ tại ' + nt.diachi + ', ' + nt.quan as DiaChiNhaTro,
		replace(dientich, '.', ',') + ' m2' as DienTich,
		replace(substring(convert(varchar, giaphong, 1), 1,
		len(convert(varchar, giaphong, 1)) - 3), ',', '.') as GiaPhong,
		mota as MoTa,
		convert(varchar, ngaydangtin, 105) as NgayDangTin,
		NguoiLienHe = case
			when gioitinh = N'Nam' then 'A. ' + tennguoidung
			when gioitinh = N'Nữ' then 'C. ' + tennguoidung
			else tennguoidung
			end,
		dienthoai as SoDienThoai,
		nd.diachi + ', ' + nd.quan as DiaChiNguoiLienHe
	from nguoidung nd
	join nhatro nt on nd.manguoidung = nt.manguoilienhe
	join loainha ln on ln.maloainha = nt.maloainha
	where nt.quan = @quan
	and dientich between @dientichMin and @dientichMax
	and ngaydangtin between @ngaydangtinMin and @ngaydangtinMax
	and giaphong between @giaphongMin and @giaphongMax
	and tenloainha = @loainhatro;

	print cast(@dientichMin as varchar);
	print cast(@dientichMax as varchar);
	print cast(@ngaydangtinMin as varchar);
	print cast(@ngaydangtinMax as varchar);
	print cast(@giaphongMin as varchar);
	print cast(@giaphongMax as varchar);

end
go

exec timkiem_phongtro N'Quận Bình Tân', null, null,
null, null, null, null, N'Chung cư';
go

exec timkiem_phongtro N'Quận Tân Bình', null, 100,
'2023-01-01', '2023-11-11', 10000000, null, N'Nhà trọ';
go

-- Viết một hàm có các tham số đầu vào tương ứng với tất cả các cột của bảng NGUOIDUNG. Hàm này trả về mã người dùng (giá trị của cột khóa chính của bảng NGUOIDUNG) thỏa mãn các giá trị được truyền vào tham số
if object_id('fTimNguoiDung', 'fn') is not null
drop function fTimNguoiDung
go

create function fTimNguoiDung (@manguoidung int, @tennguoidung nvarchar(50),
								@gioitinh nchar(3), @dienthoai varchar(12),
								@diachi nvarchar(50), @quan nvarchar(20), @email varchar(50))
returns table
as
return
	(select manguoidung
	from nguoidung
	where manguoidung = @manguoidung and tennguoidung = @tennguoidung and gioitinh = @gioitinh
	and dienthoai = @dienthoai and diachi = @diachi and quan = @quan and email = @email)
go

select *
from fTimNguoiDung (1, N'Nguyễn Thị Ánh Tuyết', N'Nữ', '02666332262', 
N'2 Trường Chinh, phường 12', N'Quận Tân Bình', 'nguyenthianhtuyet@gmail.com');
go

-- Viết hàm có tham số đầu vào là mã nhà trọ (cột khóa chính của bảng NHATRO). Hàm này trả về tổng số LIKE và DISLIKE của nhà trọ này
if object_id('fLikeOrDisNhaTro', 'fn') is not null
drop function fLikeOrDisNhaTro
go

create function fLikeOrDisNhaTro (@manhatro int)
returns @LikeOrDisNhaTro table (Manhatro int, Solike int, Dislike int)
as
begin
	declare @like int = (select count(*) from danhgia where manhatro = @manhatro and danhgia = 1);
	declare @dislike int = (select count(*) from danhgia where manhatro = @manhatro and danhgia = 0);

	insert into @LikeOrDisNhaTro values
	(@manhatro, @like, @dislike);
return
end
go

select *
from fLikeOrDisNhaTro(15);
go

-- Tạo một View lưu thông tin của TOP 10 nhà trọ có số người dùng LIKE nhiều nhất gồm các thông tin sau: Diện tích, Giá, Mô tả, Ngày đăng tin, Tên người liên hệ, Địa chỉ, Điện thoại, Email
if object_id('Top10NhaTroLike', 'vw') is not null
drop function Top10NhaTroLike
go

create view Top10NhaTroLike
as
select top 10 dientich, giaphong, mota, ngaydangtin, tennguoidung,
nd.diachi, nd.dienthoai, nd.email, count(danhgia) as Likes
from nhatro nt
join nguoidung nd
on nt.manguoilienhe = nd.manguoidung
join danhgia dg
on dg.manhatro = nt.manhatro
where danhgia = 1
group by dg.manhatro, dientich, giaphong, mota, ngaydangtin,
tennguoidung, nd.diachi, nd.dienthoai, nd.email
order by count(danhgia) desc
go

select *
from Top10NhaTroLike;
go

-- Viết một Stored Procedure nhận tham số đầu vào là mã nhà trọ (cột khóa chính của bảng NHATRO). SP này trả về tập kết quả gồm các thông tin sau: Mã nhà trọ, Tên người đánh giá, Trạng thái LIKE hay DISLIKE, Nội dung đánh giá
if object_id('spDanhGiaNhaTro', 'sp') is not null
drop function spDanhGiaNhaTro
go

create proc spDanhGiaNhaTro @manhatro int
as
begin
	select nt.manhatro, tennguoidung, danhgia = case danhgia
	when 1 then 'Like'
	when 0 then 'Dislike'
	end, noidung
	from nhatro nt
	join nguoidung nd
	on nt.manguoilienhe = nd.manguoidung
	join danhgia dg
	on dg.manhatro = nt.manhatro
	where nt.manhatro = @manhatro
end
go

exec spDanhGiaNhaTro 2;
go

-- Viết một SP nhận một tham số đầu vào kiểu int là số lượng DISLIKE. SP này thực hiện thao tác xóa thông tin của các nhà trọ và thông tin đánh giá của chúng, nếu tổng số lượng DISLIKE tương ứng với nhà trọ này lớn hơn giá trị tham số được truyền vào
if object_id('spXoaNhaTroDislike', 'sp') is not null
drop function spXoaNhaTroDislike
go

create proc spXoaNhaTroDislike @dislike int
as
begin
	begin transaction;

	begin try
		delete from danhgia
		where manhatro in (
			select manhatro
			from danhgia
			where danhgia = 0
			group by manhatro
			having count(danhgia) > @dislike
		);

		delete from nhatro
		where manhatro in (
			select manhatro
			from danhgia
			where danhgia = 0
			group by manhatro
			having count(danhgia) > @dislike
		);

		commit;
		print N'Đã xoá';
	end try
	begin catch
		rollback;
		print N'Đã trả lại dữ liệu vì xuất hiện lỗi';
	end catch
end;
go

exec spXoaNhaTroDislike 1;
go

-- Viết một SP nhận hai tham số đầu vào là khoảng thời gian đăng tin. SP này thực hiện thao tác xóa thông tin những nhà trọ được đăng trong khoảng thời gian được truyền vào qua các tham số
if object_id('spXoaNhaTroTheoNgayDang', 'sp') is not null
drop function spXoaNhaTroTheoNgayDang
go

create proc spXoaNhaTroTheoNgayDang @ngaydangtinmin date, @ngaydangtinmax date
as
begin
	begin transaction;

	begin try
		delete from danhgia
		where manhatro in (
			select manhatro
			from nhatro
			where ngaydangtin between @ngaydangtinmin and @ngaydangtinmax
		);

		delete from nhatro
		where ngaydangtin between @ngaydangtinmin and @ngaydangtinmax;

		commit;
		print N'Đã xoá';
	end try
	begin catch
		rollback;
		print N'Đã trả lại dữ liệu vì xuất hiện lỗi';
	end catch
end
go

exec spXoaNhaTroTheoNgayDang '2023-05-01', '2023-07-01';
go

-- Tạo Trigger ràng buộc khi thêm, sửa thông tin nhà trọ phải thỏa mãn các điều kiện sau: Diện tích phòng >=8 (m2), Giá phòng >=0
if object_id('tgThemSuaNhaTro', 'tg') is not null
drop function tgThemSuaNhaTro
go

create trigger tgThemSuaNhaTro on nhatro
for insert, update
as
begin
	if exists (select * 
				from inserted 
				where dientich < 8 or giaphong < 0)
		begin
			print N'Chỉ nhận thông tin nhà trọ từ 
			8 mét vuông trở lên và giá phòng phải nhập đúng';
			rollback transaction;
		end
end;
go

insert into nhatro values
(21, 30, 15000000, N'21 Cầu Xéo, phường 3', N'Quận Tân Phú',
N'Giống biệt thự', 3, '2023-06-06', 7);
go

insert into nhatro values
(22, 7, 1000000, N'22 Tên Lửa, phường 4', N'Quận Bình Tân',
null, 4, '2023-05-30', 9);
go

-- Tạo Trigger để khi xóa thông tin người dùng
-- Nếu có các đánh giá của người dùng đó thì xóa cả đánh giá
-- Nếu có thông tin liên hệ của người dùng đó trong nhà trọ thì sửa thông tin liên hệ sang người dùng khác hoặc để trống thông tin liên hệ
if object_id('tgXoaNguoiDungSuaNhaTro', 'tg') is not null
drop function tgXoaNguoiDungSuaNhaTro
go

create trigger tgXoaNguoiDungSuaNhaTro on nguoidung
instead of delete
as
begin
	delete from danhgia
	where manguoidanhgia in (select manguoidung from deleted);

	update nhatro
	set manguoilienhe = (select top 1 manguoidung 
						from nguoidung 
						where manguoidung <> (select manguoidung from deleted))
	where manguoilienhe in (select manguoidung from deleted);

	delete from nguoidung
	where manguoidung in (select manguoidung from deleted);
end
go

delete from nguoidung
where manguoidung = 14;
go