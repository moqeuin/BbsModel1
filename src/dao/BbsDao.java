
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.BbsDto;

public class BbsDao {
	private static BbsDao dao = new BbsDao();
	
	private BbsDao() {
	
	}
	
	public static BbsDao getInstance() {
		return dao;
	}
	
	
	// 게시판 데이터 불러오기
	public List<BbsDto> getBbsList(){
		String sql = " SELECT SEQ, ID, REF, STEP, DEPTH, "
				   + " TITLE, CONTENT, WDATE, "
				   + " DEL, READCOUNT "
				   + " FROM BBS "
				   + " ORDER BY REF DESC, STEP ASC ";
	
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<BbsDto> list = new ArrayList<BbsDto>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 login success");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 login success");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 login success");
			
			// 하나의 데이터이면 if
			while(rs.next()) {
				int i = 1;						// 대입 후 증가
				BbsDto dto = new BbsDto(rs.getInt(i++), //seq
										rs.getString(i++), //id
										rs.getInt(i++), //ref
										rs.getInt(i++), //step
										rs.getInt(i++), //depth
										rs.getString(i++), //title
										rs.getString(i++), //content
										rs.getString(i++), //wdate
										rs.getInt(i++), //del
										rs.getInt(i++) //readcount
										);
				list.add(dto);
		
			}
			System.out.println("4/6 login success");
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, rs);
		}
		
		return list;		
	}
	
	
	// 게시판 글쓰기
	public boolean writeBbs(BbsDto dto) {
		
		// 서브쿼리 SELECT를 먼저 실행 하기 때문에 NVL에서 맥스값은 0이 되고 거기에 1을 더하게 되고  
		// 다음에 NEXTVAL가 진행되서 1이 돼서 같게된다. (시퀀스 == 그룹번호)
		// ID는 SESSION에 저장된 데이터를 대입
		String sql = " INSERT INTO BBS "
				   + " (SEQ, ID, REF, STEP, DEPTH, "
				   + " TITLE, CONTENT, WDATE, "
				   + " DEL, READCOUNT) "
				   			// 시퀀스를 진행
				   + " VALUES( SEQ_BBS.NEXTVAL, ?, "
				   			+ "(SELECT NVL(MAX(REF), 0)+1 FROM BBS), 0, 0, "
				   			+ " ?, ?, SYSDATE, "
				   			+ "0, 0) ";
				   			// 지워지면 del은 1
		System.out.print(sql);
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 login success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			System.out.println("2/6 login success");
			
			count = psmt.executeUpdate();
			System.out.println("3/6 login success");
			
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			
			DBClose.close(psmt, conn, null);
			
		}
		
		return count > 0 ? true:false;	
	}
	
	public BbsDto getBbs(int seq) {
		String sql = " SELECT SEQ, ID, REF, STEP, DEPTH ,TITLE, CONTENT, WDATE, DEL, READCOUNT "
				   + " FROM BBS "
				   + " WHERE SEQ = ?";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		BbsDto dto = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 login success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/6 login success");
			rs = psmt.executeQuery();
			System.out.println("3/6 login success");
			
			
			while(rs.next()) {
				int i = 1;
				int _seq = rs.getInt(i++);
				String id = rs.getString(i++);
				
				int ref = rs.getInt(i++);
				int step = rs.getInt(i++);
				int depth = rs.getInt(i++);
				
				String title = rs.getString(i++);
				String content = rs.getString(i++);
				String wdate = rs.getString(i++);
				
				int del = rs.getInt(i++);
				int readcount = rs.getInt(i++);
				
				dto = new BbsDto(_seq, id, ref, step, depth, title, content, wdate, del, readcount);
				
			}
			System.out.println("4/6 login success");
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			
			DBClose.close(psmt, conn, rs);
		}
		return dto;
	}
	
	public void readcount(int seq) {
		String sql = " UPDATE BBS"
				   + " SET READCOUNT = READCOUNT +1 "
				   + " WHERE SEQ = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 login success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/6 login success");
			
			psmt.executeUpdate();
			System.out.println("3/6 login success");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, null);
		}
		
	}
						// seq(부모게시글) : ref update bbs : insert
	public boolean answer(int seq, BbsDto bbs) {
		// update, 글을 추가하면 부모글보다 step 첫 번째 답글에서 실행x
		String sql1 = " UPDATE BBS "
					+ " SET STEP=STEP+1 "
						// 부모 게시글의 시퀀스 중에 같은 그룹번호
					+ " WHERE REF = (SELECT REF FROM BBS WHERE SEQ=?) "
						// 부모 게시글의 STEP      
					+ " AND STEP > (SELECT STEP FROM BBS WHERE SEQ=? ) ";
		// insert
		
		
		String sql2 = " INSERT INTO BBS"
					+ " (SEQ, ID, "
					+ " REF, STEP, DEPTH, "
					+ " TITLE, CONTENT, WDATE, DEL, READCOUNT) "
					// 시퀀스를 변경하는 이유는 부모게시글과 구분해서 그 글에 답글을 추가하기 위해 변경한다.
					+ " VALUES(SEQ_BBS.NEXTVAL, ?, "
					+ " 	(SELECT REF FROM BBS WHERE SEQ=?), "
					+ "		(SELECT STEP FROM BBS WHERE SEQ=?) + 1, "
					+ " 	(SELECT DEPTH FROM BBS WHERE SEQ=?) + 1, "	
					+ " 	?, ?, SYSDATE, 0, 0) ";	
		
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			conn.setAutoCommit(false);
			System.out.println("1/6 login success");
			
			//update
			psmt = conn.prepareStatement(sql1);
			psmt.setInt(1, seq);
			psmt.setInt(2, seq);
			System.out.println("2/6 login success");
			
			count = psmt.executeUpdate();
			System.out.println("3/6 login success");
			
			// psmt 초기화
			psmt.clearParameters();
			
			// insert
			psmt = conn.prepareStatement(sql2);
			
			psmt.setString(1, bbs.getId());
			psmt.setInt(2, seq);
			psmt.setInt(3, seq);
			psmt.setInt(4, seq);
			psmt.setString(5, bbs.getTitle());
			psmt.setString(6, bbs.getContent());
			System.out.println("4/6 login success");
			
			count = psmt.executeUpdate();
			System.out.println("5/6 login success");
			
			// db에 적용
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
			try {
				// 문제가 발생하면 초기화
				conn.rollback();
			} catch (SQLException e1) {
				
				e1.printStackTrace();
			}
		}finally {
			
			try {
				conn.setAutoCommit(true);
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
			DBClose.close(psmt, conn, null);
			System.out.println("6/6 login success");
		}
		
		return count > 0?true:false;
	}
	
	public boolean deleteBbs(int seq) {
		
		String sql = " UPDATE BBS "
				   + " SET DEL = 1 "
				   + " WHERE SEQ = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 login success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/6 login success");
			
			count = psmt.executeUpdate();
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			
			DBClose.close(psmt, conn, null);
		}
		return count > 0 ?true:false;
	}
	
	public List<BbsDto> getBbsList(String sel, String keyword) {
		
		String sql = " SELECT SEQ, ID, REF, STEP, DEPTH, TITLE, CONTENT, WDATE, DEL, READCOUNT "
				   + " FROM BBS ";
				 //  + " WHERE 1=1 ";
		
		
		// 기존에 있던 게시물 전체출력 쿼리문에다가 키워드를 추가해서 제어문으로 쿼리문 추가
		
		// sql+=으로 추가하면 % 때문에 컬럼을 인식하지 못해서 쿼리문 적용이 되지 않는다.
		String select = "";
		if(sel.equals("TITLE")) {
			// %가 포함되면 column값 인식 x  
			//select = " AND TITLE LIKE " + "'%"+keyword.trim()+"%'";
			select = " WHERE TITLE LIKE " + "'%"+keyword.trim()+"%'" + " AND DEL = 0 ";
		}
		else if(sel.equals("CONTENT")) {
			//select = " AND CONTENT LIKE " + "'%"+keyword.trim()+"%'";
			select = " WHERE CONTENT LIKE " + "'%"+keyword.trim()+"%'" + " AND DEL = 0 ";
		}
		else if(sel.equals("ID")) {
			//select = " AND ID LIKE " + "'%"+keyword.trim()+"%'";
			select = " WHERE ID LIKE " + "'%"+keyword.trim()+"%'" + " AND DEL = 0 ";
		}
		// 키워드를 적용해서 출력	
		sql = sql + select;
		// 키워드가 없을 경우에는 전체 출력
		sql += " ORDER BY REF DESC, STEP ASC ";
		
		
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<BbsDto> list = new ArrayList<BbsDto>();
		
		System.out.println(sel);
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 login success");
			
			psmt = conn.prepareStatement(sql);
		//	psmt.setString(1, sel);

			System.out.println("2/6 login success");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 login success");
			
			while(rs.next()) {
				
				int i = 1;						// 대입 후 증가
				BbsDto dto = new BbsDto(rs.getInt(i++), //seq
										rs.getString(i++), //id
										rs.getInt(i++), //ref
										rs.getInt(i++), //step
										rs.getInt(i++), //depth
										rs.getString(i++), //title
										rs.getString(i++), //content
										rs.getString(i++), //wdate
										rs.getInt(i++), //del
										rs.getInt(i++) //readcount
										);
				list.add(dto);
		
			}
			System.out.println("4/6 login success");
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, rs);
		}
		
		
		
		return list;
	}
	
	public boolean updateBbs(int seq, String title, String content) {
		String sql = " UPDATE BBS "
				   + " SET TITLE = ?, CONTENT = ? "
				   + " WHERE SEQ = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 updateBbs success");
			
			psmt = conn.prepareStatement(sql);
			
			psmt.setString(1, title);
			psmt.setString(2, content);
			psmt.setInt(3, seq);
			System.out.println("2/6 updateBbs success");
			
			count = psmt.executeUpdate();
			System.out.println("3/6 updateBbs success");
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, null);
		}
		
		return count > 0?true:false;
	}
	
	// 글의 전체 갯수
	public int getAllBbs(String sel, String keyword) {
		
		String sql = " SELECT COUNT(*) "
				   + " FROM BBS ";
		
		String select = "";
		
		if(sel.equals("TITLE")) {
			// %가 포함되면 column값 인식 x  
			//select = " AND TITLE LIKE " + "'%"+keyword.trim()+"%'";
			select = " WHERE TITLE LIKE " + "'%"+keyword.trim()+"%'" + " AND DEL = 0 ";
		}
		else if(sel.equals("CONTENT")) {
			//select = " AND CONTENT LIKE " + "'%"+keyword.trim()+"%'";
			select = " WHERE CONTENT LIKE " + "'%"+keyword.trim()+"%'" + " AND DEL = 0 ";
		}
		else if(sel.equals("ID")) {
			//select = " AND ID LIKE " + "'%"+keyword.trim()+"%'";
			select = " WHERE ID LIKE " + "'%"+keyword.trim()+"%'" + " AND DEL = 0 ";
		}
		sql += select;
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;		
				
		int len = 0;
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				
				len = rs.getInt(1);
			}
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			
			DBClose.close(psmt, conn, rs);
		}
	
		return len;
	}
	
	public List<BbsDto> getBbsPagingList(String sel, String keyword, int page) {
		
		/*
		 	1. row 번호
		 	2. 검색
		 	3. 정렬
		 	4. 범위1 ~ 10
		*/
		
		
		String sql = " SELECT SEQ, ID, REF, STEP, DEPTH, "
				+ " TITLE, CONTENT, WDATE, "
				+ " DEL, READCOUNT "
				+ " FROM ";
		
		sql +=  " (SELECT ROW_NUMBER()OVER(ORDER BY REF DESC, STEP ASC) AS RNUM, " + 
				" SEQ, ID, REF, STEP, DEPTH, TITLE, CONTENT, WDATE, DEL, READCOUNT " + 
				" FROM BBS ";
		
				 //  + " WHERE 1=1 ";
		
		
		// 기존에 있던 게시물 전체출력 쿼리문에다가 키워드를 추가해서 제어문으로 쿼리문 추가
		
		
		String select = "";
		if(sel.equals("TITLE")) {
			// %가 포함되면 column값 인식 x  
			//select = " AND TITLE LIKE " + "'%"+keyword.trim()+"%'";
			select = " WHERE TITLE LIKE " + "'%"+keyword.trim()+"%'" + " AND DEL = 0 ";
			
		}
		else if(sel.equals("CONTENT")) {
			//select = " AND CONTENT LIKE " + "'%"+keyword.trim()+"%'";
			select = " WHERE CONTENT LIKE " + "'%"+keyword.trim()+"%'" + " AND DEL = 0 ";
			
		}
		else if(sel.equals("ID")) {
			//select = " AND ID LIKE " + "'%"+keyword.trim()+"%'";
			select = " WHERE ID LIKE " + "'%"+keyword.trim()+"%'" + " AND DEL = 0 ";
			
		}
		
		// 키워드를 적용해서 출력	
		sql = sql + select;
		// 키워드가 없을 경우에는 전체 출력
	//	sql += " ORDER BY REF DESC, STEP ASC ";
		
		sql += " ORDER BY REF DESC, STEP ASC) ";
		sql += " WHERE RNUM >= ? AND RNUM <= ? ";
		System.out.println(sql);
		int start, end;
		// 1+ -> 0 == 1, 1 == 2
		// 1페이지 1번부터 시작 ,2페이지 11번부터 시작
		
		// 출력 범위
		start = 1 + 10 * page;	// 시작 글의 번호
		end = 10 + 10 * page;	// 끝 글의 번호
		
	
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<BbsDto> list = new ArrayList<BbsDto>();
		
		System.out.println(sel);
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 login success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, start);
			psmt.setInt(2, end);
		//	psmt.setString(1, sel);

			System.out.println("2/6 login success");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 login success");
			
			while(rs.next()) {
				
				int i = 1;						// 대입 후 증가
				BbsDto dto = new BbsDto(rs.getInt(i++), //seq
										rs.getString(i++), //id
										rs.getInt(i++), //ref
										rs.getInt(i++), //step
										rs.getInt(i++), //depth
										rs.getString(i++), //title
										rs.getString(i++), //content
										rs.getString(i++), //wdate
										rs.getInt(i++), //del
										rs.getInt(i++) //readcount
										);
				list.add(dto);
		
			}
			System.out.println("4/6 login success");
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, rs);
		}
		
		
		
		return list;
	
	}
	
	
	
}
