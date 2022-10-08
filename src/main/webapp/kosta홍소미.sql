--jblog 계정생성, 권한설정
create user jblog identified by jblog ;
grant resource, connect to jblog ;

--테이블 삭제
drop table comments;
drop table post;
drop table category;
drop table blog;
drop table users;

--시퀀스 삭제
drop sequence seq_users_no;
drop sequence seq_category_no;
drop sequence seq_post_no;
drop sequence seq_comments_no;

CREATE SEQUENCE seq_users_no
INCREMENT BY 1
START WITH 1 
NOCACHE ;

CREATE SEQUENCE seq_category_no
INCREMENT BY 1
START WITH 1 
NOCACHE ;


CREATE SEQUENCE seq_post_no 
INCREMENT BY 1
START WITH 1 
NOCACHE ;


CREATE SEQUENCE seq_comments_no
INCREMENT BY 1
START WITH 1 
NOCACHE ;

CREATE TABLE users (
  userNo    NUMBER,
  id        VARCHAR2(50)  NOT NULL Unique,
  userName  VARCHAR2(100) NOT NULL,
  password  VARCHAR2(50)  NOT NULL,
  joinDate  DATE          NOT NULL,
  PRIMARY KEY(userNo)
);


CREATE TABLE blog (
  userNo    NUMBER,
  blogTitle VARCHAR2(200)   NOT NULL,
  logoFile  VARCHAR2(200),
  PRIMARY KEY(userNo),
  CONSTRAINT c_blog_fk FOREIGN KEY (userNo)
  REFERENCES users(userNo)
);

CREATE TABLE category (
  cateNo        NUMBER,
  userNo        NUMBER, 
  cateName      VARCHAR2(200)   NOT NULL,
  description   VARCHAR2(500),
  regDate       DATE            NOT NULL,
  PRIMARY KEY(cateNo),
  CONSTRAINT c_category_fk FOREIGN KEY (userNo)
  REFERENCES blog(userNo)
);


CREATE TABLE post (
  postNo        NUMBER,
  cateNo        NUMBER,  
  postTitle     VARCHAR2(300)   NOT NULL,
  postContent   VARCHAR2(4000),
  regDate       DATE            NOT NULL,
  PRIMARY KEY(postNo),
  CONSTRAINT c_post_fk FOREIGN KEY (cateNo)
  REFERENCES category(cateNo)
);


CREATE TABLE comments (
  cmtNo         NUMBER,
  postNo        NUMBER,
  userNo           NUMBER,
  cmtContent    VARCHAR2(300)   NOT NULL,
  regDate       DATE            NOT NULL,
  coName		varchar(25),
  PRIMARY KEY(cmtNo),
  CONSTRAINT c_comments_fk FOREIGN KEY (postNo)
  REFERENCES post(postNo),
  CONSTRAINT c_users_fk FOREIGN KEY (userNo)
  REFERENCES users(userNo)
);


SELECT * FROM users;
SELECT * FROM BLOG b ;
SELECT * FROM CATEGORY c ;
SELECT * FROM POST p ;
SELECT * FROM COMMENTS c ;

INSERT INTO users values(seq_users_no.nextval, 'sun', '해나', '1234' sysdate);
INSERT INTO users values(seq_users_no.nextval, 'hgd', '홍길동', '1234' sysdate);
INSERT INTO users values(seq_users_no.nextval, 'somi', '홍소미', '1234' sysdate);
INSERT INTO users values(seq_users_no.nextval, 'kim', '갑경', '1234' sysdate);
INSERT INTO users values(seq_users_no.nextval, 'cup', '컵', '1234' sysdate);

INSERT INTO blog values(1, '해나의 블로그입니다.', 'spring-logo.jpg');
INSERT INTO blog values(2, '홍길동의 블로그입니다.', 'spring-logo.jpg');
INSERT INTO blog values(3, '홍소미의 블로그입니다.', 'spring-logo.jpg');

INSERT INTO CATEGORY values(seq_category_no.nextVal, 1, '스프링MVC', '스프링 설정과 사용법', sysdate);
INSERT INTO CATEGORY values(seq_category_no.nextVal, 1, '스프링MVC', '스프링 설정과 사용법', sysdate);
INSERT INTO CATEGORY values(seq_category_no.nextVal, 2, '자바', '자바사용법', sysdate);
INSERT INTO CATEGORY values(seq_category_no.nextVal, 2, '스프링MVC', '스프링 설정과 사용법', sysdate);

INSERT INTO post values(seq_post_no.nextVal, 1, '스프링 시작', '스프링이란', sysdate);
INSERT INTO post values(seq_post_no.nextVal, 1, '홍소미', '홍소미란', sysdate);
INSERT INTO post values(seq_post_no.nextVal, 2, '스프링 시작', '스프링이란', sysdate);
INSERT INTO post values(seq_post_no.nextVal, 2, '김해나', '김해나란', sysdate);

INSERT INTO COMMENTS values(seq_comments_no.nextval, 1, 1, '안녕하세요', sysdate ,'김해나');
INSERT INTO COMMENTS values(seq_comments_no.nextval, 1, 1, '반갑습니다', sysdate, '김갑경');
INSERT INTO COMMENTS values(seq_comments_no.nextval, 2, 2, '또만나요', sysdate, '김문진');





						
