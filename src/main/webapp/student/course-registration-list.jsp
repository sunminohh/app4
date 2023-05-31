<%@page import="vo.Course"%>
<%@page import="java.util.List"%>
<%@page import="dao.CourseDao"%>
<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%

	String err = request.getParameter("err");

	//세션에서 로그인된 사용자 정보를 조회한다
	String loginType = (String) session.getAttribute("loginType");
	String loginId = (String) session.getAttribute("loginId");
	
	// 세션에 속성으로 저장된 로그인한 학생의 아이디 조회하기
	if (loginId == null) {
		response.sendRedirect("../loginform.jsp?err=req&job="+URLEncoder.encode("수강신청현황", "utf-8"));
		return;
	}
	
	// 세션에 속성으로 저장된 로그인한 타입 조회하기
	if (!"STUDENT".equals(loginType)) {
		response.sendRedirect("../home.jsp?err=deny&job="+URLEncoder.encode("수강신청현황", "utf-8"));
		return;
	}
	
	CourseDao courseDao = CourseDao.getInstace();
	List<Course> courseList = courseDao.getCoursesByStudentId(loginId);

%>
<!doctype html>
<html lang="ko">
<head>
<title></title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<style type="text/css">
	.btn.btn-xs {--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;}
</style>
</head>
<body>
<jsp:include page="../nav.jsp">
	<jsp:param name="menu" value="학생"/>
</jsp:include>
<div class="container">
	<div class="row mb-3">
    	<div class="col-12">
        	<h1 class="border bg-light fs-4 p-2">수강신청 현황</h1>
      	</div>
   	</div>
   	
<% if ("deny".equals(err)) {  %>

		<div class="alert alert-danger">
			<strong>타인의 수강신청정보는 변경할 수 없습니다.</strong>
		</div>

<% }  %>
   	
	<div class="row mb-3">
		<div class="col-12">
			<p>현재 수강신청 현황을 확인하세요</p>
			<table class="table">
				<thead>
					<tr class="table-dark">
						<th style="width: 10%;">신청번호</th>
						<th style="width: 10%;">과정번호</th>
						<th style="width: 20%;">과정명</th>
						<th style="width: 15%;">학과</th>
						<th style="width: 15%;">담당교수</th>
						<th style="width: 15%;">신청상태</th>
						<th style="width: 15%;"></th>
					</tr>
				</thead>
				<tbody>
		
<% if (courseList.isEmpty()) { %>		

						<tr>
							<td colspan="7" class="text-cneter">수강신청 정보가 존재하지 않습니다.</td>
						</tr>
	
<% } else {%>		
	<% for (Course course : courseList) { %>				
					
						<tr class="align-middle">
							<td><%=course.getRegistration().getNo() %></td>
							<td><%=course.getNo() %></td>
							<td><%=course.getName() %></td>
							<td><%=course.getDept().getName() %></td>
							<td><%=course.getProfessor().getName() %></td>
							<td><%="신청완료".equals(course.getRegistration().getStatus()) ? "<span class='badge text-bg-success'>신청완료</span>" : "<span class='badge text-bg-secondary'>신청취소</span>" %></td>
							<td>
								<a href="course-detail.jsp?cno=<%=course.getNo() %>" class="btn btn-outline-dark btn-xs">상세정보</a>
	<% if("신청완료".equals(course.getRegistration().getStatus())) { %>	
							
								<a href="course-cancel.jsp?regNo=<%=course.getRegistration().getNo() %>" class="btn btn-outline-danger btn-xs">수강취소</a>
							
	<% } else { %>						
							
								<a href="course-reapply.jsp?regNo=<%=course.getRegistration().getNo() %>" class="btn btn-primary btn-xs">재수강</a>
							
							</td>
						</tr>
	<% } %>						
			
	<% } %>		

<% } %>		
				
				</tbody>
			</table>
		</div>
	</div>
</div>
</body>
</html>