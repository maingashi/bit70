<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/frameHeader.jsp"%>
    
    <link href="/resources/nojo/css/dropzone.css" rel="stylesheet" type="text/css"/>
    <script src="/resources/nojo/script/dropzone.js"></script>
    <script src="/resources/nojo/script/xlsx.core.min.js"></script>
	
	<style>
	    .tree {
	        padding-left: 0px;
	        list-style: none;
	        margin-bottom: 0px;
	    }
	    
	    .tree-node{
	    	padding: 0px;
	    }
	    
	    .node-content{
	    	display: none;
	    }
	    
	    .node-name{
	    	display: block;
	    	cursor: pointer;
	    	padding: 10px 0px 10px 10px;
	    }
	    
	    .node-name:hover{
	    	background: #DDD;
	    }
	    
	    .node-name.active{
	    	background-color: #337ab7;
	    	color: #fff;
	    }
	    
	    .node-name.parent{
	    	font: bold;
	    }
	    
	    .node-name.parent:after {
	    	content: '›';
	    	margin-left: 5px;
	    	font-weight: normal;
	    }
	    
	    li li > .node-name { padding-left: 20px; }
	  	li li li > .node-name { padding-left: 30px; }
	  	li li li li > .node-name { padding-left: 40px; }
	  	li li li li li > .node-name { padding-left: 50px; } 
	  	
	</style>
	
	<!-- Content Header (Page header) -->
		<section class="content-header">
		    <h1>　</h1>
		    <ol class="breadcrumb">
		        <li><a href="#"><i class="fa fa-fw fa-home"></i>Home</a></li>
		        <li><a href="#">java70</a></li>
		        <li class="active">커리큘럼</li>
		    </ol>
		</section>
		<!-- Main content -->
		<section class="content">
		    <div class="box box-primary">
		        <div class="box-header with-border">
		            <button id="add" class="btn bg-olive">추가</button>
		            <button id="del" class="btn bg-olive">삭제</button>
		            <button id="mod" class="btn bg-olive">수정</button>
		        	<button id="save" class="btn bg-olive">저장</button>
		        	<div class="pull-right">
		        		<button id="excel" class="btn bg-olive" data-toggle="modal" data-target="#myModal">엑셀</button>
		        	</div>
		        </div>
		        <div class="box-body">
		        	<div class="row">
		        		<div class="col-md-3">
		        			<form id="searchTree">
								<div class="input-group">
							      <input id="treeSearchText" type="text" class="form-control" placeholder="커리큘럼 검색">
							      <span class="input-group-btn">
							        <button class="btn btn-info">검색</button>
							      </span>
							    </div><!-- /input-group -->
							</form>
		        			<div id="curri"></div>
		        		</div>
		        		<div class="col-md-9">
		        			<div class="panel panel-primary">
								<div class="panel-heading">
									<h1 id="curri_title" class="panel-title" style="display: inline;">　</h1>
								</div>
								<div class="panel-body">
									<textarea id="curri_content" class="form-control" rows="15"></textarea>
								</div>
							</div>
		        		</div>
		        	</div>
		        </div>
		    </div>
		</section>
		
		<!-- Modal -->
		<div class="modal fade" id="myModal" role="dialog">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
		        <h4 class="modal-title">엑셀</h4>
		      </div>
		      <div class="modal-body">
		        <input type="file" id="excelUpload">
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		      </div>
		    </div>
		  </div>
		</div>
		<!-- /Modal -->
		
