<%@page import="dto.BbsDto"%>
<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%


int seq = Integer.parseInt(request.getParameter("seq"));

BbsDao bdao = BbsDao.getInstance();
BbsDto bdto = bdao.getBbs(seq);





%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
.tb_border{


width: 700;
border: 1px solid black;
border-collapse: collapse;"

}


</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>


<div align="center">
<form id="frm" action="bbsupdateAf.jsp">
<input type="hidden" value="<%=seq %>" name="seq">
<table class="tb_border">
<tr>

<th>ID:<%=bdto.getId() %></th>
</tr>
<tr>
<th>제목:<input type="text" value="<%=bdto.getTitle() %>" size="60" name="title" id="title" value=""></th>
</tr>

<tr>
<td><textarea rows="30" cols="70" name="content" id="content">
<%=bdto.getContent() %>
</textarea>
</td>
</tr>
</table>
</form>

<button type="button" id="listBtn">글 목록</button>
<button type="button" id="updateBtn">수정완료</button>

</div>

<script type="text/javascript">
$(function() {
	$('#updateBtn').click(function() {
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