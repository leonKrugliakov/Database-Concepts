/* Introduction to SQL 					*/
/* Script file for ORACLE  DBMS				*/
/* This script file creates the following tables:	*/
/* VENDOR, PRODUCT, CUSTOMER, INVOICE, LINE		*/
/* EMPLOYEE, EMP					*/
/* and loads the default data rows			*/

CREATE TABLE VENDOR (
V_CODE 		NUMBER,
V_NAME 		VARCHAR2(35) NOT NULL,
V_CONTACT 	VARCHAR2(15) NOT NULL,
V_AREACODE 	CHAR(3) NOT NULL,
V_PHONE 	CHAR(8) NOT NULL,
V_STATE 	CHAR(2) NOT NULL,
V_ORDER 	CHAR(1) NOT NULL,
PRIMARY KEY (V_CODE));

CREATE TABLE PRODUCT (
P_CODE 	VARCHAR2(10) CONSTRAINT PRODUCT_P_CODE_PK PRIMARY KEY,
P_DESCRIPT 	VARCHAR2(35) NOT NULL,
P_INDATE 	DATE NOT NULL,
P_QOH 	  	NUMBER NOT NULL,
P_MIN 		NUMBER NOT NULL,
P_PRICE 	NUMBER(8,2) NOT NULL,
P_DISCOUNT 	NUMBER(5,2) NOT NULL,
V_CODE 		NUMBER,
CONSTRAINT PRODUCT_V_CODE_FK
FOREIGN KEY (V_CODE) REFERENCES VENDOR);

CREATE TABLE CUSTOMER (
CUS_CODE	NUMBER PRIMARY KEY,
CUS_LNAME	VARCHAR2(15) NOT NULL,
CUS_FNAME	VARCHAR2(15) NOT NULL,
CUS_INITIAL	CHAR(1),
CUS_AREACODE 	CHAR(3),
CUS_PHONE	CHAR(8) NOT NULL,
CUS_BALANCE	NUMBER(9,2) DEFAULT 0.00,
CONSTRAINT CUS_UI1 UNIQUE(CUS_LNAME,CUS_FNAME, CUS_PHONE));

CREATE TABLE INVOICE (
INV_NUMBER     	NUMBER PRIMARY KEY,
CUS_CODE	NUMBER NOT NULL REFERENCES CUSTOMER(CUS_CODE),
INV_DATE  	DATE DEFAULT SYSDATE NOT NULL
);

CREATE TABLE LINE (
INV_NUMBER 	NUMBER NOT NULL,
LINE_NUMBER	NUMBER(2,0) NOT NULL,
P_CODE		VARCHAR2(10) NOT NULL,
LINE_UNITS	NUMBER(9,2) DEFAULT 0.00 NOT NULL,
LINE_PRICE	NUMBER(9,2) DEFAULT 0.00 NOT NULL,
PRIMARY KEY (INV_NUMBER,LINE_NUMBER),
FOREIGN KEY (INV_NUMBER) REFERENCES INVOICE ON DELETE CASCADE,
FOREIGN KEY (P_CODE) REFERENCES PRODUCT(P_CODE),
CONSTRAINT LINE_UI1 UNIQUE(INV_NUMBER, P_CODE));

CREATE TABLE EMPLOYEE (
EMP_NUM		NUMBER 	PRIMARY KEY,
EMP_TITLE	CHAR(10),
EMP_LNAME	VARCHAR2(15) NOT NULL,
EMP_FNAME	VARCHAR2(15) NOT NULL,
EMP_INITIAL	CHAR(1),
EMP_DOB		DATE,
EMP_HIRE_DATE	DATE,
EMP_YEARS	NUMBER,
EMP_AREACODE 	CHAR(3),
EMP_PHONE	CHAR(8));

