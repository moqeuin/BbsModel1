<%@page import="dto.PdsDto"%>
<%@page import="dao.PdsDao"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
MemberDto mem = (MemberDto) session.getAttribute("login");


int seq = Integer.parseInt(request.getParameter("seq"));

PdsDao pdao = PdsDao.getInstance();
PdsDto pdto = pdao.getPds(seq);


if(!mem.getId().equals(pdto.getId())){
	
	pdao.readCount(seq);
}


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h1>게시물 상세정보</h1>


<%=pdto.getTitle() %>
<div align="center"> 													
 													
<form action="" method="post">



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
		<input type="text" name="title"  value="<%=pdto.getTitle() %>" readonly="readonly">
		
	</td>
</tr>

<tr>

	<th>파일 다운로드</th>
	<td colspan="2">
		<input type="button"  value="다운로드" style="width:100px"
		  onclick="location.href='filedown?filename=<%=pdto.getFilename()%>&seq=<%=pdto.getSeq()%>'">
	</td>
</tr>

<tr>

	<th>내용</th>
	<td>
		<textarea rows="20" cols="50" name="content" readonly="readonly"><%=pdto.getContent() %></textarea>
	</td>
</tr>

<%
if(mem.getId().equals(pdto.getId())){

%>


<tr align="center">

	<td colspan="2" >
		<button type="button" id="updateBtn" onclick="updateFunc()">수정</button>
		<button type="button" id="deleteBtn" onclick="deleteFunc()">삭제</button>
	</td>

</tr>

<%
}
%>
</table>


</form>

</div>


<script type="text/javascript">


let seq = "<%=pdto.getSeq() %>";

function updateFunc(){
	
	location.href = "pdsupdate.jsp?seq=" + seq;
	
}

function deleteFunc(){
	
	location.href = "pdsdelete.jsp?seq=" + seq;
	
}




</script>




</body>
</html>