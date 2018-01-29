<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html >
<html>
<head>

<link rel="shortcut icon" href="/SpringMavenWeb/image/min.ico" type="image/x-icon">
	<meta charset="utf-8">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	
	<title>민형홈</title>		
	
	
	<script type="text/javascript" src="/SpringMavenWeb/js/jquery-3.2.1.js"></script>	
	
	<script type="text/javascript">
		$(document).ready(function(){
			$("#btnWrite").click(function(){
				location.href="/SpringMavenWeb/write";
			});
			
			$("#btnRefresh").click(function(){
				location.href="/SpringMavenWeb/list/";
			});			
		});	
		
		function goCate(no){
			$("#innerFrame").attr("src", "/SpringMavenWeb/list?cateNo="+no);			
		}
		
	</script>	
	
	<style type="text/css">		 
	</style>
	
	<link rel="stylesheet" type="text/css" href="/SpringMavenWeb/css/common.css" />	
	<link rel="stylesheet" type="text/css" href="/SpringMavenWeb/css/button.css" />
	<link rel="stylesheet" type="text/css" href="/SpringMavenWeb/css/html5.css" />	

</head>

<body>

<div class="container">

<header>
	<h1>Working Note</h1>
</header>


<nav>
<!-- img src="/SpringMavenWeb/image/image1.gif" width="100" height="60" -->
<ul>
<c:forEach var="cate" items="${cateList}" varStatus="status">
 <li><H3><a href="javascript:goCate(${cate.cateNo})">${cate.cateName}<c:if test="${cate.cnt ne 0 }"> <font color="blue">[${cate.cnt}]</font></c:if></a></H3></li>
</c:forEach>
</ul>

</nav>

<article>
<!-- 게시물 보드 리스트  -->
<!-- div contentEditable="true" -->
<left>
<iframe id="innerFrame" src="/SpringMavenWeb/list/" scrolling="yes" name="inFrame" width="100%" height="600" style="border-width:0px; border-color:white; border-style:solid"></iframe>
</left>

<!-- div -->
</article>

<footer>Copyright &copy; minhyung.kim</footer>
</div>

</body>
</html>
