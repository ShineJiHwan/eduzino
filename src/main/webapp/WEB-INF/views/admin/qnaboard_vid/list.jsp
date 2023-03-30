
<%@page import="com.edu.zino.domain.QnaboardVid"%>
<%@page import="com.edu.zino.domain.QnaboardAcc"%>
<%@page import="com.edu.zino.domain.QnaboardPay"%>
<%@page import="com.edu.zino.domain.QnaboardFnq"%>
<%@page import="com.edu.zino.model.admin.MybatisAdminboardDAO"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.edu.zino.domain.Adminboard"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%
	List qnaboardvidList = (List) request.getAttribute("qnaboardvidList");
%>
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
<style type="text/css">
</style>
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
						<div class="header-right"></div>

					</div>

					<!-- table row starts here -->
					<div class="col-sm-15 col-xl-11 stretch-card grid-margin">
						<div class="card">
							<div class="card-body">
								<form id="form1">
									<div class="d-flex border-bottom mb-4 pb-2">
										<div class="hexagon">
											<div class="hex-mid hexagon-primary">
												<i class="mdi mdi-laptop-windows"></i>
											</div>
										</div>
										<div class="pl-4">
											<h4 class="font-weight-bold text-ght-bold text-primary mb-0">재생
												및 사용오류</h4>

											<h6 class="text-muted">zinoedu</h6>
										</div>

									</div>
									<%
										for (int i = 0; i < qnaboardvidList.size(); i++) {
									%>
									<%
										QnaboardVid qnaboardvid = (QnaboardVid) qnaboardvidList.get(i);
									%>
									<div class="d-flex border-bottom mb-4 pb-2"><%=i%>
										<div class="hexagon"></div>
										<div class="pl-4">
											<a
												href="/admin/qnaboard_vid/detail?qnaboardvid_idx=<%=qnaboardvid.getQnaboardvid_idx()%>"><%=qnaboardvid.getQnaboardvid_title()%></a>
											</h4>
											<h6 class="text-muted">zinoedu</h6>

										</div>
									</div>
									<%
										}
									%>
									<button type="button" class="btn btn-primary active"
										id="bt_regist">글쓰기 등록</button>
									<button type="button" class="btn btn-primary active"
										id="bt_list">목록</button>
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
		function regist() {
			$("#form1").attr({
				action : "/admin/qnaboard_vid/registform",
				method : "GET"
			});
			$("#form1").submit();
		}

		$(function() {
			$("#bt_regist").click(function() {
				regist();
			});

			$("#bt_list").click(function() {
				location.href = "/admin/qnaboard";
			});
		});
	</script>

</body>

</html>