create database ShopperStoreDb 
use ShopperStoreDb

create schema Production
create schema Sales;
create schema HumanResources;
create schema Person;


 TABLES W/O DEPENDENCIES OF FOREIGN KEY

create table Person.Person
(
  personID int  primary key identity(1,1),
  title varchar(10),
  firstname varchar(50) not null,
  middlename varchar(50),
  lastname varchar(50),
  gender varchar(10) not null check(gender in ('M','F')),
  modifieddate date default getdate()
);

create table Sales.Country
(
   countryID int primary key identity(1,1),
   countryName varchar(100)

);

create  table HumanResources.Department
(
  DepartmentID int primary key identity(1,101),
  departmentname varchar(50)
);

create table Production.ProductCategory
(
   ProductCategoryID int primary key identity(1,1),
   ProductCategoryName varchar(100)

);



 TABLES WITH DEPENDENCIES OF FOREIGN KEY


create table Sales.Territory
(
   territoryID int primary key identity(1,1),
   territoryname varchar(100),
   countryid int references Sales.Country(countryID)on delete set null on update cascade,
);

create table Sales.Customer
(
   customerID int primary key identity(1,1),
   personID  int references Person.Person(PersonID) on delete set null on update cascade,
   territoryID int references Sales.Territory(territoryID) on delete set null on update cascade,
    CustomerGrade varchar(10) not null
);

create table HumanResources.Employee
(
   EmployeeID int primary key identity(1,1001),
   Designation varchar(100) not null,
   ManagerID int references HumanResources.Employee(EmployeeID) ,
   DateofJoining date not null check(DateofJoining < getdate()),
   DepartmentID   int references HumanResources.Department(DepartmentID) on delete set null on update cascade,
   personID  int references Person.Person(PersonID)  on delete set null on update cascade
);



create table Sales.SalesOrderHeader
(
  SalesorderheaderID int primary key identity(1,1),
  orderdate date not null check (orderdate < getdate()),
  customerID int references Sales.Customer(customerID) on delete set null on update cascade,
  salespersonID int references HumanResources.Employee(employeeid) on delete set null
);


create  table  Production.ProductSubCategory  
(
  ProductSubCategoryID int primary key identity(1,1),
  ProductSubCategoryName varchar(100) not null,
  ProductCategoryID int references  Production.ProductCategory(ProductCategoryID) on delete set null on update cascade
);


create table Production.Product
(
  ProductID int primary key identity(1,101),
  ProductName varchar(500) not null,
  ProductCost money not null,
  QuantityInStock int not null,
  ProductSubCategoryID int references  Production.ProductSubCategory(ProductSubCategoryID) on delete set null on update cascade

);

create table Sales.SalesOrderDetail
(
   SalesOrderDetaiID int primary key identity(1,1),
   SalesorderheaderID int references Sales.SalesOrderHeader( SalesorderheaderID) on delete set null ,
   ProductID int references Production.Product (productid) on delete set null ,
   OrderQuantity int not null
)