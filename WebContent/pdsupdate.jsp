
<%@page import="dto.MemberDto"%>
<%@page import="dto.PdsDto"%>
<%@page import="dao.PdsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 

<%
MemberDto mem = (MemberDto) session.getAttribute("login");


int seq = Integer.parseInt(request.getParameter("seq"));

PdsDao pdao = PdsDao.getInstance();
PdsDto pdto = pdao.getPds(seq);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


<h1>게시물 수정페이지</h1>



<div align="center"> 													
 													
<form action="pdsupdateAf.jsp" method="post" enctype="multipart/form-data">


<input type="hidden" name="work" value="update">
<input type="hidden" name="seq" value="<%=pdto.getSeq()%>">

<table border="1">
<col width="200"> <col width="500">

<tr>
	
	<th>아이디</th>
	<td >
		<input type="text" name="id" value="<%=mem.getId()%>" readonly="readonly">
	</td>
		
</tr>

<tr>
	<th>
	정보
	
	
	</th>
	<td>
	조회수:&nbsp;&nbsp;<%=pdto.getReadcount() %>
	다운로드수:&nbsp;&nbsp;<%=pdto.getDowncount() %>
	게시날짜:&nbsp;&nbsp;<%=pdto.getRegdate() %>
	</td>
	
</tr>

<tr>

	<th>제목</th>
	<td>
		<input type="text" name="title" size="50" value=<%=pdto.getTitle() %> >
	</td>
</tr>

<tr>

	<th>업로드한 파일 </th>
	<td colspan="2">
		  		<input type="text" name="oldfile" style="width:400px" value="<%=pdto.getFilename()%>">	  
	</td>
</tr>


<tr>

	<th>업로드 파일 변경 </th>
	<td colspan="2">
		  		<input type="file" name="fileload" style="width:400px">	  
	</td>
</tr>

<tr>

	<th>내용</th>
	<td>
		<textarea rows="20" cols="50" name="content"><%=pdto.getContent() %></textarea>
	</td>
</tr>

<tr align="center">

	<td colspan="2">
		<input type="submit" value="수정완료">
	</td>
</tr>


</table>


</form>

</div>

</body>
</html>