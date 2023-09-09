-- Lab 3
use QLDA;
go

-- Bài 1: Sử dụng cast và convert
-- Liệt kê tên đề án và tổng số giờ làm việc một tuần của tất cả các nhân viên tham dự đề án
-- Xuất định dạng “tổng số giờ làm việc” kiểu decimal với 2 số thập phân và kiểu varchar
select tendean, sum(thoigian) as tongTG,
	cast(sum(thoigian) as decimal(10,2)) as Cast_tongTG,
	convert(decimal(10,2), sum(thoigian)) as Convert_tongTG,
	cast(sum(thoigian) as nvarchar(10)) as Cast_Var_tongTG,
	convert(nvarchar(10), sum(thoigian)) as Convert_tongTG
from dean da
join congviec cv on cv.mada = da.mada
join phancong pc on pc.mada = cv.mada
group by tendean;
go

-- Liệt kê tên phòng ban và lương trung bình của những nhân viên làm việc cho phòng ban đó
-- Xuất định dạng “luong trung bình” kiểu decimal với 2 số thập phân, sử dụng dấu phẩy để phân biệt phần nguyên và phần thập phân
-- Xuất định dạng “luong trung bình” kiểu varchar. Sử dụng dấu phẩy tách cứ mỗi 3 chữ số trong chuỗi ra, gợi ý dùng thêm các hàm Right, Replace
select tenphg, avg(luong) as luongTB,
	replace(convert(decimal(10,2), avg(luong)), '.', ',') as Convert_luongTB_a,
	replace(cast(avg(luong) as decimal(10,2)), '.', ',') as Cast_luongTB_a,
	replace(convert(nvarchar(10), avg(luong)), right(convert(nvarchar(10), avg(luong)),3), ',' + right(convert(nvarchar(10), avg(luong)),3)) as Convert_luongTB_b,
	replace(cast(avg(luong) as nvarchar(10)), right(cast(avg(luong) as nvarchar(10)),3), ',' + right(cast(avg(luong) as nvarchar(10)),3)) as Cast_luongTB_b
from nhanvien nv
join phongban pb on pb.maphg = nv.phg
group by tenphg;
go

-- Bài 2: Sử dụng các hàm toán học
-- Liệt kê tên đề án và tổng số giờ làm việc một tuần của tất cả các nhân viên tham dự đề án
-- Xuất định dạng “tổng số giờ làm việc” với hàm CEILING, FLOOR và làm tròn tới 2 chữ số thập phân

select tendean, sum(thoigian) as tongTG,
	ceiling(sum(thoigian)) as Ceiling_tongTG,
	floor(sum(thoigian)) as Floor_tongTG,
	round(sum(thoigian),2) as Round_tongTG
from dean da
join congviec cv on cv.mada = da.mada
join phancong pc on cv.mada = pc.mada
group by tendean;
go

-- Họ tên nhân viên (HONV, TENLOT, TENNV) có mức lương trên mức lương trung bình (làm tròn đến 2 số thập phân) của phòng "Nghiên cứu"
select concat(honv, ' ', tenlot, ' ', tennv) as HoTen, luong
from nhanvien
where luong > (
	select round(avg(luong),2)
	from nhanvien nv
	join phongban pb on nv.phg = pb.maphg
	group by tenphg
	having tenphg = N'Nghiên cứu');
go

-- Bài 3: Sử dụng các hàm xử lý chuỗi
-- Danh sách những nhân viên (HONV, TENLOT, TENNV, DCHI) có trên 2 thân nhân, thỏa các yêu cầu
-- Dữ liệu cột HONV được viết in hoa toàn bộ
-- Dữ liệu cột TENLOT được viết chữ thường toàn bộ
-- Dữ liệu chột TENNV có ký tự thứ 2 được viết in hoa, các ký tự còn lại viết thường( ví dụ: kHanh)
-- Dữ liệu cột DCHI chỉ hiển thị phần tên đường, không hiển thị các thông tin khác như số nhà hay thành phố.

select upper(honv) as Ho,
	lower(tenlot) as TenLot,
	replace(tennv, right(left(tennv,2),1), upper(right(left(tennv,2),1))) as Ten,
	substring(dchi, charindex(' ', dchi) + 1, charindex(',', dchi) - charindex(' ', dchi) - 1) as DiaChi
from nhanvien
where manv in (
	select ma_nvien
	from thannhan
	group by ma_nvien
	having count(tentn) >2);
go

-- Cho biết tên phòng ban và họ tên trưởng phòng của phòng ban có đông nhân viên nhất, hiển thị thêm một cột thay thế tên trưởng phòng bằng tên “Fpoly”
select tenphg as TenPhongBan, concat(nv.honv, ' ', nv.tenlot, ' ', nv.tennv) as HoTen, replace(concat(nv.honv, ' ', nv.tenlot, ' ', nv.tennv), concat(nv.honv, ' ', nv.tenlot, ' ', nv.tennv), 'Fpoly') as TenThayThe
from nhanvien
join phongban on nhanvien.phg = phongban.maphg
join nhanvien nv on nv.manv = phongban.trphg
group by tenphg, concat(nv.honv, ' ', nv.tenlot, ' ', nv.tennv)
having count(nv.manv) >= all (
	select count(manv)
	from nhanvien
	group by phg);
go

-- Bài 4: Sử dụng các hàm ngày tháng năm
-- Cho biết các nhân viên có năm sinh trong khoảng 1960 đến 1965
select *
from nhanvien
where year(ngsinh) between 1960 and 1965;
go

-- Cho biết tuổi của các nhân viên tính đến thời điểm hiện tại
select tennv, ngsinh, year(getdate()) - year(ngsinh) as Tuoi
from nhanvien;
go

-- Dựa vào dữ liệu NGSINH, cho biết nhân viên sinh vào thứ mấy
select tennv, ngsinh, datename(weekday, ngsinh) as Thu
from nhanvien;
go

-- Cho biết số lượng nhân viên, tên trưởng phòng, ngày nhận chức trưởng phòng và ngày nhận chức trưởng phòng hiển thi theo định dạng dd-mm-yy (ví dụ 25-04-2019)
select count(nv.manv) as SoLuongNhanVien, concat(nv.honv, ' ', nv.tenlot, ' ', nv.tennv) as TenTP, ng_nhanchuc as NgayNhanChuc, convert(varchar, ng_nhanchuc, 105) as NgayNhanChuc_ChuyenDoi 
from phongban
join nhanvien nv on nv.manv = phongban.trphg
join nhanvien on nhanvien.phg = phongban.maphg
group by concat(nv.honv, ' ', nv.tenlot, ' ', nv.tennv), ng_nhanchuc;
go