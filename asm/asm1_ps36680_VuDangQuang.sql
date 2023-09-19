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