CREATE TABLE EMP2 (
EMP_NUM		NUMBER 	PRIMARY KEY,
EMP_TITLE	CHAR(10),
EMP_LNAME	VARCHAR2(15) NOT NULL,
EMP_FNAME	VARCHAR2(15) NOT NULL,
EMP_INITIAL	CHAR(1),
EMP_DOB		DATE,
EMP_HIRE_DATE	DATE,
EMP_AREACODE 	CHAR(3),
EMP_PHONE	CHAR(8),
EMP_MGR		NUMBER,
CONSTRAINT EMP_FK FOREIGN KEY (EMP_MGR) REFERENCES EMP2(EMP_NUM));



/* Loading data rows					*/
/* Turn Escape character on                             */
/* Default escape character "\" 			*/
/* Used to enter special characters (&)			*/



/* VENDOR rows						*/
INSERT INTO VENDOR VALUES(21225,'Bryson, Inc.'    ,'Smithson','615','223-3234','TN','Y');
INSERT INTO VENDOR VALUES(21226,'SuperLoo, Inc.'  ,'Flushing','904','215-8995','FL','N');
INSERT INTO VENDOR VALUES(21231,'D\&E Supply'     ,'Singh'   ,'615','228-3245','TN','Y');
INSERT INTO VENDOR VALUES(21344,'Gomez Bros.'     ,'Ortega'  ,'615','889-2546','KY','N');
INSERT INTO VENDOR VALUES(22567,'Dome Supply'     ,'Smith'   ,'901','678-1419','GA','N');
INSERT INTO VENDOR VALUES(23119,'Randsets Ltd.'   ,'Anderson','901','678-3998','GA','Y');
INSERT INTO VENDOR VALUES(24004,'Brackman Bros.'  ,'Browning','615','228-1410','TN','N');
INSERT INTO VENDOR VALUES(24288,'ORDVA, Inc.'     ,'Hakford' ,'615','898-1234','TN','Y');
INSERT INTO VENDOR VALUES(25443,'B\&K, Inc.'      ,'Smith'   ,'904','227-0093','FL','N');
INSERT INTO VENDOR VALUES(25501,'Damal Supplies'  ,'Smythe'  ,'615','890-3529','TN','N');
INSERT INTO VENDOR VALUES(25595,'Rubicon Systems' ,'Orton'   ,'904','456-0092','FL','Y');

