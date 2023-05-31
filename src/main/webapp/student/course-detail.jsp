<%@page import="vo.Registration"%>
<%@page import="dao.RegistrationDao"%>
<%@page import="vo.Course"%>
<%@page import="dao.CourseDao"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%

	//세션에서 로그인된 사용자 정보를 조회한다
	String loginType = (String) session.getAttribute("loginType");
	String loginId = (String) session.getAttribute("loginId");
	
	// 요청 파라미터 조회
	int cno = Integer.parseInt(request.getParameter("cno"));
	
	// 업무로직 수행 - 요청파라미터로 전달받은 과정번호에 해당하는 과정 상세정보 조회하기
	CourseDao courseDao = CourseDao.getInstace();
	Course course = courseDao.getCourseByNo(cno);

	// 이미 신청한 과정인지 조회하기
	boolean isAlreadyRegistered = false;
	if (loginId != null) {
		RegistrationDao registrationDao = RegistrationDao.getInstance();
		Registration registration = registrationDao.getRegistrationByCourseAndStudent(cno, loginId);
		if (registration != null) {
			isAlreadyRegistered = true;
		}
	}
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
	<jsp:param name="menu" value="학생"/>
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
		<div class="col-12 text-end">
		
<% if (course.getReqCnt() < course.getQuota() && loginId != null && "STUDENT".equals(loginType) && !isAlreadyRegistered) { %>		

			<a href="course-request.jsp?cno=<%=course.getNo() %>" class="btn btn-success btn-sm">수강신청</a>
			
<% }%>		
		
			<a href="course-list.jsp" class="btn btn-secondary btn-sm">목록보기</a>
		</div>
	</div>
</div>
</body>
</html>