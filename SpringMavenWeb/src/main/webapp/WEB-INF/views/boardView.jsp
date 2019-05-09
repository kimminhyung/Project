<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html >
<html>
<head>
<link rel="shortcut icon" href="/SpringMavenWeb/image/min.ico" type="image/x-icon">
	<meta charset="utf-8">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>민형홈-글보기</title>		

	<script type="text/javascript" src="/SpringMavenWeb/js/jquery-3.2.1.js"></script>
	
	<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet"> 
	<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 	
	<link href="/SpringMavenWeb/summernote/summernote.css" rel="stylesheet"> 
	<script src="/SpringMavenWeb/summernote/summernote.js"></script>	
	<link rel="stylesheet" type="text/css" href="/SpringMavenWeb/css/button.css" />

	
	<script type="text/javascript">
	  $(document).ready(function(){
		  
		 var editable = false;
		  		  
		 $("#btnList").click(function(){
			 location.href="/SpringMavenWeb/list?curPageNo=${curPage}&cateNo=${model.cateNo}";
		 });
		 
		 $("#btnDel").click(function(){
			 if( confirm("삭제하시겠습니까?")){
			 	location.href="/SpringMavenWeb/del/${model.no}?curPage=${curPage}&cateNo=${model.cateNo}";
			 }
		 });
		 
		 $("#summernote").dblclick(function(){			 
			 if(!editable){
				 enableContent();
			 }
		 });
		  
		 $("#btnMody").click(function(){
		    if(!editable){
		    	enableContent();
		    	return;
		    }
		    var titleVal = $("#titletd").html();
			var code = $("#summernote").summernote("code");
			var formObj =  $("form[name=form1]");			
			$("#content").val(code);			
			$("#title").val(titleVal);			
					
			formObj.submit();			
		 });
		 
		 function enableContent(){
			 // title Text 활성화			 
			 var tdObj = $("#titletd");
			 var titleVal = tdObj.html();
			 titleVal = titleVal.replace(/\</gi,"");
			 titleVal = titleVal.replace(/\>/gi,"");
			 titleVal = titleVal.replace(/\//gi,"");
			 titleVal = titleVal.replace(/b/gi,"");

			 tdObj.html("<input type='text' name= 'title' value='"+ titleVal+"' size='80' />");
			 
			 //summernote 활성화
			 $('#summernote').summernote(
						{ 
							height : 300, // 에디터의 높이 
						    minHeight : null,
						    maxHeight : null,
						    focus : false,
						    lang : 'ko-KR', // 기본 메뉴언어 US->KR로 변경 
						}
			);		
	    	editable = true;
		 }
		 
		 $("#summernote2").click(function(){
			//댓글 summernote 활성화
			 $('#summernote2').summernote(
						{ 
							height : 150, // 에디터의 높이 
						    minHeight : null,
						    maxHeight : null,
						    focus : true,
						    lang : 'ko-KR', // 기본 메뉴언어 US->KR로 변경 
						}
			);		
		 });
		 
		$("#btnReply").click(function(){
		   var formObj = $("form[name=replyForm]");
		   var replyContent = $("#summernote2").summernote("code");
		
		   $("#replyContent").val(replyContent);		   
		   formObj.submit();
		   
		});
		 
	  });
	  
	  function del(repNo){
		  if(confirm("댓글 삭제하시겠어요?")){  
	  	  	location.href="/SpringMavenWeb/deleteReply?pno=${model.no}&no="+ repNo+"&curPage=${curPage}";
		  }
	  }
	  
	</script>	
</head>

<body>

<div align="center"><h1>${model.cateName}</h1></div>

<article>
<form id="form1" name="form1" action="/SpringMavenWeb/modify/${model.no}" method="POST">
	<input type="hidden" id="content" name="content" />
	<input type="hidden" id="curPage" name="curPage" value="${curPage}" />
	<input type="hidden" id="cateNo" name="cateNo" value="${model.cateNo}" />

	<table align="center" width="100%" bgcolor="white">
		<tr>
			<td width="8%" bgcolor="gray" style="color:white" > 제목 </td>
			<td id="titletd" contentEditable="false"><b>${model.title}</b></td>			
		</tr>
		<tr>
			<td  bgcolor="gray" style="color:white"> 글쓴이 </td>
			<td><b>${model.userId} (${model.updDate})</b></td>			
		</tr>
		
		<!-- 본문내용 -->
		<tr height="300" valign="top">
			<td  bgcolor="gray" style="color:white"> 내용 </td>
			<td id="summernote"><b><c:out value="${model.content}" escapeXml="false" /></b></td>			
		</tr>	
		<tr>
		    <td align="left" bgcolor="#aaaaaa" colspan="2" > 
				<font color="blue"><h5>&nbsp; 댓글  (${model.repCnt})</h5></font>			
			</td>					
		</tr>
		
		<!-- 댓글 리스트 -->
		<c:forEach var="repModel" items="${replyList}" varStatus="varStatus">    
			<tr>
				<td align="right" bgcolor="gray">
					<span class="button medium icon"><span class="check"></span><button type="button" id="replyDel" onClick="javascript:del(${repModel.no})">삭제</button></span>
				</td>
				<td><b>작성자: ${repModel.writer} (${repModel.regDate})</b><br><br><b>${repModel.content}</b></td>
			</tr>
		</c:forEach>
		
		<!-- 댓글쓰기 -->
		<tr>
			<td align="right" bgcolor="gray"><span class="button medium icon"><span class="add" ></span><button type="button"  id="btnReply">댓글등록</button></span></td>
			<td ><textarea id="summernote2" name="replyContent" cols="100" rows="2" style="overflow:hidden; resize:both" ></textarea></td>			
		</tr>	
	</table>
</form>

<form name="replyForm" id="replyForm" action="/SpringMavenWeb/reply/${model.no}" method="POST">
	<input type="hidden" id="replyContent" name="content" />
	<input type="hidden" id="pno" name="pno"  value="${model.no}" />	
	<input type="hidden" id="curPage" name="curPage" value="${curPage}" />
</form>


<p align="right">
	<span class="button medium icon"><span class="check" ></span><button type="button"  id="btnDel">본문삭제</button></span>	
	<span class="button medium icon"><span class="add" ></span><button type="button"  id="btnMody">수정</button></span>
	<span class="button medium icon"><span class="add" ></span><button type="button"  id="btnList">목록으로</button></span>		
</p>

</article>


</body>

</html>