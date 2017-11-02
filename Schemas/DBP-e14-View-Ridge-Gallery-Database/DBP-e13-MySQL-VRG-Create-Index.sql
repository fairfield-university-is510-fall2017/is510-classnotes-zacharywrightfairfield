/********************************************************************************/
/*																		        */
/*	Kroenke and Auer - Database Processing (13th Edition) Chapter 10C         	*/
/*																		        */
/*	The View Ridge Gallery (VRG) - Create Index 							    */
/*																		        */
/*	These are the MySQL 5.5 SQL code solutions                              	*/
/*																		        */
/********************************************************************************/

/* *** SQL-ALTER-TABLE-CH10C-01 *** */
ALTER TABLE CUSTOMER
    ADD INDEX ZipPostalCodeIndex
        USING BTREE(ZipPostalCode);
