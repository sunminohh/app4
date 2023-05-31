<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 1. 세션에 저장된 사용자 정보 조회하기
	String loginId = (String) session.getAttribute("loginId");
	String loginType = (String) session.getAttribute("loginType");
	
	// 2. 요청파라미터 조회하기
	String menu = request.getParameter("menu");
%>


<nav class="navbar navbar-expand-sm bg-dark navbar-dark mb-3">
	<div class="container">
    	<ul class="navbar-nav me-auto">
        	<li class="nav-item"><a class="nav-link <%="홈".equals(menu) ? "active" : "" %>" href="/app4/home.jsp">홈</a></li>

<%  if ("STUDENT".equals(loginType)) { %>
			
			<li class="nav-item dropdown ">
          		<a class="nav-link dropdown-toggle  <%="학생".equals(menu) ? "active" : "" %>" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            	학생
          		</a>
          		<ul class="dropdown-menu">
            		<li><a class="dropdown-item" href="/app4/student/course-list.jsp">모든 과정 조회</a></li>
            		<li><a class="dropdown-item" href="/app4/student/course-registration-list.jsp">신청현황 조회</a></li>
          		</ul>
        	</li>
        	
<%  } else if ("PROFESSOR".equals(loginType)) { %>

			<li class="nav-item dropdown">
          		<a class="nav-link dropdown-toggle  <%="교수".equals(menu) ? "active" : "" %>" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            	교수
          		</a>
          		<ul class="dropdown-menu">
            		<li><a class="dropdown-item" href="/app4/professor/course-list.jsp">개설한 과정 조회</a></li>
            		<li><a class="dropdown-item" href="/app4/professor/course-form.jsp">과정 등록</a></li>
          		</ul>
        	</li>
        	
<%  }  %>
        	
      	</ul>
      	
<% if (loginType != null) {  %>      	

	<span class="navbar-text me-5">
		<strong class="text-white bolder"><%=loginId %></strong>님 환영합니다.
	</span>

<% } %>      	
      	
      	<ul class="navbar-nav">
      
<% if (loginId != null) { %>        	
        	
         	<li class="nav-item"><a class="nav-link " href="/app4/logout.jsp">로그아웃</a></li>
         	
<% } else { %>

         	<li class="nav-item"><a class="nav-link <%="로그인".equals(menu) ? "active" : "" %>" href="/app4/loginform.jsp">로그인</a></li>
			<li class="nav-item dropdown">
          		<a class="nav-link dropdown-toggle  <%="회원가입".equals(menu) ? "active" : "" %>" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            	사용자 등록
          		</a>
          		<ul class="dropdown-menu">
            		<li><a class="dropdown-item" href="/app4/student/form.jsp">학생</a></li>
            		<li><a class="dropdown-item" href="/app4/professor/form.jsp">교수</a></li>
          		</ul>
        	</li>

<% } %>         	
         	
      	</ul>
   	</div>
</nav>









