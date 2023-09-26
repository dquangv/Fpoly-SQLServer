create database QlNhaTro_ps36680;
go

use QlNhaTro_ps36680;
go

create table loainha (
maloainha int not null,
tenloainha nvarchar(50) not null,
constraint pk_loainha primary key (maloainha)
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
constraint pk_nguoidung primary key (manguoidung)
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
constraint pk_nhatro primary key (manhatro)
);
go

create table danhgia (
manguoidanhgia int not null,
manhatro int not null,
danhgia bit not null,
noidung nvarchar(250),
constraint pk_danhgia primary key (manguoidanhgia, manhatro)
);
go

alter table nhatro
add constraint fk_nhatro_loainha foreign key (maloainha) references loainha(maloainha),
	constraint fk_nhatro_nguoidung foreign key (manguoilienhe) references nguoidung(manguoidung),
	constraint chk_dientich check (dientich > 0),
	constraint chk_giaphong check (giaphong > 0);
go

alter table danhgia
add constraint fk_danhgia_nguoidung foreign key (manguoidanhgia) references nguoidung(manguoidung),
	constraint fk_danhgia_nhatro foreign key (manhatro) references nhatro(manhatro);
go

insert into loainha values
(1, N'Chung cư'),
(2, N'Nhà đất'),
(3, N'Nhà trọ'),
(4, N'Biệt thự');
go

insert into nguoidung values
(1, N'Nguyễn Thị Ánh Tuyết', N'Nữ', '02666332262', N'2 Trường Chinh, phường 12', N'Tân Bình', 'nguyenthianhtuyet@gmail.com'),
(2, N'Vũ Thế Vinh', 'Nam', '03666333363', N'3 Quang Trung, phường 8', N'Gò Vấp', 'vuthevinh@gmail.com'),
(3, N'Vũ Hoàng Long', 'Nam', '04666334464', N'4 Điện Biện Phủ, phường 4', N'Quận 3', 'vuhoanglong@gmail.com'),
(4, N'Vũ Đăng Quang', 'Nam', '01666331161', N'1 Lê Trọng Tấn, phường Tây Thạnh', N'Tân Phú', 'vudangquang@gmail.com'),
(5, N'Trương Thị Minh Ngọc', N'Nữ', '05666335565', N'5 Tân Kỳ Tân Quý, phường Bình Hưng Hoà', N'Bình Tân', 'truongthiminhngoc@gmail.com'),
(6, N'Phạm Đức Hải Duy', 'Nam', '06666336666', N'6 Phạm Ngũ Lão, phường Nguyễn Thái Bình', N'Quận 1', 'phamduchaiduy@gmail.com'),
(7, N'Nguyễn Tuấn Quỳnh', 'Nam', '07666337767', N'7 Vĩnh Khánh, phường 8', N'Quận 4', 'nguyentuanquynh@gmail.com'),
(8, N'Nguyễn Anh Điền Độ', 'Nam', '08666338868', N'8 Hà Huy Giáp, phường Thạnh Lộc', N'Quận 12', 'nguyenanhdiendo@gmail.com'),
(9, N'Nguyễn Thiện Thông', 'Nam', '09666339969', N'9 Vĩnh Viễn, phường 8', N'Quận 10', 'nguyenthienthong@gmail.com'),
(10, N'Dương Trung Nghĩa', 'Nam', '0066330060', N'10 Kha Vạn Cân, phường Linh Chiểu', N'Quận 9', 'duongtrungnghia@gmail.com');
go

insert into nhatro values
(1, 54, 5500, N'1 Hương Lộ 2, phường Bình Trị Đông', N'Quận Bình Tân', N'5 phòng ngủ, 6 phòng vệ sinh', 2, '2023-09-07', 7),
(2, 200, 25900, N'2 Đường số 8, phường An Phú', N'Quận 2', N'5 phòng ngủ, 6 phòng vệ sinh, sân vườn', 2, '2023-07-25', 4),
(3, 35, 1850, N'3 Dương Thị Mười, phường Tân Chánh Hiệp', N'Quận 12', N'2 phòng ngủ, 2 phòng vệ sinh', 2, '2023-01-25', 6),
(4, 80, 3800, N'4 Võ Văn Kiệt, phường An Lạc', N'Quận Bình Tân', N'2 phòng ngủ, 2 phòng vệ sinh', 1, '2023-08-22', 1),
(5, 92, 4500, N'5 Võ Văn Kiệt, phường An Lạc', N'Quận Bình Tân', N'3 phòng ngủ, 2 phòng vệ sinh', 1, '2023-07-01', 9),
(6, 47, 1650, N'6 Nguyễn Xiển, phường Long Thạnh Mỹ', N'Quận 9', N'1 phòng ngủ', 1, '2023-07-20', 3),
(7, 35, 0.0065, N'7 Đặng Văn Ngữ, phường 14', N'Quận Phú Nhuận', N'ban công, giữ xe miễn phí', 3, '2023-12-07', 8),
(8, 50, 0.012, N'8 Sông Đà, phường 2', N'Quận Tân Bình', N'ban công, phòng gym', 3, '2023-01-01', 10),
(9, 284, 34000, N'9 Lê Lai, phường 3', N'Quận Gò Vấp', N'1 trệt, 3 lầu, mặt tiền', 4, '2023-05-05', 5),
(10, 100, 15000, N'10 Quốc Lộ 13, phường Hiệp Bình Phước', N'Quận 9', N'1 hầm, 4 lầu, gần trường học, công viên, hồ bơi', 4, '2023-10-10', 2);
go

insert into danhgia values
(7, 10, 1, 'like'),
(10, 1, 1, 'like'),
(2, 2, 0, 'dislike'),
(9, 6, 0, 'dislike'),
(4, 8, 0, 'dislike'),
(1, 3, 1, 'like'),
(5, 4, 0, 'dislike'),
(6, 5, 0, 'dislike'),
(7, 9, 1, 'like'),
(8, 7, 0, 'dislike');
go

-- Tạo ba Stored Procedure (SP) với các tham số đầu vào phù hợp.
-- SP thứ nhất thực hiện chèn dữ liệu vào bảng NGUOIDUNG
create or alter proc nguoidung_insert
@manguoidung int, @tennguoidung nvarchar(50), @gioitinh nchar(3),
@dienthoai varchar(12), @diachi nvarchar(50), @quan nvarchar(20), @email varchar(50)
as
begin
	if (@manguoidung is null) or (@tennguoidung is null) or (@dienthoai is null) or (@diachi is null) or (@quan is null)
		begin
			print N'Yêu cầu nhập đầy đủ dữ liệu';
		end;
	else
		begin
			insert into nguoidung values
			(@manguoidung, @tennguoidung, @gioitinh, @dienthoai, @diachi, @quan, @email)
			select *
			from nguoidung;
		end;
end;
go

exec nguoidung_insert 11, N'Trần Trọng Đăng Khoa', null, '01111111111', N'1 Quang Trung, phường 1', N'Quận 12', null;
go

exec nguoidung_insert 12, null, N'Nữ', '01222331121', N'2 Quang trung, phường 1', N'Quận 12', 'nguyenanhdiendo@gmail.com';
go

-- SP thứ hai thực hiện chèn dữ liệu vào bảng NHATRO

-- SP thứ ba thực hiện chèn dữ liệu vào bảng DANHGIA