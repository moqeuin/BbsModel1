<%@page import="dto.PdsDto"%>
<%@page import="dao.PdsDao"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="java.io.File"%>
<%@page import="java.io.IOException"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%!
// upload 함수
						// commons.fileupload
public String processUploadFile(FileItem fileItem, String dir)throws IOException{
								// abc.txt ->파일명	  d:\tmp\  ->경로
								
	String filename = fileItem.getName(); // 경로 + 파일명
	long sizeInBytes = fileItem.getSize(); // 파일의 크기, 바이트 단위
	
	// 파일이 정상
	if(sizeInBytes > 0 ){ // d:\\tmp\\abc.txt	or     d:/tmp/abc.txt
		
		int idx = filename.lastIndexOf("\\");  // 파일이름만 가져오기위한 인덱스 번호
		if(idx == -1){
			idx = filename.lastIndexOf("/");
		}
		
		filename = filename.substring(idx + 1); // abc.txt
		//File uploadFile = new File(dir, filename); 
		
		File uploadFile = new File(dir, filename);
		
		try{
			fileItem.write(uploadFile); // 실제 db 부분
		}catch(Exception e){
			
		}
	}
	return filename;
}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>pdsupload.jsp</title>
</head>
<body>


<%
// tomcat 배포(server)
String fupload = application.getRealPath("/upload");


// 지정 폴더(client)
//String fupload = "d:\\tmp";

System.out.println("업로더 폴더:" + fupload);

// 파일을 저장할 경로
String yourTempDir = fupload;

int yourMaxRequestSize = 100 * 1024 * 1024; // 1 mb
int yourMaxMemorySize = 100 * 1024; // 1kb

// form field의 데이터를 저장할 변수 <file x)
String  id="";
String  title="";
String  content="";

String work="";
String sseq="";


// file
String filename = "";

boolean isMultiPart = ServletFileUpload.isMultipartContent(request); // 송신한 데이터가 다중 데이터인지 확인
if(isMultiPart == true){
	
	//Fileitem 생성
	DiskFileItemFactory factory = new DiskFileItemFactory();
	
	// 업로드할 파일을 저장할 최대 메모리 크기
	factory.setSizeThreshold(yourMaxMemorySize);
	// 크기를 넘기면 저장한 임시디렉토리 지정
	factory.setRepository(new File(yourTempDir));
	
	// 업로드할 크기를 지정하기 위해 업로드 객체에 저장
	ServletFileUpload upload = new ServletFileUpload(factory);
	// 전체파일 업로드 최대 크기
	upload.setSizeMax(yourMaxRequestSize);
	

	List<FileItem> items = upload.parseRequest(request); // list로 받음 (ID, TITLE, CONTENT, FILE)
	
	Iterator<FileItem> it = items.iterator();
	
	// 구분 
	while(it.hasNext()){
		FileItem item = it.next();
		
		if(item.isFormField()){ // id, title, content
			if(item.getFieldName().equals("id")){
				id = item.getString("utf-8");
				
			}else if(item.getFieldName().equals("title")){
				title = item.getString("utf-8");
				
			}else if(item.getFieldName().equals("content")){
				content = item.getString("utf-8");
			}		

		}else{ // fileload
			if(item.getFieldName().equals("fileload")){
				filename = processUploadFile(item, fupload);
			}
			
		}
		
		
	}
	
}
	
// DB에 저장
PdsDao dao = PdsDao.getInstance();
boolean isS = dao.writePds(new PdsDto(id, title, content, filename));
if(isS){
%>

	<script type="text/javascript">
	
	alert("파일 업로드 성공");
	location.href = "pdslist.jsp";
	</script>

<%	
}else{
%>
	 <script type="text/javascript">
	
	alert("파일 업로드 실패");
	location.href = "pdslist.jsp";
	</script>

<%	
}
%>

</body>
</html>