<%@page import="dto.MemberDto"%>
<%@page import="dto.BbsDto"%>
<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%

int seq = Integer.parseInt(request.getParameter("seq"));

BbsDao dao = BbsDao.getInstance();
BbsDto bbs = dao.getBbs(seq);
dao.readcount(seq);

MemberDto mem = (MemberDto)request.getSession().getAttribute("login");
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
<!-- 

작성자(id)
제목
작성일
조회수
정보
내용 textarea
 -->
<h1 align="center">작성글</h1>
<div align="center">
<table style="width: 700; border: 2px solid black; border-collapse: collapse; ">
<col width="100"> <col width="400"> <col width="100"> <col width="100"> 


<tr>

<td colspan="1" class=tb_border>정보 : </td>
<td colspan="3"><%=bbs.getRef() %>-<%=bbs.getStep() %>-<%=bbs.getDepth() %></td>
</tr>
<tr >
<td class=tb_border>작성자 : <%=bbs.getId() %></td>

<td colspan="2" class=tb_border>작성일 : <%=bbs.getWdate() %> </td>
<td class=tb_border>조회수 : <%=bbs.getReadcount() %></td>
</tr>
<tr>
<td colspan="4">제목 : <%=bbs.getTitle() %></td>
</tr>
<tr>
<td colspan="4"><textarea rows="15" cols="100" readonly="readonly"><%=bbs.getContent() %></textarea></td>
</tr>

</table>
<button type="button" id="listBtn">목록</button>

<%
if(bbs.getId().equals(mem.getId())){
%>

	<button type="button" onclick="updateBbs(<%=bbs.getSeq()%>)">수정</button>
	<button type="button" onclick="deleteBbs(<%=bbs.getSeq()%>)">삭제</button>
<%	
}

%>

<%-- 
location.href는 seq 노출
<button type="button" onclick="answerBbs(<%=bbs.getSeq()%>)">댓글</button> --%>
<%-- 중요 데이터 감춤, submit은 테이블로 배치 --%>

<form action="answer.jsp" method="get">
	<input type="hidden" name="seq" value="<%=bbs.getSeq() %>">
	<input type="submit" value="댓글">
</form> 

</div>




<script type="text/javascript">
$(function () {
	$('#listBtn').click(function() {
		
		location.href ="bbslist.jsp";
		
	});
	
});


function updateBbs(seq) {
	location.href = "bbsupdate.jsp?seq=" + seq;
}

function deleteBbs(seq) {
	location.href = "bbsdelete.jsp?seq=" + seq;
}

</script>

</body>
</html>