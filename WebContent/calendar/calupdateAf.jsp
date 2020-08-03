<%@page import="calendarEx.CalendarDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
int seq = Integer.parseInt(request.getParameter("seq"));
String title = request.getParameter("title");
String content = request.getParameter("content");

CalendarDao cdao = CalendarDao.getInstance();
boolean isS = cdao.updateCalendar(seq, title, content);

if(isS){


%>
	<script type="text/javascript">
	alert("수정에 성공했습니다.");
	location.href = "calendar.jsp";
	</script>
<%

}else{
%>
	<script type="text/javascript">
	alert("수정에 실패했습니다.");
	location.href = "calendar.jsp";
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