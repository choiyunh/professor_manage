CREATE OR REPLACE PROCEDURE UPDATETEACH
-- 【4-⑤】
(
    sCid IN VARCHAR2,
    sCidno IN VARCHAR2,
    sTmax IN VARCHAR2,
    result OUT VARCHAR2)
IS
    sCname VARCHAR2(50);
    nYear NUMBER;
    nSemester NUMBER;
    nCounter NUMBER;
BEGIN
    result := '';
    -- 현재 년/학기를 가져온다.
    nYear := Date2EnrollYear(SYSDATE);
    nSemester := Date2EnrollSemester(SYSDATE);

    -- 과목명을 가져온다.
    SELECT c.c_name
    INTO sCname
    FROM teach t
    JOIN course c ON(c.c_id=t.c_id and c.c_id_no=t.c_id_no)
    WHERE t.c_id = sCid and t.c_id_no = sCidno and t.t_year = nYear and t.t_semester = nSemester;

    -- 현재 강의를 신청한 학생 수를 COUNT
    SELECT COUNT(*)
    INTO nCounter
    FROM enroll
    WHERE c_id = sCid and c_id_no = sCidno and e_year = nYear and e_semester = nSemester;

    result := sCname;
    -- 수강정원에 공백(스페이스) 값을 입력할 수 없음 
    IF (regexp_like(sTmax, ' ')) THEN
        result := result || ' : 변경 불가(사유 : 수강정원에는 공백을 입력할 수 없습니다.)';
    -- 수강정원에 숫자 외에 다른 문자를 입력할 수 없음 
    ELSIF (regexp_like(sTmax, '[^[:digit:]]')) THEN
        result := result || ' : 변경 불가(사유 : 숫자 외에 다른문자를 입력할 수 없습니다.)';
    -- 수강정원에 0~100 사이의 값만 입력할 수 있음 
    ELSIF (TO_NUMBER(sTmax) < 0 or TO_NUMBER(sTmax) > 100) THEN
        result := result || ' : 변경 불가(사유 : 수강정원은 0 ~ 100사이의 값만 입력 가능합니다.)';
    -- 수강정원에 NULL 값을 입력할 수 없음
    ELSIF (sTmax is null) THEN
        result := result || ' : 변경 불가(사유 : 수강정원을 입력하지 않았습니다.)';
    -- ⑤ 수강정원은 현재 수강 신청 인원 미만으로 입력할 수 없음
    ELSIF (TO_NUMBER(sTmax) < nCounter) THEN
        result := result || ' : 변경 불가(사유 : 강의를 신청한 학생 수 ' || nCounter || '명 이상의 수를 입력해야 합니다.)';
    -- 위 다섯 조건을 모두 만족하면 UPDATE
    ELSE 
        UPDATE teach
        SET t_max = sTmax
        WHERE teach.c_id = sCid and teach.c_id_no = sCidno and teach.t_year = nYear and teach.t_semester = nSemester;
        result := result || ' : 변경완료';
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        result := SQLERRM;
    
END;
/
