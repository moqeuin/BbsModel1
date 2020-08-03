<%@page import="java.util.Date"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
MemberDto mem =(MemberDto)session.getAttribute("login");

// 시간을 취득 -> 파일명

String fname = (new Date().getTime() +"") ;
System.out.println(fname);

// myifile.text -> 1596421349363.txt
// db -> myifile, 1596421349363.txt
// 다운로드 1596421349363.txt -> 다운로드 후 myfile.txt로 변경 , 확장자 명도 바꿈

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>pdswrite.jsp</title>
</head>
<body>

<h1>자료 올리기</h1>
<%--

	id -> String		form field data
	title -> String
	content -> String
	
	
	file -> byte
 
 													multipart = String, byte유형에 송신데이터를 나눔		--%>
 													
 													
<div align="center"> 													
 													
<form action="pdsupload.jsp" method="post" enctype="multipart/form-data">

<input type="hidden" name="work" value="write">

<table border="1">
<col width="200"> <col width="500">

<tr>
	
	<th>아이디</th>
	<td>
		<input type="text" name="id" value="<%=mem.getId()%>" readonly="readonly">
	</td>
		
</tr>

<tr>

	<th>제목</th>
	<td>
		<input type="text" name="title" size="50">
	</td>
</tr>

<tr>

	<th>파일 업로드</th>
	<td>
		<input type="file" name="fileload" style="width:400px">
	</td>
</tr>

<tr>

	<th>내용</th>
	<td>
		<textarea rows="20" cols="50" name="content"></textarea>
	</td>
</tr>


<tr align="center">

	<td colspan="2">
		<input type="submit" value="올리기">
	</td>
</tr>
</table>


</form>

</div>


</body>
</html>