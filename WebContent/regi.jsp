<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>


<style type="text/css">



</style>
</head>
<body>
<div style="width : 50%; height: 100%;margin: 0 auto; ">
<div align ="center">
<h1 align="center">회원가입</h1>
<form id="frm" method="post" action="regiAf.jsp">

ID:<input type="text" name="id" id="id" value="">
<button type="button" id="ch_id">ID 확인</button>
<br>
<p id="sc_id" align="center">중복된 아이디 확인</p>

Password:<input type="password" name="pwd" id="pwd" value=""><br><br>

Name:<input type="text" name="name" id="name" value=""><br><br>

email:<input type="text" name="email"  id="email" value="">

<br><br>

<button type="button" id="signUpBtn">회원 가입</button>

</form>
</div>
</div>

<script type="text/javascript">


$(function() {
	
	$('#signUpBtn').click(function() {
		
		
		if($("#id").val().trim() ==""){
			alert("id를 입력해주세요");
			$("#id").focus();
		}
		else if($("#pwd").val().trim() ==""){
			alert("패스워드를 입력해주세요");
			$("#pwd").focus();
		}
		else if($("#name").val().trim() ==""){
			alert("이름을 입력해주세요");
			$("#name").focus();
		}
		else if($("#email").val().trim() ==""){
			alert("이메일을 입력해주세요");
			$("#email").focus();
		}		
		else{
			$('#frm').submit();
		}
		
	});
	$('#ch_id').click(function() {
		
		$.ajax({
			
			url:"checkId.jsp",
			type:"get",
			datatype:"A",
			data:"id="+$('#id').val(),
			
			success:function(ch){
			//	alert(ch);
			
				if(ch.trim()=='yes'){
					$('#sc_id').text("중복된 ID입니다.");
					$('#id').val("");
				}
				else{
					$('#sc_id').text("사용해도되는 ID입니다.");
				}
			},
			error:function(){
				alert("송신에 실패했습니다.");
			}
			
		});		
	});
});

</script>

</body>
</html>