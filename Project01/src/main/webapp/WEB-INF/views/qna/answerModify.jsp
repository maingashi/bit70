<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/frameHeader.jsp"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>   
<%@page import="java.util.*" %>

<c:set var="regDate" value="${QuestionVO.question_reg_date }"/>


    <link href="/resources/froala_editor/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
	<!-- Include Editor style. -->
	<link href="/resources/froala_editor/css/froala_editor.min.css" rel="stylesheet" type="text/css" />
	<link href="/resources/froala_editor/css/froala_style.min.css" rel="stylesheet" type="text/css" />

<style>
	.qnatitle{
		font-size: 28px;
	}
	
	.btnmargin{
		margin: 0px 0px 0px 10px;
	}
	
	.space {
		height:10px; 
	}
</style>

	   
<section class="content-header">
	<h1>
		<small></small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="#">
				<i class="fa fa-fw fa-home"></i> Home
			</a></li>
		<li class="active">${domain}</li>
		<li class="active">질문답변</li>
	</ol>
</section>


	<!-- Main content -->
	<section class="content">
	<div class='row'>
		<div class='col-md-12'>
			<div class='box'>
				<div class="box-header with-border">
				  <h3 class="box-title"><i class="fa fa-fw fa-edit "></i>답변수정</h3>
				</div><!-- /.box-header -->
				<!-- /.box-header -->
		
	
				<div class='box-body'>
					<div class="box-group" id="accordion">
						<!-- we are adding the .panel class so bootstrap.js collapse plugin detects it -->
						<div class="panel box box-primary">
							<div class="box-header ">
							<div style="float: left;"><span class="glyphicon glyphicon-question-sign" style="font-size: 40px;"></span></div>
								<div style="margin-left: 70px;">
									<span class="qnatitle">${QuestionVO.question_title }</span>
									<dl>
										<dt style="display: inline;"><span class="glyphicon glyphicon-user"></span> ${QuestionVO.mem_id }</dt>
											<dd style="display: inline;">
													<fmt:formatDate value="${regDate }" type="date" pattern="yyyy.MM.dd hh:mm:ss"/>
											</dd>
									</dl>
								</div>
								<hr>
							</div>
							<div class="box-header ">
								<div class="froala-view" style="height: 200px;">${QuestionVO.question_content }</div>
								<ul id="fileAttach" class='list-group' >
									<li id="attach" class="list-group-item"></li>
								</ul>
							</div>
						</div>
					</div>
					<div class="space"></div>
								
				</div>
			
			
				<div class='box-body'>
					<div class="box-group" id="accordion">
						<div class="panel box box-success">
				
						<section id="editor" style="width : 100%; margin: auto;">
							<form role="form" method="post" action="answerModify">
								<div style="height: 100px;">
									<div class="space"></div>
									<input id="answer_no" type="hidden" class="form-control" value= "${vo.answer_no }" name="answer_no" >	
									<input id="question_no" type="hidden" class="form-control" value= "${vo.question_no }" name="question_no" >							
									<input id="title" type="text" class="form-control" value= "${vo.answer_title }" name="answer_title" placeholder="title">
									<div class="space"></div>
									<input id="answer_visible" type="radio" name="answer_visible" value = "1" checked> 공개
									<input id="answer_visible" type="radio" name="answer_visible" value = "0" > 비공개
									<input id="mem_id" type="hidden" class="form-control" name="mem_id" value = '${user.id }' placeholder="맴버아이디 히든으로 처리하자">
									<input id="clz_domain" type="hidden" class="form-control" name="clz_domain" value= "${vo.clz_domain }" } placeholder="도메인 히든으로 처리하자">
								</div>
								<div class="space"></div>
								<textarea id='edit' name="answer_content" style="margin-top: 30px;">${vo.answer_content }</textarea>
								<br/>
								<div>
										<ul class='list-group' >
											<li id="ansAttach" class="list-group-item"></li>
										</ul>
								</div>
							<div class="box-footer text-center">
								<button id="ansModify" type="submit" class="btn btn-primary btn-lg">수정</button>
								<a href="listpage">
									<button type="button" class="btn btnmargin btn-default pull-right">목록</button>
								</a>
							</div>
							
							
							
							
							</form>
						</section>
						
						</div>
					
					</div>
				</div>
				
				
			</div>		
		</div>		
 	</div>
	</section>
<div class='control-sidebar-bg'></div>


<!-- Text Editor -->
<script type="text/javascript"
	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="/resources/froala_editor/js/froala_editor.min.js"></script>

