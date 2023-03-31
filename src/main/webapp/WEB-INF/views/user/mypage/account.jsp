<%@page import="com.edu.zino.domain.Member"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
	Member member = (Member)session.getAttribute("member");
	//out.print(member);
%>
<!DOCTYPE html>
<html lang="en">
<style>
.container1 {
  margin-bottom: 20px; /* 아래쪽 여백 추가 */
}
</style>
<head>
    <title>내 계정</title>

    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	
	<!-- header_link -->
	<jsp:include page="../inc/header_link.jsp"></jsp:include>
	<!-- header_link end -->

</head>
<body>
	<!-- hero-content -->
    <div class="page-header">
    	<!-- header-->
		<jsp:include page="../inc/page/header.jsp"></jsp:include>
		<!-- header end -->
    	<jsp:include page="../inc/page/header_main.jsp"></jsp:include>
    </div>
    <!-- hero-content end-->
	
	
	
	<div class="container">
		<div class="row">
			<div class="col-md-3">
				<!-- partial:partials/_sidebar.html -->
				<jsp:include page="../inc/mypage/sidebar.jsp"></jsp:include>
				 <!-- sidebar.html end  -->
			</div>
		<!-- *********************회원 정보 시작************************** -->
			<div class="col-md-9 mt-5">
			<div class="card">
            <div class="card-body">
                <form class="forms-sample">
                
                    <div class="container1">
					  <div class="row ">
					<div class="col-4">
					    <img id="imgThumb" src="/resources/user/mon.jpg" width="200" height="200">
					           <span class="mask"></span>
					</div>
					  </div>
					  <div class="row">
					    <div class="col-4">
					       <input type="file" name="img[]" class="file-upload-default">
					       <div class="input-group col-xs-6">
					           <input type="text" class="form-control file-upload-info" placeholder="선택된 사진 ">
					           <span class="input-group-append">
					               <button class="file-upload-browse btn btn-primary" type="button"> Upload </button>
					           </span>
					       </div>
					    </div>
					  </div>
					</div>

                    <div class="form-group row">
                        <label class="col-sm-3 col-form-label">닉네임 :  </label>
                        <div class="col-sm-5">
                            <input type="text"class="form-control" name="nickname" value="<%=member.getMember_nickname() %>" >
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-3 col-form-label">이메일 :  </label>
                        <div class="col-sm-9">
                            <input type="email" readonly class="form-control-plaintext" name="email" value="<%//=member.getEmail().getEmail_addr()%>">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-3 col-form-label">가입형태 : </label>
                        <div class="col-sm-9">
                            <input type="text" readonly class="form-control-plaintext" name="age" value="<%=member.getSns().getSns_type()%>">
                        </div>
                    </div>
<!-- * * * * * * * * * * * * * * * * * * * * * * * * 
                    <div class="form-group row">
                        <label class="col-sm-2 col-form-label">회원상태</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="status" placeholder="회원상태">
                        </div>
                    </div>  -->
<!-- * * * * * * * * * * * * * * * * * * * * * * * *  -->
                   
                    <div class="header-left">
                            <button type="button" class="btn btn-outline-danger btn-icon-text">
                                <i class="mdi mdi-pencil btn-icon-sm"></i> 수정하기 </button>
                            <button type="button" class="btn btn-outline-secondary btn-fw">
                                <i class="mdi mdi-account-outline btn-icon-prepend"></i> 탈퇴하기 </button>
                        </div>
                </form>
            </div>
        </div>

			    
			</div>
		</div>	
	</div>
   
	
	<!-- clients_logo -->
    <jsp:include page="../inc/clients_logo.jsp"></jsp:include>
    <!-- clients_logo end -->
    
	<!-- footer -->
	<jsp:include page="../inc/footer.jsp"></jsp:include>
	<!-- footer -->
	<!-- footer_link -->
	<jsp:include page="../inc/footer_link.jsp"></jsp:include>
	<!-- footer_link end-->

</body>
<script type="text/javascript">
$(function(){
	//회원정보 수정하기 
	 $("#bt_regist").click(function(){
		 if(confirm("해당 닉네임으로 수정하시겠어요?")){
			$("#form1").attr({
				 //action:"/admin/member/{blacklist_idx}",
				 method:"post"		
			 });
			 $("#form1").submit();	
		}	
	 });
	 
	//계정삭제하기
	 $("#bt_toteacher").click(function() {
			if(confirm("계정을 삭제하시겠습니까?")){
				$("#form1").attr({
					action:"/admin/member/{blacklist_idx}",
					 method:"put"		
				 });
				 $("#form1").submit();	
			}
	});

});

</script>

</html>