/* PRODUCT rows						*/
INSERT INTO PRODUCT VALUES('11QER/31','Power painter, 15 psi., 3-nozzle'     ,to_date('03-NOV-2017', 'dd-mon-yyyy'),  8,  5,109.99,0.00,25595);
INSERT INTO PRODUCT VALUES('13-Q2/P2','7.25-in. pwr. saw blade'              ,to_date('13-DEC-2017', 'dd-mon-yyyy'), 32, 15, 14.99,0.05,21344);
INSERT INTO PRODUCT VALUES('14-Q1/L3','9.00-in. pwr. saw blade'              ,to_date('13-NOV-2017', 'dd-mon-yyyy'), 18, 12, 17.49,0.00,21344);
INSERT INTO PRODUCT VALUES('1546-QQ2','Hrd. cloth, 1/4-in., 2x50'            ,to_date('15-JAN-2018', 'dd-mon-yyyy'), 15,  8, 39.95,0.00,23119);
INSERT INTO PRODUCT VALUES('1558-QW1','Hrd. cloth, 1/2-in., 3x50'            ,to_date('15-JAN-2018', 'dd-mon-yyyy'), 23,  5, 43.99,0.00,23119);
INSERT INTO PRODUCT VALUES('2232/QTY','B\&D jigsaw, 12-in. blade'            ,to_date('30-DEC-2017', 'dd-mon-yyyy'),  8,  5,109.92,0.05,24288);
INSERT INTO PRODUCT VALUES('2232/QWE','B\&D jigsaw, 8-in. blade'             ,to_date('24-DEC-2017', 'dd-mon-yyyy'),  6,  5, 99.87,0.05,24288);
INSERT INTO PRODUCT VALUES('2238/QPD','B\&D cordless drill, 1/2-in.'         ,to_date('20-JAN-2018', 'dd-mon-yyyy'), 12,  5, 38.95,0.05,25595);
INSERT INTO PRODUCT VALUES('23109-HB','Claw hammer'                          ,to_date('20-JAN-2018', 'dd-mon-yyyy'), 23, 10,  9.95,0.10,21225);
INSERT INTO PRODUCT VALUES('23114-AA','Sledge hammer, 12 lb.'                ,to_date('02-JAN-2018', 'dd-mon-yyyy'),  8,  5, 14.40,0.05,NULL);
INSERT INTO PRODUCT VALUES('54778-2T','Rat-tail file, 1/8-in. fine'          ,to_date('15-DEC-2017', 'dd-mon-yyyy'), 43, 20,  4.99,0.00,21344);
INSERT INTO PRODUCT VALUES('89-WRE-Q','Hicut chain saw, 16 in.'              ,to_date('07-FEB-2018', 'dd-mon-yyyy'), 11,  5,256.99,0.05,24288);
INSERT INTO PRODUCT VALUES('PVC23DRT','PVC pipe, 3.5-in., 8-ft'              ,to_date('20-FEB-2018', 'dd-mon-yyyy'),188, 75,  5.87,0.00,NULL);
INSERT INTO PRODUCT VALUES('SM-18277','1.25-in. metal screw, 25'             ,to_date('01-MAR-2018', 'dd-mon-yyyy'),172, 75,  6.99,0.00,21225);
INSERT INTO PRODUCT VALUES('SW-23116','2.5-in. wd. screw, 50'                ,to_date('24-FEB-2018', 'dd-mon-yyyy'),237,100,  8.45,0.00,21231);
INSERT INTO PRODUCT VALUES('WR3/TT3' ,'Steel matting, 4''x8''x1/6", .5" mesh',to_date('17-JAN-2018', 'dd-mon-yyyy'), 18,  5,119.95,0.10,25595);


/* CUSTOMER rows					*/
INSERT INTO CUSTOMER VALUES(10010,'Ramas'   ,'Alfred','A' ,'615','844-2573',0);
INSERT INTO CUSTOMER VALUES(10011,'Dunne'   ,'Leona' ,'K' ,'713','894-1238',0);
INSERT INTO CUSTOMER VALUES(10012,'Smith'   ,'Kathy' ,'W' ,'615','894-2285',345.86);
INSERT INTO CUSTOMER VALUES(10013,'Olowski' ,'Paul'  ,'F' ,'615','894-2180',536.75);
INSERT INTO CUSTOMER VALUES(10014,'Orlando' ,'Myron' ,NULL,'615','222-1672',0);
INSERT INTO CUSTOMER VALUES(10015,'O''Brian','Amy'   ,'B' ,'713','442-3381',0);
INSERT INTO CUSTOMER VALUES(10016,'Brown'   ,'James' ,'G' ,'615','297-1228',221.19);
INSERT INTO CUSTOMER VALUES(10017,'Williams','George',NULL,'615','290-2556',768.93);
INSERT INTO CUSTOMER VALUES(10018,'Farriss' ,'Anne'  ,'G' ,'713','382-7185',216.55);
INSERT INTO CUSTOMER VALUES(10019,'Smith'   ,'Olette','K' ,'615','297-3809',0);

