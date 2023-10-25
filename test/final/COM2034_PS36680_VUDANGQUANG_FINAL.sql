create database COM2034_PS36680_VuDangQuang;
go

use COM2034_PS36680_VuDangQuang;
go

create table doibong (
madoi varchar(2),
tendoi nvarchar(100),
namthanhlap int,
primary key (madoi));
go

create table cauthu (
macauthu varchar(2),
tencauthu nvarchar(100),
phai nvarchar(3),
ngaysinh date,
noisinh nvarchar(50),
primary key (macauthu));
go

create table ct_doibong (
madoi varchar(2),
macauthu varchar(2),
ngayvaoclb date,
primary key (madoi, macauthu));
go

insert into doibong values
('D1', N'Đội 1', 2020),
('D2', N'Đội 2', 2021),
('D3', N'Đội 3', 2020),
('D4', N'Đội 4', 2022),
('D5', N'Đội 5', 2022);
go

insert into cauthu values
('C1', N'Nguyễn Văn An', 'Nam', '2000-05-24', N'Bến Tre'),
('C2', N'Lê Văn Bé', 'Nam', '2001-06-19', 'TP HCM'),
('C3', N'Trần Thị Bảy', N'Nữ', '2001-07-15', 'Long An'),
('C4', N'Nguyễn Thị Lan', N'Nữ', '2002-05-17', N'Bến Tre'),
('C5', N'Lê Văn Nhàn', 'Nam', '2000-12-24', 'TP HCM');
go

insert into ct_doibong values
('D1', 'C1', '2022-06-01'),
('D1', 'C2', '2022-11-28'),
('D2', 'C3', '2023-03-05'),
('D2', 'C4', '2023-02-01'),
('D3', 'C5', '2021-04-01'),
('D3', 'C2', '2021-11-01');
go

alter table ct_doibong
add constraint fk_ct_db
foreign key (madoi)
references doibong (madoi);
go

alter table ct_doibong
add constraint fk_ct_cth
foreign key (macauthu)
references cauthu (macauthu);
go

-- sp
if object_id('sp_soluongcauthu') is not null
	drop proc sp_soluongcauthu;
go

create proc sp_soluongcauthu @madoi varchar(2)
as
begin
select madoi, count(macauthu) as SoLuongCauThu
from ct_doibong
where madoi = @madoi
group by madoi
end;
go

exec sp_soluongcauthu 'D1';
go

-- function
if object_id('f_cauthu') is not null
	drop function f_cauthu;
go

create function f_cauthu (@madoi varchar(2))
returns table
as
return (
	select tencauthu, year(getdate()) - year(ngaysinh) as Tuoi
	from cauthu cth
	join ct_doibong ct
	on cth.macauthu = ct.macauthu
	where madoi = @madoi
	group by tencauthu, madoi, year(getdate()) - year(ngaysinh)
	);
go

select *
from f_cauthu('D1');
go

-- trigger
if object_id('tg_them_capnhat_cauthu') is not null
	drop trigger tg_them_capnhat_cauthu;
go

create trigger tg_them_capnhat_cauthu on cauthu
for insert, update
as
if exists (select *
			from inserted
			where year(getdate()) - year(ngaysinh) < 18)
	begin
		print N'Cầu thủ phải lớn hơn hoặc bằng 18 tuổi';
		rollback transaction;
	end
go

insert into cauthu values
('C6', N'Vũ Đăng Quang', 'Nam', '2020-09-07', 'TP HCM');
go

-- view
if object_id('v_cauthu') is not null
	drop view v_cauthu;
go

create view v_cauthu
as
select tencauthu, phai, year(getdate()) - year(ngaysinh) as Tuoi, noisinh, tendoi, ngayvaoclb
from cauthu cth
join ct_doibong ct
on cth.macauthu = ct.macauthu
join doibong db
on ct.madoi = db.madoi
go

select *
from v_cauthu
where year(ngayvaoclb) = 2022;
go