<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/frameHeader.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
  
		<!-- Content Header (Page header) -->
		<section class="content-header">
			<h1>
				Top Navigation <small>Example 2.0</small>
			</h1>
			<ol class="breadcrumb">
				<li><a href="#">
						<i class="fa fa-dashboard"></i> Home
					</a></li>
				<li class="active">Dashboard</li>
			</ol>
		</section>



		<!-- Main content -->
		<section class="content">
		<!-- ----------------------------------------- -->
			<div class="box box-info">
                <div class="box-header with-border">
                  <h3 class="box-title">■수업상세FAFD</h3>
                </div><!-- /.box-header -->
               
				<!-- form start -->
                <form id="classinputform" class="form-horizontal" action="/classinfo/classmodify" method="post">
                  <div class="box-body">
                    <div class="form-group">
                      <label for="inputEmail3" class="col-sm-2 control-label">수업명</label>
                      <div class="col-sm-10">
                        <input type="text" class="form-control" id="inputEmail3" name='clz_name'" value="${clzinfo.clz_name}">
                      </div>
                    </div>
                    <div class="form-group">
                      <label for="inputPassword3" class="col-sm-2 control-label" >도메인</label>
                      <label for="inputPassword3" class="col-sm-2 control-label" >http://www.XXX.com/</label>
                      <div class="col-sm-2"><input id="clz_domain" type="text" class="form-control" name="clz_domain" value="${clzinfo.clz_domain}" >
                      	${clzinfo.clz_domain}
                      </div>
                      <div class="col-sm-4">
                      	<div id="domainmsg"></div>
                      </div>
                      <div class="col-sm-2">
                      	
                      </div>
                    </div>
                    <div class="form-group">
                      <label for="inputPassword3" class="col-sm-2 control-label">선생님</label>
                      <div class="col-sm-8">
                 		<div id="choiceteacher" class="time-label">
                 		<c:forEach items="${clzinfo.teacherlist}" var="teacher">
                 			<div data-vid='${teacher.mem_id}' class='bg-gray'>${teacher.mem_name}(${teacher.mem_id})X <input type='text' data-hid='${teacher.mem_id}' name='mem_id' value='${teacher.mem_id}' ></div>
                 		</c:forEach>                 		
                      	</div>
                      </div>
                      <div class="col-sm-2">
                 		<button id="btn_teachlist" type="button" class="btn btn-info pull-right" data-toggle="modal" data-target="#teacherModal">선생님찾기</button>	
                      </div>
                    </div>

                                         
                    <div class="form-group">
                      <label for="inputPassword3" class="col-sm-2 control-label">강의실</label>
                      <div class="col-sm-10">
                        <input type="text" class="form-control" id="inputEmail3" name='clz_room' value='${clzinfo.clz_room}'>
                      </div>
                    </div>
                    <div class="form-group">
                      <label for="inputPassword3" class="col-sm-2 control-label">시작일</label>
                      <div class="col-sm-10">
                        <input type="date" class="form-control" id="inputEmail3" name='clz_start_date' value='<fmt:formatDate pattern="yyyy-MM-dd" value="${clzinfo.clz_start_date}"/>'>
                      </div>
                    </div>
                    <div class="form-group">
                      <label for="inputPassword3" class="col-sm-2 control-label">종료일</label>
                      <div class="col-sm-10">
                        <input type="date" class="form-control" id="inputEmail3" name='clz_end_date' value='<fmt:formatDate pattern="yyyy-MM-dd" value="${clzinfo.clz_end_date}"/>'>
                      </div>
                    </div>
                    <div class="form-group">
					  <label for="inputPassword3" class="col-sm-2 control-label" >상태</label>
                      <div class="col-sm-10">
                        <label>
                              준비중
                          <input type="radio" name="clz_state" id="optionsRadios1" value="1" <c:out value="${clzinfo.clz_state == '1'?'checked=checked':''}" />>
                        </label>
                        <label>&nbsp;&nbsp;&nbsp;&nbsp;
                              강의중
                          <input type="radio" name="clz_state" id="optionsRadios2" value="2" >
                        </label>
                        <label>&nbsp;&nbsp;&nbsp;&nbsp;
                              종료
                          <input type="radio" name="clz_state" id="optionsRadios3" value="3" >
                        </label>
                        <label>&nbsp;&nbsp;&nbsp;&nbsp;
                              일시정지
                          <input type="radio" name="clz_state" id="optionsRadios4" value="4" >
                        </label>
                      </div>
                    </div>                         
                  </div><!-- /.box-body -->
                  <div class="box-footer">
                  	<a href="/classinfo/classlist" class="btn btn-default">목록</a>
                    <c:if test="${isAdmin}">
                    	<button type="submit" class="btn btn-info pull-right">수정</button>
                    </c:if>
                  </div><!-- /.box-footer -->
                </form>
			</div><!-- /.box box-info -->		
		<!-- ----------------------------------------- -->
			
		</section>
		<!-- /.content -->