/* INVOICE rows						*/
INSERT INTO INVOICE VALUES(1001,10014,to_date('16-JAN-2018', 'dd-mon-yyyy'));
INSERT INTO INVOICE VALUES(1002,10011,to_date('16-JAN-2018', 'dd-mon-yyyy'));
INSERT INTO INVOICE VALUES(1003,10012,to_date('16-JAN-2018', 'dd-mon-yyyy'));
INSERT INTO INVOICE VALUES(1004,10011,to_date('17-JAN-2018', 'dd-mon-yyyy'));
INSERT INTO INVOICE VALUES(1005,10018,to_date('17-JAN-2018', 'dd-mon-yyyy'));
INSERT INTO INVOICE VALUES(1006,10014,to_date('17-JAN-2018', 'dd-mon-yyyy'));
INSERT INTO INVOICE VALUES(1007,10015,to_date('17-JAN-2018', 'dd-mon-yyyy'));
INSERT INTO INVOICE VALUES(1008,10011,to_date('17-JAN-2018', 'dd-mon-yyyy'));

/* LINE rows						*/
INSERT INTO LINE VALUES(1001,1,'13-Q2/P2',1,14.99);
INSERT INTO LINE VALUES(1001,2,'23109-HB',1,9.95);
INSERT INTO LINE VALUES(1002,1,'54778-2T',2,4.99);
INSERT INTO LINE VALUES(1003,1,'2238/QPD',1,38.95);
INSERT INTO LINE VALUES(1003,2,'1546-QQ2',1,39.95);
INSERT INTO LINE VALUES(1003,3,'13-Q2/P2',5,14.99);
INSERT INTO LINE VALUES(1004,1,'54778-2T',3,4.99);
INSERT INTO LINE VALUES(1004,2,'23109-HB',2,9.95);
INSERT INTO LINE VALUES(1005,1,'PVC23DRT',12,5.87);
INSERT INTO LINE VALUES(1006,1,'SM-18277',3,6.99);
INSERT INTO LINE VALUES(1006,2,'2232/QTY',1,109.92);
INSERT INTO LINE VALUES(1006,3,'23109-HB',1,9.95);
INSERT INTO LINE VALUES(1006,4,'89-WRE-Q',1,256.99);
INSERT INTO LINE VALUES(1007,1,'13-Q2/P2',2,14.99);
INSERT INTO LINE VALUES(1007,2,'54778-2T',1,4.99);
INSERT INTO LINE VALUES(1008,1,'PVC23DRT',5,5.87);
INSERT INTO LINE VALUES(1008,2,'WR3/TT3',3,119.95);
INSERT INTO LINE VALUES(1008,3,'23109-HB',1,9.95);

