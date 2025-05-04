/*
----------------------------   EASY  -------------------------------------
1-savol:

Data - tartiblanmagan malumotlar yig'indisiga data deyiladi. Masalan: rasmlar, videolar, harxil turdagi ma'lumotlar

Database - ma'lumotlarni tarib bilan saqlash va ulardan tez , tushunarli foydalanish uchun kerak buladigan tizimdir

Relation Database - Bu malumotlarni jadval kurinishidagi turi. Har bir Relation database alohida mavzu uchun yaratiladi

Jadval- ustun va satrlardan tashkil topgan relation databasening qismi hisoblanadi. Unda ma'lumotlarni turlari 
va ma'lumotlarning uzi tashkil topgan bo'ladi

2-savol:
Ma'lumotlarni tartib bilan tushunarli qilib saqlash
Ma'lumotlarni oson qushish va olib tashlash
Ma'lumotlarning xafsizligii oshirish. Foydalanuchilarga kerakli ma'lumotlarga kirshga ruxsat berish
Ma'lumotlar yo'qolmasligi. Sqlning avtomatik saqlashi
Oson va sodda boshqarish

3-savol 
Windows orqali kirish : Bu kirish usuli orqali noutbukning uzini serveri orqali kiriladi. Login va parollarsiz tez va oson.

SQL Server orqali kirish: BU orqali windows tizimini ishlatmaydiganlar kupincha foydalanadi. Va bunda login parol bilan kiriladi


----------------------------    Medium   -----------------------------------------
*/

CREATE DATABASE SchoolDB;

use SchoolDB

create table Students(
	StudentID int ,
    Ism varchar(50),
    Age int)

select * from Students

/*
Describe the differences between SQL Server, SSMS, and SQL? - 

SQL Server	Ma’lumotlarni saqlaydigan va boshqaradigan server dasturi
SSMS SQL Server bilan ishlash uchun qulay grafik dastur
SQL	Ma’lumotlar bilan ishlash uchun yoziladigan buyruqlar tili


---------------------------  HARD - ---------------------------

DQL ||	Ma’lumotni so‘rash	    ||      SELECT
DML	||Ma’lumotni o‘zgartirish	||INSERT, UPDATE, DELETE
DDL	||Strukturani boshqarish	||CREATE, ALTER, DROP
DCL	||Ruxsatlarni boshqarish	||GRANT, REVOKE
TCL	||Operatsiyalarni nazorat qilish ||	COMMIT, ROLLBACK, SAVEPOINT
*/

insert into Students (StudentID, Ism, Age)VALUES 
(1, 'Baxodir', 20),
(2, 'Azamat', 22),
(3, 'Bexruz', 19)

--Oxirgi bak faylni ham ishga tushurdim 
/*
AdventureWorksDW2022.bak faylni GitHub havolasi orqali yuklab oldim.

Faylni Backup papkaga ko‘chirdim.

SSMS dasturida Restore Database... oynasini ochdim.

Device orqali .bak faylni tanladim.

Fayl tanlanganidan so‘ng, AdventureWorksDW2022 nomini saqladim.
*/