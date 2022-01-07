DROP TABLE IF EXISTS Grades
DROP TABLE IF EXISTS Students
DROP TABLE IF EXISTS GradeRate
DROP TABLE IF EXISTS Programs
DROP TABLE IF EXISTS Subjects
DROP TABLE IF EXISTS Teachers
DROP TABLE IF EXISTS Contacts
DROP TABLE IF EXISTS Addresses



CREATE TABLE Students
(ID INT PRIMARY KEY, Title varchar(50) NOT NULL, FullName varchar(50) NOT NULL, Name varchar(50) NOT NULL, Surname varchar(50) NOT NULL, StudyYear varchar(50) NOT NULL, Term varchar(50) NOT NULL, StartYear INT NOT NULL, ProgramID INT NOT NULL, ContactID INT NOT NULL);

CREATE TABLE Teachers
(ID INT PRIMARY KEY, Title varchar(50) NOT NULL, FullName varchar(50) NOT NULL, Name varchar(50) NOT NULL, Surname varchar(50) NOT NULL, ContactID INT NOT NULL);

CREATE TABLE Programs
(ID INT PRIMARY KEY, ProgramName varchar(50) NOT NULL, Degree varchar(50) NOT NULL, Language varchar(50) NOT NULL, Length varchar(50) NOT NULL, Description varchar(255));

CREATE TABLE Subjects
(ID INT PRIMARY KEY, SubjectCode varchar(50) NOT NULL, SubjectName varchar(50) NOT NULL, NumOfTerms INT NOT NULL, TeacherID INT NOT NULL, Credits INT NOT NULL);

CREATE TABLE Contacts
(ID INT PRIMARY KEY, Phone varchar(50) NOT NULL, Email varchar(50) NOT NULL, AddressID INT NOT NULL);

CREATE TABLE Addresses
(ID INT PRIMARY KEY, Country varchar(50) NOT NULL, City varchar(50) NOT NULL, Municipality varchar(50) NOT NULL, ZipCode varchar(50) NOT NULL, Street varchar(50) NOT NULL, HouseNo varchar(50) NOT NULL);

CREATE TABLE Grades
(ID INT PRIMARY KEY, StudyYear varchar(50) NOT NULL, Term varchar(50) NOT NULL, GradeID INT NOT NULL, GradeDate Date NOT NULL, StudentID INT NOT NULL, SubjectID INT NOT NULL);

CREATE TABLE GradeRate
(ID INT PRIMARY KEY, GradeName varchar(50) NOT NULL, GradeRating INT NOT NULL);



ALTER TABLE Students	ADD CONSTRAINT StudentProgram	FOREIGN KEY (ProgramID) REFERENCES Programs (ID);
ALTER TABLE Students	ADD CONSTRAINT StudentContact	FOREIGN KEY (ContactID) REFERENCES Contacts (ID);
ALTER TABLE Teachers	ADD CONSTRAINT TeacherContact	FOREIGN KEY (ContactID) REFERENCES Contacts (ID);
ALTER TABLE Contacts	ADD CONSTRAINT COntactAddress	FOREIGN KEY (AddressID) REFERENCES Addresses(ID);
ALTER TABLE Subjects	ADD CONSTRAINT SubjectTeacher	FOREIGN KEY (TeacherID) REFERENCES Teachers (ID);
ALTER TABLE Grades		ADD CONSTRAINT GradeStudent		FOREIGN KEY (StudentID) REFERENCES Students (ID);
ALTER TABLE Grades		ADD CONSTRAINT GradeSubject		FOREIGN KEY (SubjectID) REFERENCES Subjects (ID);
ALTER TABLE Grades		ADD CONSTRAINT GradeRates		FOREIGN KEY (GradeID)	REFERENCES GradeRate(ID);


INSERT INTO Programs (ID, ProgramName, Degree, Language, Length, Description) VALUES
  (1, 'INFOAP', 'Bachelors', 'English', '3 years', 'Informatics')
, (2, 'COMSCI', 'Bachelors', 'English', '3 years', 'ComputerScience')

INSERT INTO Addresses (ID, Country, City, Municipality, ZipCode, Street, HouseNo) VALUES
  (1, 'Czech Republic', 'Prague', 'Nusle', '140 00', 'Kotorska', '1574/22')
, (2, 'Czech Republic', 'Prague', 'Haje', '149 00', 'Starobyla', '1009')
, (3, 'Czech Republic', 'Prague', 'Chodov', '148 00', 'Blatenska', '2178')
, (4, 'Czech Republic', 'Brno', 'Brno-stred', '602 00', 'Stredova', '161/2')

INSERT INTO Contacts (ID, Phone, Email, AddressID) VALUES
  (1, '+420775343656', 'Aygun.Guliyeva@studenti.czu.cz', 1)
, (2, '+420747845652', 'Pavel.Jedlicka@rektorat.czu.cz', 2)
, (3, '+420145665422', 'John.Peter@studenti.czu.cz', 3)
, (4, '+420855578565', 'James.Peter@rektorat.czu.cz', 3)
, (5, '+420269745632', 'Tereza.Valentova@rektorat.czu.cz', 4)

INSERT INTO Students (ID, Title, FullName, Name, Surname, StudyYear, Term, StartYear, ProgramID, ContactID) VALUES
  (1, 'Bcs', 'Aygun Guliyeva', 'Aygun', 'Guliyeva', '2nd', '3rd', 2020, 1, 1)
