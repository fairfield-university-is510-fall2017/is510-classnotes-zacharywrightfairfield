/* MySQL solutions for ch07 */
/* 7.101 command still runs even if syntax warning on CHECK constraint */

CREATE  TABLE COMPUTER(	
	SerialNumber		Int					NOT NULL,
	Make				Char(12)			NOT NULL,
	Model				Char(24)			NOT NULL,
	ProcessorType		Char(24)			NULL,
	ProcessorSpeed	Numeric(3,2)		NOT NULL,
	MainMemory		Char(15)			NOT NULL,
	DiskSize			Char(15)			NOT NULL,
	CONSTRAINT 		COMPUTER_PK 		PRIMARY KEY(SerialNumber),
	CONSTRAINT 		MAKE_CHECK		CHECK
								(Make IN ('Dell', 'HP', 'Other')),
	CONSTRAINT 		SPEED_CHECK		CHECK
								(ProcessorSpeed BETWEEN 2.0 AND 5.0)
	);

/* command still runs even if syntax warning on ON UPDATE NO ACTION */
CREATE  TABLE COMPUTER_ASSIGNMENT(
	SerialNumber		Int					NOT NULL,
    EmployeeNumber	Int	 				NOT NULL,
	DateAssigned		Date				NOT NULL,
	DateReassigned	Date				NULL,
	CONSTRAINT 		COMP_ASSIGN_PK 	PRIMARY KEY(SerialNumber,EmployeeNumber),
	CONSTRAINT 		COMP_ASSIGN_EMPLOYEE	FOREIGN KEY(EmployeeNumber)
						REFERENCES EMPLOYEE(EmployeeNumber)
							ON UPDATE NO ACTION
							ON DELETE NO ACTION,
	CONSTRAINT 		COMP_ASSIGN_COMPUTER	FOREIGN KEY(SerialNumber)
						REFERENCES COMPUTER(SerialNumber)
							ON UPDATE NO ACTION
							ON DELETE CASCADE
	);

/* 7.102 */
INSERT INTO COMPUTER VALUES(
	9871234, 'HP', 'Pavilion 500qe', 'Intel i5-4590', 3.30,
	'8.0 GByte', '1.0 TBytes');
INSERT INTO COMPUTER VALUES(
	9871245, 'HP', 'Pavilion 500qe', 'Intel i5-4590', 3.30,
	'8.0 GByte', '1.0 TBytes');
INSERT INTO COMPUTER VALUES(
	9871256, 'HP', 'Pavilion 500qe', 'Intel i5-4590', 3.30,
	'8.0 GByte', '1.0 TBytes');
INSERT INTO COMPUTER VALUES(
	9871267, 'HP', 'Pavilion 500qe', 'Intel i5-4590', 3.30,
	'8.0 GByte', '1.0 TBytes');
INSERT INTO COMPUTER VALUES(
	9871278, 'HP', 'Pavilion 500qe', 'Intel i5-4590', 3.30,
	'8.0 GByte', '1.0 TBytes');
INSERT INTO COMPUTER VALUES(
	9871289, 'HP', 'Pavilion 500qe', 'Intel i5-4590', 3.30,
	'8.0 GByte', '1.0 TBytes');
INSERT INTO COMPUTER VALUES(
	6541001, 'Dell', 'OptiPlex 9020', 'Intel i7-4790', 3.60,
	'8.0 GBytes', '1.0 TBytes');
INSERT INTO COMPUTER VALUES(
	6541002, 'Dell', 'OptiPlex 9020', 'Intel i7-4790', 3.60,
	'8.0 GBytes', '1.0 TBytes');
INSERT INTO COMPUTER VALUES(
	6541003, 'Dell', 'OptiPlex 9020', 'Intel i7-4790', 3.60,
	'8.0 GBytes', '1.0 TBytes');
INSERT INTO COMPUTER VALUES(
	6541004, 'Dell', 'OptiPlex 9020', 'Intel i7-4790', 3.60,
	'8.0 GBytes', '1.0 TBytes');
INSERT INTO COMPUTER VALUES(
	6541005, 'Dell', 'OptiPlex 9020', 'Intel i7-4790', 3.60,
	'8.0 GBytes', '1.0 TBytes');
INSERT INTO COMPUTER VALUES(
	6541006, 'Dell', 'OptiPlex 9020', 'Intel i7-4790', 3.60,
	'8.0 GBytes', '1.0 TBytes');

/* 7.102 */
INSERT INTO COMPUTER VALUES(
	9871234, 'HP', 'Pavilion 500qe', 'Intel i5-4590', 3.30,
	'8.0 GByte', '1.0 TBytes');
