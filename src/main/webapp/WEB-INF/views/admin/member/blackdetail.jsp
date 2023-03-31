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
    <title>Admin-blacklist</title>
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
	
	<div class="card-body"  >
		<h4 class="card-title">Striped Table</h4>
		<div class="table-responsive">
			<table class="table table-striped">
	<!-- - - - - - - - - -컬럼명 - - - - - - - - - - - -->	
				<thead>
					<tr>
						<th>회원</th>
						<th>닉네임</th>
						<th>메일</th>
						<th>정지사유</th>
						<th>정지일</th>
					</tr>
				</thead>
	<!-- - - - -디비에 저장된 회원들이 출력 될 곳 - - - - - - -->			
				<tbody>
					<tr>
						<td class="py-1">
							<img src="/resources/user/images/o.jpg" alt="image">
						</td>
						<td @click="getDetail(obj.member_idx)"><a href="#">catt</a></td>
						<td>dokk126@gmail.com</td>
						<td>회원 비방</td>
						<td>2023-03-29 02:58:17.0</td>
					</tr>	
					<tr>
						<td class="py-1">
							<img src="/resources/user/images/4.jpg" alt="image">
						</td>
						<td @click="getDetail(obj.member_idx)"><a href="#">ya ay</a></td>
						<td>yuna0118@gmail.com</td>
						<td>영업 시도</td>
						<td>2023-03-28 07:44:42.0</td>
					</tr>			
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
let app1;
const row={
	template:`
	<tr>
		<td class="py-1">
			<img src="../../assets/images/faces-clipart/pic-1.png" alt="image">
		</td>
		<td @click="getDetail(obj.member_idx)"><a href="#">{{obj.member_nickname}}</a></td>
		<td>{{obj.email.email_addr}}</td>
		<td>{{obj.blacklist.blacklist_memo}}</td>
		<td> {{obj.blacklist.pause}}</td>
	</tr>
	`, 
	props:['member'],
	data(){
		return {
			obj:this.member
			
		};	
		
	}, 
	methods:{
		getDetail:function(member_idx){
			alert(member_idx);
			location.href="/admin/member/detail?member_idx="+member_idx;
		}
	}
};


//목록가져오기 
function getList(){
	$.ajax({
		url:"/admin/rest/member/blacklist",
		type:"get",
		success:function(result, status, xhr){
			console.log("서버에서 전송된 결과 : ", result);
			app1.memberList=result;
		}
	});	
}

function init(){
	app1=new Vue({
		el:"#app1", 
		components:{
			row
		},
		data:{
			memberList:[]
		}
	});
}


$(function () {
	init();
	getList();
});
</script>
</html>