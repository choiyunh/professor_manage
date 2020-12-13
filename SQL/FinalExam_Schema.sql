/* 실습 테이블 */
/*
학생(student) : 학번, 이름, 주소,학년,학부, 전공, 패스워드
과목(course) : 과목번호, 분반, 과목명, 학점
교수(professor) : 교수번호, 교수이름, 전공, 학과, 패스워드
등록(enroll) : 학번, 과목번호, 분반, 등록시기, 등록학기, 성적
강의(teach) : 교수번호, 과목번호, 분반, 강의시기, 교시, 장소, 수강최대인원
*/

DROP TABLE student CASCADE CONSTRAINTS;  
DROP TABLE course CASCADE CONSTRAINTS;  
DROP TABLE professor CASCADE CONSTRAINTS;  
DROP TABLE enroll CASCADE CONSTRAINTS;  
DROP TABLE teach CASCADE CONSTRAINTS;  

CREATE TABLE student
(
    s_id	    VARCHAR2(10),
    s_name  VARCHAR2(50)   not null,
    s_addr    VARCHAR2(200),
    s_year     NUMBER(1)   not null,
    s_college    VARCHAR2(50)   not null,
    s_major   VARCHAR2(50)   not null,
    s_pwd       VARCHAR2(10)   not null,
    CONSTRAINT s_pk PRIMARY KEY (s_id)
);


INSERT INTO student (s_id, s_name, s_addr, s_year, s_college, s_major, s_pwd) VALUES
('20011234', '신경화','경기도 화성군 송산면 고정1리 540-2', 4, 'IT학부', '컴퓨터공학','1234');
INSERT INTO student (s_id, s_name, s_addr, s_year, s_college, s_major, s_pwd) VALUES
('20011235', '서용만','경기도 용인시 기흥읍 농서리 산24', 4, 'IT학부', '컴퓨터공학','1235');
INSERT INTO student (s_id, s_name, s_addr, s_year, s_college, s_major, s_pwd) VALUES
('20011236', '정주영','경기도 성남시 분당구 구미동 79번지 까치마을', 4, 'IT학부', '컴퓨터공학','1236');
INSERT INTO student (s_id, s_name, s_addr, s_year, s_college, s_major, s_pwd) VALUES
('20011237', '고정환','경기도 수원시 팔달구 매탄3동 416번지', 4, 'IT학부', '컴퓨터공학','1237');
INSERT INTO student (s_id, s_name, s_addr, s_year, s_college, s_major, s_pwd) VALUES
('20021245', '전용호','경북 안동시 용상동 1234-5번지', 3, 'IT학부', '컴퓨터공학','3123');
INSERT INTO student (s_id, s_name, s_addr, s_year, s_college, s_major, s_pwd) VALUES
('20021246', '한신동','서울 종로구 수송동 81', 3, 'IT학부', '컴퓨터공학','3124');
INSERT INTO student (s_id, s_name, s_addr, s_year, s_college, s_major, s_pwd) VALUES
('20021247', '노호현','서울 동작구 사당3동 183-2', 3, 'IT학부', '컴퓨터공학','3125');
INSERT INTO student (s_id, s_name, s_addr, s_year, s_college, s_major, s_pwd) VALUES
('20023451', '김영철','서울 동대문구 회기동 101-6', 3, 'IT학부', '멀티미디어공학','3451');
INSERT INTO student (s_id, s_name, s_addr, s_year, s_college, s_major, s_pwd) VALUES
('20012454', '정태웅','서울 송파구 가락동 80-3', 4, 'IT학부', '멀티미디어공학','3454');
INSERT INTO student (s_id, s_name, s_addr, s_year, s_college, s_major, s_pwd) VALUES
('20012456', '정진영','인천시 부평구 갈산2동 400-5', 4, 'IT학부', '멀티미디어공학','3456');

CREATE TABLE course
(
    c_id   	VARCHAR2(10),
    c_id_no  NUMBER(1),
    c_name  VARCHAR2(50),
    c_unit     NUMBER(1),
    CONSTRAINT c_pk PRIMARY KEY (c_id, c_id_no)
);