<!-- ****************************************************************************** -->
<!-- ****************************************************************************** -->
<!-- ****************************************************************************** -->
<!-- 선생님리스트 모달창 -->
<!-- Modal -->
<div class="modal fade" id="teacherModal" role="dialog">
   <div class="modal-dialog">
    
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">선생님리스트</h4>
      </div>
      <div class="modal-body">    
        <div id="example1_wrapper" class="dataTables_wrapper form-inline dt-bootstrap">
        	<table id="example1" class="table table-bordered table-striped dataTable" role="grid" aria-describedby="example1_info">
		    <thead>
		    	<tr role="row">
		        	<th class="sorting_asc" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Rendering engine: activate to sort column descending" style="width: 109px;">아이디</th>
			        <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="Browser: activate to sort column ascending" style="width: 142px;">성명</th>
			        <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="Engine version: activate to sort column ascending" style="width: 92px;">이메일</th>
			        <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending" style="width: 64px;">연락처</th>			                   
		        </tr>
		    </thead>
		    <tbody id="teacherinfo">

		    </tbody>
		    </table>
		</div><!-- /.example1_wrapper -->
        <div class="dataTables_paginate paging_simple_numbers text-center" id="example1_paginate">
        	<ul id="teacherpaging" class="pagination">
            	
        	</ul>
        </div><!-- /.example1_paginate -->
      </div><!-- /.modal-body -->
      
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
      
  </div><!-- ./modal-dialog -->
</div><!-- ./modal fade -->              
<!-- ./Modal -->  
<!-- ****************************************************************************** -->
<!-- ****************************************************************************** -->
<!-- ****************************************************************************** -->

  </body>
</html>


<script>
//로딩시 라이오 버튼 체크
$(":input[name=clz_state][value=${clzinfo.clz_state}]").attr("checked", "checked");

//모달 선생님 리스트//
var page = 1
$("#btn_teachlist").on("click", function() {
	popteacherlist(page)
});

function popteacherlist(){
	$.ajax({
		url: '/membership/modalteacherlist/'+page,
		type: 'post',
		dataType:'json',
		success: function(map){
			var listStr = "";
			$(map.poplist).each(
					function() {
						listStr += "<tr role='row' class='userinfo'><td class='userid'><a href='#'>"+this.mem_id+"</a></td><td class='username'>"+this.mem_name+"</td><td>"+this.mem_email+"</td><td>"+this.mem_tel+"</td></tr>";
					}
			);
			$("#teacherinfo").html(listStr);
			
			
			//페이징
		    replypage = (map.poppageMaker.page);
		var startPage = (map.poppageMaker.startPage);
		var endPage = (map.poppageMaker.endPage);
		var prevURL = (map.poppageMaker.startPage-1) ; 
		var nextURL = (map.poppageMaker.endPage+1) ; 
		var prev = (map.poppageMaker.prev);
		var next = (map.poppageMaker.next);
		var pageMakerList ="";
			
		if(prev === true){
			pageMakerList +='<li id='+ prevURL +'><a href="#">prev</a></li>';
		}
		
		for(var i=startPage; i<=endPage ; i++ ){
			if(i==replypage){
				pageMakerList += '<li id='+ i +'><a href="#"><b>  '+ i +' </a></b></li>';
			}else {
				pageMakerList += '<li id='+ i +'><a href="#">'+ i +'</a></li>';
			}
		}
		
		if(next === true){
			pageMakerList +='<li id='+ nextURL +'><a href="#">next</a></li>';
		}
		
		$("#teacherpaging").html(pageMakerList); 
		}
	});
}

$("#teacherpaging").on("click", "li", function(event) {
	event.preventDefault();
	page=$(this).attr("id");
	popteacherlist(page)
});
//./모달 선생님 리스트//

//모달창 선생님 선택시
$("#teacherinfo").on("click", ".userid", function(){
	var userid ;
	var username ;
	userid = $(this).text();
	username = $(this).siblings('.username').text();
	console.log(userid);
	console.log(username);
	$("#choiceteacher").append("<div data-vid='"+ userid +"' class='bg-gray'>"+ username + "(" + userid + ") X <input type='text' data-hid='mem_id' name='mem_id' value='"+userid+"' ></div>");
	
});


//선택된 선생님 취소
$("#choiceteacher").on("click", ".bg-gray", function(){
	$this = $(this)
	$this.remove();
});








</script>

<%@include file="/WEB-INF/views/include/frameFooter.jsp"%>