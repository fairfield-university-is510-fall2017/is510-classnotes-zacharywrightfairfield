# J
DELIMITER //
CREATE FUNCTION GetLastNameCommaSeparated
-- These are the input parameters
(
varName VARCHAR(25)
)
RETURNS VARCHAR(25) DETERMINISTIC
BEGIN
-- This is the variable that will hold the value to be returned
DECLARE varLastName VARCHAR(25);
-- This is the variable that will hold the position of the comma
DECLARE varIndexValue INT;
-- SQL statement to find the comma separator
SET varIndexValue = LOCATE(',', varName);
-- SQL statement to determine last name
SET varLastName = SUBSTRING(varName, 1, (varIndexValue - 1));
-- Return the last name
RETURN varLastName;
END
//
DELIMITER ;

# test above function
select GetLastNameCommaSeparated("Frost, Robert");

# K
DELIMITER //
CREATE FUNCTION GetFirstNameCommaSeparated
-- These are the input parameters
(
varName VARCHAR(50)
)
RETURNS VARCHAR(25) DETERMINISTIC
BEGIN
-- This is the variable that will hold the value to be returned
DECLARE varFirstName VARCHAR(25);
-- This is the variable that will hold the position of the comma
DECLARE varIndexValue INT;
-- SQL statement to find the comma separator
SET varIndexValue = LOCATE(',', varName);
-- SQL statement to determine last name1
SET varFirstName = SUBSTRING(varName, (varIndexValue + 2));
-- Return the first name
RETURN varFirstName;
END
//
DELIMITER ;

# test above function
select getfirstnamecommaseparated("Frost, Robert");

# L
ALTER TABLE insurance_temp
  ADD AgentLastName VarChar(45) NULL;
  
ALTER TABLE insurance_temp
  ADD AgentFirstName VarChar(45) NULL;

# M
UPDATE insurance_temp
  		SET AgentLastName = GetLastNameCommaSeparated(AgentName);
  
# N
UPDATE insurance_temp
  			SET AgentFirstName = GetFirstNameCommaSeparated(AgentName);
  
# test M and N
SELECT AgentLastName, AgentFirstName FROM Insurance_temp;

# O

CREATE TABLE INSURANCE_BROKER (
		InsuranceBrokerID		INT NOT NULL auto_increment,
		InsuranceBrokerName  	VarChar(45) NOT NULL,
		AgentLastName			VarChar(45) NOT NULL,
        AgentFirstName			VarChar(45) NOT NULL,
        AgentEmailAddress		VarChar(100) NOT NULL,
        AgentPhone				VarChar(45) NULL,
		CONSTRAINT IB_PK PRIMARY KEY (InsuranceBrokerID));


# P
INSERT INTO INSURANCE_BROKER
		SELECT null, IT.InsuranceBrokerName, IT.AgentLastName, IT.AgentFirstName,
        IT.AgentEmailAddress, IT.AgentPhone
		FROM (SELECT DISTINCT InsuranceBrokerName, AgentLastName, AgentFirstName, 
        AgentEmailAddress, AgentPhone
		      FROM insurance_temp) IT;

select * from insurance_broker;

# Q
CREATE TABLE INSURANCE_POLICY (
		InsurancePolicyID	VarChar(25) NOT NULL,
		ShipmentID		Int NOT NULL,
		InsuranceBrokerID	Int NOT NULL,
		ShippingValue	Numeric(12,2) Null,
		PolicyAmount	Numeric(12,2) not null,
		CONSTRAINT IP_PK PRIMARY KEY (InsurancePolicyID),
		CONSTRAINT SI_FK_SHIPMENT FOREIGN KEY (ShipmentID)
			REFERENCES SHIPMENT(ShipmentID),
		CONSTRAINT IP_FK_IB FOREIGN KEY (InsuranceBrokerID) 
REFERENCES Insurance_Broker(InsuranceBrokerID));

/*  R  */

ALTER TABLE INSURANCE_TEMP
	ADD InsuranceBrokerID Int NULL;

UPDATE INSURANCE_TEMP
  SET InsuranceBrokerID =
   (SELECT InsuranceBrokerID
    FROM INSURANCE_BROKER IB
    WHERE IB.InsuranceBrokerName = 	INSURANCE_TEMP.InsuranceBrokerName
     );
     
select * from insurance_temp;
select * from shipment;
     

/*  S  */

INSERT INTO INSURANCE_POLICY
	SELECT InsurancePolicyID, ShipmentID, InsuranceBrokerID,
		ShippingValue, PolicyAmount
	FROM INSURANCE_TEMP;
    
select * from insurance_policy;

/*  T  */

/*  No answer required  */




     