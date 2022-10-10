<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>


<html>
<head>
	<script src="http://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script src="${path}/resources/js/board.js" charset="UTF-8"></script>
	<script src="${path}/resources/js/user.js" charset="UTF-8"></script>
	<link rel="stylesheet" type="text/css" href="${path}/resources/board.css">

	<title>Home</title>
<script>
function boardWrite() {
	if('${MEMID}'==''||'${MEMID}'==null){
		alert("로그인해주세요");
	}else{
		location.href='./goInsert';
	}
}
function boardDetail(boardno) {
	if('${MEMID}'==''||'${MEMID}'==null){
		alert("로그인해주세요");
	}else{
		location.href='${path}/boardDetail?boardno='+boardno;
	}
}
</script>	
</head>
<body>
<h1 style="margin-top:10px">
	게시판
</h1>

	<div class="contain">
		<c:if test="${MEMID!=null}">
			<h4 style="text-align: right;">${MEMID}님 환영합니다.</h4>
		</c:if>
		<form id= "frm" name="frm" method="post" action="${path}/">
			<div style="float:left; width:65%" >
				<select style="width:20%;" id="userListSearchPeriod" name="userListSearchPeriod">
					<option value="">검색조건</option>
					<option value="userName" <c:if test="${userListSearchPeriod eq 'userName'}">selected</c:if>>이름</option>
					<option value="userId" <c:if test="${userListSearchPeriod eq 'userId'}">selected</c:if>>아이디</option>
					<option value="boardTitle" <c:if test="${userListSearchPeriod eq 'boardTitle'}">selected</c:if>>제목</option>
					<option value="boardContents" <c:if test="${userListSearchPeriod eq 'boardContents'}">selected</c:if>>내용</option>
				</select>
				<input style="width:50%;" type="text" class="SearchWord" id="userListSearchWord" name="userListSearchWord" value="${userListSearchWord}">
				<button id="sch_button" class="button_sch">검색</button>
			</div>
		</form>
		<div style="margin-bottom:5px; float:right;">
			<c:if test="${MEMID!=null}">
				<button type="button" class="button_home" onclick="location.href='${path}/userDetail?userId=${MEMID}'">마이페이지</button>&nbsp;
				<button type="button" class="button_home" onclick="location.href='${path}/logout'">로그아웃</button>
				<c:if test="${MEMAUTHORITY=='관리자'}">
					<button type="button" class="button_home" onclick="location.href='${path}/userList'">회원 리스트</button>
				</c:if>
			</c:if>
			<c:if test="${MEMID==null}">
				<button type="button" class="button_home" onclick="location.href='${path}/userLoginPage'">로그인</button>&nbsp;
				<button type="button" class="button_home" onclick="location.href='${path}/userInsertPage'">회원가입</button>
			</c:if>
		</div>
		
		<table>
			<thead>
				<tr>
					<th><input type="checkbox" onclick="selectAll(this)"></th>
					<th width="5%">순번</th>
					<th width="5%">아이디</th>
					<th width="7%">이름</th>
					<th width="15%">제목</th>
					<th width="20%">내용</th>
					<th width="10%">작성일자</th>
					<th width="10%">등록날짜</th>
					<th width="10%">수정날짜</th>
					<th width="9%">등록IP</th>
					<th width="9%">수정IP</th>
				</tr>
			</thead>
			<tbody>
		    	<c:forEach items="${boardList}" var="b">
		    	<tr ondblclick="boardDetail('${b.boardno}')">
		    		<td ondblclick='event.cancelBubble=true;'><input type="checkbox" name="check" value="${b.boardno}"></td>
		    		<td>${b.cnt}</td>
		    		<td>${b.userId}</td>
		    		<td>${b.userName}</td>
		    		<td><c:if test="${b.notice_YN == 'Y'}"><a style="display:inline">[공지] </a></c:if>${b.boardTitle}</td>
		    		<c:if test="${b.contentReply==null}">
		    			<td>${b.boardContents}</td>
		    		</c:if>
	    			<c:if test="${b.contentReply!=null}">
		    			<td><img src="resources/image/답글.png" width="20px" height="20px"/>${b.boardContents}</td>
		    		</c:if>
		    		<td>${b.writeDate}</td>
		    		<td>${b.registDate}</td>
		    		<td>${b.updateDate}</td>
		    		<td>${b.registIp}</td>
		    		<td>${b.updateIp}</td>
	    		</tr>
		    	</c:forEach>
		    </tbody>
		</table>
		<div style="text-align: center; margin-top:10px;">
			​<div class="pagination">
			    <c:if test="${paging.prev}">
			        <span><a href='<c:url value="./?page=${paging.startPage-1}"/>'>이전</a></span>
			    </c:if>
			    <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="memoNum">
			        <span>
			        	<c:choose>
			        	<c:when test="${paging.cri.page == memoNum}">
			          <a class="active" href="#">${memoNum}</a>
			        	</c:when>
			        	<c:otherwise>
			          <a href='<c:url value="./?page=${memoNum}&userListSearchPeriod=${userListSearchPeriod}&userListSearchWord=${userListSearchWord}"/>'>${memoNum}</a>
			        	</c:otherwise>
			        	</c:choose>
			        </span>
			    </c:forEach>
			    <c:if test="${paging.next && paging.endPage>0}">
			        <span><a href='<c:url value="./?page=${paging.endPage+1}"/>'>다음</a></span>
			    </c:if>
			</div>
		</div>
		<div class="btnDiv"style="margin-top:5px">
			<input type="hidden" id=MEMAUTHORITY value="${MEMAUTHORITY}">
			<button type="button" class="button_home" onclick="boardWrite()">글등록</button>
			<button type="button" class="button_home" onclick="deleteValue()">선택삭제</button>
		</div>
	</div>
</body>
</html>
