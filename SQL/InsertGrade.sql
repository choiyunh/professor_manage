CREATE OR REPLACE PROCEDURE INSERTGRADE
 -- 【5-⑫】
 (sScore IN VARCHAR2,
 sSid IN VARCHAR2,
 sCid IN VARCHAR2,
 nCidno IN NUMBER,
 nYear NUMBER,
 nSemester NUMBER,
 result OUT VARCHAR2)
IS
 not_current EXCEPTION;
 is_vacation EXCEPTION;
 cur_year NUMBER;
 cur_month CHAR(2);
 cur_semester NUMBER;
 nScore NUMBER;
 sGrade VARCHAR(5);

BEGIN
 result:= '';

-- 현재 년/학기를 가져온다.
 cur_year := Date2GradeYear(SYSDATE);
 cur_semester := Date2GradeSemester(SYSDATE); 
 
 -- sScore가 숫자로만 되어있으면 TO_NUMBER를 사용하여 NUMBER형 nSCore에 저장한다.
 -- 추후 점수의 범위(0~100)를 체크하기 위해 nScore사용한다.
 IF(not(regexp_like(sScore, '[^[:digit:]]'))) THEN
    nScore := TO_NUMBER(sScore);
 END IF;

-- 현재 월을 가져온다.
-- 추후 학기 중인지 방학 중인지 체크하기 위해 사용한다.
 SELECT TO_CHAR(SYSDATE, 'MM')
 INTO cur_month
 FROM DUAL;

-- cur_month := '07'; 방학 기간 예외 처리 테스트용 코드

-- 방학 기간 예외 처리
 IF(cur_month='07' or cur_month='08' or cur_month='01' or cur_month='02') THEN
   RAISE is_vacation;
 END IF;

-- 현재 년도/학기 예외 처리
 IF (cur_year != nYear) THEN
  RAISE not_current;
 END IF;
 IF (cur_semester != nSemester) THEN
  RAISE not_current;
 END IF;

-- 공백, 문자 포함 여부, 점수 범위, NULL 체크
-- 위 네 조건을 모두 만족하면 점수를 UPDATE
 IF(regexp_like(sScore, ' ')) THEN
  result := '등록 불가 (사유 : 점수에는 공백을 입력할 수 없습니다.)'; 
 ELSIF(regexp_like(sScore, '[^[:digit:]]')) THEN
  result := '등록 불가 (사유 : 숫자 외에 다른 문자를 입력할 수 없습니다.)';
 ELSIF(not(nScore >= 0 and nScore <= 100)) THEN
  result := '등록 불가 (사유 : 점수는 0~100사이의 값만 입력 가능합니다.)';
 ELSIF(sScore is null) THEN
  result := '등록 불가 (사유 : 점수를 입력하지 않았습니다.)'; 
 ELSE
  UPDATE ENROLL 
  SET e_score = sScore
  WHERE s_id = sSid and 
  c_id = sCid and 
  c_id_no = nCidno and
  e_year = nYear and
  e_semester = nSemester;
  result := '등록 완료';
 END IF;

-- ChangeGrade 함수를 사용하여 성적 처리
 sGrade := ChangeGrade(nScore);
 UPDATE ENROLL
 SET e_grade = sGrade
 WHERE s_id = sSid and 
 c_id = sCid and 
 c_id_no = nCidno and
 e_year = nYear and
 e_semester = nSemester;

EXCEPTION
 WHEN not_current THEN
  RAISE_APPLICATION_ERROR(-20002, '등록 불가(사유 : 현재 학기 성적만 입력 가능합니다.)');
 WHEN is_vacation THEN
  RAISE_APPLICATION_ERROR(-20003, '등록 불가(사유 : 학기 중에만 성적 입력 가능합니다.)');
END;
/