<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>       
    <c:set var="path" value="${pageContext.request.contextPath}"/> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<script src="http://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script src="${path}/resources/js/user.js" charset="UTF-8"></script>
	<script src="${path}/resources/js/board.js" charset="UTF-8"></script>
	<link rel="stylesheet" type="text/css" href="${path}/resources/board.css">

<title>Insert title here</title>
</head>
<body>
<h1>
	회원 리스트
</h1>
	<div class="contain">
		<form id= "frm" name="frm" method="post" action="${path}/userList">
		<div style="margin:5px">
			<select style="width:15%;" id="userListSearchPeriod" name="userListSearchPeriod">
				<option value="">검색조건</option>
				<option value="userName" <c:if test="${userListSearchPeriod eq 'userName'}">selected</c:if>>이름</option>
				<option value="userId" <c:if test="${userListSearchPeriod eq 'userId'}">selected</c:if>>아이디</option>
				<option value="gender" <c:if test="${userListSearchPeriod eq 'gender'}">selected</c:if>>성별</option>
				<option value="address" <c:if test="${userListSearchPeriod eq 'address'}">selected</c:if>>주소</option>
			</select>
			<input style="width:50%;" type="text" class="SearchWord" id="userListSearchWord" name="userListSearchWord" value="${userListSearchWord}">
			<button id="sch_button" class="button_sch">검색</button>
			<div style="float:right;">
				<button type="button" class="button_home" onclick="location.href='${path}/logout'">로그아웃</button>
				<button type="button" class="button_home" onclick="location.href='${path}/'">게시판 이동</button>
			</div>
		</div>
		</form>
		<table>
			<thead>
				<tr>
					<th width="3%"><input type="checkbox" id="checkAll" onclick="selectAll(this)"></th>
					<th width="4%">순번</th>
					<th width="5%">권한</th>
					<th width="7%">이름</th>
					<th width="5%">아이디</th>
					<th width="11%">전화</th>
					<th width="4%">성별</th>
					<th width="7%">이메일</th>
					<th width="*%">주소</th>
					<th width="8%">가입일</th>
					<th width="8%">수정일</th>
					<th width="10%">등록IP</th>
					<th width="10%">수정IP</th>
				</tr>
			</thead>
			<tbody>
		    	<c:forEach items="${userList}" var="u">
		    	<tr ondblclick="location.href='${path}/userDetail?userId=${u.userId}'">
		    		<td><input type="checkbox" name="check" value="${u.userId}"></td>
		    		<td>${u.cnt}</td>
		    		<td>${u.authority}</td>
		    		<td>${u.userName}</td>
		    		<td>${u.userId}</td>
		    		<td>${u.telephone}</td>
		    		<td>${u.gender}</td>
		    		<td>${u.email}</td>
		    		<td>${u.address}</td>
		    		<td>${u.userRegistDate}</td>
		    		<td>${u.userUpdateDate}</td>
		    		<td>${u.userRegistIp}</td>
		    		<td>${u.userUpdateIp}</td>
	    		</tr>
		    	</c:forEach>
		    </tbody>
		</table>
		<div style="text-align: center; margin-top:10px;">
			​<div class="pagination">
			    <c:if test="${paging.prev}">
			        <span><a href='<c:url value="./userList?page=${paging.startPage-1}"/>'>이전</a></span>
			    </c:if>
			    <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="memoNum">
			        <span>
			        	<c:choose>
			        	<c:when test="${paging.cri.page == memoNum}">
			          <a class="active" href="#">${memoNum}</a>
			        	</c:when>
			        	<c:otherwise>
			          <a href='<c:url value="./userList?page=${memoNum}&userListSearchPeriod=${userListSearchPeriod}&userListSearchWord=${userListSearchWord}"/>'>${memoNum}</a>
			        	</c:otherwise>
			        	</c:choose>
			        </span>
			    </c:forEach>
			    <c:if test="${paging.next && paging.endPage>0}">
			        <span><a href='<c:url value="./userList?page=${paging.endPage+1}"/>'>다음</a></span>
			    </c:if>
			</div>
		</div>
		<div class="btnDiv"style="margin-top:5px">
			<button type="button" class="button_home" onclick="deleteUser()">선택삭제</button>
		</div>
	</div>
</body>
</html>