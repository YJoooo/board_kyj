<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>       
    <c:set var="path" value="${pageContext.request.contextPath}"/> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<script src="http://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script src="${path}/resources/js/user.js" charset="UTF-8"></script>
	<link rel="stylesheet" type="text/css" href="${path}/resources/board.css">

<title>Insert title here</title>
<script type="text/javascript">
function updatePassInput(){
	if($("#dis").css("display") == "none"){
	    $("#dis").show();
	    $("#dis2").show();
	} else {
	    $("#dis").hide();
	    $("#dis2").hide();
	}
}
/* function updatPass(){
	var userPass = $('input[name=userPass]').val();
	if(userPass==""||userPass==null){
		alert("변경할 비밀번호를 입력해주세요")
		return;
	}
	if(!confirm("수정하시겠습니까?")) return;
    $.ajax({
        url : './userPassUpdate',
        data : $('#Frm').serialize(),
        type : "POST",
        success : function(result) {
            alert(result.message);
            location.reload();
        },
        error : function(error) {     
            alert(error);    
        }
    }); */
   function checkPassword(password){
	   var userPass = $('input[name=userPass]').val();
		if(userPass==""||userPass==null){
			alert("변경할 비밀번호를 입력해주세요")
			return;
		}
   	  if(!/^[a-zA-Z0-9]{8,16}$/.test(userPass)){
   	    alert('숫자와 영문자 조합으로 8~16자리를 사용해야 합니다.');
   	    return false;
   	  }

   	  var checkNum = userPass.search(/[0-9]/g); // 숫자사용
   	  var checkEng = userPass.search(/[a-z]/ig); // 영문사용

   	  if(checkNum <0 || checkEng <0){
   	    alert("숫자와 영문자를 조합하여야 합니다.");
   	    return false;
   	  }
   	  
   	  
   if(!confirm("수정하시겠습니까?")) return;
   $.ajax({
       url : './userPassUpdate',
       data : $('#Frm').serialize(),
       type : "POST",
       success : function(result) {
           alert(result.message);
           location.reload();
       },
       error : function(error) {     
           alert(error);    
       }
   });
}
</script>
</head>
<body>
<c:if test="${MEMID==user.userId}">
	<h1>마이페이지</h1>
</c:if>
<c:if test="${MEMID!=user.userId}">
	<h1>회원정보 조회</h1>
</c:if>
<div class="container_mypage">
	<form id="Frm" name="Frm" method="post">
		<input type="hidden" name="userId" value="${user.userId}">
	<div class="row">
			<label>아이디 : ${user.userId}</label><br>
	</div>	
	<div class="row">
			<label>비밀번호 : ${user.userPass} </label>
			<button type="button" class="button_home" onclick="updatePassInput()">비밀번호변경</button><br>
			<input type="text" name="userPass" id="dis" style="display:none; width:75%">&nbsp<button type="button" id="dis2" class="button_home" style="display:none;"onclick="checkPassword()">변경완료</button>
	</div>	
	<div class="row">
			<label>이름 : ${user.userName} </label><br>
	</div>	
	<div class="row">
			<label>권한 : ${user.authority} </label><br>
	</div>	
	<div class="row">
			<label>이메일 : ${user.email} </label><br>
	</div>	
	<div class="row">
			<label>휴대전화번호 : ${user.telephone} </label><br>
	</div>
	<div class="row">
		<label>성별 : ${user.gender} </label><br>
	</div>	
	<div class="row">
			<label>주소 : ${user.address} </label><br>
	</div>	
	<div class="row">
			<label>등록일 : ${user.userRegistDate} </label><br>
	</div>	
	</form>
	<div class="btnDiv">
		<button type="button" class="button_home" onclick="location.href='${path}/userUpdatePage?userId=${user.userId}'">수정</button>
		<c:if test="${MEMAUTHORITY=='일반사용자'}">
		<button type="submit" class="button_home" id="userDelete">회원탈퇴</button>
		</c:if>
		<c:if test="${MEMAUTHORITY=='관리자'}">
			<button type="submit" class="button_home" id="userMasterDelete">회원삭제</button>
		</c:if>
		<button type="button" class="button_home" onclick="location.href='${path}/'">메인으로 이동</button>
	</div>
</div>


</body>
</html>