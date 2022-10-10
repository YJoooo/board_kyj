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
</head>
<script>
window.onload = function(){
	 document.querySelector("#Frm input[value='${user.gender}']").setAttribute('checked' , true);
}

//수정 button
function boardUpdate(userID) {
	if('${MEMID}' != userID){
		alert("작성자만 수정 가능합니다.");
		return;
	}
    if(!confirm("수정하시겠습니까?")) return;
    var boardno = $('#boardno').val();
    $.ajax({
        url : './boardUpdate',
        data : $('#Frm').serialize(),
        type : "POST",
        success : function(result) {     
            //alert(result.success);
            alert(result.message);
            location.href = "./boardDetail?boardno="+boardno;
        },
        error : function(error) {     
            alert(error);    
        }
    }); 
}
</script>
<body>
<h1>회원정보 수정</h1>
<div class="container">
	<form id="Frm" name="Frm" action="${path}/userUpdate" method="post">
	<div class="row">
		<div class="col-25">
			<label>아이디 : </label>
		</div>
		<div class="col-75">
			<input type="text" name="userId" id="userId" value="${user.userId}" readonly><br>
		</div>
	</div>	
	<div class="row">
		<div class="col-25">
			<label>비밀번호 : </label>
		</div>
		<div class="col-75">
			<input type="text" name="userPass" value="${user.userPass}" readonly><br>
		</div>
	</div>
	<div class="row">
		<div class="col-25">
			<label>이름 : </label>
		</div>
		<div class="col-75">
			<input type="text" name="userName" value="${user.userName}"><br>
		</div>
	</div>
	<div class="row">
		<div class="col-25">
			<label>이메일 : </label>
		</div>
		<div class="col-75">
			<input type="text" name="email" value="${user.email}"><br>
		</div>
	</div>
	<div class="row">
		<div class="col-25">
			<label>휴대폰번호 : </label>
		</div>
		<div class="col-75">
			<input type="text" name="telephone" value="${user.telephone}"><br>
		</div>
	</div>
	<div class="row">
		<div class="col-25">
			<label>성별 : </label>
		</div>
		<div class="col-75">
			<input type="radio" name="gender" value="남성" readonly>남성
			<input type="radio" name="gender" value="여성" readonly>여성<br>
		</div>
	</div>	
	<div class="row">
		<div class="col-25">
			<label>권한 : </label>
		</div>
		<div class="col-75">
		<c:if test="${MEMAUTHORITY=='일반사용자'}">
			<input type="text"name="authority"  value="${user.authority}" readonly>
		</c:if>
		<c:if test="${MEMAUTHORITY=='관리자'}">
			<select name="authorityUpdate">
				<option value="일반사용자">일반사용자</option>
				<option value="관리자">관리자</option>
			</select>
		</c:if>
		</div>
	</div>	
	
	<div class="row">
		<div class="col-25">
			<label>주소 :</label>
		</div> 
		<div class="col-75">
			<button type="button" id="addressSearch" onclick="execDaumPostcode()">우편번호 찾기</button>
			<input type="text" id="userZipcode" placeholder="우편번호">
			<input type="text" id="userAddress"placeholder="주소" value="${user.address}">
			<input type="text" id="extraAddress" placeholder="참고항목">
			<input type="text" id="detailAddress" placeholder="상세주소">
			<input type="hidden" name="address" id="address" value="${user.address}">
		</div>
	</div>
	<div class="btn">	
		<button type="button" class="button" id="userUpdate">수정완료</button>
		<button type="button" class="button" onclick="location.href='${path}/userList'">리스트로 이동</button>
	</div>
	</form>
</div>

</body>
</html>