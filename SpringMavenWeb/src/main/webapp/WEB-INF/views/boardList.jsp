8
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
		
		function goCate(no, cateName){
			$("#selCateNo").val(no);
			$("#selCateName").val(cateName);
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
<p>
<SPAN>선택카테고리&nbsp;&nbsp;<input type="text" id="selCateNo" style="width:30px" value=""></input></SPAN>
<SPAN>&nbsp;<input type="text" id="selCateName" style="width:100px" value=""></input></SPAN>
</p>
<span class="button medium icon"><span class="add" ></span><button type="button"  id="btnMody">추가</button></span>
<span class="button medium icon"><span class="add" ></span><button type="button"  id="btnMody">하위추가</button></span>
<span class="button medium icon"><span class="add" ></span><button type="button"  id="btnMody">삭제</button></span>
<!-- img src="/SpringMavenWeb/image/image1.gif" width="100" height="60" -->
<ul>
<c:forEach var="cate" items="${cateList}" varStatus="status">
 <li><H3><a href="javascript:goCate(${cate.cateNo}, '${cate.cateName}')">${cate.cateName}<c:if test="${cate.cnt ne 0 }"> <font color="blue">[${cate.cnt}]</font></c:if></a></H3></li>
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