/* EMP rows						*/
INSERT INTO EMP2 VALUES(100,'Mr.' ,'Kolmycz'   ,'George' ,'D' ,to_date('15-JUN-1942','dd-mon-yyyy'),to_date('15-MAR-1985','dd-mon-yyyy'),'615','324-5456',NULL);
INSERT INTO EMP2 VALUES(101,'Ms.' ,'Lewis'     ,'Rhonda' ,'G' ,to_date('19-MAR-1965','dd-mon-yyyy'),to_date('25-APR-1986','dd-mon-yyyy'),'615','324-4472',100);
INSERT INTO EMP2 VALUES(102,'Mr.' ,'Vandam'    ,'Rhett'  ,NULL,to_date('14-NOV-1958','dd-mon-yyyy'),to_date('20-DEC-1990','dd-mon-yyyy'),'901','675-8993',100);
INSERT INTO EMP2 VALUES(103,'Ms.' ,'Jones'     ,'Anne'   ,'M' ,to_date('16-OCT-1974','dd-mon-yyyy'),to_date('28-AUG-1994','dd-mon-yyyy'),'615','898-3456',100);
INSERT INTO EMP2 VALUES(105,'Mr.' ,'Williams'  ,'Robert' ,'D' ,to_date('14-MAR-1975','dd-mon-yyyy'),to_date('08-NOV-1998','dd-mon-yyyy'),'615','890-3220',NULL);
INSERT INTO EMP2 VALUES(104,'Mr.' ,'Lange'     ,'John'   ,'P' ,to_date('08-NOV-1971','dd-mon-yyyy'),to_date('20-OCT-1994','dd-mon-yyyy'),'901','504-4430',105);
INSERT INTO EMP2 VALUES(106,'Mrs.','Smith'     ,'Jeanine','K' ,to_date('12-FEB-1968','dd-mon-yyyy'),to_date('05-JAN-1989','dd-mon-yyyy'),'615','324-7883',105);
INSERT INTO EMP2 VALUES(107,'Mr.' ,'Diante'    ,'Jorge'  ,'D' ,to_date('21-AUG-1974','dd-mon-yyyy'),to_date('02-JUL-1994','dd-mon-yyyy'),'615','890-4567',105);
INSERT INTO EMP2 VALUES(108,'Mr.' ,'Wiesenbach','Paul'   ,'R' ,to_date('14-FEB-1966','dd-mon-yyyy'),to_date('18-NOV-1992','dd-mon-yyyy'),'615','897-4358',NULL);
INSERT INTO EMP2 VALUES(109,'Mr.' ,'Smith'     ,'George' ,'K' ,to_date('18-JUN-1961','dd-mon-yyyy'),to_date('14-APR-1989','dd-mon-yyyy'),'901','504-3339',108);
INSERT INTO EMP2 VALUES(110,'Mrs.','Genkazi'   ,'Leighla','W' ,to_date('19-MAY-1970','dd-mon-yyyy'),to_date('01-DEC-1990','dd-mon-yyyy'),'901','569-0093',108);
INSERT INTO EMP2 VALUES(111,'Mr.' ,'Washington','Rupert' ,'E' ,to_date('03-JAN-1966','dd-mon-yyyy'),to_date('21-JUN-1993','dd-mon-yyyy'),'615','890-4925',105);
INSERT INTO EMP2 VALUES(112,'Mr.' ,'Johnson'   ,'Edward' ,'E' ,to_date('14-MAY-1961','dd-mon-yyyy'),to_date('01-DEC-1983','dd-mon-yyyy'),'615','898-4387',100);
INSERT INTO EMP2 VALUES(113,'Ms.' ,'Smythe'    ,'Melanie','P' ,to_date('15-SEP-1970','dd-mon-yyyy'),to_date('11-MAY-1999','dd-mon-yyyy'),'615','324-9006',105);
INSERT INTO EMP2 VALUES(114,'Ms.' ,'Brandon'   ,'Marie'  ,'G' ,to_date('02-NOV-1956','dd-mon-yyyy'),to_date('15-NOV-1979','dd-mon-yyyy'),'901','882-0845',108);
INSERT INTO EMP2 VALUES(115,'Mrs.','Saranda'   ,'Hermine','R' ,to_date('25-JUL-1972','dd-mon-yyyy'),to_date('23-APR-1993','dd-mon-yyyy'),'615','324-5505',105);
INSERT INTO EMP2 VALUES(116,'Mr.' ,'Smith'     ,'George' ,'A' ,to_date('08-NOV-1965','dd-mon-yyyy'),to_date('10-DEC-1988','dd-mon-yyyy'),'615','890-2984',108);

