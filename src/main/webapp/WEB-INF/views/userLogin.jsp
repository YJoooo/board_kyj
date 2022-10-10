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
	<link rel="stylesheet" type="text/css" href="${path}/resources/board.css?version=1">
	

<title>Insert title here</title>

</head>
<body>
<h1>로그인</h1>
<div class="container_user">
		<form id="loginFrm" name="loginFrm" action="${path}/loginCheck" method="post">
		<div class="row">
			<div class="col-25_user">
				<label>아이디 : </label>
			</div>
			<div class="col-75_user">
				<input type="text" name="userId" id="userId"><br>
			</div>
		</div>	
		<div class="row">
			<div class="col-25_user">
				<label>비밀번호 : </label>
			</div>
			<div class="col-75_user">
				<input type="password" name="userPass" id="userPass"><br>
			</div>
		</div>
		<div style="text-align: center;">
		<c:if test="${msg == '실패'}">
			<a style="text-align: center; color:red;">아이디 또는 패스워드가 틀렸습니다. <br>다시 입력해주세요</a>
		</c:if>
		</div>
		<div class="btn">
			<button type="submit" class="button_user" id="userLogin">로그인</button>
			<button type="button" class="button_user" onclick="location.href='${path}/userInsertPage'">회원가입</button>
			<button type="button" class="button_user" onclick="location.href='${path}/'">메인이동</button>
		</div>	
		</form>
</div>

</body>
</html>