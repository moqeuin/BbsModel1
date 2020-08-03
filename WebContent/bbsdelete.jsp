<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<% 

int seq = Integer.parseInt(request.getParameter("seq"));
boolean ch = false;
BbsDao bdao = BbsDao.getInstance();
ch = bdao.deleteBbs(seq);

%>
<% 
if(ch){

%>
<script type="text/javascript">
alert("게시글을 삭제를 했습니다.");
location.href = "bbslist.jsp";
</script>

<%
}else{
	

%>

<script type="text/javascript">
alert("게시글을 삭제하는데 실패했습니다.");
location.href = "bbslist.jsp";
</script>


<%
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>