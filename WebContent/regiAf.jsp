<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%

	MemberDao dao = MemberDao.getInstance();
	boolean ch = false;

	request.setCharacterEncoding("UTF-8");
	
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	
//	System.out.println(id + " " + pwd + " "+name + " "+email);
	ch = dao.addMember(id, pwd, name, email);
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


<%
if(ch){
	%>	
	<script type="text/javascript">
	alert("회원정보 가입에 성공했습니다.");
	location.href="login.jsp";
	</script>
<%
}
else{
%>

	<script type="text/javascript">
	alert("회원정보 가입에 실패했습니다.");
	location.href="regi.jsp";
	</script>
<%

}
%>




</body>
</html>