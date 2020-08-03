package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.PdsDto;

public class PdsDao {

	private static PdsDao dao = new PdsDao();
	
	private PdsDao() {}
	
	public static PdsDao getInstance() {
		return dao;
	}
	
	public List<PdsDto> getPdsList(){
		
		String sql =" SELECT SEQ, ID, TITLE, CONTENT, FILENAME, "
				+	" READCOUNT, DOWNCOUNT, REGDATE "
				+	" FROM PDS "
				+	" ORDER BY SEQ DESC ";
		
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<PdsDto> list = new ArrayList<PdsDto>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getPdsList success");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 getPdsList success");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 getPdsList success");
			
			
			while(rs.next()) {				
				int i = 1;				
				PdsDto dto = new PdsDto(rs.getInt(i++), // 시퀀스
										rs.getString(i++), // id
										rs.getString(i++), // title
										rs.getString(i++), // content
										rs.getString(i++), // filename
										rs.getInt(i++),  // readcount
										rs.getInt(i++),  // downcount
										rs.getString(i++)); // regdate
				list.add(dto);
			}
			System.out.println("4/6 getPdsList success");
		} catch (Exception e) {
			System.out.println("getPdsList fail");
			e.printStackTrace();
		}finally {
			
			DBClose.close(psmt, conn, rs);
		}
		
		return list;		
	}
	
	public boolean writePds(PdsDto pds) {
		
		String sql =" INSERT INTO PDS(SEQ, ID, TITLE, CONTENT, FILENAME, "
									+" READCOUNT, DOWNCOUNT, REGDATE) "
					+" VALUES(SEQ_PDS.NEXTVAL, ?, ?, ?, ?, "
					+" 0, 0, SYSDATE)";
		//System.out.println(sql);
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn =DBConnection.getConnection();
			System.out.println("1/6 writePds success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, pds.getId());
			psmt.setString(2, pds.getTitle());
			psmt.setString(3, pds.getContent());
			psmt.setString(4, pds.getFilename());
			System.out.println("2/6 writePds success");
			
			count = psmt.executeUpdate();
			System.out.println("3/6 writePds success");
			
		} catch (Exception e) {
			System.out.println("writePds fail");
			e.printStackTrace();
		}finally {
			
			DBClose.close(psmt, conn, null);
		}
		return count>0?true:false;
	}
	
	public PdsDto getPds(int seq) {
		String sql = " SELECT SEQ, ID, TITLE, CONTENT, FILENAME, "
				+	 " READCOUNT, DOWNCOUNT, REGDATE "
				+	 " FROM PDS "
				+	 " WHERE SEQ =? ";
		
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		PdsDto dto = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getPds success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/6 getPds success");
			
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				int i = 1;
				dto = new PdsDto(rs.getInt(i++), // 시퀀스
						rs.getString(i++), // id
						rs.getString(i++), // title
						rs.getString(i++), // content
						rs.getString(i++), // filename
						rs.getInt(i++),  // readcount
						rs.getInt(i++),  // downcount
						rs.getString(i++)); // regdate
				
				
				
			}
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			
			DBClose.close(psmt, conn, rs);
		}
		
		return dto;
		
	}
	
	
	public boolean updatePds(int seq, String title, String content, String filename) {
		String sql = " UPDATE PDS "
				+	 " SET TITLE =?, CONTENT=?, FILENAME=?, REGDATE=SYSDATE "
				+	 " WHERE SEQ =? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 updatePds success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, title);
			psmt.setString(2, content);
			psmt.setString(3, filename);
			psmt.setInt(4, seq);
			System.out.println("2/6 updatePds success");
			
			count = psmt.executeUpdate();
			System.out.println("3/6 updatePds success");
			
			
		} catch (Exception e) {
			
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, null);
		}
		
		return count > 0 ?true:false;	
	}
	
	public boolean deletePds(int seq) {
		String sql = " DELETE FROM PDS "
				+	 " WHERE SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 deletePds success");
			
			psmt = conn.prepareStatement(sql);			
			psmt.setInt(1, seq);
			System.out.println("2/6 deletePds success");
			
			count = psmt.executeUpdate();
			System.out.println("3/6 deletePds success");
			
		} catch (Exception e) {
			
			e.printStackTrace();
		}finally {
			
			DBClose.close(psmt, conn, null);
		}
		return count > 0?true:false;
		
	}
	
	public void downCount(int seq) {
		
		String sql = " UPDATE PDS "
				+	 " SET DOWNCOUNT = DOWNCOUNT + 1 "
				+	 " WHERE SEQ =? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 downCount success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/6 downCount success");
			
			psmt.executeUpdate();
			System.out.println("3/6 downCount success");
			
		} catch (Exception e) {
			
			e.printStackTrace();
		}finally {
			
			DBClose.close(psmt, conn, null);
		}		
	}
	
	public void readCount(int seq) {
		
		String sql = " UPDATE PDS "
				+	 " SET READCOUNT = READCOUNT + 1 "
				+	 " WHERE SEQ =? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 readCount success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/6 readCount success");
			
			psmt.executeUpdate();
			System.out.println("3/6 readCount success");
			
		} catch (Exception e) {
			
			e.printStackTrace();
		}finally {
			
			DBClose.close(psmt, conn, null);
		}		
	}
	
}
