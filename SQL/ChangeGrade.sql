CREATE OR REPLACE FUNCTION CHANGEGRADE
-- 【5-⑪】
(
    nScore IN NUMBER
)
RETURN VARCHAR2
IS
    result VARCHAR2(5);
BEGIN
    IF(nScore >= 90) THEN
        result := 'A';
    ELSIF(nScore>=80) THEN
        result := 'B';
    ELSIF(nScore>=70) THEN
        result := 'C';
    ELSIF(nScore>=60) THEN
        result := 'D';
    ELSE
        result := 'F';
    END IF;
    
    RETURN result;
END;
/
