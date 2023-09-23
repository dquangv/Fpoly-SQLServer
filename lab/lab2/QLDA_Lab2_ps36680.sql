-- Bài 1: Xây dựng cơ sở dữ liệu
use master;
go

drop database QLDA_Lab2_ps36680;
go

create database QLDA_Lab2_ps36680;
go

use QLDA_Lab2_ps36680;
go

create table nhanvien (
	honv nvarchar(15) not null,
	tenlot nvarchar(15) not null,
	tennv nvarchar(15) not null,
	manv varchar(9) primary key,
	ngsinh date,
	dchi nvarchar(30),
	phai nchar(3),
	luong money,
	ma_nql varchar(9),
	phg int not null
);
go

create table thannhan (
	ma_nvien varchar(9),
	tentn nvarchar(15) not null ,
	phai nchar(3),
	ngsinh date,
	quanhe nvarchar(15),
	primary key (ma_nvien, tentn)
);
go

create table phongban (
	tenphg nvarchar(15),
	maphg int not null primary key,
	trphg varchar(9),
	ng_nhanchuc date not null
);
go

create table diadiem_phg (
	maphg int not null,
	diadiem nvarchar(15) not null,
	primary key (maphg, diadiem));
go

create table phancong (
	ma_nvien varchar(9) not null,
	mada int not null,
	stt int,
	thoigian float,
	primary key (ma_nvien, mada, stt));
go

create table congviec (
	mada int not null,
	stt int,
	ten_cong_viec nvarchar(50),
	primary key (mada, stt));
go

create table dean (
	tenda nvarchar(15) not null,
	mada int not null primary key,
	ddiem_da nvarchar(15),
	phong int);
go

insert into congviec values
(1, 1, N'Thiết kế sản phẩm X'),
(1, 2, N'Thử nghiệm sản phẩm X'),
(2, 1, N'Sản xuất sản phẩm Y'),
(2, 2, N'Quảng cáo sản phẩm Y'),
(3, 1, N'Khuyến mãi sản phẩm Z'),
(10, 1, N'Tin học hoá phòng nhân sự'),
(10, 2, N'Tin học hoá phòng kinh doanh'),
(20, 1, N'Lắp đặt cáp quang'),
(30, 1, N'Đào tạo nhân viên Marketing'),
(30, 2, N'Đào tạo chuyên viên thiết kế');
go

insert into dean values
(N'Sản phẩm X', 1, N'Vũng Tàu', 5),
(N'Sản phẩm Y', 2, N'Nha Trang', 5),
(N'Sản phẩm Z', 3, N'TP HCM', 5),
(N'Tin học hoá', 10, N'Hà Nội', 4),
(N'Cáp quang', 20, N'TP HCM', 1),
(N'Đào tạo', 30, N'Hà Nội', 4);
go

insert into diadiem_phg values
(1, N'TP HCM'),
(4, N'Hà Nội'),
(5, N'TAU'),
(5, N'NHA TRANG'),
(5, N'TP HCM');
go

insert into nhanvien values
(N'Đinh', N'Bá', N'Tiên', '009', '1960-02-11', N'119 Cống Quỳnh, Tp HCM', 'Nam', 30000, '005', 5),
(N'Nguyễn', 'Thanh', N'Tùng', '005', '1962-08-20', N'222 Nguyễn Văn Cừ, Tp HCM', 'Nam', 40000, '006', 5),
(N'Bùi', N'Ngọc', N'Hằng', '007', '1954-03-11', N'332 Nguyễn Thái Học, Tp HCM', 'Nam', 25000, '001', 4),
(N'Lê', N'Quỳnh', N'Như', '001', '1967-02-01', N'291 Hồ Văn Huê, Tp HCM', N'Nữ', 43000, '006', 4),
(N'Nguyễn', N'Mạnh', N'Hùng', '004', '1967-03-04', N'95 Bà Rịa, Vũng Tàu', 'Nam', 38000, '005', 5),
(N'Trần', 'Thanh', N'Tâm', '003', '1957-05-04', N'34 Mai Thị Lự, Tp HCM', 'Nam', 25000, '005', 5),
(N'Trần', N'Hồng', 'Quang', '008', '1967-09-01', N'80 Lê Hồng Phong, Tp HCM', 'Nam', 25000, '001', 4),
(N'Phạm', N'Văn', 'Vinh', '006', '1965-01-01', N'45 Trưng Vương, Hà Nội', N'Nữ', 55000, null,1);
go

insert into phancong values
('009', 1, 1, 32),
('009', 2, 2, 8),
('004', 3, 1, 40),
('003', 1, 2, 20.0),
('003', 2, 1, 20.0),
('008', 10, 1, 35),
('008', 30, 2, 5),
('001', 30, 1, 20),
('001', 20, 1, 15),
('006', 20, 1, 30),
('005', 3, 1, 10),
('005', 10, 2, 10),
('005', 20, 1, 10),
('007', 30, 2, 30),
('007', 10, 2, 10);
go

insert into phongban values
(N'Nghiên cứu', 5, '005', '1978-05-22'),
(N'Điều hành', 4, '008', '1985-01-01'),
(N'Quản lý', 1, '006', '1971-06-19');
go

