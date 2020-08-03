<%@page import="dao.BbsDao"%>
<%@page import="dao.MemberDao"%>
<%@page import="dto.BbsDto"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

boolean ch = false;

MemberDto dto = (MemberDto)session.getAttribute("login");


String id = dto.getId();
String title = request.getParameter("title");
String content = request.getParameter("content");

BbsDto bd = new BbsDto(id, title, content);

BbsDao dao = BbsDao.getInstance();


ch = dao.writeBbs(bd); 

if(ch){
%>
<script type="text/javascript">
alert("추가가 되었습니다.");
location.href="bbslist.jsp";
</script>

<%
}else{

%>
<script type="text/javascript">
alert("추가하는 데 실패 했습니다.");
location.href="bbswrite.jsp";
</script>


<%
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>

</body>
</html>