<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>       
    <c:set var="path" value="${pageContext.request.contextPath}"/> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<script src="http://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="${path}/resources/js/user.js" charset="UTF-8"></script>
	<link rel="stylesheet" type="text/css" href="${path}/resources/board.css">

<title>Insert title here</title>
<script>
$(document).ready(function() {
	// 아이디 유효성 검사
	$('.userId').focusout(function(){
		var userId = $('.userId').val(); // userId에 입력되는 값
		if(userId==""||userId==null){
			$("#checkId").html('아이디를 입력해주세요.');
			$("#checkId").attr('color','red');
			return;
		}
		
		$.ajax({
			url : "./checkId",
			type : "post",
			data : $('#insertFrm').serialize(),
			success : function(data){
				if(data.result == 1){
					$("#checkId").html('이미 존재하는 아이디입니다.');
					$("#checkId").attr('color','red');
				} else{
					$("#checkId").html('사용 가능한 아이디입니다.');
					$("#checkId").attr('color','green');
				} 

			},
			error : function(request, status, error){
				alert("서버요청실패");
				alert("status : " + request.status + ", message : " + request.responseText + ", error : " + error);
			}
		})
		 
	})
	// 비밀번호, 비밀번호확인 일치여부 체크
	$('.userPass').focusout(function(){
		var userPass = $('#userPass').val();
		var userPassCheack = $('#userPassCheack').val();
		if(userPass==""||userPass==null){
			$("#checkPass").html('비밀번호를 입력해주세요.');
			$("#checkPass").attr('color','red');
			return false;
		}
   	  if(!/^[a-zA-Z0-9]{8,16}$/.test(userPass)){
		$("#checkPass").html('숫자와 영문자 조합으로 8~16자리를 사용해야 합니다.');
		$("#checkPass").attr('color','red');
   	    return false;
   	  }

   	  var checkNum = userPass.search(/[0-9]/g); // 숫자사용
   	  var checkEng = userPass.search(/[a-z]/ig); // 영문사용

   	  if(checkNum <0 || checkEng <0){
  		$("#checkPass").html('숫자와 영문자 조합으로 사용해야 합니다.');
		$("#checkPass").attr('color','red');
   	    return false;
   	  }
		if(userPass!=userPassCheack){
			$("#checkPass").html('비밀번호가 일치하지 않습니다.');
			$("#checkPass").attr('color','red');
			return;
		}else{
			$("#checkPass").html('비밀번호가 일치합니다.');
			$("#checkPass").attr('color','green');
		}

	})
	// 이름 유효성 검사
	$('#userName').focusout(function(){
		var userName = $("#userName").val();
		if(userName==""||userName==null){
			$("#checkName").html('이름을 입력해주세요.');
			$("#checkName").attr('color','red');
			return false;
		}
		var n_RegExp = /^[가-힣]{2,15}$/;
		if(!n_RegExp.test(userName)){
			$("#checkName").html('한글만 입력 가능합니다.');
			$("#checkName").attr('color','red');
		}else{
			$("#checkName").html('');
		}
	});

	// 이메일형식 유효성검사
	$('#email').focusout(function(){
 	var emailVal = $("#email").val();
	if(emailVal==""||emailVal==null){
		$("#checkEmail").html('이메일을 입력해주세요.');
		$("#checkEmail").attr('color','red');
		return false;
	}
  	var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

	  if (emailVal.match(regExp) != null) {
			$("#checkEmail").html('이메일 인증이 완료되었습니다.');
			$("#checkEmail").attr('color','green');

	  }
	  else {
		$("#checkEmail").html('이메일형식이 잘못되었습니다.');
		$("#checkEmail").attr('color','red');

	  }
	});
	// 전화번호 유효성 검사
	$('#telephone').focusout(function(){
		var telephone = $("#telephone").val();
		if(telephone.length==13||telephone.length==12||telephone.length==11){
			$("#checkTel").html('');
		}else{
			$("#checkTel").html('전화번호 형식이 잘못되었습니다.');
			$("#checkTel").attr('color','red');
		}
	});  
	
});
// 전화번호 자동 하이픈 , 문자 입력 불가
$(document).on("keyup", "#telephone", function() { 
	$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") );
});
</script>
</head>
<body>
<h1>회원가입</h1>
<div class="container_user">
	<form id="insertFrm" name="insertFrm" action="${path}/userInsert" method="post">
	<div class="row">
		<div class="col-25_user">
			<label>아이디 : </label>
		</div>
		<div class="col-75_user">
			<input type="text" name="userId" class="userId"><br>
			<font id="checkId" size="2"></font>
		</div>
	</div>	
	<div class="row">
		<div class="col-25_user">
			<label>비밀번호 : </label>
		</div>
		<div class="col-75_user">
			<input type="text" class = userPass name="userPass" id="userPass"><br>
		</div>
	</div>
	<div class="row">
		<div class="col-25_user">
			<label>비밀번호 확인 : </label>
		</div>
		<div class="col-75_user">
			<input type="text" class = userPass name="userPassCheack" id="userPassCheack"><br>
			<font id="checkPass" size="2"></font>
		</div>
	</div>
	
	<div class="row">
		<div class="col-25_user">
			<label>이름 : </label>
		</div>
		<div class="col-75_user">
			<input type="text" name="userName" id= "userName"><br>
			<font id="checkName" size="2"></font>
		</div>
	</div>
	<div class="row">
		<div class="col-25_user">
			<label>이메일 : </label>
		</div>
		<div class="col-75_user">
			<input type="text" name="email" id="email"><br>
			<font id="checkEmail" size="2"></font>
		</div>
	</div>
	<div class="row">
		<div class="col-25_user">
			<label>휴대폰번호 : </label>
		</div>
		<div class="col-75_user">
			<input type="text" name="telephone" id="telephone"><br>
			<font id="checkTel" size="2"></font>
		</div>
	</div>
	<div class="row">
		<div class="col-25_user">
			<label>성별 : </label>
		</div>
		<div class="col-75_user">
			<input type="radio" name="gender" id="male"value="남성">남성
			<input type="radio" name="gender" id="female" value="여성">여성<br>
			<font id="checkGender" size="2"></font>
		</div>
	</div>	
	<div class="row">
		<div class="col-25_user">
			<label>주소 :</label>
		</div> 
		<div class="col-75_user">
			<button type="button" id="addressSearch" onclick="execDaumPostcode()">우편번호 찾기</button>
			<input type="text" id="userZipcode" placeholder="우편번호" readonly>
			<input type="text" id="userAddress"placeholder="주소" readonly>
			<input type="text" id="extraAddress" placeholder="참고항목" readonly>
			<input type="text" id="detailAddress" placeholder="상세주소">
			<input type="hidden" name="address" id="address" >
			<font id="checkAddress" size="2"></font>
		</div>
	</div>	
	<div class="btn">
		<button type="button" class="button_user" id="userInsert">가입완료</button>
		<button type="button" class="button_user" onclick="location.href='${path}/'">메인이동</button>
	</div>	
	</form>
</div>

</body>
</html>