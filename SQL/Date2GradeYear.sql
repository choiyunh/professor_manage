CREATE OR REPLACE FUNCTION DATE2GRADEYEAR
-- 【5-⑨】
(dDate IN DATE)
RETURN NUMBER
IS
    nYear NUMBER;
    sMonth CHAR(2);
BEGIN
/* 3월~8월: 1학기, 9~2월: 2학기*/
    SELECT TO_NUMBER(TO_CHAR(dDate, 'YYYY')), TO_CHAR(dDate, 'MM')
    INTO nYear, sMonth
    FROM DUAL;
    IF (sMonth ='01' or sMonth='02')  THEN
        nYear := nYear - 1;
    END IF; 
    RETURN nYear;

END;
/