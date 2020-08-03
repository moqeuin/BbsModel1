package filedown;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.PdsDao;

public class FileDownLoader extends HttpServlet {
	ServletConfig mConfig = null;
	final int BUFFER_SIZE = 8192;
	
	
 	@Override
	public void init(ServletConfig config) throws ServletException {
		// 서버의 경로 획득
		super.init(config);
		mConfig = config; // file 업로드 경로를 취득하기 위함
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//System.out.println("FileDownLoader doget");
		
		String filename = req.getParameter("filename");
		String sseq = req.getParameter("seq");
		
		PdsDao dao = PdsDao.getInstance();
		
		// down load 횟수를 증가(DB)
		
		BufferedOutputStream out = new BufferedOutputStream(resp.getOutputStream());
		
		String filepath ="";
		
		//tomcat(server), 부팅을 계속하면 사라질수가 있음
		filepath = mConfig.getServletContext().getRealPath("/upload");
		
		//폴더(client)
		//filepath = "d:\\tmp";
		
		
		filepath = filepath + "\\" +filename;
		System.out.println("filepath : " + filepath);
		
		File f = new File(filepath);
		
		// 파일이 존재하거나 읽을 수 있으면
		if(f.exists() && f.canRead()) {
			
			// download window set
			
			
			resp.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\";");
			// 파일명 확인
			resp.setHeader("Content-Transfer-Encoding", "binary;");
			// 인코딩 방식 바이너리
			resp.setHeader("Content-Length", "" + f.length());
			// 막대 길이
			resp.setHeader("Pragma", "no-cache;"); 
			// 임시 공간 : 저장안함
			resp.setHeader("Expires", "-1;");
			// 기한 : 무제한
			
			// 파일 생성, 데이터 저장
			
			BufferedInputStream fileInput = new BufferedInputStream(new FileInputStream(f));
			
			byte buffer[] = new byte[BUFFER_SIZE];
			
			int read = 0;
			
			while((read = fileInput.read(buffer)) != -1) {
				out.write(buffer, 0, read); // 실제 다운로드
			}
				
			// 반드시 닫아야한다
			fileInput.close();
			out.flush();
		}
		// 다운로드 카운트
		int seq = Integer.parseInt(sseq);
		dao.downCount(seq);
		
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("FileDownLoader dopost");
	}
	
}
