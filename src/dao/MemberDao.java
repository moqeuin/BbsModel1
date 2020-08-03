package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import db.DBClose;
import db.DBConnection;
import dto.MemberDto;

public class MemberDao {
	
	private static MemberDao dao = new MemberDao();
	
	private MemberDao() {
		
	}
	
	public static MemberDao getInstance() {
		return dao;
	}
	
	
	// db에서 id가 있는 지 확인(있으면 true, 없으면 false)
	public boolean getId(String id) {
		String sql = " SELECT ID "
				   + " FROM MEMBER "
				   + "WHERE ID = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		boolean ch = false;
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			psmt.setString(1,id);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				
				ch = true;
			}
		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			
			DBClose.close(psmt, conn, rs);
		}
		return ch;
		
	}
	
	// 회원가입의 데이터 -> db
	public boolean addMember(String id, String pwd, String name, String email) {
		String sql = "INSERT INTO MEMBER(ID, PWD, NAME, EMAIL, AUTH)"
				   + "VALUES(?, ?, ?, ?, 3)";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int ch = 0;
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setString(2, pwd);
			psmt.setString(3, name);
			psmt.setString(4, email);
			
			ch = psmt.executeUpdate();
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, null);
		}
		
		return ch > 0 ? true:false;
	}
	
	// id, pwd로 회원정보를 객체로 반환
	public MemberDto login(String id,String pwd) {
		
		String sql =" SELECT ID, NAME, EMAIL, AUTH "
				+   " FROM MEMBER "
				+   " WHERE ID=? AND PWD=? ";
				
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		MemberDto dto = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 login success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setString(2, pwd);
			System.out.println("2/6 login success");
			
			// 관리자랑 사용자라
			rs = psmt.executeQuery();
			System.out.println("3/6 login success");
			
			if(rs.next()) {
				
				String user_id = rs.getString(1);
				String name = rs.getString(2);
				String email = rs.getNString(3);
				String auth = rs.getNString(4);
				
				dto = new MemberDto(user_id, null, name, email, auth);
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
	
	
	
}
