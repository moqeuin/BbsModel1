package dto;

import java.io.Serializable;

public class PdsDto implements Serializable {
/*	
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
*/

	
	private int seq;
	private String id;
	private String title;
	private String content;
	
	
	private String filename; // 경로를 포함한 파일명, 시스템시간으로 파일 이름을 받을 때는 original name을 따로 저장해서 바꿔줘야한다.(name 2개 필요)
	private int readcount;
	private int downcount;
	
	private String regdate; // 등록일
	
	
	public PdsDto() {
	
	}


	public PdsDto(int seq, String id, String title, String content, String filename, int readcount, int downcount,
			String regdate) {
		super();
		this.seq = seq;
		this.id = id;
		this.title = title;
		this.content = content;
		this.filename = filename;
		this.readcount = readcount;
		this.downcount = downcount;
		this.regdate = regdate;
	}


	public PdsDto(String id, String title, String content, String filename) {
		super();
		this.id = id;
		this.title = title;
		this.content = content;
		this.filename = filename;
	}


	public int getSeq() {
		return seq;
	}


	public void setSeq(int seq) {
		this.seq = seq;
	}


	public String getId() {
		return id;
	}


	public void setId(String id) {
		this.id = id;
	}


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}


	public String getContent() {
		return content;
	}


	public void setContent(String content) {
		this.content = content;
	}


	public String getFilename() {
		return filename;
	}


	public void setFilename(String filename) {
		this.filename = filename;
	}


	public int getReadcount() {
		return readcount;
	}


	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}


	public int getDowncount() {
		return downcount;
	}


	public void setDowncount(int downcount) {
		this.downcount = downcount;
	}


	public String getRegdate() {
		return regdate;
	}


	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}


	@Override
	public String toString() {
		return "PdsDto [seq=" + seq + ", id=" + id + ", title=" + title + ", content=" + content + ", filename="
				+ filename + ", readcount=" + readcount + ", downcount=" + downcount + ", regdate=" + regdate + "]";
	}
	
	
	
}
