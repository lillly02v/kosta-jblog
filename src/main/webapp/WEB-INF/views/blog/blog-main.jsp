<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%> 


<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JBlog</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/jblog.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/jquery/jquery-1.12.4.js"></script>
<script>
	$(document).ready(function(){
		var index=0;
		var cateNo=0;
		var authUser = sessionStorage.getItem("authUser");
		$('.cateNo').hide();
		$(".cateName").off('click').on('click',function(e){
			e.preventDefault();
			index = $(".cateName").index(this);
    		cateNo = $(".cateNo:eq("+index+")")[0].innerHTML;
			cateNameClick();
			$('.postNo').hide();
			postTitleClick();
		})
		
		$(".replySave").off('click').on('click',function(e){
			e.preventDefault();
			replyFirstSave();
		})
    	function cateNameClick(){
    		console.log("cateNo"+cateNo);
    		$.ajax({
				type : "GET",
				data : {
					cateNum: cateNo
				},
				async: false,
				url : "${pageContext.servletContext.contextPath}/${blogVo.userNo}/blog/getPostLIst",
				success : function(obj){
					$(".blog-list").empty();
					console.log(obj)
					var resultCate="";
					var blogcontent="";
					if(obj.length > 0){
						for(var i=0; i<obj.length;i++){
							console.log(obj[i]);
							resultCate += "<li class='postList'>"
							resultCate += "<a href='' class='postTitle'>"+obj[i]['postTitle']+"</a>"
							resultCate += "<span class='postNo'>"+obj[i]['postNo']+"</span>"
							resultCate += "<span>"+obj[i]['regDate']+"</span>"
							resultCate += "</li>"
						}
					} else {
						$(".blog-content").empty();
						blogcontent += "<h4>등록된 글이 없습니다.</h4>"
						$(".blog-content").append(blogcontent);
						$("#commentTable").empty();
					}
					$(".blog-list").append(resultCate);
				},
				error : function(xhr,status,error){
					alert(error+"에러");
				}
			})
		}
		
		var postNo = 0;
		function postTitleClick(){
   			$(".postTitle").off('click').on('click',function(e){
   				e.preventDefault();
   				index = $(".postTitle").index(this);
   				postNo = $(".postNo:eq("+index+")")[0].innerHTML;
   				getPostContent();
   				getCommentList();
   				replySaveClick();
   			})
   		}
	    	
    	function getPostContent(){
    		console.log("postNo"+postNo);
    		$.ajax({
				type : "GET",
				data : {
					postNum: postNo
				},
				async: false,
				url : "${pageContext.servletContext.contextPath}/${blogVo.userNo}/getPostContent",
				success : function(obj){
					$(".blog-content").empty();
					console.log(obj)
					var postContent="";
						for(var i=0; i<obj.length;i++){
							console.log(obj[i]);
							postContent += "<h4>"+obj[i]['postTitle']+"</h4>"
							postContent += "<p>"+obj[i]['postContent']+"</p>"
						}
						$(".blog-content").append(postContent);
				},
				error : function(xhr,status,error){
					alert(error+"에러");
				}
			})
    	}
			
    	function getCommentList(){
    		$.ajax({
				type : "GET",
				data : {
					postNum: postNo
				},
				async: false,
				url : "${pageContext.servletContext.contextPath}/${blogVo.userNo}/getCommentsList",
				success : function(obj){
					$("#commentTable").empty();
					console.log(obj)
					var commentContent="";
					commentContent += "<table class='commentTable'>"
						for(var i=0; i<obj.length;i++){
							console.log(obj[i]);
							commentContent += "<tr class='commentTr'>"
							commentContent += "<td>"+obj[i]['coName']+"</td>"
							commentContent += "<td>"+obj[i]['cmtContent']+"</td>"
							commentContent += "<td>"+obj[i]['regDate']+"</td>"
							commentContent += "</tr>"
						}
					commentContent += "</table>"
					$("#commentTable").append(commentContent);
				},
				error : function(xhr,status,error){
					alert(error+"에러");
				}
			})
		}
	    		
		function replySaveClick(){
			$(".replySave").off('click').on('click', function(e){
				e.preventDefault();
				replySave();
			})
		}		
		
    	function replySave(){
    		var name = $(".name").text();
    		var replyContent = $('.replyContent')[0].value;
    		$.ajax({
				type : "GET",
				data : {
					postNum: postNo,
					name: name,
					replyContent: replyContent
				},
				async: false,
				url : "${pageContext.servletContext.contextPath}/${blogVo.userNo}/addReply",
				success : function(obj){
					console.log(obj)
					var commentContent="";
						commentContent += "<tr>";
						commentContent += "<td>"+obj['coName']+"</td>"
						commentContent += "<td>"+obj['cmtContent']+"</td>"
						commentContent += "<td>"+obj['regDate']+"</td>"
						commentContent += "</tr>";
						$(".commentTable").prepend(commentContent);
				},
				error : function(xhr,status,error){
					alert(error+"에러");
				}
			})
    	}
			
	    $('.postNo').hide();
	    $(".postTitle").off('click').on('click', function(e) {
	    	index = $(".postTitle").index(this);
	    	postNo = $(".postNo:eq("+index+")")[0].innerHTML;
	    	e.preventDefault();
	    	getPostContent();
	    	getCommentList();
	    	replySaveClick();
	    });
    	function getPostContent(){
    		console.log("postNo"+postNo);
    		$.ajax({
				type : "GET",
				data : {
					postNum: postNo
				},
				async: false,
				url : "${pageContext.servletContext.contextPath}/${blogVo.userNo}/getPostContent",
				success : function(obj){
					$(".blog-content").empty();
					console.log(obj)
					var postContent="";
						for(var i=0; i<obj.length;i++){
							console.log(obj[i]);
							postContent += "<h4>"+obj[i]['postTitle']+"</h4>"
							postContent += "<p>"+obj[i]['postContent']+"</p>"
						}
						$(".blog-content").append(postContent);
				},
				error : function(xhr,status,error){
					alert(error+"에러");
				}
			})
    	}
			
		function getCommentList(){
   			$("#commentTable").empty();
    		$.ajax({
				type : "GET",
				data : {
					postNum: postNo
				},
				async: false,
				url : "${pageContext.servletContext.contextPath}/${blogVo.userNo}/getCommentsList",
				success : function(obj){
					console.log(obj)
					var commentContent="";
					commentContent += "<table class='commentTable'>"
						for(var i=0; i<obj.length;i++){
							console.log(obj[i]);
							commentContent += "<tr class='commentTr'>"
							commentContent += "<td>"+obj[i]['coName']+"</td>"
							commentContent += "<td>"+obj[i]['cmtContent']+"</td>"
							commentContent += "<td>"+obj[i]['regDate']+"</td>"
							commentContent += "</tr>"
						}
					commentContent += "</table>"
					$("#commentTable").append(commentContent);
				},
				error : function(xhr,status,error){
					alert(error+"에러");
				}
			})
   		}
				
		function replySaveClick(){
			$(".replySave").off('click').on('click',function(e){
				e.preventDefault();
				replySave();
			})
		}
				
    	function replySave(){
    		var name = $(".name").text();
    		var replyContent = $('.replyContent')[0].value;
    		$.ajax({
				type : "GET",
				data : {
					postNum: postNo,
					name: name,
					replyContent: replyContent
				},
				async: false,
				url : "${pageContext.servletContext.contextPath}/${blogVo.userNo}/addReply",
				success : function(obj){
					console.log(obj)
					var commentContent="";
						commentContent += "<tr>";
						commentContent += "<td>"+obj['coName']+"</td>"
						commentContent += "<td>"+obj['cmtContent']+"</td>"
						commentContent += "<td>"+obj['regDate']+"</td>"
						commentContent += "</tr>";
						$(".commentTable").prepend(commentContent);
				},
				error : function(xhr,status,error){
					alert(error+"에러");
				}
			})
			
    	}
    	
    	function replyFirstSave(){
    		var name = $(".name").text();
    		var replyContent = $('.replyContent')[0].value;
    		postNo = $(".postNo:eq(0)")[0].innerHTML;
    		$.ajax({
				type : "GET",
				data : {
					postNum: postNo,
					name: name,
					replyContent: replyContent
				},
				async: false,
				url : "${pageContext.servletContext.contextPath}/${blogVo.userNo}/addReply",
				success : function(obj){
					console.log(obj)
					var commentContent="";
						commentContent += "<tr>";
						commentContent += "<td>"+obj['coName']+"</td>"
						commentContent += "<td>"+obj['cmtContent']+"</td>"
						commentContent += "<td>"+obj['regDate']+"</td>"
						commentContent += "</tr>";
						$(".commentTable").prepend(commentContent);
				},
				error : function(xhr,status,error){
					alert(error+"에러");
				}
			})
			
    	}
					

	})
