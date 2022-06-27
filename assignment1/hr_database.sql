create database hr_database
go
use hr_database
go
create table regions (
	region_id int,
	region_name varchar(25),
	primary key (region_id)
);
go
create table countries (
	country_id int,
	country_name varchar(40),
	region_id int,
	primary key (country_id),
	foreign key (region_id) references regions(region_id)
);

go
create table locations (
	location_id int,
	street_address varchar(25),
	postal_code varchar(12),
	city varchar(30),
	state_province varchar(12),
	country_id int,
	foreign key (country_id) references countries(country_id)
);
alter table locations drop constraint [PK__location__771831EA2AE6C6B2]

go
create table departments (
	department_id int,
	department_name varchar(25),
	manager_id int,
	location_id int,
	primary key (department_id),
);
go
create table jobs (
	job_id varchar(10),
	job_title varchar(35),
	min_salary int,
	max_salary int,
	primary key (job_id)
);
go
create table job_history (
	employee_id int,
	start_date date,
	end_date date,
	job_id varchar(10),
	department_id int,
	primary key (employee_id, start_date),
	foreign key (department_id) references departments(department_id),
	foreign key (job_id) references jobs(job_id)
);
go
create table job_grades (
	grade_level varchar(2),
	lowest_sal int,
	highest_sal int
);
go
create table employees (
	employee_id int,
	first_name varchar(20),
	last_name varchar(25),
	email varchar(25),
	phone_number varchar(20),
	hire_date date,
	job_id varchar(10),
	salary int,
	commission_pct int,
	manager_id int,
	department_id int,
	primary key (employee_id),
	foreign key (department_id) references departments(department_id),
	foreign key (job_id) references jobs(job_id)
);
go
alter table job_history add unique(employee_id);
go
alter table employees add foreign key (employee_id) references job_history(employee_id);