INSERT INTO course VALUES ('C100', 1, '컴퓨터 프로그래밍', 3) ;
INSERT INTO course VALUES ('C200', 1, '자료구조', 3) ;
INSERT INTO course VALUES ('C300', 1, '알고리즘', 3) ;
INSERT INTO course VALUES ('C400', 1, '데이터베이스 시스템', 3) ;
INSERT INTO course VALUES ('C500', 1, '운영체제', 3) ;
INSERT INTO course VALUES ('C600', 1, '소프트웨어 공학', 3) ;
INSERT INTO course VALUES ('C700', 1, '네트워크', 3) ;
INSERT INTO course VALUES ('C800', 1, '데이터베이스 프로그래밍', 3) ;
INSERT INTO course VALUES ('C900', 1, '객체지향 윈도우즈 프로그래밍', 3) ;
INSERT INTO course VALUES ('M100', 1, '멀티미디어 개론', 3) ;
INSERT INTO course VALUES ('M200', 1, '선형대수', 3) ;
INSERT INTO course VALUES ('M300', 1, '그래픽 활용', 3) ;
INSERT INTO course VALUES ('M400', 1, '윈도우즈 프로그래밍', 3) ;
INSERT INTO course VALUES ('M500', 1, '컴퓨터 그래픽스', 3) ;
INSERT INTO course VALUES ('M600', 1, '멀티미디어 처리', 3) ;
INSERT INTO course VALUES ('M700', 1, '게임 프로그래밍', 3) ;
INSERT INTO course VALUES ('C100', 2, '컴퓨터 프로그래밍', 3) ;
INSERT INTO course VALUES ('C400', 2, '데이터베이스 시스템', 3) ;
INSERT INTO course VALUES ('C700', 2, '네트워크', 3) ;
INSERT INTO course VALUES ('C900', 2, '객체지향 윈도우즈 프로그래밍', 3) ;
INSERT INTO course VALUES ('M100', 2, '멀티미디어 개론', 3) ;
INSERT INTO course VALUES ('M400', 2, '윈도우즈 프로그래밍', 3) ;
INSERT INTO course VALUES ('M700', 2, '게임 프로그래밍', 3) ;



CREATE TABLE professor
(
    p_id	       VARCHAR2(10),
    p_name      VARCHAR2(50)   not null,
    p_college    VARCHAR2(50)   not null,
    p_major      VARCHAR2(50)   not null,
    p_pwd         VARCHAR2(10)   not null,
    CONSTRAINT p_pk PRIMARY KEY (p_id)
);

INSERT INTO professor VALUES ('CS4580', '박구곤', 'IT학부', '컴퓨터공학','4580');
INSERT INTO professor VALUES ('CS4581', '홍길동', 'IT학부', '컴퓨터공학','4581');
INSERT INTO professor VALUES ('CS4582', '이은선', 'IT학부', '컴퓨터공학','4582');
INSERT INTO professor VALUES ('CS4583', '서의홍', 'IT학부', '컴퓨터공학','4583');
INSERT INTO professor VALUES ('CS4584', '김심선', 'IT학부', '컴퓨터공학','4584');
INSERT INTO professor VALUES ('CS4585', '전지영', 'IT학부', '컴퓨터공학','4585');
INSERT INTO professor VALUES ('MM4570', '김정미', 'IT학부', '멀티미디어공학','4570');
INSERT INTO professor VALUES ('MM4571', '신기웅', 'IT학부', '멀티미디어공학','4571');
INSERT INTO professor VALUES ('MM4572', '이상헌', 'IT학부', '멀티미디어공학','4572');


CREATE TABLE enroll
(
    s_id	     VARCHAR2(10),
    c_id	     VARCHAR2(10),
    c_id_no    NUMBER(1),
    e_year      NUMBER(4),
    e_semester    NUMBER(1),
    e_score    NUMBER(3),
    CONSTRAINT e_pk PRIMARY KEY (s_id, c_id, c_id_no),
    CONSTRAINT e_c_id_fk FOREIGN KEY (c_id, c_id_no) REFERENCES  course (c_id, c_id_no)
);

