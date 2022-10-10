<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<c:set var="path" value="${pageContext.request.contextPath}"/>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="./resources/js/board.js" charset="UTF-8"></script>
<link rel="stylesheet" type="text/css" href="${path}/resources/board.css">
<title>Insert title here</title>
<script>
function boardDelete(userID) {
    	if('${MEMID}' != userID){
    		alert("작성자만 삭제 가능합니다.");
    		return;
    	}
	    if(!confirm("삭제하시겠습니까?")) return;
	    $.ajax({
            url : './boardDelete',
            data : $('#Frm').serialize(),
            type : "POST",
            success : function(result) {     
                //alert(result.success);
                alert(result.message);
                location.href = "./";
            },
            error : function(error) {   
                alert(error);    
            }
        });
    }
function boardGoUpdate(userId,boardNo,updateId){
/* 	if('${MEMID}' != userId && '${MEMAUTHORITY}'!= '관리자' && '${MEMID}' != updateId){
		alert("작성자만 수정 가능합니다.");
		return;
	} */
	location.href='${path}/goUpdate?boardno='+boardNo
}    
    
</script>
</head>
<body>
<h1>게시글 상세페이지</h1>
<div class="container">
	<form id="Frm" name="Frm" method="post">
		<input type="hidden" name="board.notice_YN" value="${board.notice_YN}">
		<input type="hidden" name="boardno" value="${board.boardno}">
	<div class="row">
			<label>작성자 아이디 : ${board.userId}</label><br>
	</div>	
	<div class="row">
			<label>이름 : ${board.userName} </label><br>
	</div>	
	<div class="row">
			<label>작성 일자 : ${board.writeDate} </label><br>
	</div>	
	<div class="row">
			<label>수정 일자 : ${board.updateDate} </label><br>
	</div>	
	<div class="row">
			<label>공지 등록 : ${board.notice_YN} </label><br>
	</div>	
	
	<div class="row">
		<div class="col-25">
			<label>제목 : </label>	
		</div>	
		<div class="col-75">
			<input type="text" name="boardTitle" value="${board.boardTitle}" readonly><br><br>
		</div>
	</div>	
		<div class="row">
		<div class="col-25">
			<label>내용 : </label>
		</div>
		<div class="col-75">
			<textarea name="boardContents" style="height:200px" readonly>${board.boardContents}</textarea><br><br>
		</div>
	</div>	
	<c:if test="${board.contentReply!=null}">
		<div class="row">
			<div class="col-25">
				<label>내용 답글 : </label>
			</div>
			<div class="col-75">
					<textarea name="contentReply" style="height:200px" readonly>${board.contentReply}</textarea><br><br>
			</div>
		</div>	
	</c:if>
	</form>
	<button type="button" class="button" onclick="boardGoUpdate('${board.userId}','${board.boardno}','${board.updateId}')">수정</button>
	<button type="submit" class="button" onclick="boardDelete('${board.userId}')">삭제</button>
	<button type="button" class="button" onclick="location.href='${path}/'">리스트로 이동</button>
	
</div>
</body>
</html>