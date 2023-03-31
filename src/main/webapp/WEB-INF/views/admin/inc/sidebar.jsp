<%@ page contentType="text/html;charset=UTF-8"%>
<nav class="sidebar sidebar-offcanvas" id="sidebar">
<ul class="nav">
  <li class="nav-item nav-profile border-bottom">
      <a class="nav-link flex-column" href="/teacher/index">
      <!--  <div class="nav-logo-image">
        <img src="/resources/teacher/data/logo2.jpg" alt="logo" />
      </div> -->
      </a>
    <a href="#" class="nav-link flex-column">
      	<div class="nav-profile-image">
        <img src="/resources/admin/data/admin.png" alt="profile" />
        <!--change to offline or busy as needed-->
        </div>
        <div class="nav-profile-text d-flex ml-0 mb-3 flex-column">
          <span class="font-weight-semibold mb-1 mt-2 text-center">Admin1</span>
        </div>
      </a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="/admin/index">
        <i class="mdi mdi-checkbox-blank-circle menu-icon"></i>
        <span class="menu-title">요약</span>
      </a>
    </li>
    <li class="nav-item">
      <a class="nav-link" data-toggle="collapse" href="#ui-basic1" aria-expanded="false" aria-controls="ui-basic">
      	<i class="mdi mdi-chart-bar menu-icon"></i>
        <span class="menu-title">매출 & 정산</span>
        <i class="menu-arrow"></i>
      </a>
      <div class="collapse" id="ui-basic1">
        <ul class="nav flex-column sub-menu">
          <li class="nav-item">
            <a class="nav-link" href="#">Buttons</a>
          </li>
        </ul>
      </div>
    </li>
    <li class="nav-item">
       <a class="nav-link" data-toggle="collapse" href="#ui-basic2" aria-expanded="false" aria-controls="ui-basic">
        <i class="mdi mdi-youtube menu-icon"></i>
        <span class="menu-title">강의</span>
         <i class="menu-arrow"></i>
      </a>
      <div class="collapse" id="ui-basic2">
        <ul class="nav flex-column sub-menu">
          <li class="nav-item">
            <a class="nav-link" href="/admin/subject/list/1">강의목록</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="/admin/subject/list/request/1">강의승인</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="pages/ui-features/buttons.html">영상관리</a>
          </li>
        </ul>
      </div>
    </li>
    <li class="nav-item">
       <a class="nav-link" data-toggle="collapse" href="#ui-basic3" aria-expanded="false" aria-controls="ui-basic">
        <i class="mdi mdi-clipboard-account menu-icon"></i>
        <span class="menu-title">회원관리</span>
                 <i class="menu-arrow"></i>
      </a>
      <div class="collapse" id="ui-basic3">
        <ul class="nav flex-column sub-menu">
          <li class="nav-item">
            <a class="nav-link" href="/admin/member">전체회원관리</a>
          </li>
           
          <li class="nav-item">
            <a class="nav-link" href="/admin/member/blacklist">정지회원관리</a>
          </li>
        </ul>
      </div>
    </li>
    <li class="nav-item">
       <a class="nav-link" data-toggle="collapse" href="#ui-basic4" aria-expanded="false" aria-controls="ui-basic">
        <i class="mdi mdi-content-paste menu-icon"></i>
        <span class="menu-title">게시판 관리</span>
                 <i class="menu-arrow"></i>
      </a>
      <div class="collapse" id="ui-basic4">
        <ul class="nav flex-column sub-menu">
          <li class="nav-item">
            <a class="nav-link" href="pages/ui-features/buttons.html">공지사항</a>
          </li>
        </ul>
      </div>
    </li>
    <li class="nav-item">
       <a class="nav-link" data-toggle="collapse" href="#ui-basic5" aria-expanded="false" aria-controls="ui-basic">
        <i class="mdi mdi-format-list-bulleted menu-icon"></i>
        <span class="menu-title">전체</span>
                 <i class="menu-arrow"></i>
      </a>
      <div class="collapse" id="ui-basic5">
        <ul class="nav flex-column sub-menu">
          <li class="nav-item">
            <a class="nav-link" href="/admin/board">공지사항</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="/admin/qnaboard">QnA</a>
          </li>
        </ul>
      </div>
    </li>
  </ul>
</nav>
      