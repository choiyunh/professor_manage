CREATE OR REPLACE TRIGGER BEFOREUPDATEPROFESSOR
-- 【1-⑥】
BEFORE UPDATE ON professor
FOR EACH ROW
DECLARE
 same_pwd EXCEPTION;
 invalid_pwd EXCEPTION;
 invalid_research EXCEPTION;
BEGIN
 /* 암호 제약조건 : 문자와 숫자 조합, 기존과 다른 패스워드 */
 /* 연구 분야 제약조건 : 데이터베이스, 네트워크, 운영체제 */
 IF(not(regexp_like(:new.p_pwd, '[^[:digit:]]')) or not(regexp_like(:new.p_pwd, '[^[:alpha:]]'))) THEN
  raise invalid_pwd;
 END IF;    

 IF(not(:new.p_research IN('데이터베이스','운영체제','네트워크'))) THEN
  raise invalid_research;
 END IF;

 IF(:old.p_pwd=:new.p_pwd) THEN
  raise same_pwd;
 END IF;

EXCEPTION
 WHEN same_pwd THEN
  RAISE_APPLICATION_ERROR(-20002, '패스워드는 기존과 동일하게 변경할 수 없습니다.');
 WHEN invalid_pwd THEN
  RAISE_APPLICATION_ERROR(-20003, '패스워드는 문자와 숫자를 조합해야 합니다.');
 WHEN invalid_research THEN
  RAISE_APPLICATION_ERROR(-20004, '연구분야를 다시 입력해주세요.');
END;
/