insert into thannhan values
('005', 'Trinh', N'Nữ', '1976-04-05', N'Con gái'),
('005', 'Khang', 'Nam', '1973-10-25', N'Con trai'),
('005', N'Phương', N'Nữ', '1948-05-03', N'Vợ chồng'),
('001', 'Minh', 'Nam', '1932-02-29', N'Vợ chồng'),
('009', N'Tiến', 'Nam', '1978-01-01', N'Con trai'),
('009', N'Châu', 'Nữ', '1978-12-30', N'Con gái'),
('009', N'Phương', 'Nữ', '1957-05-05', N'Vợ chồng');
go

alter table nhanvien
add foreign key (phg) references phongban(maphg),
	foreign key (ma_nql) references nhanvien(manv);
go

alter table thannhan
add foreign key (ma_nvien) references nhanvien(manv);
go

alter table phongban
add foreign key (trphg) references nhanvien(manv);
go

alter table diadiem_phg
add foreign key (maphg) references phongban(maphg);
go

alter table phancong
add foreign key (mada, stt) references congviec(mada, stt),
	foreign key (ma_nvien) references nhanvien(manv);
go

alter table dean
add foreign key (phong) references phongban(maphg);
go

alter table congviec
add foreign key (mada) references dean(mada);
go

-- Bài 2: Sử dụng biến thực hiện các công việc sau:

-- Tính diện tích, chu vi hình chữ nhật khi biết chiều dài và chiều rộng.
begin
	declare @dienTich float, @chuVi float, @chieuDai float, @chieuRong float;
	set @chieuDai = 9.8;
	set @chieuRong = 7.9;
	set @dienTich = @chieuDai * @chieuRong;
	set @chuVi = (@chieuDai + @chieuRong) * 2;

	print N'Diện tích hình chữ nhật là ' + cast(@dienTich as nvarchar(15));
	print N'Chu vi hình chữ nhật là ' + cast(@chuVi as nvarchar(15));
end;
go

-- 1. Cho biêt nhân viên có lương cao nhất
begin
	declare @nhanVien_maxLuong table
	(maxLuong money, tenNV nvarchar(30));

	insert into @nhanVien_maxLuong
	select luong, concat(honv, ' ', tenlot, ' ', tennv)
	from nhanvien
	where luong = (
		select max(luong)
		from nhanvien);
	
	select *
	from @nhanVien_maxLuong;
end;
go

-- 2. Cho biết họ tên nhân viên (HONV, TENLOT, TENNV) có mức lương trên mức lương trung bình của phòng "Nghiên cứu”
begin
	declare @nhanVien_luongTB table
	(tenNV nvarchar(30), luong money);

	insert into @nhanVien_luongTB
	select concat(honv, ' ', tenlot, ' ',tennv), luong
	from nhanvien
	where luong > (
		select avg(luong)
		from nhanvien nv
		inner join phongban pb on nv.phg = pb.maphg
		group by tenphg
		having tenphg = N'Nghiên cứu');

	select *
	from @nhanVien_luongTB;
end;
go

-- 3. Với các phòng ban có mức lương trung bình trên 30,000, liệt kê tên phòng ban và số lượng nhân viên của phòng ban đó.
begin
	declare @phongBan_luongTB table
	(tenPhongBan nvarchar(15), soNhanVien int);

	insert @phongBan_luongTB
	select tenphg, count(manv)
	from phongban pb
	inner join nhanvien nv on pb.maphg = nv.phg
	group by tenphg
	having avg(luong) > 30000;

	select *
	from @phongBan_luongTB;
end;
go
			
-- 4. Với mỗi phòng ban, cho biết tên phòng ban và số lượng đề án mà phòng ban đó chủ trì
begin
	declare @phongBan_deAn table
	(tenPhongBan nvarchar(15), luongDeAn int);

	insert into @phongBan_deAn
	select tenphg, count(mada)
	from dean da
	inner join phongban pb on pb.maphg = da.phong
	group by tenphg;

	select *
	from @phongBan_deAn;
end;
go

-- Cho biết các đề án mà số lượng nhân viên tham gia nhiều nhất
begin
	declare @DeAn_NVien table
	(DeAn nvarchar(15), SoLuongNhanVien int);

	insert into @DeAn_NVien
	select tenda, count(manv)
	from dean da
	join phongban pb on da.phong = pb.maphg
	join nhanvien nv on pb.maphg = nv.phg
	group by tenda
	having count(manv) >= (
		select top 1 count(manv)
		from dean da
		join phongban pb on da.phong = pb.maphg
		join nhanvien nv on pb.maphg = nv.phg
		group by tenda
		order by count(manv) desc);

	select *
	from @DeAn_NVien;
end;
go

-- Cho biết danh sách nhân viên tham gia đề án do phòng "Nghiên Cứu" chủ trì
begin
	declare @NhVien_DeAn table
	(honv nvarchar(15), tenlot nvarchar(15), tennv nvarchar(15), manv varchar(9), ngsinh date, dchi nvarchar(30), phai nchar(3), luong money, ma_nql varchar(9), phg int, tenpb nvarchar(15));

	insert into @NhVien_DeAn
	select nv.*, tenphg
	from nhanvien nv
	join phongban pb on nv.phg = pb.maphg
	where tenphg = N'Nghiên Cứu';

	select *
	from @NhVien_DeAn;
end;
go
