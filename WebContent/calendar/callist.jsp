<%@page import="calendarEx.CalendarDto"%>
<%@page import="java.util.List"%>
<%@page import="calendarEx.CalendarDao"%>
<%@page import="dto.MemberDto"%>
<%@page import="util.UtilEx"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%

Object ologin = session.getAttribute("login");
MemberDto mem = null;
if(ologin == null){
	response.sendRedirect("goCheck.jsp?proc=login");	
}

mem = (MemberDto)ologin;


String year = request.getParameter("year");
String month = UtilEx.two(request.getParameter("month"));
String day = UtilEx.two(request.getParameter("day"));

String thisdate = year + month + day;

CalendarDao cdao = CalendarDao.getInstance();
List<CalendarDto> list = cdao.getThisCalList(thisdate, mem.getId());

String rdate[] = new String[list.size()];

for(int i =0; i < rdate.length; i++){
	rdate[i] = "";
	
}


for(int i = 0; i < list.size(); i++){
	
String srdate = list.get(i).getRdate();

rdate[i] += srdate.substring(0, 4)+"년";
rdate[i] += srdate.substring(4, 6)+"월";
rdate[i] += srdate.substring(6, 8)+"일";
rdate[i] += srdate.substring(8, 10)+"시";
rdate[i] += srdate.substring(10, 12)+"분";


}




%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>



<div align="center">
<table border = "1" width="600">
<col width="100"> <col width="300"> <col width="200">
<tr>
	<th>번호</th>
	<th>제목</th>
	<th>일정</th>

</tr>
<tr>
<%
if(list.size()==0 || list == null){
	
%>
<tr>
	<td colspan ="3">일정내용이 없습니다.</td>
</tr>
<%

}else{
	
	for(int i = 0; i < list.size(); i++){
		CalendarDto cdto = list.get(i);
%>
<tr>
	<th><%=(i+1) %></th>	
	<td>
	<a href="caldetail.jsp?seq=<%=cdto.getSeq() %>"><%=cdto.getTitle() %></a>
	</td>
	<td>
	<%=rdate[i] %>
	</td>
<%
	}
}
%>




</table>

<button type="button" onclick="calback()">일정으로 가기</button>


</div>




<script type="text/javascript">

function calback(){
	
	location.href ="calendar.jsp";
}

</script>






</body>
</html>