INSERT INTO enroll VALUES ( '20011234', 'C100', 1, 2021, 1, 60);
INSERT INTO enroll VALUES ( '20011234', 'C200', 1, 2021, 1, 57);
INSERT INTO enroll VALUES ( '20011234', 'C300', 1, 2021, 1, null);
INSERT INTO enroll VALUES ( '20011234', 'C400', 1, 2021, 1, 85);
INSERT INTO enroll VALUES ( '20011234', 'C500', 1, 2021, 1, null);
INSERT INTO enroll VALUES ( '20011234', 'C600', 1, 2020, 2, null);
INSERT INTO enroll VALUES ( '20011234', 'C700', 1, 2020, 2, null);
INSERT INTO enroll VALUES ( '20011235', 'C100', 1, 2020, 2, 76);
INSERT INTO enroll VALUES ( '20011235', 'C200', 1, 2021, 1, 78);
INSERT INTO enroll VALUES ( '20011235', 'C300', 1, 2020, 2, null);
INSERT INTO enroll VALUES ( '20011235', 'C400', 1, 2020, 2, null);
INSERT INTO enroll VALUES ( '20011235', 'C500', 1, 2020, 2, null);
INSERT INTO enroll VALUES ( '20011235', 'C600', 1, 2020, 2, null);
INSERT INTO enroll VALUES ( '20011235', 'C700', 1, 2020, 2, null);
INSERT INTO enroll VALUES ( '20011235', 'C900', 1, 2021, 1, null);
INSERT INTO enroll VALUES ( '20011236', 'C100', 1, 2020, 2, 67);
INSERT INTO enroll VALUES ( '20011236', 'C200', 1, 2021, 1, 95);
INSERT INTO enroll VALUES ( '20011236', 'C300', 1, 2020, 2, null);
INSERT INTO enroll VALUES ( '20011236', 'C400', 1, 2021, 1, 95);
INSERT INTO enroll VALUES ( '20011236', 'C500', 1, 2020, 2, null);
INSERT INTO enroll VALUES ( '20011236', 'C600', 1, 2020, 2, null);
INSERT INTO enroll VALUES ( '20011236', 'C700', 1, 2020, 2, null);
INSERT INTO enroll VALUES ( '20011236', 'C900', 1, 2021, 1, null);
INSERT INTO enroll VALUES ( '20011237', 'C100', 1, 2020, 2, 45);
INSERT INTO enroll VALUES ( '20011237', 'C200', 1, 2021, 1, 68);
INSERT INTO enroll VALUES ( '20011237', 'C300', 1, 2020, 2, null);
INSERT INTO enroll VALUES ( '20011237', 'C400', 1, 2021, 1, 88);
INSERT INTO enroll VALUES ( '20011237', 'C500', 1, 2020, 2, null);
INSERT INTO enroll VALUES ( '20011237', 'C600', 1, 2020, 2, null);
INSERT INTO enroll VALUES ( '20011237', 'C700', 1, 2020, 2, null);
INSERT INTO enroll VALUES ( '20011237', 'C900', 1, 2021, 1, null);
INSERT INTO enroll VALUES ( '20021245', 'C100', 1, 2020, 2, 75);
INSERT INTO enroll VALUES ( '20021245', 'C200', 1, 2020, 2, null);
INSERT INTO enroll VALUES ( '20011245', 'C900', 1, 2021, 1, null);
INSERT INTO enroll VALUES ( '20021246', 'C100', 1, 2020, 2, 91);
INSERT INTO enroll VALUES ( '20021246', 'C200', 1, 2020, 2, null);
INSERT INTO enroll VALUES ( '20011246', 'C900', 1, 2021, 1, null);
INSERT INTO enroll VALUES ( '20021247', 'C100', 1, 2020, 2, 87);
INSERT INTO enroll VALUES ( '20021247', 'C200', 1, 2020, 2, null);
INSERT INTO enroll VALUES ( '20012454', 'C100', 1, 2020, 2, 67);
INSERT INTO enroll VALUES ( '20012454', 'M100', 1, 2020, 2, 57);
INSERT INTO enroll VALUES ( '20012454', 'M200', 1, 2021, 1, 71);
INSERT INTO enroll VALUES ( '20012454', 'M300', 1, 2021, 1, 83);
INSERT INTO enroll VALUES ( '20012454', 'M400', 1, 2021, 1, 89);
INSERT INTO enroll VALUES ( '20012454', 'M500', 1, 2020, 2, null);
INSERT INTO enroll VALUES ( '20012456', 'C100', 1, 2020, 2, 96);
INSERT INTO enroll VALUES ( '20012456', 'C200', 1, 2021, 1, 87);
INSERT INTO enroll VALUES ( '20012456', 'M100', 1, 2020, 2, 63);
INSERT INTO enroll VALUES ( '20012456', 'M200', 1, 2021, 1, 68);
INSERT INTO enroll VALUES ( '20012456', 'M300', 1, 2021, 1, 98);
INSERT INTO enroll VALUES ( '20012456', 'M400', 1, 2021, 1, 85);
INSERT INTO enroll VALUES ( '20012456', 'M500', 1, 2020, 2, null);