, (2, 'Bcs', 'John Peter', 'John', 'Peter', '1st', '1st', 2021, 2, 3)

INSERT INTO Teachers (ID, Title, FullName, Name, Surname, ContactID) VALUES
  (1, 'Prof.', 'Pavel Jedlicka', 'Pavel', 'Jedlicka', 2)
, (3, 'Prof.', 'James Peter', 'James', 'Peter', 4)
, (2, 'Prof.', 'Tereza Valentova', 'Tereza', 'Valentova', 5)

INSERT INTO Subjects (ID, SubjectCode, SubjectName, NumOfTerms, Credits, TeacherID) VALUES
  (1, 'AppMath', 'Applied Mathematics', 2, 30, 1)
, (2, 'AlgDev', 'Algorythm Development', 1, 25, 2)
, (3, 'ComArch', 'Computer Architecture', 2, 30, 3)

INSERT INTO GradeRate (ID, GradeName, GradeRating) VALUES
(1, 'Excellent', 5), (2, 'Very Good', 4), (3, 'Good', 3), (4, 'Satisfactory', 2), (5, 'Failure', 1)

INSERT INTO Grades (ID, StudyYear, Term, GradeID, GradeDate, StudentID, SubjectID) VALUES
  (1, '1st', '1st', 2, '2020-11-29', 1, 1)
, (2, '1st', '1st', 1, '2020-12-15', 1, 2)
, (3, '1st', '1st', 1, '2020-12-28', 1, 3)
, (4, '1st', '2nd', 2, '2021-05-25', 1, 1)
, (5, '1st', '2nd', 2, '2020-06-08', 1, 3)
, (6, '1st', '1st', 1, '2021-12-08', 2, 1)
, (7, '1st', '1st', 2, '2021-12-15', 2, 2)
, (8, '1st', '1st', 3, '2021-12-20', 2, 3)



SELECT * FROM Grades gr
SELECT * FROM GradeRate rt
SELECT * FROM Students st
SELECT * FROM Programs pr
SELECT * FROM Subjects sb
SELECT * FROM Teachers tc
SELECT * FROM Contacts cn
SELECT * FROM Addresses ad



SELECT st.FullName AS StudentName, pr.ProgramName, st.StudyYear AS CurrentYear, st.Term AS CurrentTerm, sb.SubjectName, gr.StudyYear, gr.Term, rt.GradeName, gr.GradeDate, tc.FullName AS Examiner
FROM Grades gr
LEFT JOIN GradeRate rt ON gr.GradeID = rt.ID
LEFT JOIN Students st ON gr.StudentID = st.ID
LEFT JOIN Subjects sb ON gr.SubjectID = sb.ID
LEFT JOIN Teachers tc ON sb.TeacherID = tc.ID
LEFT JOIN Programs pr ON st.ProgramID = pr.ID
ORDER BY StudentName, GradeDate



SELECT st.FullName AS StudentName, sb.SubjectName, AVG(rt.GradeRating) AS AvgGrade
FROM Grades gr
LEFT JOIN GradeRate rt ON gr.GradeID = rt.ID
LEFT JOIN Subjects sb ON gr.SubjectID = sb.ID
LEFT JOIN Students st ON gr.StudentID = st.ID
GROUP BY st.FullName, sb.SubjectName
ORDER BY StudentName



SELECT tc.FullName AS TeacherName, sb.SubjectName, sb.NumOfTerms*sb.Credits AS YearlyCredits, DENSE_RANK() OVER(ORDER BY sb.NumOfTerms*sb.Credits DESC) AS CreditsRank, cn.Phone, cn.Email, ad.City
FROM Subjects sb
LEFT JOIN Teachers tc ON sb.TeacherID = tc.ID
LEFT JOIN Contacts cn ON tc.ContactID = cn.ID
LEFT JOIN Addresses ad ON cn.AddressID = ad.ID
ORDER BY tc.FullName


SELECT st.FullName AS StudentName, sb.SubjectName, gr.StudyYear, gr.Term, rt.GradeName, gr.GradeDate, tc.FullName AS Examiner
FROM Grades gr
LEFT JOIN GradeRate rt ON gr.GradeID = rt.ID
LEFT JOIN Students st ON gr.StudentID = st.ID
LEFT JOIN Subjects sb ON gr.SubjectID = sb.ID
LEFT JOIN Teachers tc ON sb.TeacherID = tc.ID
WHERE GradeName LIKE '%fail%'
ORDER BY StudentName, GradeDate


SELECT ppl.Title, ppl.FullName, cn.Phone, cn.Email, ad.ID, ad. Country, ad.City, ad.Municipality, ad.Street, ad.HouseNo, ad.ZipCode
FROM (	SELECT Title, FullName, ContactID FROM Students
		UNION ALL
		SELECT Title, FullName, ContactID FROM Teachers) ppl
LEFT JOIN Contacts cn ON ppl.ContactID = cn.ID
LEFT JOIN Addresses ad ON cn.AddressID = ad.ID
INNER JOIN
	(SELECT cn.AddressID, COUNT(cn.AddressID) AS Cnt
	FROM Contacts cn
	GROUP BY cn.AddressID
	HAVING COUNT(cn.AddressID) > 1) fml ON cn.AddressID = fml.AddressID



