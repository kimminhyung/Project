<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html >
<html>
<head>
<link rel="shortcut icon" href="/SpringMavenWeb/image/min.ico" type="image/x-icon">
	<meta charset="utf-8">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>민형홈-글쓰기	</title>		
	
	<script type="text/javascript" src="/SpringMavenWeb/js/jquery-3.2.1.js"></script>	
			
	<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet"> 
	<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 	
	<link href="/SpringMavenWeb/summernote/summernote.css" rel="stylesheet"> 
	<script src="/SpringMavenWeb/summernote/summernote.js"></script>
	
	<!-- include summernote-ko-KR -->
	<script src="/SpringMavenWeb/summernote/lang/summernote-ko-KR.js"></script>
	
	<link rel="stylesheet" type="text/css" href="/SpringMavenWeb/css/button.css" />


	<script> 
		$(document).ready(function() {			
			
			$("#title").focus();
			$('#summernote').summernote(
					{ 
						height : 300, // 에디터의 높이 
					    minHeight : null,
					    maxHeight : null,
					    focus : false,
					    lang : 'ko-KR' // 기본 메뉴언어 US->KR로 변경 
					}
			);	
			$("#btnWrite").click( function (){
				
				var formObj = $("form[id=form1]");
				var reqObj = formObj.find("[notnull]");
				for(var i=0; i<reqObj.length; i++){
					if( reqObj.eq(i).val() == ''){
						alert(""+ reqObj.eq(i).attr("chkStr"));
						reqObj.eq(i).focus();
						return false;
					}
				}
				var htmlStr = $("#summernote").summernote('code');
				htmlStr = htmlStr.trim();
				
				if(htmlStr.length == 0){
					alert("글 내용을 입력 해주세요 !!");
					$("#summernote").summernote({focus:true});
					return false;
				}				
				$("#summernote").summernote("code", "<br>" + $("#summernote").summernote("code") );								
				$("#form1").submit();
			});	
			
			$("#btnCancel").click(function (){
				location.href ="/SpringMavenWeb/list/";
			});
		}); 
	</script>


</head>

<body>
<div align="center">
<h1>${cateName}</h1>
</div>

<form id="form1" name="form1" action="/SpringMavenWeb/writeDone" method="post">
<input type="hidden" name="userId" value="fireguy" />
<input type="hidden" name="cateNo" value="${cateNo}" />
	<table width="99%">
		<tr>
			<td width="10%" align="center" bgcolor="gray">제목</td>
			<td align="left">&nbsp;<input id="title" name="title" type="text" size="80" notnull="true" chkStr="제목을 입력해주세요" /> </td>
		</tr>
		<tr>
			<td colspan="2" align="center" bgcolor="gray">글내용 </td>
		</tr>
		<tr>
			<td colspan="2" ><textarea id="summernote" name="content"   notnull="true" chkStr="글내용을 입력해주세요"  > </textarea> </td>
		</tr>	
		<tr>
			<td align="left" ><span class="button medium icon"><span class="add" ></span><button type="button"  id="btnCancel">목록으로</button></span>  </td>
			<td align="right"><span class="button medium icon"><span class="check" ></span><button type="button"  id="btnWrite">글작성</button></span> </td>
		</tr>		
	</table>
</form>


</body>