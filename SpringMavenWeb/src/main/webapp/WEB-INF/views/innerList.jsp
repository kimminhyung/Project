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
	
	<link rel="stylesheet" type="text/css" href="/SpringMavenWeb/css/button.css" />	
	<script type="text/javascript" src="/SpringMavenWeb/js/jquery-3.2.1.js"></script>	
	
	<script type="text/javascript">
		$(document).ready(function(){
			$("#btnWrite").click(function(){
				location.href="/SpringMavenWeb/write?cateNo=${cateNo}";
			});
			
			$("#btnRefresh").click(function(){
				location.href="/SpringMavenWeb/list?cateNo=${cateNo}";
			});
			
		});	
		
		function goPage(pageNo){
			location.href="/SpringMavenWeb/list?curPageNo="+pageNo+"&cateNo=${cateNo}";
		}
		
		$(document).attr("designMode", "off");
		
	</script>		
	<link rel="stylesheet" type="text/css" href="/SpringMavenWeb/css/common.css" />
</head>

<body align="center">


<!-- 게시물 보드 리스트  -->
<!-- div contentEditable="true" -->
<p align="center">
<H1>${cateName}</H1>
</p>

<p align="right">
<span class="button medium icon"><span class="check" ></span><button type="button"  id="btnRefresh">새로고침</button></span> 
<span class="button medium icon"><span class="add" ></span><button type="button"  id="btnWrite">글쓰기</button></span> 
</p>

<table WIDTH="100%" bgcolor="white" >

	
	<!-- tr style="background:linear-gradient(to right, white , black); color:black" -->
	<tr style="background:gray;">
		<td width="5%"  style="color:white">NO</td>
		<td width="60%"  style="color:white">제목</td>
		<td width="5%"  style="color:white">조회</td>
		<td style="color:white">댓글</td>					
		<td width="5%"  style="color:white">추천</td>		
		<td style="color:white">작성자</td>	
		<td width="13%" style="color:white">작성시간</td>
	</tr>
	<c:forEach var="item" items="${list}" varStatus="status">
		<tr>
			<td><a href="/SpringMavenWeb/view/${item.no}/${pageInfo.curPage}">${item.no}</a></td>
			<td  align="left"><b><a href="/SpringMavenWeb/view/${item.no}/${pageInfo.curPage}"> ${item.title}</a></b></td>				
			<td>${item.hitCnt}</td>		
			<td style="color:red"><c:if test="${item.repCnt ne 0 }"> (${item.repCnt}) </c:if></td>					
			<td>${item.recmCnt}</td>			
			<td>${item.userId}</td>	
			<td>${item.updDate}</td>
		</tr>	
	</c:forEach>
</table>


<BR>
<p align="center">
<c:if test="${pageInfo.pagePre !='' }">
<a href="javascript:goPage(<c:out value='${pageInfo.startPage-1}'/>)">
<c:out value="${pageInfo.pagePre}" />
</a>
</c:if>
<c:forEach var="pageNo" items="${pageInfo.pageList}" varStatus="loopStatus">
<a href="javascript:goPage(<c:out value='${pageNo}'/>)">[${pageNo}]</a>
</c:forEach>
<c:if test="${pageInfo.pageNext != '' }" >
<a href="javascript:goPage(<c:out value='${pageInfo.endPage+1}'/>)"><c:out value="${pageInfo.pageNext}" /></a>
</c:if>
</p>


</body>
</html>
