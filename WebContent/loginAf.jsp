<%@page import="dto.MemberDto"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
String id = request.getParameter("id");
String pwd = request.getParameter("pwd");




%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
MemberDao dao = MemberDao.getInstance();
// id와 pwd로 등록된 회원의 정보를 가져온다
MemberDto mem = dao.login(id, pwd);


// 로그인 성공
if(mem != null && !mem.getId().equals("")){
	//login 정보 저장, login 함수에서 아이디, 이메일, 이름, 번호 가져옴
	
	// 로그인을 하면 세션 회원정보 저장
	session.setAttribute("login", mem);
	// 세션 유지 시간
//	session.setMaxInactiveInterval(30 * 60 * 60);
%>
	<script type="text/javascript">
	alert("안녕하세요<%=mem.getName()%>님");
	location.href = "./bbslist.jsp";
	
	</script>

<%
}else{
%>
	<script type="text/javascript">
	alert("id나 password를 확인하십시오");
	location.href = "./login.jsp";
	</script>

<%
}
%>





</body>
</html>