<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>LoginView</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

<!-- <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script> -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="http://lab.alexcican.com/set_cookies/cookie.js" type="text/javascript" ></script>

<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>


<style>
body {
	font-family: 'Varela Round', sans-serif;
}
.modal-login {
	width: 350px;
}

.modal-login .modal-title{

	color :#ffffff;
	font-size: 2em;
}


.modal-login .modal-content {
	padding: 20px;
	border-radius: 1px;
	border: none;
	background-color: #336699;
}
.modal-login .modal-header {
	border-bottom: none;
	position: relative;
	justify-content: center;
}
.modal-login h4 {
	text-align: center;
	font-size: 26px;
}
.modal-login .form-group {
	margin-bottom: 20px;
}
.modal-login .form-control, .modal-login .btn {
	min-height: 40px;
	border-radius: 30px; 
	font-size: 15px;
	transition: all 0.5s;
}
/*                텍스트  필드    평상시       */
.modal-login .form-control {
	font-size: 13px;
}
/*                텍스트 필드       포커스가 됐을 때        */
.modal-login .form-control:focus {
    /* 윤곽선의 색상 */
	border-color: #ff9900;
}
.modal-login .hint-text {
	text-align: center;
	padding-top: 10px;
	
}
.modal-login .close {
	position: absolute;
	top: -5px;
	right: -5px;
}
.modal-login .btn, .modal-login .btn:active {
	border: none;
	background: #ff9900 !important;
	line-height: normal;
}
.modal-login .btn:hover, .modal-login .btn:focus {
	background: #e68a00 !important;
}
.modal-login .hint-text a {
	color: #ffffff;
}
.trigger-btn {
	display: inline-block;
	margin: 100px auto;
}
</style>
</head>
<body>

<div class="text-center">
	<!-- Button HTML (to Trigger Modal) -->
	<a href="#myModal" class="trigger-btn" data-toggle="modal">Click to Open Login</a>
</div>

<div id="myModal" class="modal fade">
	<div class="modal-dialog modal-login">
		<div class="modal-content">
			<div class="modal-header">				
				<h4 class="modal-title">Sign in</h4>
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			</div>
			<div class="modal-body">
			
				<form method="post" id="frm">
					
					
					<!-- required 공백일 경우 메세지 출력, 제이쿼리가 아닌 html에서만 체크하기 때문에 제이쿼리로 submit을 하면 작동을 하지 않는다 -->
					<!-- 아이디  -->
					
					<div class="form-group">
						<input type="text" class="form-control" placeholder="Username" required="required" id="id" name="id" value="">
						<input type="checkbox" id="chk_save_id"> <font color="white" >save id</font>
					</div>
					
					<!-- 패스워드 -->
					
					<div class="form-group">
						<input type="password" class="form-control" placeholder="Password" required="required" id="pwd" name="pwd" value="123">
					</div>
					<!--  submit -->
					<div class="form-group">
						<!-- <input type="submit" class="btn btn-primary btn-block btn-lg" value="Sign in"> -->
						<input type="button" id="_btnLogin" class="btn btn-primary btn-block btn-lg" value="login">
					</div>
					
				</form>		
						
				<p class="hint-text small"><a href="#">Forgot Your Password?</a></p>
				<p class="hint-text small"><a href="regi.jsp">Register Here</a></p>
			</div>
		</div>
	</div>
</div> 

<script type="text/javascript">


// 1) 쿠키를 불러와서 저장이 됐는지 확인

// user_id라는 쿠키를 불러오고 user_id 변수에 저장
let user_id = $.cookie("user_id");

//저장된 cookie가 있을 때
if(user_id!= null){ 			  
	
	// 텍스트필드에 cookie에 저장된 데이터를 채움
	$('#id').val(user_id); 
	// 체크박스를 체크
	$('#chk_save_id').attr("checked","checked"); 
	
}
$("#_btnLogin").click(function() {
	// ID 공백확인
	if($('#id').val().trim()==""){
		alert("id를 입력해 주십시오");
		$('#id').focus();
	}
	// 패스워드  공백 확인
	else if($('#pwd').val().trim()==""){
		alert("pwd를 입력해 주십시오");
		$('#pwd').focus();
	}
	// 공백이 없으면 loginAf.jsp로 이동하면서 입력한 데이터를 전달한다.
	else{
		
		$('#frm').attr("action","loginAf.jsp").submit();
	}
});
// 아이디 저장 체크박스를 눌렀을 때
$('#chk_save_id').click(function() {
	//체크되었을 때
	if($('#chk_save_id').is(":checked")){ 

		// cookie 저장
		
		// id란이 공백일 때
		if($('#id').val().trim() == ""){
			alert("id를 입력해주십시오");
			// 체크박스 해제
			$("#chk_save_id").prop("checked",false);
		}
		// id란이 입력되었을 때
		else{
			// 쿠키 저장 (쿠키명,쿠키의 데이터,기한)
			// 쿠기한설정, 7일이 지나면 체크해서 저장한 id 삭제 (-1이면 무한대)
			$.cookie("user_id", $('#id').val().trim(), {expires:7, path:'/'});
		}
	}
	else{
		// cookie 삭제	
		
		$.removeCookie("user_id", {path:'/'});
	}
});

</script>

    
</body>
</html>