<script>
	function Curriculum(obj) {
		this.curri_no = obj.no;
		this.curri_pno = obj.pno;
		this.curri_name = obj.name;
	    this.curri_depth = obj.depth;
	    this.curri_content = obj.content
	    this.mode = obj.mode;
	}
	
	$("#curri_content").change(function(){
	  var target = $(".node-name.active");
	  var content = target.next();
	  if(!content.length){
		content = $('<span class="node-content">');
		target.parent().append(content);
	  }
	  content.text($("#curri_content").val());
	  var li = target.parent();
	  if(!li.data("mode")){
		  li.attr("data-mode", "modify");
	  }
	});
	
	$("#save").click(function(){
		if(!confirm("정말 저장 하시겠습니까?")){ 
			return;
		}
		var list = [];
		var d = $(".tree-node");
		d.each(function(){
			var mode = $(this).data("mode");
			if(!mode){
			  return;
			}
			var no = $(this).data("no");
			var pno = $(this).data("pno");
			var depth = $(this).data("depth"); 
			var name = $(this).children(".node-name").text();
			var content = $(this).children(".node-content").text();
			list.push(new Curriculum({no: no, pno: pno, depth: depth, name: name, content: content, mode: mode}));
		});
		console.log(list);
		if(list.length < 1){
			return;
		}
		$.ajax({
		  url : "/${domain}/curriculum",
	      type : "POST",
	      contentType : "application/json",
	      data : JSON.stringify(list),
	      success : function(data) {
	        alert("성공");
			location.reload();
	      }
		});
	});

	$("#mod").click(function(){
	  var target = $(".node-name.active");
	  if(target.length){
	    var li = target.parent();
	  	var mode = li.data("mode");
	  	if(!mode){
	  		li.attr("data-mode", "modify");
	  	}
	  	var name = target.text();
	  	li.prepend('<input class="node-name-input form-control" type="text" value="' + name + '">');
	  	target.remove();
	  }else{
	    alert("수정할 타겟을 선택하세요");
	  }
	});

	$("#del").click(function(){
	  var target = $(".node-name.active");
	  if(target.length){
	    var ul = target.closest(".tree");
		var li = ul.find(".tree-node");	        
	    li.each(function(){
			if($(this).data("mode")=="add"){
				$(this).removeAttr("data-mode");
			}else{
				$(this).attr("data-mode", "remove");
			}
		});
		ul.css("display", "none");	    
	  }else{
	    alert("삭제할 타겟을 선택하세요");
	  }
	});

	$("#add").click(function(){
	  var target = $(".node-name.active");
	  var str = ''
	  if(target.length){
	    var li = target.parent();
    	var depth = parseInt(li.data("depth")) + 1;
    	var pno = li.data("no");
    	var str = '<ul class="tree">'
		        + '<li class="tree-node" data-mode="add" data-depth="' + depth + '" data-pno="' + pno + '">'
		        + '<input class="node-name-input form-control" type="text" placeholder="입력">'
		        + '</li>'
		        + '</ul>';
	    li.append(str);  
	  }else{
	    var str = '<ul class="tree list-group">'
		        + '<li class="tree-node list-group-item" data-mode="add" data-depth="1">'
		        + '<input class="node-name-input form-control" type="text" placeholder="입력">'
		        + '</li>'
		        + '</ul>';
	    $("#curri").append(str);
	  }
	});
	
	$("#curri").on("keypress", ".node-name-input", function(e){
	  if(e.keyCode == 13){
	  	var name = $(this).val();
	  	$(this).parent().prepend('<span class="node-name">' + name + '</span>');
	  	$(this).closest(".tree").siblings(".node-name").addClass("parent");
	  	$(this).remove();
	  }
	});

	$("#curri").on("click", ".node-name", function(){
	  var $this = $(this);
	  if(! $this.hasClass("active")){
	  	$(".node-name.active").removeClass("active");
	  }
	  $this.toggleClass("active");
	  $this.parent().children(".tree").slideToggle();
	  $("#curri_title").text($this.text());
	  $("#curri_content").val($this.next().text());
	});

   $.getJSON("/${domain}/curriculum", function(list){
    	var temp = [];
    	var work;
    	$(list).each(function(){
    		var name = this.curri_name;
    		var depth = this.curri_depth;
    		var no = this.curri_no;
    		var content = this.curri_content || "";
    		if(depth == 1){
    		  	var str = '<ul class="tree list-group">'
			            + '<li class="tree-node list-group-item" data-no="' + no + '" data-depth="' + depth + '">'
			            + '<span class="node-name">' + name + '</span>'
			            + '<span class="node-content">' + content + '</span>'
			            + '</li>'
			            + '</ul>';
			    var root = $(str);
    			work = [root];
    			temp.push(root);
    		}else{
    			var parent = work[depth-2];
    			var str = '<ul class="tree">'
			            + '<li class="tree-node" data-no="' + no + '" data-depth="' + depth + '" data-pno="' + this.curri_pno + '">'
			            + '<span class="node-name">' + name + '</span>'
			            + '<span class="node-content">' + content + '</span>'
			            + '</li>'
			            + '</ul>';
    			var child = $(str);
    			work[depth-1] = child;
    			parent.children("li:first").append(child).children(".node-name").addClass("parent");
    		}
    	});
    	for(var i in temp){
    		$("#curri").append(temp[i]);
    	}
    	$(".tree .tree").slideUp(0);
    });
   
   $("#searchTree").submit(function(e){
		e.preventDefault();
		var searchText = $("#treeSearchText").val();
		var target = $("#curri .node-name:contains("+searchText+"):last");
		target.parents(".tree").each(function(){
			$(this).find(".tree").slideDown();
		});
		if(! target.hasClass("active")){
			$(".node-name.active").removeClass("active");
		}
		target.toggleClass("active");
		$("#curri_title").text(target.text());
		$("#curri_content").val(target.next().text());
   });
   
   $("#excelUpload").change(handleFile);
 	function handleFile(e) {
         var file = e.target.files[0];
         var reader = new FileReader();
         var name = file.name;
         reader.onload = function(e) {
             var data = e.target.result;
             var workbook = XLSX.read(data, {type : 'binary'});
             var sheet_name_list = workbook.SheetNames;
             sheet_name_list.forEach(function(y) {
                 var worksheet = workbook.Sheets[y];
                 var temp = [];
                 var work;
                 for (z in worksheet) {
                     if (z[0] === '!')
                         continue;
                     var cell = worksheet[z];
                     var name = cell.v;
                     var content = "";
                     if(cell.c){
                     	content = cell.c[0].t;
                     }
                     var depth = z.charCodeAt(0) - 64;
             		if(depth == 1){
	             		var str = '<ul class="tree list-group">'
		 			            + '<li class="tree-node list-group-item" data-mode="add" data-depth="' + depth + '">'
		 			            + '<span class="node-name">' + name + '</span>'
		 			           + '<span class="node-content">' + content + '</span>'
		 			            + '</li>'
		 			            + '</ul>';
		 			    var root = $(str);
             			work = [root];
             			temp.push(root);
             		}else{
             		 	var str = '<ul class="tree">'
		 			            + '<li class="tree-node" data-mode="add" data-depth="' + depth + '">'
		 			            + '<span class="node-name">' + name + '</span>'
		 			            + '<span class="node-content">' + content + '</span>'
		 			            + '</li>'
		 			            + '</ul>';
		     			var child = $(str);
             			work[depth-1] = child;
             			work[depth-2].children(".tree-node").append(child).children(".node-name").addClass("parent");
             		}
                 }
                 $("#curri > .tree").each(function(){
             	    var ul = $(this);
               		var li = ul.find(".tree-node");	        
               	    li.each(function(){
               			if($(this).data("mode")=="add"){
               				$(this).removeAttr("data-mode");
               			}else{
               				$(this).attr("data-mode", "remove");
               			}
               		});
               		ul.css("display", "none");	    
        		 });
		        for ( var i in temp) {
		          $("#curri").append(temp[i]);
		        }
                $(".tree .tree").slideUp(0);
	      	});
	    };
	    reader.readAsBinaryString(file);
	    $("#myModal").modal("hide");
	    $(this).val("");
	}
</script>

<%@include file="/WEB-INF/views/include/frameFooter.jsp"%>