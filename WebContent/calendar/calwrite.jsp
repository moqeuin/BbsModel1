<%@page import="java.util.Calendar"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
// 클릭한 연도, 월, 일
String year = request.getParameter("year");
String month = request.getParameter("month");
String day = request.getParameter("day");
MemberDto mem =(MemberDto)session.getAttribute("login");


//System.out.println(year);
//System.out.println(month);
//System.out.println(day);


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>

<%
// 범위를 설정하는 기준
Calendar cal = Calendar.getInstance();
int tyear = cal.get(Calendar.YEAR);
int tmonth = cal.get(Calendar.MONTH) + 1; // 0 ~ 11
int tday = cal.get(Calendar.DATE);
int thour = cal.get(Calendar.HOUR_OF_DAY);
int tmin = cal.get(Calendar.MINUTE);


%>
<h1>일정추가</h1>
<div align="center">
<form action="calwriteAf.jsp" method="post">
<table border="1">
<col width="200"> <col width="500">
<tr>

	<th>ID</th>
	<td>
	
		<%=mem.getId() %>
		<%-- 캘린더를 기록할 때 id를 넘겨줌(아니면 af에서 session) --%>
		<input type="hidden" name="id" value="<%=mem.getId() %>">
	</td>

</tr>

<tr>
	<th>제목</th>
	<td>
		<input type="text" size="60" name="title">
	</td>
</tr>
<tr>

	<th>일정</th>
	<td>
		<select name="year">
		<%
			for(int i = tyear -5; i < tyear + 5; i++){
				%>
				<%-- 현재의 연도가 반복 중에 일치한다면 선택한 상태로 태그생성  --%>
				<option <%=year.equals(i + "")?"selected='selected'":"" %> value="<%=i %>">
					<%=i %>
				</option>				
				<%		
			}		
		%>	
		</select>년
		<select name="month">
		<%
			for(int i = 1; i <= 12; i++){
				%>
				<%-- 현재의 월이 반복 중에 일치한다면 선택한 상태로 태그생성--%>
				<option <%=month.equals(i + "")?"selected='selected'":"" %> value="<%=i %>">
					<%=i %>
				</option>				
				<%		
			}		
		%>	
		</select>월
		<select name="day">
		<%
			for(int i = 1; i <= cal.getActualMaximum(Calendar.DAY_OF_MONTH) ; i++){
				%>
				<%-- 현재의 일이 반복 중에 일치한다면 선택한 상태로 태그생성 --%>
				<option <%=day.equals(i + "")?"selected='selected'":"" %> value="<%=i %>">
					<%=i %>
				</option>				
				<%		
			}		
		%>	
		</select>일
		<select name="hour">
		<%
			for(int i = 0; i <24 ; i++){
				%>
				<%-- 현재의 시간이 반복 중에 일치한다면 선택한 상태로 태그생성 --%>
				<option <%=(thour + "").equals(i + "")?"selected='selected'":"" %> value="<%=i %>">
					<%=i %>
				</option>				
				<%		
			}		
		%>	
		</select>시
		<select name="min">
		<%
			for(int i = 0; i <60 ; i++){
				%>
				<%-- 현재의 분이 반복 중에 일치한다면 선택한 상태로 태그생성 --%>
				<option <%=(tmin + "").equals(i + "")?"selected='selected'":"" %> value="<%=i %>">
					<%=i %>
				</option>				
				<%		
			}		
		%>	
		</select>분
	</td>	
</tr>

<tr>

	<th>내용</th>
	<td>
	
		<textarea rows="20" cols="60" name="content"></textarea>
	</td>
</tr>
<tr>
	<td colspan="2">
		<input type="submit" value="일정추가">
	</td>


</tr>






</table>



</form>

</div>


<script type="text/javascript">




$("select[name='day']").val("<%=day %>");






$(document).ready(function () {
	// 월의 값이 바뀌면 setday함수 실행
	$("select[name='month']").change(setday);
	
});


function setday(){
	// 해당 년도의 월을 통해서 마지막날을 구한다.
	let year = $("select[name='year']").val();
	let month = $("select[name='month']").val();
	
	let lastday = new Date(year, month, 0).getDate();
	//alert(lastday);
	
	// 날짜 적용
	let str ="";
	for(i = 1; i <= lastday; i++){
		str += "<option value='" + i + "'>" + i + "</option>";
	}
	
	$("select[name='day']").html(str);
	
	
	
}




</script>




</body>
</html>