<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JBlog</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/jblog.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/jquery/jquery-1.12.4.js"></script>
<script type="text/javascript">
	$(function(){
		initData();
		
	});
	
	
	
	//카테고리 리스트 값 가져오기
	function initData(){
		$.ajax({
			type : "GET",
			dataType : "json",
			async: false,//동기식 처리로 변경하여 함수를 순서대로 실행하도록 처리
			url : "${pageContext.servletContext.contextPath}/catelist",
			success : function(obj){//obj는 컨트롤러/서비스에서 리턴값 받을 변수
				var resultCate="";
				for(var i=0; i<obj.length;i++){
					console.log(obj[i]);
					var cateNo = obj[i]['cateNo'];
					resultCate += "<tr class='tr'>"
					resultCate += "<td class='no'>" + (obj.length-i) + "</td>"
					resultCate += "<td>" + obj[i]['cateName'] + "</td>"
					resultCate += "<td class='count'>" + obj[i]['countPost'] + "</td>" //포스트 수 올리기 위해 만든 컬럼
					resultCate += "<td>" + obj[i]['description'] + "</td>"
					resultCate += "<td>" + "<a href='${pageContext.servletContext.contextPath }/${authUser.id}/delete/"+cateNo+"' class='delete'> " + "<img src='${pageContext.request.contextPath}/assets/images/delete.jpg'></a>"  +"</td>"
					resultCate += "</tr>"
				}
				$("#result_data tbody").html(resultCate); //여긴 아래에 상단바 작성 테이블 아이디를 가져와서 테이블 안에 tbody부분에 결과값을 뿌려주는 용도
			},
			error : function(xhr,status,error){
				alert(error+"에러");
			}
		})
		
	}
	
	$(document).ready(function(){
	    $("#btnAddCate").click(
	    	function(){
	    		var cateName = $("#cateName").val();
	    		var desc = $("#desc").val();
	    		$.ajax({
					type : "POST",
					data : "cateName="+cateName+"&desc="+desc,
					url : "${pageContext.servletContext.contextPath}/${authUser.id}/admin/cateInsert",
					async: false,
					success : function(obj){
						var resultCate="";
						for(var i=0; i<obj.length;i++){
							console.log(obj[i]);
							var cateNo = obj[i]['cateNo'];
							resultCate += "<tr class='tr'>"
							if($('.no:eq(0)')[0]==undefined){
								resultCate += "<td class='no'>1</td>"
							} else {
								resultCate += "<td class='no'>" + (Number($('.no:eq(0)')[0].innerHTML)+1) + "</td>"
							}
							resultCate += "<td>" + obj[i]['cateName'] + "</td>"
							resultCate += "<td class='count'>" + obj[i]['countPost'] + "</td>" //포스트 수 올리기 위해 만든 컬럼
							resultCate += "<td>" + obj[i]['description'] + "</td>"
							resultCate += "<td>" + "<a href='${pageContext.servletContext.contextPath }/${authUser.id}/delete/"+cateNo+"' class='delete'> " + "<img src='${pageContext.request.contextPath}/assets/images/delete.jpg'></a>"  +"</td>"
							resultCate += "</tr>"
						}
						$("#result_data tbody").prepend(resultCate);
					},
					error : function(xhr,status,error){
						alert(error+"에러");
					}
				})
	    })
	    
	    preventDelete();
	    
	    
	})
	
	function preventDelete(){
		for(var j=0;j<document.getElementsByClassName('tr').length;j++){
			if((document.getElementsByClassName('count')[j].textContent)>0){
				document.getElementsByClassName('delete')[j].addEventListener('click', function(e) {
					e.preventDefault();
					alert('삭제할 수 없습니다.');
				})
			}
		}
	}
	
	
	
	
	
	
	
</script>
</head>
<body>

	<div id="container">
		
		<!-- 블로그 해더 -->
		<div id="header">
			<h1><a href="${pageContext.servletContext.contextPath }/${authUser.id}">${blogVo.blogTitle}</a></h1>
			<ul>
				<c:choose>
					<%-- 로그인 전 메뉴 --%>
					<c:when test='${empty authUser}'>
						<li><a href="${pageContext.servletContext.contextPath }/user/login">로그인</a></li>
					</c:when>
					<%-- 로그인 후 메뉴 --%>
					<c:otherwise>
						<li><a href="${pageContext.servletContext.contextPath }/user/logout">로그아웃</a></li>
						<li><a href="${pageContext.servletContext.contextPath }/${authUser.id}/admin/basic">내블로그 관리</a></li>
					</c:otherwise>
				</c:choose>	
			</ul>
		</div>

		
		<div id="wrapper">
			<div id="content" class="full-screen">
				<ul class="admin-menu">
					<li><a href="${pageContext.servletContext.contextPath }/${authUser.id}/admin/basic">기본설정</a></li>
					<li class="selected"><a href="${pageContext.servletContext.contextPath }/${authUser.id}/admin/category">카테고리</a></li>
					<li><a href="${pageContext.servletContext.contextPath }/${authUser.id}/admin/write">글작성</a></li>
				</ul>
				
		      	<table class="admin-cat" id="result_data">
		      		<thead>
			      		<tr>
			      			<th>번호</th>
			      			<th>카테고리명</th>
			      			<th>포스트 수</th>
			      			<th>설명</th>
			      			<th>삭제</th>      			
			      		</tr>
		      		</thead>
		      		<tbody id=cateList>
					</tbody>
				</table>
      	
      			<h4 class="n-c">새로운 카테고리 추가</h4>
		      	<table id="admin-cat-add" >
		      		<tr>
		      			<td class="t">카테고리명</td>
		      			<td><input type="text" name="name" id="cateName" value=""></td>
		      		</tr>
		      		<tr>
		      			<td class="t">설명</td>
		      			<td><input type="text" name="desc" id="desc"></td>
		      		</tr>
		      		<tr>
		      			<td class="s">&nbsp;</td>
		      			<td><input id="btnAddCate" type="submit" value="카테고리 추가"></td>
		      		</tr>      		      		
		      	</table> 
		      	
			</div>
		</div>
		
		<!-- 푸터-->
		<div id="footer">
			<p>
				<strong>Spring 이야기</strong> is powered by JBlog (c)2018
			</p>
		</div>
	</div>
</body>



</html>