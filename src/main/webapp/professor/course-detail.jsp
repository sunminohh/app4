<%@page import="vo.Student"%>
<%@page import="java.util.List"%>
<%@page import="dao.StudentDao"%>
<%@page import="vo.Course"%>
<%@page import="dao.CourseDao"%>
<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%

	//세션에서 로그인된 사용자 정보를 조회한다
	String loginType = (String) session.getAttribute("loginType");
	String loginId = (String) session.getAttribute("loginId");
	
	// 세션에 속성으로 저장된 로그인한 학생의 아이디 조회하기
	if (loginId == null) {
		response.sendRedirect("../loginform.jsp?err=req&job="+URLEncoder.encode("개설과정조회", "utf-8"));
		return;
	}
	
	// 세션에 속성으로 저장된 로그인한 타입 조회하기
	if (!"PROFESSOR".equals(loginType)) {
		response.sendRedirect("../home.jsp?err=deny&job="+URLEncoder.encode("개설과정조회", "utf-8"));
		return;
	}
	
	// 요청 파라미터 조회
	int no = Integer.parseInt(request.getParameter("no"));
	
	//업무로직 수행 - 요청파라미터로 전달받은 과정번호에 해당하는 과정 상세정보 조회하기
	CourseDao courseDao = CourseDao.getInstace();
	Course course = courseDao.getCourseByNo(no);
	
	// 해당과목 수강중인 학생리스트 조회하기
	StudentDao studentDao = StudentDao.getInstance();
	List<Student> studentList = studentDao.getStudentsByCourseNo(no);

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
</head>
<body>
<jsp:include page="../nav.jsp">
	<jsp:param name="menu" value="교수"/>
</jsp:include>
<div class="container">
	<div class="row mb-3">
    	<div class="col-12">
        	<h1 class="border bg-light fs-4 p-2">과정 상세 정보</h1>
      	</div>
   	</div>
	<div class="row mb-3">
		<div class="col-12">
			<p>과정 상세정보를 확인하세요</p>
			<table class="table table-bordered">
				<tbody>
					<tr>
						<th class="table-dark" style="width: 15%;">과정이름</th>
						<td style="width: 35%;"><%=course.getName() %> 개론</td>
						<th class="table-dark" style="width: 15%;">번호</th>
						<td style="width: 35%;"><%=course.getNo() %></td>
					</tr>
					<tr>
						<th class="table-dark" style="width: 15%;">구분</th>
						<td style="width: 35%;"><%=course.getType() %></td>
						<th class="table-dark" style="width: 15%;">학점</th>
						<td style="width: 35%;"><%=course.getScore() %></td>
					</tr>
					<tr>
						<th class="table-dark" style="width: 15%;">학과</th>
						<td style="width: 35%;"><%=course.getDept().getName() %></td>
						<th class="table-dark" style="width: 15%;">담당교수</th>
						<td style="width: 35%;"><%=course.getProfessor().getName() %></td>
					</tr>
					<tr>
						<th class="table-dark" style="width: 15%;">모집정원</th>
						<td style="width: 35%;"><%=course.getQuota() %></td>
						<th class="table-dark" style="width: 15%;">신청자수</th>
						<td style="width: 35%;"><%=course.getReqCnt() %></td>
					</tr>
					<tr>
						<th class="table-dark" style="width: 15%;">설명</th>
						<td style="width: 85%; height: 100px;" colspan="3"><%=course.getDescription() %></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	
	<div class="row mb-3">
		<div class="col-12">
			<p>해당 과정을 신청한 학생들을 확인하세요</p>
			<table class="table table-sm">
				<thead>
					<tr class="table-dark">
						<th style="width: 20%;">순번</th>
						<th style="width: 20%;">아이디</th>
						<th style="width: 20%;">학생이름</th>
						<th style="width: 20%;">소속학과</th>
						<th style="width: 20%;">학년</th>
					</tr>
				</thead>
				<tbody>
				
<% if (studentList.isEmpty()) { %>

					<tr>
						<td colspan="5" class="text-cneter">수강신청 정보가 존재하지 않습니다.</td>
					</tr>

<% } %>
				
<% for (Student student : studentList) { %>				

					<tr>
						<td><%=student.getRegistration().getNo() %></td>
						<td><%=student.getId() %></td>
						<td><%=student.getName() %></td>
						<td><%=student.getDept().getName() %></td>
						<td><%=student.getGrade() %></td>
					</tr>
					
<% } %>				
				
				</tbody>
			</table>
		</div>
	</div>
</div>
</body>
</html>