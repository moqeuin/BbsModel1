<%@page import="calendarEx.CalendarDto"%>
<%@page import="calendarEx.CalendarDao"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
Object ologin = session.getAttribute("login");
MemberDto mem = null;
if(ologin == null){
	response.sendRedirect("goCheck.jsp?proc=login");	
}

mem = (MemberDto)ologin;

int seq = Integer.parseInt(request.getParameter("seq")); 

CalendarDao cdao = CalendarDao.getInstance();
CalendarDto cdto = cdao.getCalendar(seq);





%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


<div align="center">
<table border="1" width="500">
<tr>
<td>ID:&nbsp;&nbsp;<%=cdto.getId() %></td>
</tr>

<tr>
<td>일정:&nbsp;&nbsp;<%=cdto.getRdate() %></td>
</tr>


<tr>
<td>제목:&nbsp;&nbsp;<%=cdto.getTitle() %></td>
</tr>


<tr>
<td> <textarea rows="30" cols="70" readonly="readonly" ><%=cdto.getContent() %></textarea> </td>
</tr>


	


</table>

<button type="button" onclick="updatefunc(<%=seq%>)">수정</button>
<button type="button" onclick="deletefunc(<%=seq%>)">삭제</button>
<button type="button" onclick="listfunc()">목록</button>
</div>
<script type="text/javascript">

function updatefunc(seq) {
	
	location.href = "calupdate.jsp?seq=" + seq;
}



function deletefunc(seq){
	location.href = "caldelete.jsp?seq=" + seq;
}

function listfunc(){
	
	location.href = "../bbslist.jsp";
}




</script>

</body>
</html>