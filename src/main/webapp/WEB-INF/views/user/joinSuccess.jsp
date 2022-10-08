<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JBlog</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/jblog.css">
</head>
<body>
	<div class="center-content">
				
		<!-- 메인해더 -->
	 	<a href="${pageContext.servletContext.contextPath }/main">
			<img class="logo" src="${pageContext.request.contextPath}/assets/images/logo.jpg">
		</a>
		<ul class="menu">
				<c:choose>
					<%-- 로그인 전 메뉴 --%>
					<c:when test='${empty authUser}'>
						<li><a href="${pageContext.servletContext.contextPath }/user/login">로그인</a></li>
						<li><a href="${pageContext.servletContext.contextPath }/user/join">회원가입</a></li>
					</c:when>
					<%-- 로그인 후 메뉴 --%>
					<c:otherwise>
						<li><a href="${pageContext.servletContext.contextPath }/user/logout">로그아웃</a></li>
						<li><a href="${pageContext.servletContext.contextPath }/${authUser.id}">내블로그</a></li> 
					</c:otherwise>
				</c:choose>
 		</ul>
		
		<p class="welcome-message">
			<span> 감사합니다.
				       회원 가입 및 블로그가 성공적으로 만들어 졌습니다.
		    </span>
			<br><br>
			<a href="${pageContext.servletContext.contextPath }/user/login">로그인 하기</a>
		</p>
		
	</div>
</body>
</html>
