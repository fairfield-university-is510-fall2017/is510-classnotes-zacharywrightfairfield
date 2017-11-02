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

