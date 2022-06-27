--1.Đổi tên bảng countries thành country_new
exec sp_rename	countries ,country_new

--2.Thêm cột region_id tới bảng locations 
alter table locations add  region_id int
alter table locations add foreign key(region_id) references regions(region_id)

--3.Thêm cột ID vào bảng locations với điều kiện cột ID là cột đầu tiên của bảng. 
alter table locations add id int

--4.Thêm cột region_id đứng liền sau cột state_province của bảng locations.
alter table locations add region_id int;

--5.Thay đổi kiểu dữ liệu của cột country_id thành integer trong bảng locations. 
alter table locations alter column country_id  int not null

--6.Xóa cột city trong bảng locations
alter table locations drop column city

--7.Đổi tên cột state_province thành cột state, giữa nguyên kiểu và kích thước của cột
EXEC sp_rename 'dbo.locations.state_province', 'state', 'COLUMN' 
--8. Thêm khóa chính cho cột location_id trong bảng location 
alter table locations add constraint fk_locations primary key(location_id)

--9.Thêm khóa chính là cặp 2 cột (location_id, country_id) cho bảng locations.
alter table locations drop constraint fk_locations 
alter table locations add constraint fk_locations_new primary key(location_id,country_id)
-- 10.Xóa khóa chính là cặp (location_id, country_id) đã tạo
alter table locations drop constraint fk_locations_new

-- 11.Tạo khóa ngoại job_id cho bảng job_history mà tham chiếu tới job_id của bảng jobs.
alter table job_history add constraint pk_job_history_1 foreign key(job_id) references jobs(job_id)
-- 12.Tạo ràng buộc có tên là fk_job_id với job_id của bảng job_history tham chiếu tới job_id của bảng jobs. 
alter table job_history drop constraint pk_job_history_1 
alter table job_history add constraint fk_job_id foreign key(job_id) references jobs(job_id)

-- 13.Xóa khóa ngoại fk_job_id trong bảng job_history đã tạo. 
alter table job_history drop constraint fk_job_id

-- 14.Thêm chỉ mục có tên indx_job_id trên thuộc tính job_id của bảng job_history.
create index indx_job_id on job_history(job_id)

-- 15.Xóa chỉ mục indx_job_id trong bảng job_history. 
drop index job_history.indx_job_id


