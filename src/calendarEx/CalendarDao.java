package calendarEx;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import db.DBClose;
import db.DBConnection;

public class CalendarDao {
	private static CalendarDao dao = new CalendarDao();
	
	
	private CalendarDao() {}
	
	public static CalendarDao getInstance() {
		return dao;
	}
	
	
	public List<CalendarDto> getCalendarList(String id, String yyyyMM){
		
		String sql =" SELECT SEQ, ID, TITLE, CONTENT, RDATE, WDATE "
				+   " FROM ( "
				+   " SELECT ROW_NUMBER() OVER(PARTITION BY SUBSTR(RDATE, 1, 8)ORDER BY RDATE ASC ) AS RNUM, " 
				+   " SEQ, ID, TITLE, CONTENT, RDATE, WDATE " 
				+   " FROM CALENDAR " 
				+   " WHERE ID=? AND SUBSTR(RDATE, 1, 6)=? )  "
				+   " WHERE RNUM BETWEEN 1 AND 5 ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<CalendarDto> list = new ArrayList<CalendarDto>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getCalendarList success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setString(2, yyyyMM);
			System.out.println("2/6 getCalendarList success");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 getCalendarList success");
			
			while(rs.next()) {
				int i = 1;
				
				CalendarDto dto = new CalendarDto(rs.getInt(i++), 
												  rs.getNString(i++), 
												  rs.getNString(i++), 
												  rs.getNString(i++), 
												  rs.getNString(i++), 
												  rs.getNString(i++));
				
				list.add(dto);	
			}
			System.out.println("4/6 getCalendarList success");
			
		} catch (Exception e) {
			
			e.printStackTrace();
		} finally {
			
			DBClose.close(psmt, conn, rs);
		}
		return list;
	}
	
	public boolean addCalendar(CalendarDto cal) {
		
		String sql = " INSERT INTO CALENDAR(SEQ, ID, TITLE, CONTENT, RDATE, WDATE) "
				+	 " VALUES(SEQ_CAL.NEXTVAL, ?, ?, ?, ?, SYSDATE)";
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0 ;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 addCalendar success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, cal.getId());
			psmt.setString(2, cal.getTitle());
			psmt.setString(3, cal.getContent());
			psmt.setString(4, cal.getRdate());
			System.out.println("2/6 addCalendar success");
			
			count = psmt.executeUpdate();
			System.out.println("3/6 addCalendar success");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, null);
		}
		
		return count>0?true:false;
	}
	
	public CalendarDto getCalendar(int seq) {
		String sql = " SELECT ID, TITLE, CONTENT, RDATE "
				+	 " FROM CALENDAR "
				+	 " WHERE SEQ =? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		CalendarDto dto = null;
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				int i = 1;
				String id = rs.getString(i++);
				String title= rs.getString(i++);
				String content = rs.getString(i++);
				String rdate = rs.getString(i++);
			
				
				dto = new CalendarDto(id, title, content,rdate);
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			
			DBClose.close(psmt, conn, rs);
		}
		return dto;
	}
	
	public boolean deleteCalendar(int seq) {
		String sql = " DELETE FROM CALENDAR "
				+	 " WHERE SEQ =? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		
		try {
			conn =DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			
			count = psmt.executeUpdate();
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, null);
		}
		return count > 0 ?true:false;
	}
	
	public boolean updateCalendar(int seq,String title, String content) {
		String sql = " UPDATE CALENDAR "
				+	 " SET TITLE = ?, CONTENT = ? "
				+    " WHERE SEQ = ? ";
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			
			psmt.setString(1, title);
			psmt.setString(2, content);
			psmt.setInt(3, seq);
			count = psmt.executeUpdate();
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			
			DBClose.close(psmt, conn, null);
		}
		
		return count > 0?true:false;
	}
	
	public List<CalendarDto> getThisCalList(String thisdate, String id){
		String sql = " SELECT SEQ, TITLE , RDATE "
				+    " FROM CALENDAR ";
				
		String addstring = " WHERE RDATE LIKE '" + thisdate + "%' " + " AND ID = ? " 
						 + " ORDER BY RDATE ASC ";
		sql += addstring;
		System.out.println(sql);
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<CalendarDto> list = new ArrayList<CalendarDto>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getThisCalList success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			System.out.println("2/6 getThisCalList success");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 getThisCalList success");
			while(rs.next()) {
				
				int seq = rs.getInt(1);
				String title = rs.getString(2);
				String rdate = rs.getString(3);
				
				CalendarDto dto = new CalendarDto(seq, title, rdate);
				
				list.add(dto);
			}
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			
			DBClose.close(psmt, conn, rs);
		}
		return list;
	}
	
	
	
	
}
