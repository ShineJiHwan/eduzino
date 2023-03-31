<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Admin-회원상세</title>
    <!-- plugins:css -->
    <jsp:include page="../inc/header_link.jsp"></jsp:include>
</head>

<body>
    <div class="container-scroller">
        <!-- partial:partials/_sidebar.html -->
        <jsp:include page="../inc/sidebar.jsp"></jsp:include>
        <!-- sidebar.html end  -->

        <!-- partial  -->
        <div class="container-fluid page-body-wrapper">
            <!-- partial:partials/_settings-panel.html -->
            <!-- partial -->
            <!-- partial:partials/_navbar.html -->
            <jsp:include page="../inc/navbar.jsp"></jsp:include>
            <!-- partial -->
            <div class="main-panel">
                <div class="content-wrapper pb-0">

                    <!-- *********************상단 버튼들 시작************************** -->
                    <div class="page-header flex-wrap">
                        <div class="header-left">
                            <button class="btn btn-primary mb-2 mb-md-0 mr-2"> Mail </button>
                            <button class="btn btn-outline-primary bg-white mb-2 mb-md-0"> Excel </button>
                        </div>
                        
                    </div>
                    <!-- *********************상단 버튼들 끝************************** -->

                    <!-- *********************회원 정보 시작************************** -->
                    <h3 class="card-title mb-5">회원 상세정보</h3>
                    <div class="row">
                        <!-- *** 프로필 사진 *** -->
                        <div class="col-md-3">
                            <div style="width:200px">
                                <img class="card-img-center" src="/resources/user/mon.jpg "
                                    alt="Card image" style="width:100%">
                            </div>
                        </div>
                        <!-- *** 상세정보 *** -->
                        <div class="col-md-9">
                            <div class="card">
                                <div class="card-body">
                                    <form class="forms-sample" id="form1">
                                        <div class="form-group row">
                                            <label class="col-sm-2 col-form-label">닉네임 :  </label>
                                            <div class="col-sm-9">
                                                <input type="text" readonly class="form-control-plaintext" name="nickname" value="do an" >
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-sm-2 col-form-label">이메일 :  </label>
                                            <div class="col-sm-9">
                                                <input type="email" readonly class="form-control-plaintext" name="email" value="dokyy1226@gmail.com">
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-sm-2 col-form-label">가입형태 : </label>
                                            <div class="col-sm-9">
                                                <input type="text" readonly class="form-control-plaintext" name="age" value="google">
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-sm-2 col-form-label">가입일 :</label>
                                            <div class="col-sm-9">
                                                <input type="text" readonly class="form-control-plaintext" name="regdate" value="2023-03-30 14:59:10.0">
                                            </div>
                                        </div>
            <!-- * * * * * * * * * * * * * * * * * * * * * * * *  -->
                                        <div class="form-group row">
                                            <label class="col-sm-2 col-form-label">회원상태 :</label>
                                            <div class="col-sm-6">
                                                 <button type="button" class="btn btn-outline-success btn-icon-text" id="bt_toteacher">
                                					<i class="mdi mdi-account-convert btn-icon-sm"></i> 강사로 전환하기 </button>
                                            </div>
                                        </div>
            <!-- * * * * * * * * * * * * * * * * * * * * * * * *  -->
                                        <div class="form-group row">
                                            <label class="col-sm-2 col-form-label">회원정지 :</label>
                                            <div class="col-sm-6">
                                                <button type="button" class="btn btn-outline-danger btn-icon-text" data-toggle="modal" data-target="#blackModal">
                                                	<i class="mdi mdi-account-off"></i> 계정 정지하기 </button>
                                                <!-- The Modal -->
                                                <div class="modal fade" id="blackModal">
													<div class="modal-dialog modal-dialog-centered">
														<div class="modal-content">

                                                            <!-- Modal Header -->
                                                            <div class="modal-header">
                                                                <h4 class="modal-title">회원 계정 정지</h4>
                                                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                            </div>

                                                            <!-- Modal body -->
                                                            <div class="modal-body">
																<div class="form-group row">
																    <label for="exampleInputConfirmPassword2" class="col-sm-3 col-form-label"> 정지 사유:</label>
																    <div class="col-sm-9">
																    	<textarea class="form-control" id="exampleTextarea1" rows="4"></textarea>
																    </div>
																</div>																
                                                            </div>

                                                            <!-- Modal footer -->
                                                            <div class="modal-footer">
	                                                            <button type="button" class="btn btn-secondary" id="bt_regist"> 등록</button>
                                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <button type="button" class="btn btn-primary mr-2" id="bt_list"> 목록으로 </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- 회원 테이블 -->
                    <!-- **********************회원 정보 끝************************** -->

                </div>
                <!-- content-wrapper ends -->
                <!-- partial:partials/_footer.html -->
                <jsp:include page="../inc/footer.jsp"></jsp:include>
                <!-- partial:partials/_footer.html end -->
                <!-- partial -->
            </div>
            <!-- main-panel ends -->
        </div>
        <!-- partial end  -->
        <!-- page-body-wrapper ends -->
    </div>
    <!-- container-scroller -->
    <!-- plugins:js -->
    <jsp:include page="../inc/footer_link.jsp"></jsp:include>
    <!-- plugins:js end -->
    <!-- End custom js for this page -->
</body>
<script type="text/javascript">
let json;


function toTeacher(){
	if(confirm("강사로 전환하시겠습니까?")){
		location.href="/admin/member/detail";	
	}
}


function toBlacklist(){
	if(confirm("해당 계정을 정지하시겠어요?")){
		location.href="/admin/member/detail";
	}
}

$(function(){
	//회원 목록으로 
	 $("#bt_list").click(function(){
			location.href="/admin/member";
	});
	
	 $("#bt_toteacher").click(function(){
			 toTeacher();
	});
	 
	 $("#bt_regist").click(function(){
			 toBlacklist();
	});
});

</script>

</html>