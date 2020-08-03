<%@page import="calendarEx.CalendarDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%

String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq);
boolean isS = false;
CalendarDao dao = CalendarDao.getInstance();

isS = dao.deleteCalendar(seq);



if(isS){
	
%>
<script type="text/javascript">
alert("삭제되었습니다.");
location.href = "calendar.jsp";

</script>

<%	
	
}else{


%>

<script type="text/javascript">
alert("삭제를 실패했습니다..");
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