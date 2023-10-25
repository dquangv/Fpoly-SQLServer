create database COM2034_PS36680_QLDeTai;
go

use COM2034_PS36680_QLDeTai;
go

create table sinh_vien (
masv int,
hotensv nvarchar(40),
namsinh int,
quequan nvarchar(30)
primary key (masv));
go

create table de_tai (
madt char(10),
tendt nvarchar(30),
kinhphi int,
noithuctap nvarchar(30),
masv int,
ketqua decimal(5, 2),
primary key (madt));
go

insert into sinh_vien values
(1, N'Lê Văn Nam', 1990, N'Nghệ An'),
(2, N'Nguyễn Thị Mỹ', 1990, N'Thanh Hoá'),
(3, N'Bùi Xuân Đức', 1992, N'Hà Nội'),
(4, N'Nguyễn Văn Tùng', null, N'Hà Tĩnh'),
(5, N'Lê Khánh Linh', 1989, N'Hà Nam');
go

insert into de_tai values
('Dt01', 'GIS', 100, N'Nghệ An', 1, 6.80),
('Dt02', 'ARC GIS', 500, N'Nam Định', 2, 7.65),
('Dt03', 'Spatial DB', 100, N'Hà Tĩnh', 2, 8.25),
('Dt04', 'Blockchain', 300, N'Nam Định', null, null),
('Dt05', 'Cloud Computing', 700, N'Nam Định', null, null);
go

alter table de_tai
add constraint fk_dt_sv
foreign key (masv)
references sinh_vien(masv);
go

create proc detai_ketquacao
	@ketqua int
as
begin
select madt, tendt, hotensv, kinhphi, noithuctap, ketqua
from de_tai dt
join sinh_vien sv
on dt.masv = sv.masv
where ketqua > @ketqua
end;
go

exec detai_ketquacao 7;
go

create function tongkinhphi (@masv int)
returns table
as
return (
		select sv.masv, hotensv, sum(kinhphi) as TongKinhPhi
		from sinh_vien sv
		join de_tai dt
		on sv.masv = dt.masv
		where sv.masv = @masv
		group by sv.masv, hotensv);
go

select *
from tongkinhphi(2);
go

create trigger xoasinhvien on sinh_vien
instead of delete
as
delete from de_tai
where masv in (select masv from deleted);
delete from sinh_vien
where masv in (select masv from deleted);
go

delete from sinh_vien
where namsinh = 1990;
go

create view DeAnKhongTacGia
as
select masv, tendt, kinhphi, noithuctap, ketqua
from de_tai
where masv is null
go

update DeAnKhongTacGia
set masv = 3
go