DROP TABLE PDS
CASCADE CONSTRAINTS;

DROP SEQUENCE SEQ_PDS;


-- SEQ를 외래키로 사용하지 않는 경우 기본키로 설정할 필요

CREATE TABLE PDS(

	SEQ NUMBER(8) PRIMARY KEY,
	ID VARCHAR2(50) NOT NULL,
	TITLE VARCHAR2(200) NOT NULL,
	CONTENT VARCHAR2(4000) NOT NULL,
	FILENAME VARCHAR2(50) NOT NULL,
	READCOUNT NUMBER(8) NOT NULL,
	DOWNCOUNT NUMBER(8) NOT NULL,
	REGDATE DATE NOT NULL
)

CREATE SEQUENCE SEQ_PDS
START WITH 1
INCREMENT BY 1;

ALTER TABLE PDS
ADD CONSTRAINT FK_PDS_ID FOREIGN KEY(ID)
REFERENCES MEMBER(ID)

SELECT * FROM PDS;



