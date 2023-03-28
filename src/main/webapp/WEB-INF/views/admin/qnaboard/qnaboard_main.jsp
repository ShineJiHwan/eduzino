<%@page import="com.edu.zino.domain.Adminboard"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<!-- Required meta tags -->
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>Plus Admin</title>
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
			<div id="settings-trigger">
				<i class="mdi mdi-settings"></i>
			</div>
			<div id="theme-settings" class="settings-panel">
				<i class="settings-close mdi mdi-close"></i>
				<p class="settings-heading">SIDEBAR SKINS</p>
				<div class="sidebar-bg-options selected" id="sidebar-default-theme">
					<div class="img-ss rounded-circle bg-light border mr-3"></div>
					Default
				</div>
				<div class="sidebar-bg-options" id="sidebar-dark-theme">
					<div class="img-ss rounded-circle bg-dark border mr-3"></div>
					Dark
				</div>
				<p class="settings-heading mt-2">HEADER SKINS</p>
				<div class="color-tiles mx-0 px-4">
					<div class="tiles default primary"></div>
					<div class="tiles success"></div>
					<div class="tiles warning"></div>
					<div class="tiles danger"></div>
					<div class="tiles info"></div>
					<div class="tiles dark"></div>
					<div class="tiles light"></div>
				</div>
			</div>
			<!-- partial -->
			<!-- partial:partials/_navbar.html -->
			<jsp:include page="../inc/navbar.jsp"></jsp:include>
			<!-- partial -->
			<div class="main-panel">
				<div class="content-wrapper pb-0">
					<div class="page-header flex-wrap">
						<div class="header-reght"></div>
						<button type="button" class="btn btn-outline-success"
							id="bt_regist">글쓰기 등록</button>
					</div>

					<!-- table row starts here -->
					<div class="col-sm-15 col-xl-11 stretch-card grid-margin">
						<div class="card">
							<div class="card-body">
							<form id="form1">
								<div class="d-flex border-bottom mb-4 pb-2">
									<div class="hexagon">
										<div class="hex-mid hexagon-warning">
											<i class="mdi mdi-book-variant"></i>
										</div>
									</div>
									<div class="pl-4">
										<h4 class="font-weight-bold text-warning mb-0">자주묻는질문</h4>
										<h6 class="text-muted">zinoedu</h6>
										<button type="button" class="btn btn-inverse-warning btn-sm">
											List</button>
									</div>
								</div>
								<div class="d-flex border-bottom mb-4 pb-2">
									<div class="hexagon">
										<div class="hex-mid hexagon-danger">
											<i class="mdi mdi-book-open-variant"></i>
										</div>
									</div>
									<div class="pl-4">
										<h4 class="font-weight-bold text-danger mb-0">서비스 소개 및
											이용문의</h4>
										<h6 class="text-muted">zinoedu</h6>
										<button type="button" class="btn btn-danger btn-sm" id="bt_service">
											List</button>
									</div>
								</div>
								<div class="d-flex border-bottom mb-4 pb-2">
									<div class="hexagon">
										<div class="hex-mid hexagon-success">
											<i class="mdi mdi-square-inc-cash"></i>
										</div>
									</div>
									<div class="pl-4">
										<h4 class="font-weight-bold text-success mb-0">결제/환불 문의</h4>
										<h6 class="text-muted">zinoedu</h6>
										<button type="button" class="btn btn-success btn-sm">
											List</button>
									</div>
								</div>
								<div class="d-flex border-bottom mb-4 pb-2">
									<div class="hexagon">
										<div class="hex-mid hexagon-info">
											<i class="mdi mdi-account"></i>
										</div>
									</div>
									<div class="pl-4">
										<h4 class="font-weight-bold text-info mb-0">계정문의</h4>
										<h6 class="text-muted">zinoedu</h6>
										<button type="button" class="btn btn-info btn-sm">
											List</button>
									</div>
								</div>
								<div class="d-flex border-bottom mb-4 pb-2">
									<div class="hexagon">
										<div class="hex-mid hexagon-primary">
											<i class="mdi mdi-laptop-windows"></i>
										</div>
									</div>
									<div class="pl-4">
										<h4 class="font-weight-bold text-primary mb-0">재생 및 사용오류
										</h4>
										<h6 class="text-muted mb-0">zinoedu</h6>
										<button type="button" class="btn btn-primary btn-sm">
											List</button>
									</div>
								</div>
								<div class="d-flex border-bottom mb-4 pb-2">
									<div class="hexagon">
										<div class="hex-mid hexagon-secondary">
											<i class="mdi mdi-jeepney"></i>
										</div>
									</div>
									<div class="pl-4">
										<h4 class="font-weight-bold text-sceondary mb-0">준비물 문의</h4>
										<h6 class="text-muted mb-0">zinoedu</h6>
										<button type="button" class="btn btn-secondary btn-sm">
											List</button>
									</div>
								</div>
									</form>
							</div>
						</div>
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
	</div>
	<script type="text/javascript">
	
	function servicelist(){
		$("#form1").attr({
			action : "/admin/qnaboard/list",
			method: "GET"
		});
		$("#form1").submit();
	}
		$(function(){
			$("#bt_service").click(function(){
				servicelist();
			});
		});
	</script>


</body>

</html>