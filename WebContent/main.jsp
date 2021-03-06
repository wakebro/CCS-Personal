<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인화면</title>
</head>
<body>
	<h1>어서오세요, ${userInfo.name }님</h1>
	<a href="/ccs/logout.do">로그아웃</a>
	<table border="1">
		<tr>
			<td><a href="/ccs/main.do"><input type="submit" value="메인화면"></a></td>
			<td><a href="/ccs/board.do?page=1"><input type="submit" value="게시판"></a></td>
			<td><a href="/ccs/userinfo.do"><input type="submit" value="내 정보"></a></td>
			<td><a href="/ccs/approval.do"><input type="submit" value="결재창"></a></td>
			<c:set var="dept" value="${admin }"></c:set>
			<c:if test="${dept eq '관리자' }">
				<td><a href="/ccs/admin.do"><input type="submit" value="관리자창"></a></td>
			</c:if>
		</tr>
	</table>
	<br>
	<hr>
	<h2>출퇴근 기록</h2>
		<form action="/ccs/commute.do" method="post">
		<c:choose>
			<c:when test="${lastestDate.clock_in_time == null &&lastestDate.clock_out_time == null  }">
				<input type="hidden" name="cKeyword" value="${userInfo.no}">
				<input type="submit" value="출근">
			</c:when>
			<c:when test="${lastestDate.clock_out_time != null }">
				<input type="hidden" name="cKeyword" value="${userInfo.no}">
				<input type="submit" value="출근">
			</c:when>
			<c:when test="${lastestDate.clock_out_time == null }">
				<input type="hidden" name="cKeyword" value="${userInfo.no}">
				<input type="submit" value="퇴근">
			</c:when>
		</c:choose>
		</form>
		<br>
		<table border="1">
			<tr>
				<td>No.</td>
				<td>출근시간</td>
				<td>퇴근시간</td>
			</tr>
			<c:forEach var="list" items="${commuteList}">
			<tr>
				<td>${list.c_no }</td>
				<td>${list.in_time }</td>
				<td>${list.out_time}</td>
			</tr>
			</c:forEach>
			<tr>
				<td colspan="3" align="center">
					<c:if test="${commutePageDTO.hasCommute() }">
						<c:if test="${commutePageDTO.startPage > 10 }">
							<a href="/ccs/main.do?page=${commutePageDTO.startPage-10 }">
						 		<input type="button" value="이전">
						 	</a>
						</c:if>
						<c:forEach var="pNo" begin="${commutePageDTO.startPage }" end="${commutePageDTO.endPage }">
							<a href="main.do?page=${pNo }">${pNo }</a>
						</c:forEach>
						<c:if test="${commutePageDTO.endPage != commutePageDTO.totalPage }">
							<a href="/ccs/main.do?page=${commutePageDTO.startPage + 10 }">
								<input type="button" value="다음">
							</a>							
						</c:if>						 
					</c:if>
				</td>
			</tr>
		</table>
</body>
</html>