INSERT INTO COMPUTER VALUES(
	9871245, 'HP', 'Pavilion 500qe', 'Intel i5-4590', 3.30,
	'8.0 GByte', '1.0 TBytes');
INSERT INTO COMPUTER VALUES(
	9871256, 'HP', 'Pavilion 500qe', 'Intel i5-4590', 3.30,
	'8.0 GByte', '1.0 TBytes');
INSERT INTO COMPUTER VALUES(
	9871267, 'HP', 'Pavilion 500qe', 'Intel i5-4590', 3.30,
	'8.0 GByte', '1.0 TBytes');
INSERT INTO COMPUTER VALUES(
	9871278, 'HP', 'Pavilion 500qe', 'Intel i5-4590', 3.30,
	'8.0 GByte', '1.0 TBytes');
INSERT INTO COMPUTER VALUES(
	9871289, 'HP', 'Pavilion 500qe', 'Intel i5-4590', 3.30,
	'8.0 GByte', '1.0 TBytes');
INSERT INTO COMPUTER VALUES(
	6541001, 'Dell', 'OptiPlex 9020', 'Intel i7-4790', 3.60,
	'8.0 GBytes', '1.0 TBytes');
INSERT INTO COMPUTER VALUES(
	6541002, 'Dell', 'OptiPlex 9020', 'Intel i7-4790', 3.60,
	'8.0 GBytes', '1.0 TBytes');
INSERT INTO COMPUTER VALUES(
	6541003, 'Dell', 'OptiPlex 9020', 'Intel i7-4790', 3.60,
	'8.0 GBytes', '1.0 TBytes');
INSERT INTO COMPUTER VALUES(
	6541004, 'Dell', 'OptiPlex 9020', 'Intel i7-4790', 3.60,
	'8.0 GBytes', '1.0 TBytes');
INSERT INTO COMPUTER VALUES(
	6541005, 'Dell', 'OptiPlex 9020', 'Intel i7-4790', 3.60,
	'8.0 GBytes', '1.0 TBytes');
INSERT INTO COMPUTER VALUES(
	6541006, 'Dell', 'OptiPlex 9020', 'Intel i7-4790', 3.60,
	'8.0 GBytes', '1.0 TBytes');
    
/* 7.102 */
INSERT INTO COMPUTER_ASSIGNMENT VALUES(9871234, 11, '2015-09-15', '2015-10-21');
INSERT INTO COMPUTER_ASSIGNMENT VALUES(9871245, 12, '2015-09-15', '2015-10-21');
INSERT INTO COMPUTER_ASSIGNMENT (SerialNumber, EmployeeNumber, DateAssigned)
		VALUES(9871256, 4, '2015-09-15');
INSERT INTO COMPUTER_ASSIGNMENT (SerialNumber, EmployeeNumber, DateAssigned)
		VALUES(9871267, 5, '2015-09-15');
INSERT INTO COMPUTER_ASSIGNMENT (SerialNumber, EmployeeNumber, DateAssigned)
		VALUES(9871278, 8, '2015-09-15');
INSERT INTO COMPUTER_ASSIGNMENT (SerialNumber, EmployeeNumber, DateAssigned)
	    VALUES(9871289, 9, '2015-09-15');
INSERT INTO COMPUTER_ASSIGNMENT (SerialNumber, EmployeeNumber, DateAssigned)
		VALUES(6541001, 11, '2015-10-21');
INSERT INTO COMPUTER_ASSIGNMENT (SerialNumber, EmployeeNumber, DateAssigned)
		VALUES(6541002, 12, '2015-10-21');
INSERT INTO COMPUTER_ASSIGNMENT (SerialNumber, EmployeeNumber, DateAssigned)
		VALUES(6541003, 1, '2015-10-21');
INSERT INTO COMPUTER_ASSIGNMENT (SerialNumber, EmployeeNumber, DateAssigned)
		VALUES(6541004, 2, '2015-10-21');
INSERT INTO COMPUTER_ASSIGNMENT (SerialNumber, EmployeeNumber, DateAssigned)
		VALUES(6541005, 3, '2015-10-21');
INSERT INTO COMPUTER_ASSIGNMENT (SerialNumber, EmployeeNumber, DateAssigned)
		VALUES(6541006, 6, '2015-10-21');
INSERT INTO COMPUTER_ASSIGNMENT (SerialNumber, EmployeeNumber, DateAssigned)
		VALUES(9871234, 7, '2015-11-05');
INSERT INTO COMPUTER_ASSIGNMENT (SerialNumber, EmployeeNumber, DateAssigned)
		VALUES(9871245, 10, '2015-11-05');