</script>
<style>
	table {
		border-collapse: collapse;
		border:1px solid gray;
	}
	table td {
		border: 1px solid gray;
		padding: 3px;
	}
</style>
</head>
<body>

	<div id="container">

		<!-- 블로그 해더 -->
		<div id="header">
			<h1><a href="${pageContext.servletContext.contextPath }/${userId}">${blogVo.blogTitle}</a></h1><%--고쳐야함 --%>
			<ul>
				<c:choose>
					<%-- 로그인 전 메뉴 --%>
					<c:when test='${empty authUser}'>
						<li><a href="${pageContext.servletContext.contextPath }/user/login">로그인</a></li>
					</c:when>
					<%-- 로그인 후 메뉴 --%>
					<c:otherwise>
						<li><a href="${pageContext.servletContext.contextPath }/user/logout">로그아웃</a></li>
						<c:if test="${authUser.userNo == blogVo.userNo }">
							<li><a href="${pageContext.servletContext.contextPath }/${authUser.id}/admin/basic">내블로그 관리</a></li>
						</c:if>
				 	</c:otherwise>
				 </c:choose>
			</ul>
		</div>
		
		<div id="wrapper">
			<div id="content">
				<div class="blog-content">
					<c:choose>
						<c:when test="${empty postContent}">
							<h4>등록된 글이 없습니다.</h4>
						</c:when>
						<c:otherwise>
							<h4>${postContent.postTitle }</h4>
							<p>
								${postContent.postContent}
							</p>
						</c:otherwise>
					</c:choose>
				</div>
				
				<div id="reply">
					<c:if test="${!empty authUser.id}">
						<form>
							<table>
								<tr>
									<td class="name">${authUser.userName}</td>
									<td>
										<input type="text" class="replyContent"/>
									</td>
									<td>
										<input type="button" value="저장" class="replySave" />
									</td>
								</tr>
							</table>					
						</form>
					</c:if>
					<div id="commentTable">
						<table class="commentTable">
							<c:forEach var="commentsVo" items="${commentsVo}" step="1">
								<tr class="commentTr">
									<td>${commentsVo.coName}</td>
									<td>${commentsVo.cmtContent}</td>
									<td>${commentsVo.regDate}</td>
								</tr>
							</c:forEach>
						</table>
					</div>
				</div>
				
				<ul class="blog-list">
					<c:forEach var="postVo" items="${postVo}" step="1">
						<li class="postList">
							<a href="" class="postTitle">${postVo.postTitle}</a>
							<span class="postNo">${postVo.postNo}</span>
							<span>${postVo.regDate}</span>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>

		<div id="extra">
			<div class="blog-logo">
				<img src="${pageContext.request.contextPath}/assets/images/${blogVo.logoFile}">				
			</div>
		</div>

		<div id="navigation">
			<h2>카테고리</h2>
			<ul>
				<c:forEach var="cateVo" items="${cateVo}" step="1">
					<li><a href="" class="cateName">${cateVo.cateName}</a></li>
					<li class="cateNo">${cateVo.cateNo}</li>
				</c:forEach>
			</ul>
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