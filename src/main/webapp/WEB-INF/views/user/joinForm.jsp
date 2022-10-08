<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JBlog</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/jblog.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/jquery/jquery-1.12.4.js"></script>
<script>
	$(function(){
			$('#id').change(function(){
				$('#btn-checkid').show();
				$('#check-image').hide();
			});
		$('#btn-checkid').click(function(){
			var id = $('#id').val();
			if(id == ''){
				return;
			}
			// ajax 통신
			$.ajax({
				url : "${pageContext.servletContext.contextPath }/user/api/checkid?id="+id, //문자열로 인식이 되는게 아니라 서버에서 el값으로 먼저 치환후 js통신을 한다.
				type : "GET",
				dataType : "json",
				data : "", //post방식일때 값을 여기에 넣어줌
				success:function(response){
					if(response.result != "success"){
						console.error(response.message);
						return;
					}
					if(response.data == true){
						$("#checkid-msg").text("다른 아이디로 가입해 주세요.")
						$('#id').focus();
						$('#id').val("");
						return;
					} else {
						$("#checkid-msg").text("사용할 수 있는 아이디입니다.")
					}
					$('#btn-checkid').hide();
					$('#check-image').show();
				},
				error : function(xhr, error){ //xmlHttpRequest?
						console.error("error : "+error);
				}
			});
		})
		
		
	});
	
	function check(){
		var userName = document.getElementsByName("userName");
		var id = document.getElementById("id");
		var password = document.getElementsByName("password");
		var agreeProv = document.getElementsByName("agreeProv");
		
		if(userName[0].value == ""){
			alert("이름을 입력해 주세요");
			userName[0].focus();
			return false;
		}
		
		if(id.value == ""){
			alert("아이디를 입력해 주세요");
			id.focus();
			return false;
		}
		
		if($("#checkid-msg").text() == "" || $("#checkid-msg").text() == "다른 아이디로 가입해 주세요."){
			alert("아이디 중복체크를 해주세요");
			return false;
		}
		
		if(password[0].value == ""){
			alert("패스워드를 입력해주세요");
			password[0].focus();
			return false;
		}
		
		if(agreeProv[0].checked == false){
			alert("약관에 동의해 주세요");
			return false;
		}
	}
</script>
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
		
		<form:form modelAttribute="userVo" class="join-form" id="join-form" method="post" action="${pageContext.servletContext.contextPath }/user/join">
			<label class="block-label" for="name">이름</label>
			<input type="text" name="userName"  value="" />
			
			<label class="block-label" for="id">아이디</label>
			<input type="text" name="id" id="id"  value="" />
			
			<input id="btn-checkid" type="button" value="id 중복체크">
			<img style="display: none" id="check-image" src="${pageContext.servletContext.contextPath }/assets/images/check.png"/>
			<p id="checkid-msg" class="form-error"></p>
			
			<label class="block-label" for="password">패스워드</label>
			<input type="password" name="password"  value="" />

			<fieldset>
				<legend>약관동의</legend>
				<input id="agree-prov" type="checkbox" name="agreeProv" value="y">
				<label class="l-float">서비스 약관에 동의합니다.</label>
			</fieldset>

			<input type="submit" value="가입하기" onClick="return check();">

		</form:form>
	</div>

</body>



</html>