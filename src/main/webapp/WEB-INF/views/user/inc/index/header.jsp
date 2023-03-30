<%@page import="com.edu.zino.domain.Member"%>
<%@ page contentType="text/html;charset=UTF-8"%>
        <header class="site-header">
            <div class="nav-bar">
                <div class="container">
                    <div class="row">
                        <div class="col-9 col-lg-3">
                            <div class="site-branding">
                                <h1 class="site-title"><a href="/" rel="home">Edu<span>zino</span></a></h1>
                            </div><!-- .site-branding -->
                        </div><!-- .col -->

                        <div class="col-3 col-lg-9 flex justify-content-end align-content-center">
                        <nav class="site-navigation flex justify-content-end align-items-center">
                            <ul class="flex flex-column flex-lg-row justify-content-lg-end align-content-center">
                                <li><a href="#">IT</a></li>
                                <li><a href="#">디자인</a></li>
                                <li><a href="#">마케팅</a></li>
                                <li><a href="#">외국어</a></li>
                                <li><a href="#">edu</a></li>
                            </ul>

                            <div class="hamburger-menu d-lg-none">
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                            </div><!-- .hamburger-menu -->
                            
                            <!-- 로그인/ 로그아웃  -->
                            <div class="header-bar-cart">
								<%if(session.getAttribute("member")==null){%>
                            	
                                <a href="/member/loginform" class="flex justify-content-center align-items-center"><span aria-hidden="true" class="mdi mdi-lock-outline"></span></a>
                            </div><!-- .header-bar-search -->
                            <div class="header-bar-cart">
                            	 <%}else{%>
	                            <%
	                                Member member=(Member)session.getAttribute("member");
	                            %>
                                <a href="/member/logout" class="flex justify-content-center align-items-center"><span aria-hidden="true" class="mdi mdi-lock-open-outline"></span></a>
                                   <%} %>
                            </div>
                            <!-- .header-bar-search -->
                            
                            
                            
							

                            <div class="header-bar-cart">
                                <a href="member/loginform" class="flex justify-content-center align-items-center"></a>
                            </div><!-- .header-bar-search -->
                        </nav><!-- .site-navigation -->
                    </div><!-- .col -->
                    </div><!-- .row -->
                </div><!-- .container -->
            </div><!-- .nav-bar -->
        </header><!-- .site-header -->
