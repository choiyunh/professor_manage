CREATE OR REPLACE PROCEDURE DELETETEACH
-- 【2-⑩】
( 
    sPid IN VARCHAR2,
    sCid IN VARCHAR2,
    sCidno IN NUMBER,
    result OUT VARCHAR2
)
IS
    nYear NUMBER;
    nSemester NUMBER;
    nTmax NUMBER;
    nCounter NUMBER;
    too_many_people EXCEPTION;
BEGIN 
    result := '';

    -- 현재 년/학기를 가져온다.
    nYear := Date2EnrollYear(SYSDATE);
    nSemester := Date2EnrollSemester(SYSDATE);
    
    -- 수강 정원 가져오기
    SELECT t_max
    INTO nTmax
    FROM teach
    WHERE t_year = nYear and t_semester = nSemester and c_id = sCid and c_id_no= sCidno;
    
    -- 수강 신청 인원 가져오기
    SELECT COUNT(*)
    INTO nCounter
    FROM enroll
    WHERE e_year = nYear and e_semester = nSemester and c_id = sCid and c_id_no = sCidno;

    -- 수강 신청 인원이 수강 정원의 50% 이상이면 취소할 수 없음
    IF(nCounter >= (nTmax * 0.5)) THEN
        RAISE too_many_people;
    ELSE
        DELETE 
        FROM teach 
        WHERE p_id = sPid and c_id = sCid and c_id_no = sCidno;
        result:='해당 과목 개설 신청이 취소되었습니다.';
    END IF;    

EXCEPTION 
    WHEN  too_many_people THEN
    result:=' 해당 과목의 수강 인원이 정원의 50%보다 많아 개설 신청을 취소할 수 없습니다.';    
END;
/