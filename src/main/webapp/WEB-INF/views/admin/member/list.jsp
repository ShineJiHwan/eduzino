<%@page import="com.edu.zino.domain.Member" %>
<%@page import="com.edu.zino.domain.Email" %>
<%@page import="com.edu.zino.domain.Birthday" %>
<%@page import="com.edu.zino.domain.ProfilePhoto" %>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<% 
	List<Member> memberList=(List)session.getAttribute("memberList");
%>
<!DOCTYPE html>
<html>

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Admin</title>
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

                    <!-- *********************상단 버튼들************************** -->
                    <div class="page-header flex-wrap">
                        <div class="header-left">
                            <button type="button" class="btn btn-outline-danger btn-icon-text">
                                <i class="mdi mdi-download btn-icon-sm"></i> Download </button>
                            <button type="button" class="btn btn-outline-primary btn-icon-text">
                                <i class="mdi mdi-email-variant btn-icon-prepend"></i> Send Mail </button>
                        </div>
                    </div>
                    <!-- *********************상단 버튼들************************** -->

                    <!-- **********************회원 테이블************************** -->

                    <div class="card-body" id="app1">
                        <h2 class="card-title">전체 회원 목록</h2>
                        <h5><small class="text-muted"> 수정하려면 회원 닉네임을 클릭하세요 </small></h5>
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <!-- - - - - - - - - -컬럼명 - - - - - - - - - - - -->
                                <thead>
                                    <tr>
                                        <th>User</th>
                                        <th>nickname</th>
                                        <th>가입경로</th>
                                        <th>email</th>
                                    </tr>
                                </thead>
                                <!-- - - - -디비에 저장된 회원들이 출력 될 곳 - - - - - - -->
                                <tbody>
                                <tr>
        <td class="py-1">
           <img src="/resources/user/images/c-1.png" alt="image">
        </td>
        <td><a href="/admin/member/detail">yeon</a></td>
        <td>google</td>
        <td>eddu77@gmail.com</td>
        <td>
            <label class="badge badge-info">활동회원</label>
        </td>
    </tr>
<tr>
                                	<tr>
        <td class="py-1">
           <img src="/resources/user/images/c-1.png" alt="image">
        </td>
        <td><a href="/admin/member/detail">do an</a></td>
        <td>google</td>
        <td>dokyy1226@gmail.com</td>
        <td>
            <label class="badge badge-info">활동회원</label>
        </td>
    </tr>
<tr>
        <td class="py-1">
           <img src="/resources/user/images/c-2.png" alt="image">
        </td>
        <td><a href="/admin/member/detail">gogo</a></td>
        <td>google</td>
        <td>dhodkseho11@gmail.com</td>
        <td>
            <label class="badge badge-info">활동회원</label>
        </td>
    </tr>

<tr>
        <td class="py-1">
           <img src="/resources/user/images/c-3.png" alt="image">
        </td>
        <td><a href="/admin/member/detail">YNA</a></td>
        <td>google</td>
        <td>yuna0118@gmail.com</td>
        <td>
            <label class="badge badge-info">활동회원</label>
        </td>
    </tr>
<tr>
                                </tbody>
                            </table>
                        </div>
                    </div>


                    <!-- **********************회원 테이블************************** -->

                </div>
                <!-- content-wrapper ends -->
                <!-- partial:partials/_footer.html -->
                <jsp:include page="../inc/footer.jsp"></jsp:include>
                <!-- partial:partials/_footer.html end -->
                <!-- partial -->
            </div>
            <!-- main-panel ends -->
        </div
        >
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

</script>

</html>