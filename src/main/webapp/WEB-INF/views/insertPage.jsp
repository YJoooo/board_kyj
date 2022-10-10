<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<script src="http://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="./resources/js/board.js" charset="UTF-8"></script>
<link rel="stylesheet" type="text/css" href="${path}/resources/board.css">
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
<h1>게시글 등록</h1>
<div class="container">
	<form id="insertFrm" name="insertFrm" action="${path}/boardInsert" method="post">
	<div class="row">
		<div class="col-25">
			<label>공지등록 : </label>
		</div>
		<div class="col-75">
			<input type="radio" name="notice_YN" value="Y">예 <input type="radio" name="notice_YN" value="N" checked>아니오<br>
		</div>
	</div>	
	<div class="row">
		<div class="col-25">
			<label>작성자아이디 : </label>
		</div>
		<div class="col-75">
			<input type="text" name="userId" value="${MEMID}" readonly><br>
		</div>
	</div>
	<div class="row">
		<div class="col-25">
			<label>이름 : </label>
		</div>
		<div class="col-75">
			<input type="text" name="userName" value="${MEMNAME}" readonly><br>
		</div>
	</div>
	<div class="row">
		<div class="col-25">
			<label>작성일자 : </label>
		</div>
		<div class="col-75">
			<input type="date" name="writeDate"><br>
		</div>
	</div>
	<div class="row">
		<div class="col-25">
			<label>제목 : </label>
		</div>
		<div class="col-75">
			<input type="text" name="boardTitle"><br>
		</div>
	</div>	
	<div class="row">
		<div class="col-25">
			<label>내용 :</label>
		</div> 
		<div class="col-75">
			<textarea name="boardContents" style="height:200px"></textarea><br><br>
		</div>
	</div>	
		<button type="button" class="button" id="boardInsert">등록완료</button>
		<button type="button" class="button" onclick="location.href='${path}/'">리스트로 이동</button>
	</form>
</div>
</body>
</html>