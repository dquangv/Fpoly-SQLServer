create database COM2034_PS36680_VuDangQuang;
go

use COM2034_PS36680_VuDangQuang;
go

create table khachhang (
makh varchar(5),
tenkh nvarchar(50) not null,
diachi nvarchar(100),
quan nvarchar(50),
thanhpho nvarchar(50),
primary key (makh)
);
go

create table hoadon (
sohd varchar(5),
ngaymua date not null,
makh varchar(5),
nguoilap nvarchar(50),
primary key (sohd)
);
go

insert into khachhang values
('KH001', N'Lê Hồng Anh', N'123 Nguyễn Huệ', N'Quận 1', 'Tp.HCM'),
('KH002', N'Nguyễn Quốc Anh', N'234 Ký Con', N'Quận 1', 'Tp.HCM'),
('KH003', N'Trần Minh Hoàng', N'25/7 Nguyễn Huệ', N'Quận Ninh Kiều', 'Cần Thơ'),
('KH004', N'Nguyễn Thu Thuỷ', N'26 Nguyễn Viết Xuân', N'Quận 3', 'Tp.HCM'),
('KH005', N'Lê Thị Ánh Ngọc', N'17 Lê Lợi', N'Quận Gò Vấp', 'Tp.HCM'),
('KH006', N'Trần Trung Sơn', N'87 Nguyễn Duy Tiến', N'Quận Ba Đình', N'Hà Nội');
go

insert into hoadon values
('HD001', '2021-02-15', 'KH001', N'Ngô Tuấn Tú'),
('HD002', '2021-02-03', 'KH002', N'Ngô Tuấn Tú'),
('HD003', '2001-03-17', 'KH002', N'Nguyễn Mai Hồ'),
('HD004', '2001-04-30', 'KH001', N'Trần Thanh Thảo'),
('HD005', '2021-01-05', 'KH005', N'Trần Thanh Thảo'),
('HD006', '2021-04-05', 'KH010', null),
('HD007', '2021-10-05', 'KH001', null);
go

if object_id('v_khachhang_tinh') is not null
	drop view v_khachhang_tinh;
go

create view v_khachhang_tinh
as
select kh.makh, tenkh, count(sohd) as SoLanMuaHang
from hoadon hd
right join khachhang kh
on hd.makh = kh.makh
where thanhpho = N'Tp.HCM'
group by kh.makh, tenkh;
go

select *
from v_khachhang_tinh;
go

if object_id('sp_capnhat_diachi_kh') is not null
	drop proc sp_capnhat_diachi_kh;
go

create proc sp_capnhat_diachi_kh 
	@diachi nvarchar(100), @quan nvarchar(50), @thanhpho nvarchar(50)
as
begin
	update khachhang
	set diachi = @diachi,
	quan = @quan,
	thanhpho = @thanhpho
	where makh = 'KH004'
end;
go

exec sp_capnhat_diachi_kh N'4 Đỗ Nhuận', N'Quận Tân Phú', 'Tp.HCM';
go

select *
from khachhang;
go

if object_id('f_ngaymua_LeHongAnh') is not null
	drop function f_ngaymua_LeHongAnh;
go

create function f_ngaymua_LeHongAnh ()
returns date
as
begin
return (
	select max(ngaymua)
	from hoadon hd
	join khachhang kh
	on hd.makh = kh.makh
	where tenkh like N'Lê Hồng Anh')
end
go

select kh.*, ngaymua
from khachhang kh
join hoadon hd
on kh.makh = hd.makh
where ngaymua > dbo.f_ngaymua_LeHongAnh();
go

if object_id('tg_capnhat_hoadon') is not null
	drop trigger tg_capnhat_hoadon;
go

create trigger tg_capnhat_hoadon on hoadon
for update
as
begin
	if exists (select *
				from hoadon
				where month(ngaymua) = 1 and year(ngaymua) = 2021)
		print N'Không cập nhật hoá đơn trong tháng 02 năm 2021';
		rollback transaction;
end;
go

update hoadon
set nguoilap = N'Vu Dang Quang'
where makh like 'KH005';
go

select *
from hoadon;
go