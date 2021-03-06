<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/header.jsp"%>

<!-- Left side column. contains the logo and sidebar -->
<aside class="main-sidebar">

  <!-- sidebar: style can be found in sidebar.less -->
  <section class="sidebar">
    <!-- Sidebar Menu -->
    <ul class="sidebar-menu">
      <li class="header"></li>
      <c:if test="${isAdmin || isClassTeacher}">
	      <li class="treeview active"><a href="/${domain}/main" target="inner"><i class="fa fa-home"></i> <span>홈</span></a></li>
	      <li class="treeview"><a href="/classinfo/classread?domain=${domain}" target="inner"><i class="fa fa-info"></i> <span>${domain} 수업정보</span></a></li>
	      <li class="treeview"><a href="/${domain}/curriculum/edit" target="inner"><i class="fa fa-book"></i> <span>커리큘럼</span></a></li>
	      <li class="treeview"><a href="/${domain}/qna/listpage" target="inner"><i class="fa fa-question"></i> <span>질문답변</span></a></li>
	      <li class="treeview"><a href="/${domain}/comprehension" target="inner"><i class="fa fa-line-chart"></i> <span>이해도통계</span></a></li>
	      <li class="treeview"><a href="/${domain}/course/joinmemberlist" target="inner"><i class="fa fa-users"></i> <span>우리반식구들</span></a></li>
	      <li class="treeview"><a href="/${domain}/seat" target="inner"><i class="fa fa-street-view"></i><span>학생 배치</span></a></li>
      </c:if>
      
      <c:if test="${isClassStudent || isClassPresident}">
	  	  <li class="treeview active"><a href="/${domain}/main" target="inner"><i class="fa fa-home"></i> <span>홈</span></a></li>
     	  <li class="treeview"><a href="/classinfo/classread?domain=${domain}" target="inner"><i class="fa fa-info"></i> <span>${domain} 수업정보</span></a></li>
          <li class="treeview"><a href="/${domain}/qna/listpage" target="inner"><i class="fa fa-question"></i> <span>질문답변</span></a></li>
          <li class="treeview"><a href="/${domain}/comprehension" target="inner"><i class="fa fa-line-chart"></i> <span>이해도통계</span></a></li>
          <li class="treeview"><a href="/${domain}/course/joinmemberlist" target="inner"><i class="fa fa-users"></i> <span>우리반식구들</span></a></li>
          <c:if test="${isClassPresident}">
          	<li class="treeview"><a href="/${domain}/seat" target="inner"><i class="fa fa-street-view"></i> <span>학생 배치</span></a></li>
          </c:if>
      </c:if>
      
    </ul><!-- /.sidebar-menu -->
  </section>
  <!-- /.sidebar -->
</aside>


<div class="content-wrapper">
	<iframe name="inner" src="/${domain}/main" width="100%" height="100%" style="border:none;"></iframe>
</div>
<!-- /.content-wrapper -->

<c:if test="${isClassTeacher}">
	<!-- Modal -->
	<div class="modal fade" id="myModal" role="dialog">
	    <div class="modal-dialog modal-sm">
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal">&times;</button>
	                <h4 class="modal-title">이해했니?</h4>
	            </div>
	            <div class="modal-body">
		            <form id="sendQuestion" class="form-inline">
		                <div class="form-group">
		                    <div class="input-group input-group-lg">
		                        <input type="hidden" name="curri_no">
		                        <input type="hidden" name="curri_gpno">
								<input type="text" name="teacherquestion_content" class="form-control" placeholder="질문을 입력하세요">
								<span class="input-group-btn">
									<button id="questionBtn" class="btn btn-default">전송</button>
								</span>
		                    </div>
		                </div>
		            </form>
	            </div>
	        </div>
	    </div>
	</div>
</c:if>

<c:if test="${isClassStudent || isClassPresident}">
	<!-- Modal -->
	<div class="modal fade" id="myModal" role="dialog">
	    <div class="modal-dialog modal-sm">
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal">&times;</button>
	                <h4 class="modal-title">이해했니?</h4>
	            </div>
	            <div class="modal-body">
		            <form id="sendScore" class="form-inline">
		                <div class="form-group">
		                    <div class="input-group input-group-lg">
		                        <input type="hidden" name="clz_domain" value="${domain}">
		                        <input type="hidden" name="mem_id" value="${user.id}">
		                        <input type="hidden" name="teacherquestion_no">
		                        <input type="number" name="comprehension_score" class="form-control" min="0" max="10" placeholder="점수" required="required">
		                        <span class="input-group-btn">
		                            <button class="btn btn-default">전송</button>
		                        </span>
		                    </div>
		                </div>
		            </form>
	            </div>
	        </div>
	    </div>
	</div>
</c:if>



<script src="https://cdn.socket.io/socket.io-1.2.0.js"></script>
<script>
	var socket = io.connect('http://14.32.66.104:3002');
	socket.on("connect", function(){
		socket.emit("init", {domain: "${domain}", userId: "${user.id}"});	
	});
</script>

<!-- 선택메뉴 활성화 -->
<script>
$(".treeview").on('click', function(){
	$('.treeview').attr('class','treeview')
	$(this).attr('class', 'treeview active')	
});
</script>

<%@include file="/WEB-INF/views/include/footer.jsp"%>