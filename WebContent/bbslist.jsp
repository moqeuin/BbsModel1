<%@page import="dto.BbsDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.BbsDao"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
 <%!
 // 댓글 depth와 image를 추가하는 함수  depth=1  ' '(이미지)->
 //                           depth=2  '  '(이미지)->
 public String arrow(int depth){
	 // 이미지
	 String rs ="<img src='./image/arrow.png' width='20px' height='20px'/>";
	 // 여백
	 String nbsp = "&nbsp;&nbsp;&nbsp;&nbsp;";
	 
	 String ts = "";
	 // depth만큼 여백을 추가
	 for(int i = 0; i < depth; i++){
		 ts += nbsp;
	 }
	 
	 return depth==0 ? "":ts + rs;
 }
 
 
 %>
    
<%
// 세션의 저장된 로그인한 회원의 정보를 가져온다.
Object ologin = session.getAttribute("login");
MemberDto mem = null;



//세션이 만료됐을 때
if(ologin==null){
%>
	
	<script type="text/javascript">
		alert("로그인을 해 주십시오");
		location.href ="login.jsp";
	</script>
	
<%		
}
// 세션의 회원정보 저장
mem =(MemberDto)ologin;



String sel = request.getParameter("sel");
String keyword = request.getParameter("keyword");


// 목록을 선택하지 않았을 때
if(sel == null || sel == ""){
	sel = "CHOICE";
}

// 목록에서 선택을 선택했을 때
if(sel.equals("CHOICE")){
	keyword ="";
}

// 키워드를 입력하지 않았을 때
if(keyword == null){
	sel = "CHOICE";
	keyword = "";
}





//게시판 글목록을 db에서 리스트 객체로 가져온다.
BbsDao dao = BbsDao.getInstance();

// 현재 사용자가 들어온 페이지의 번호, 처음 들어오면 null
String spageNumber = request.getParameter("pageNumber");

// 현재 페이지, null이면 pagenumber는 0 
int pageNumber = 0;

// 
if(spageNumber != null && !spageNumber.equals("")){
	pageNumber = Integer.parseInt(spageNumber);
}

System.out.println("pageNumber : " + pageNumber);

//List<BbsDto> list = dao.getBbsList(sel, keyword);
List<BbsDto> list = dao.getBbsPagingList(sel, keyword, pageNumber);

// 검색했을 때 페이지 총 갯수를 수정
int len = dao.getAllBbs(sel, keyword);
System.out.println("글의 총 갯수 : " + len);

int bbsPage = len / 10; // 예 : 12개 - > 2page
if(len % 10 > 0){ // 나머지가 남아있을 때
	bbsPage = bbsPage + 1; // -> 2
}




%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bbslist.jsp</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>



<h4 align="right" style="background-color: #f0f0f0">
	환영합니다 <%=mem.getId() %>님
</h4>
<!--  css는 ㅣli에서 수정 -->
<h1>게시판</h1>




<a href="./calendar/calendar.jsp">일정관리</a>
<a href="./pdslist.jsp">자료실</a>


<div align="center">

<table border="1">
<col width="70"><col width="600"><col width="150">
<tr>
	<th>번호</th><th>제목</th><th>작성자</th>
</tr>

<% 
if(list == null || list.size() == 0){
	%>

	<tr>
		<td colspan="3">작성된 글이 없습니다.</td>
	</tr>
<%
	
}else{
	for(int i = 0; i < list.size(); i++){
		BbsDto bbs = list.get(i);
		if(bbs.getDel() != 1){	
		
%>
	
	<tr>
	
		<th><%=i+1 %></th>
		<td>
			<%-- 여백 + 이미지 --%>
			<%=arrow(bbs.getDepth()) %>
			<%-- 제목 --%>
			<a href="bbsdetail.jsp?seq=<%=bbs.getSeq() %>">
				<%=bbs.getTitle() %>
				</a>
		</td>
		<td align="center"><%=bbs.getId() %></td>
	</tr>

<%		
		}
		else{
%>	
		<tr>
		<td colspan = "3" align="center">삭제된 글입니다.</td>
		
		</tr>
			
<% 			
		}
	}
}
%>
<tr>

</tr>
</table>

<%

// 페이지 번호 출력

for(int i = 0; i < bbsPage; i++){
	if(pageNumber == i ){  // 1 [2] [3]
		%>
		<span style="font-size: 15pt; color: #0000ff; font-weight: bold; text-decoration: none">
			<%=i+1 %>
			
		</span>&nbsp;
		
		
		<%
	}
	else{	// 그 외 페이지
		 %>
		 <a href="#none" title="<%=i+1 %>페이지" onclick="goPage(<%=i %>)"
		 	style="font-size: 15pit; color: #000; font-weight: bold; text-decoration: none">
		 	[<%=i+1 %>]
		 	</a>&nbsp;
		<%
	}
	
}

%>



</div>
<a href="bbswrite.jsp" >글쓰기</a>
<br>
<div align="center">

<form action="bbslist.jsp" method="get" id="frm">

<table width = "400">
<col width ="100"> <col width ="150"> <col width ="100">  <col width ="130">  
<tr>

<td>
<select name="sel" id="sel">
<option value="CHOICE">선택</option>
<option value="TITLE" selected="selected">제목</option>
<option value="CONTENT">내용</option>
<option value="ID">작성자</option>
</select>
</td>

<td><input type="text" value="" name="keyword" id="keyword"> </td>

<td><button type="button" id="selBtn">검색</button> </td>

</tr>
</table>
</form>


<button type="button" id="backBtn" onclick="backPage()">돌아가기</button>



</div>
<script type="text/javascript">
$(function() {
	
	$('#selBtn').click(function () {
		
		
		$('#frm').submit();
		

	});
	
	
});


let sel2 = "<%=sel %>";
let keyword2 = "<%=keyword%>";


document.getElementById("sel").value = sel2;
document.getElementById("keyword").value = keyword2;

function backPage() {
	
	location.href = "bbslist.jsp";	
};


function goPage(pageNum) {
	
	
	location.href ="bbslist.jsp?pageNumber=" + pageNum + "&sel="+sel2+"&keyword="+keyword2;
	
}
	

</script>
</body>
</html>