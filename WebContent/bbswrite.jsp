<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
Object ologin = session.getAttribute("login");
MemberDto dto = null;
 
if(ologin == null ){
%>
 <script type="text/javascript">
	alert("로그인을 해 주십시오");
	location.href ="login.jsp";
</script>

<%
}

dto = (MemberDto)ologin;


%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>


<style type="text/css">
.tb_border{


width: 700;
border: 1px solid black;
border-collapse: collapse;"

}


</style>

</head>
<body>

<div align="center">
<form id="frm" action="bbswriteAf.jsp">
<table width="400" class=tb_border>
<col width="100"> <col width="300">
<tr>
<th>ID:<%=dto.getId() %></th>
</tr>
<tr>
<th>제목:<input type="text" value="" name="title" id="title"></th>
</tr>
<tr>
<td><textarea rows="30" cols="70" name="content" id="content"></textarea></td>
</tr>

</table>


</form>

<button type="button" id="listBtn">글 목록</button>
<button type="button" id="addBtn">글 추가</button>

</div>
<script type="text/javascript">

$(function () {
	$('#listBtn').click(function() {
		
		location.href="bbslist.jsp";
	});
	
	$('#addBtn').click(function() {
		if($('#title').val().trim() == ""){
			
			alert("제목을 입력해주세요");
			$('#title').focus();
		}
		else if($('#content').val().trim() == ""){
			
			alert("내용을 입력해주세요");
			$('#content').focus();
		}
		
		else{
			
			$('#frm').submit();
		}
		
	});
		
});


</script>

</body>
</html>