<%@page import="vo.Course"%>
<%@page import="java.util.List"%>
<%@page import="dto.Pagination"%>
<%@page import="util.StringUtils"%>
<%@page import="dao.CourseDao"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%

	int pageNo = StringUtils.stringToInt(request.getParameter("page"), 1);

	CourseDao courseDao = CourseDao.getInstace();
	
	// 전체 데이터 개수 조회하기
	int totalRows = courseDao.getTotalRows();
	
	Pagination pagination = new Pagination(pageNo, totalRows);
	
	// 업무로직 수행 - 전체 개설 과정 목록 조회하기
	List<Course> courseList = courseDao.getCourses(pagination.getBegin(), pagination.getEnd());
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
        	<h1 class="border bg-light fs-4 p-2">과정 목록</h1>
      	</div>
   	</div>
	<div class="row mb-3">
		<div class="col-12">
			<p>개설된 과정을 확인하고, 수강신청하세요.</p>
			<table class="table">
				<thead>
					<tr class="table-dark">
						<th style="width: 10%;">번호</th>
						<th style="width: 20%;">과정명</th>
						<th style="width: 15%;">학과</th>
						<th style="width: 15%;">담당교수</th>
						<th style="width: 15%;">모집정원</th>
						<th style="width: 15%;">신청자수</th>
						<th style="width: 10%;"></th>
					</tr>
				</thead>
				<tbody>
				
<% for (Course course : courseList) { %>				
				
					<tr class="align-middle">
						<td><%=course.getNo() %></td>
						<td><%=course.getName() %></td>
						<td><%=course.getDept().getName() %></td>
						<td><%=course.getProfessor().getName() %></td>
						<td><%=course.getQuota() %></td>
						<td><%=course.getReqCnt() %></td>
						<td><a href="course-detail.jsp?cno=<%=course.getNo() %>" class="btn btn-outline-dark btn-xs">상세정보</a></td>
					</tr>
				
<% } %>				

				</tbody>
			</table>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col-12">
			<nav>
				<ul class="pagination justify-content-center">
					<li class="page-item <%=pageNo <= 1 ? "disabled" : "" %>">
						<a href="course-list.jsp?page=<%=pageNo - 1 %>" class="page-link">이전</a>
					</li>
					
<% for (int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) { %>					
					
					<li class="page-item <%=pageNo == num ? "active" : "" %>">
						<a href="course-list.jsp?page=<%=num  %>" class="page-link"><%=num %></a>
					</li>
					
<% } %>					
					
					<li class="page-item <%=pageNo >= pagination.getTotalPages() ? "disabled" : "" %>">
						<a href="course-list.jsp?page=<%=pageNo + 1 %>" class="page-link">다음</a>
					</li>
				</ul>
			</nav>
		</div>
	</div>
</div>
</body>
</html>