/* EMPLOYEE rows					*/
INSERT INTO EMPLOYEE VALUES(100,'Mr.' ,'Kolmycz'   ,'George' ,'D' ,to_date('15-JUN-1942','dd-mon-yyyy'),to_date('15-MAR-1985','dd-mon-yyyy'),24,'615','324-5456');
INSERT INTO EMPLOYEE VALUES(101,'Ms.' ,'Lewis'     ,'Rhonda' ,'G' ,to_date('19-MAR-1965','dd-mon-yyyy'),to_date('25-APR-1986','dd-mon-yyyy'),22,'615','324-4472');
INSERT INTO EMPLOYEE VALUES(102,'Mr.' ,'Vandam'    ,'Rhett'  ,NULL,to_date('14-NOV-1958','dd-mon-yyyy'),to_date('20-DEC-1990','dd-mon-yyyy'),18,'901','675-8993');
INSERT INTO EMPLOYEE VALUES(103,'Ms.' ,'Jones'     ,'Anne'   ,'M', to_date('16-OCT-1974','dd-mon-yyyy'),to_date('28-AUG-1994','dd-mon-yyyy'), 14,'615','898-3456');
INSERT INTO EMPLOYEE VALUES(104,'Mr.' ,'Lange'     ,'John'   ,'P' ,to_date('08-NOV-1971','dd-mon-yyyy'),to_date('20-OCT-1994','dd-mon-yyyy'), 14,'901','504-4430');
INSERT INTO EMPLOYEE VALUES(105,'Mr.' ,'Williams'  ,'Robert' ,'D' ,to_date('14-MAR-1975','dd-mon-yyyy'),to_date('08-NOV-1998','dd-mon-yyyy'), 10,'615','890-3220');
INSERT INTO EMPLOYEE VALUES(106,'Mrs.','Smith'     ,'Jeanine','K' ,to_date('12-FEB-1968','dd-mon-yyyy'),to_date('05-JAN-1989','dd-mon-yyyy'),20,'615','324-7883');
INSERT INTO EMPLOYEE VALUES(107,'Mr.' ,'Diante'    ,'Jorge'  ,'D' ,to_date('21-AUG-1974','dd-mon-yyyy'),to_date('02-JUL-1994','dd-mon-yyyy'), 14,'615','890-4567');
INSERT INTO EMPLOYEE VALUES(108,'Mr.' ,'Wiesenbach','Paul'   ,'R' ,to_date('14-FEB-1966','dd-mon-yyyy'),to_date('18-NOV-1992','dd-mon-yyyy'),16,'615','897-4358');
INSERT INTO EMPLOYEE VALUES(109,'Mr.' ,'Smith'     ,'George' ,'K' ,to_date('18-JUN-1961','dd-mon-yyyy'),to_date('14-APR-1989','dd-mon-yyyy'),19,'901','504-3339');
INSERT INTO EMPLOYEE VALUES(110,'Mrs.','Genkazi'   ,'Leighla','W' ,to_date('19-MAY-1970','dd-mon-yyyy'),to_date('01-DEC-1990','dd-mon-yyyy'),18,'901','569-0093');
INSERT INTO EMPLOYEE VALUES(111,'Mr.' ,'Washington','Rupert' ,'E' ,to_date('03-JAN-1966','dd-mon-yyyy'),to_date('21-JUN-1993','dd-mon-yyyy'), 15,'615','890-4925');
INSERT INTO EMPLOYEE VALUES(112,'Mr.' ,'Johnson'   ,'Edward' ,'E' ,to_date('14-MAY-1961','dd-mon-yyyy'),to_date('01-DEC-1983','dd-mon-yyyy'),25,'615','898-4387');
INSERT INTO EMPLOYEE VALUES(113,'Ms.' ,'Smythe'    ,'Melanie','P' ,to_date('15-SEP-1970','dd-mon-yyyy'),to_date('11-MAY-1999','dd-mon-yyyy'), 9,'615','324-9006');
INSERT INTO EMPLOYEE VALUES(114,'Ms.' ,'Brandon'   ,'Marie'  ,'G' ,to_date('02-NOV-1956','dd-mon-yyyy'),to_date('15-NOV-1979','dd-mon-yyyy'),29,'901','882-0845');
INSERT INTO EMPLOYEE VALUES(115,'Mrs.','Saranda'   ,'Hermine','R' ,to_date('25-JUL-1972','dd-mon-yyyy'),to_date('23-APR-1993','dd-mon-yyyy'), 15,'615','324-5505');
INSERT INTO EMPLOYEE VALUES(116,'Mr.' ,'Smith'     ,'George' ,'A' ,to_date('08-NOV-1965','dd-mon-yyyy'),to_date('10-DEC-1988','dd-mon-yyyy'),20,'615','890-2984');

COMMIT;

