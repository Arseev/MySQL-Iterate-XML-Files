#!/bin/bash
#This is to iterate through a directory or thousands of XML files that need to be imported into a MySQL database.
#bash file that opens up into some mysql commands, once sql commands are run then bash deletes the file created by mysql for iteration.
#echo Start of the XML import script
mysql seerDB1<<EOFMYSQL
	
SET @COUNTER = INT(1);

CREATE PROCEDURE dowhile()
BEGIN

	WHILE @COUNTER > 0
		SET @FILE = CONCAT(@COUNTER, '.xml');
		SET @COMMAND = CONCAT("LOAD DATA INFILE '/shared/08-2016/",@FILE,"' INTO TABLE mainTable ROWS IDENTIFIED BY '<STAGE_GATEWAY>';");
		SELECT @COMMAND INTO OUTFILE '/shared/08-2016/importScript.sql';

		#runs the script created with next infile
		source /shared/08-2016/importScript.sql;
		SET @COUNTER = @COUNTER + 1;
    
	END WHILE;
END;

EOFMYSQL

#rm -r /shared/08-2016/importScript.sql

done