<script type="text/javascript">

	var no = ${QuestionVO.question_no};
	var ano = ${vo.answer_no};
	var domain = '${domain}';
		
	$('#edit').editable({
		inlineMode : false,
		height : 500,
		buttons : [ 'bold', 'italic', 'underline', 'fontFamily',
				'fontSize', 'color', ' formatBlock', 'inlineStyle',
				'align', 'insertOrderedList',
				'insertUnorderedList', 'outdent', 'indent',
				'createLink', 'insertImage', 'uploadFile', 'table',
				'undo', 'redo', 'html' ],
		imageUploadURL : "/upload",	
		pastedImagesUploadURL : "/upload",		
		fileUploadURL: "/upload"
			
	});
	
	function getFileInfo(filePath){
		
		var path = filePath.attachfile_path;
		var filename, fileLink, fileno;
		
		fileno = filePath.attachfile_no;
		filesrc = "/displayFile?fileName="+path;
		fileLink = path.substr(0,14);
		filename = fileLink.substr(path.indexOf("_") + 1);
		return {filename:filename, filesrc:filesrc, filePath:filePath, fileno:fileno};
		
	}
	
	$.get(domain+"/../getQuestionFile/"+no, function(list){
		
		$(list).each(function(){
			var fileInfo = getFileInfo(this);
			var filePath = fileInfo.filePath.attachfile_path;
			var filename = fileInfo.filePath.attachfile_name;
			var file = "<div class='attach'><a href="+filesrc+"><span>"+filename+"</span></a><br/></div>";
			$('#attach').append(file);
		});	
	});
	
		$.get(domain+"/../getAnsFile/"+ano, function(list){
			$(list).each(function(){
				
				var fileInfo = getFileInfo(this);
				var filePath = fileInfo.filePath.attachfile_path;
				var filename = fileInfo.filePath.attachfile_name;
				var fileno = fileInfo.filePath.attachfile_no;
				var file = "<div class='attach'><a href="+filesrc+"><span>"+filename+"</span></a><br/></div>"
							+ "<a href='#' class='removeBtn' data-fileNo='"+fileno+"' data-src='"+filename+"'>"
						 	+ "<span class='glyphicon glyphicon-remove-circle' style='float: right;'></span></a><br/></div>";
				$('#ansAttach').append(file);
			});
		});
	
	
	$('#edit').on('editable.afterFileUpload', function (e, editor, response) {
		
		var res = JSON.parse(response);
		var str = "<div class='attach'><a href='/displayFile?fileName="+res.filePath+"'<span>"+res.fileName+"</span></a>"
				+ "<a href='#' class='removeBtn' data-fileNo='"+res.fileNo+"' data-src="+res.fileName+"><span class='glyphicon glyphicon-remove-circle' style='float: right;'></span></a><br/></div>";
		var no =  "<input class='fno' type='hidden' name='attachfile_no' value='"+res.fileNo+"' />";
		$("#ansAttach").append(str);
		$("#regForm").append($(no));
		});
	
	$('#edit').on('editable.afterImageUpload', function (e, editor, response) {
		
		var res = JSON.parse(response);
		var str = "<img width ='300' name='attachfile_name' class='fr-fin fr-dib' data-fileNo='"+res.fileNo+"' data-src="+ res.filePath +" src='/displayFile?fileName="+ res.filePath +"' />";
		var no = "<input class='fno' type='hidden' name='attachfile_no' value='"+res.fileNo+"' />";
		
		$(".froala-view").append(str);
		$("#regForm").append($(no));
		
	});
	
	$('#edit').on('editable.beforeRemoveImage', function (e, editor, img) {
		
		var attachfile_no = img.context.dataset.fileno;
		var attachfile_name = img.context.dataset.src;
	
		$.post("/deleteFile", { attachfile_name : attachfile_name ,
								attachfile_no : attachfile_no }, function(){
									
			$(":hidden[value="+attachfile_no+"]").remove();
			
		});
	});
	
	$('#ansAttach').on("click",".removeBtn",function(event){
		
		var $that = $(this);
		
		var attachfile_no =  $that.attr("data-fileNo")
		var attachfile_name = $that.attr("data-src");
		var $this = $(this);
		
		 $.ajax({
			url: "/deleteFile",
			type: "post",
			data: {attachfile_name: attachfile_name,
				   attachfile_no : attachfile_no },
			dataType: "text",
			
			success : function(result){
				if(result == 'deleted'){
					$(":hidden[value="+attachfile_no+"]").remove();
					$this.parent().remove();
				}
			}
		}); 
	});
	

</script>

<%@include file="/WEB-INF/views/include/frameFooter.jsp"%>>