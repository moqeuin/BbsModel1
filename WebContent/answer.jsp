<%@page import="dto.MemberDto"%>
<%@page import="dao.BbsDao"%>
<%@page import="dto.BbsDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%

String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq);


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


<%

BbsDao dao = BbsDao.getInstance();

BbsDto parentBbs = dao.getBbs(seq);

MemberDto login_user =(MemberDto)session.getAttribute("login");

%>
<%--
기본글<table>

작성자
제목
작성일
조회수
정보
내용

답글<table>
	로그인 id < - session id td태그
	제목
	내용
	
	answerAf.jsp로 전송
 --%>

<h1 align="center">작성글</h1>
<div align="center">
<table style="width: 700; border: 2px solid black; border-collapse: collapse; ">
<col width="100"> <col width="400"> <col width="100"> <col width="100"> 


<tr>

<td colspan="4" class=tb_border>정보 : </td>
</tr>
<tr >
<td class=tb_border>작성자 : <%=parentBbs.getId() %></td>

<td colspan="2" class=tb_border>작성일 : <%=parentBbs.getWdate() %> </td>
<td class=tb_border>조회수 : <%=parentBbs.getReadcount() %></td>
</tr>
<tr>
<td colspan="4">제목 : <%=parentBbs.getTitle() %></td>
</tr>
<tr>
<td colspan="4"><textarea rows="15" cols="100" readonly="readonly"><%=parentBbs.getContent() %></textarea></td>
</tr>

</table>
</div>

<h3 align="center">답글</h3>
<div align="center">


<!-- 부모글 번호(ref)도 넘겨야함 -->


<form action="answerAf.jsp" method="post" id="frm">

<input type="hidden" name="seq" value="<%= parentBbs.getSeq()%>">

<table class=tb_border width="500">
<col width="100"> <col width="400">

<tr>
<td> ID :<input type="text" value="<%=login_user.getId() %>" name="id">  </td>
<td>제목 : <input type="text" value="" size="43" name="title" id="title">
</tr>
<tr>

<td colspan="2" >
<textarea rows="10" cols="70" value="" name="content" id="content"></textarea>
</td>
</tr>
<tr>
<td colspan = "2" align="center">
<button type="button" id="addBtn">답글 추가</button>
</td>
</tr>

</table>



</form>
</div>
<script type="text/javascript">

$(function() {
	
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