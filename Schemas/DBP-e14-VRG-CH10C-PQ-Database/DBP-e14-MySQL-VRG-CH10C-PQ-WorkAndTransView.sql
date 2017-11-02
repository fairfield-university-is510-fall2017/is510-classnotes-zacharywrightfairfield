/********************************************************************************/
/*											                                 	*/
/*	Kroenke and Auer - Database Processing (13th Edition) Chapter 10C     		*/
/*	10C.36.J																	*/
/*	The VRG-CH10C-PQ Database - Create WorkAndTransView							*/
/*																				*/
/*	These are the MySQL 5.6 SQL code solutions				                    */
/*																				*/
/********************************************************************************/

CREATE VIEW WorkAndTransView AS
	SELECT   W.Title, W.Copy, W.Medium, W.Description, W.ArtistID,
           T.DateAcquired, T.AcquisitionPrice, T.DateSold,
			     T.AskingPrice, T.SalesPrice, T.CustomerID
	FROM 	   WORK AS W, TRANS AS T
	WHERE	   W.WorkID = T.WorkID;

# To test the view, use -->

SELECT *    FROM WorkAndTransView
ORDER BY    Title, Copy;     








