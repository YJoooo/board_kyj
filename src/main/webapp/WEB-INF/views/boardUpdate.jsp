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
<script>
window.onload = function(){
	 document.querySelector("#Frm input[value='${board.notice_YN}']").setAttribute('checked' , true);
}
</script>
<body>
<h1>게시글 수정</h1>
<div class="container">
	<form id="Frm" name="Frm" action ="./boardUpdate"method="post">
		<input type="hidden" name="boardno" id="boardno" value="${board.boardno}">
		<input type="hidden" name="registId" value="${MEMID}">
		<input type="hidden" name="updateId" value="${MEMID}">
	<div class="row">
		<div class="col-25">
			<label>아이디 : </label>
		</div>
		<div class="col-75">
			<input type="text" name="userId" value="${board.userId}" readonly><br>
		</div>
	</div>	
	<div class="row">
		<div class="col-25">
			<label>이름 : </label>
		</div>
		<div class="col-75">
			<input type="text" name="userName" value="${board.userName}" readonly><br>
		</div>
	</div>	
	<div class="row">
		<div class="col-25">
			<label>작성일자 : </label>
		</div>
		<div class="col-75">
			<input type="date" name="writeDate" value="${board.writeDate}"><br>
		</div>
	</div>
	<div class="row">
		<div class="col-25">
			<label>공지등록 : </label>
		</div>
		<div class="col-75">
			<input type="radio" name="notice_YN" value="Y">예
			<input type="radio" name="notice_YN" value="N" checked>아니오<br>
		</div>
	</div>	
	<div class="row">
		<div class="col-25">
			<label>제목 : </label>
		</div>
		<div class="col-75">
			<input type="text" name="boardTitle" value="${board.boardTitle}"><br>
		</div>
	</div>	
	<div class="row">
		<div class="col-25">
			<label>내용 : </label>
		</div>
		<div class="col-75">
			<textarea name="boardContents" style="height:200px">${board.boardContents}</textarea><br>
		</div>
	</div>	
	<div class="row">
		<div class="col-25">
			<label>내용 답글 : </label>
		</div>
		<div class="col-75">
			<textarea name="contentReply" style="height:200px"></textarea><br>
		</div>
	</div>	
		
	</form>
	<button type="button" class="button" id = "boardUpdate">수정완료</button>
	<button type="submit" class="button" id = "boardDelete2">삭제</button>
	<button type="button" class="button" onclick="location.href='./'">리스트로 이동</button>
	
</div>
</body>
</html>