CREATE TABLE teach
(
    p_id	   VARCHAR2(10),
    c_id	   VARCHAR2(10),
    c_id_no  NUMBER(1),
    t_year    NUMBER(4),
    t_semester    NUMBER(1),
    t_time    NUMBER(1),
    t_where  VARCHAR2(50),
    t_max    NUMBER(2),
    CONSTRAINT t_pk PRIMARY KEY (p_id, c_id, c_id_no,t_year,t_semester ),
    CONSTRAINT t_c_id_fk FOREIGN KEY (c_id, c_id_no) REFERENCES  course (c_id, c_id_no)
 );

INSERT INTO teach VALUES ( 'CS4580', 'C100', 1 , 2021, 1, 4, '인-201', 5);
INSERT INTO teach VALUES ( 'CS4581', 'C200', 1 , 2021, 1, 5, '인-201', 6);
INSERT INTO teach VALUES ( 'CS4581', 'C200', 1 , 2020, 2, 5, '인-201', 5);
INSERT INTO teach VALUES ( 'CS4581', 'C300', 1 , 2021, 1, 2, '인-416', 7);
INSERT INTO teach VALUES ( 'CS4582', 'C400', 1 , 2021, 1, 6, '인-201', 5);
INSERT INTO teach VALUES ( 'CS4582', 'C400', 1 , 2020, 2, 6, '인-201', 7);
INSERT INTO teach VALUES ( 'CS4583', 'C500', 1 , 2021, 1, 3, '인-201', 5);
INSERT INTO teach VALUES ( 'CS4583', 'C700', 1 , 2020, 2, 4, '인-310', 7);
INSERT INTO teach VALUES ( 'CS4584', 'C600', 1 , 2020, 2, 1, '인-309', 6);
INSERT INTO teach VALUES ( 'CS4584', 'C800', 1 , 2021, 1, 7, '인-309', 5);
INSERT INTO teach VALUES ( 'MM4570', 'M100', 1 , 2021, 1, 5, '숭-201', 8);
INSERT INTO teach VALUES ( 'MM4570', 'M400', 1 , 2021, 1, 5, '숭-201', 5);
INSERT INTO teach VALUES ( 'MM4571', 'M200', 1 , 2021, 1, 3, '숭-417', 7);
INSERT INTO teach VALUES ( 'MM4571', 'M200', 1 , 2020, 2, 3, '숭-417', 8);
INSERT INTO teach VALUES ( 'MM4571', 'M500', 1 , 2020, 2, 6, '숭-201', 5);
INSERT INTO teach VALUES ( 'MM4572', 'M300', 1 , 2021, 1, 3, '숭-201', 9);
INSERT INTO teach VALUES ( 'MM4572', 'M300', 1 , 2020, 2, 3, '숭-201', 6);
INSERT INTO teach VALUES ( 'MM4572', 'C900', 1 , 2021, 1, 2, '숭-201', 5);
INSERT INTO teach VALUES ( 'MM4572', 'M700', 1 , 2021, 1, 8, '숭-201', 8);

COMMIT;