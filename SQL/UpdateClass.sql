CREATE OR REPLACE PROCEDURE UPDATECLASS
-- 【3-③】
(
    sCid IN VARCHAR2,
    nCid IN NUMBER,
    sTwhere IN VARCHAR2,
    sTtime IN NUMBER,
    result OUT VARCHAR2
)
IS
    cur_twhere VARCHAR2(50);
    cur_ttime VARCHAR(1);
    nYear NUMBER;
    nSemester NUMBER;
    overlap_name VARCHAR2(50);
BEGIN 
    result := '';
    overlap_name := null;

    -- 현재 년/학기를 가져온다.
    nYear := Date2EnrollYear(SYSDATE);
    nSemester := Date2EnrollSemester(SYSDATE);

    -- 기존에 저장된 강의실과 시간을 가져온다.
    SELECT t.t_time, t.t_where
    INTO cur_ttime, cur_twhere
    FROM teach t
    WHERE t.c_id = sCid and t.c_id_no = nCid and t.t_year = nYear and t.t_semester = nSemester;

    -- 강의실과 시간이 중복되는지 체크
    SELECT c.c_name
    INTO overlap_name
    FROM teach t 
    JOIN course c 
    ON (c.c_id = t.c_id and c.c_id_no = t.c_id_no)
    WHERE t.t_where = sTwhere and t.t_time = sTtime and t.t_year = nYear and t.t_semester = nSemester;    

    IF(cur_twhere = sTwhere and cur_ttime = sTtime) THEN
        result := '변경된 내용이 없습니다';
    ELSIF(overlap_name is not null) THEN
        result := overlap_name || '과목과 중복되어 처리할 수 없습니다.';        
    END IF; 

EXCEPTION
    -- 강의실과 시간이 중복되는 값을 찾지 못했을 때
    WHEN no_data_found THEN
        UPDATE teach t
        SET t.t_where = sTwhere, t.t_time = sTtime
        WHERE t.c_id = sCid and 
        t.c_id_no = nCid 
        and t.t_year = nYear 
        and t.t_semester = nSemester;
        result := '과목정보를 변경하였습니다.';
    WHEN OTHERS THEN
        result := SQLERRM;   
END;
/

