<%@page import="util.UtilEx"%>
<%@page import="calendarEx.CalendarDto"%>
<%@page import="java.util.List"%>
<%@page import="calendarEx.CalendarDao"%>
<%@page import="java.util.Calendar"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%!
// nvl 함수
public boolean nvl(String msg){
	return msg == null||msg.trim().equals("")?true:false;
}
%>    

<%
Object ologin = session.getAttribute("login");
MemberDto mem = null;
if(ologin == null){
	response.sendRedirect("goCheck.jsp?proc=login");	
}

mem = (MemberDto)ologin;
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h4 align="left" style="background-color: #f0f0f0">환영합니다 <%=mem.getId() %>님</h4>

<%
	Calendar cal = Calendar.getInstance();
	cal.set(Calendar.DATE, 1);	// 7/31 -> 7/01

	String syear = request.getParameter("year");
	String smonth = request.getParameter("month");
	
	int year = cal.get(Calendar.YEAR);
	if(nvl(syear) == false){	// parameter가 넘어 왔을 때
		year = Integer.parseInt(syear);
	}
	
	int month = cal.get(Calendar.MONTH) + 1;
	if(nvl(smonth) == false){
		month = Integer.parseInt(smonth);
	}
	
	if(month < 1){
		month = 12;
		year--; 
	}
	if(month > 12){
		month = 1;
		year++;
	}
	
	cal.set(year, month - 1, 1);	// 연 월 일 셋팅이 완료 -> 2020 07 31

	// 요일
	int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
	
	// << year--
	String pp = String.format("<a href='%s?year=%d&month=%d'>" + "<img src='../image/left.gif'></a>", 
									"calendar.jsp", year-1, month);
	
	// < month--
	String p = String.format("<a href='%s?year=%d&month=%d'>" + "<img src='../image/prec.gif'></a>", 
									"calendar.jsp", year, month-1);
	
	// > month++
	String n = String.format("<a href='%s?year=%d&month=%d'>" + "<img src='../image/next.gif'></a>", 
									"calendar.jsp", year, month+1);
	
	// >> year++
	String nn = String.format("<a href='%s?year=%d&month=%d'>" + "<img src='../image/last.gif'></a>", 
									"calendar.jsp", year+1, month);
	
	CalendarDao dao = CalendarDao.getInstance();
	// 작성한 일정 5개를 가져옴
	List<CalendarDto> list = dao.getCalendarList(mem.getId(), year + UtilEx.two(month + ""));
		
%>

<div align="center">

<table border="1">
<col width="100"><col width="100"><col width="100"><col width="100">
<col width="100"><col width="100"><col width="100">

<tr height="100">
	<td colspan="7" align="center" style="padding-top: 20px">
		<%=pp %>&nbsp;&nbsp;<%=p %>&nbsp;
		
		<font color="black" style="font-size: 50px">
			<%=String.format("%d년&nbsp;&nbsp;%2d월", year, month) %>
		</font>
		
		<%=n %>&nbsp;&nbsp;<%=nn %>	
	</td>	
</tr>

<tr height="50">
	<th align="center">일</th>
	<th align="center">월</th>
	<th align="center">화</th>
	<th align="center">수</th>
	<th align="center">목</th>
	<th align="center">금</th>
	<th align="center">토</th>
</tr> 

<tr height="100" align="left" valign="top">
<%
// 위쪽 빈칸
for(int i = 1;i < dayOfWeek; i++){
	%>
	<td style="background-color: #cecece">&nbsp;</td>	
	<%
}
%>

<%-- 날짜 --%>
<%
int lastday = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
for(int i = 1; i <= lastday; i++){
	%>
	<td>
		<%=UtilEx.callist(year, month, i) %>&nbsp;&nbsp;<%=UtilEx.showPen(year, month, i) %>
		<%=UtilEx.makeTable(year, month, i, list) %>	
	</td>	
	<%
	if( (i + dayOfWeek - 1) % 7 == 0 && i != lastday){
		%>
		<tr><tr height="100" align="left" valign="top">		
		<%
	}	
}
%>

<%--밑칸 --%>
<%
cal.set(Calendar.DATE, lastday); // 그달의 마지막 날짜로 셋팅
int weekday = cal.get(Calendar.DAY_OF_WEEK);
for(int i = 0;i < 7 - weekday; i++){
	%>	
	<td style="background-color: #cecece">&nbsp;</td>	
	<%
}

%>


</tr>


</table>

</div>


</body>
</html>







