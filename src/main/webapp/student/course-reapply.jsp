<%@page import="vo.Course"%>
<%@page import="dao.CourseDao"%>
<%@page import="vo.Registration"%>
<%@page import="dao.RegistrationDao"%>
<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 과정 재신청을 처리하세요.
	// 요청 파라미터 조회 (수강신청등록번호)
	int regNo = Integer.parseInt(request.getParameter("regNo"));

	//세션에서 로그인된 사용자 정보를 조회한다
	String loginType = (String) session.getAttribute("loginType");
	String loginId = (String) session.getAttribute("loginId");
	
	// 세션에 속성으로 저장된 로그인한 학생의 아이디 조회하기
	if (loginId == null) {
		response.sendRedirect("../loginform.jsp?err=req&job="+URLEncoder.encode("재수강", "utf-8"));
		return;
	}
	
	// 세션에 속성으로 저장된 로그인한 타입 조회하기
	if (!"STUDENT".equals(loginType)) {
		response.sendRedirect("../home.jsp?err=deny&job="+URLEncoder.encode("재수강", "utf-8"));
		return;
	}
	
	RegistrationDao registrationDao = RegistrationDao.getInstance();
	Registration registration = registrationDao.getRegistrationByNo(regNo);
	
	if (!registration.getStudent().getId().equals(loginId)) {
		response.sendRedirect("course-registration-list.jsp?err=deny");
		return;
	}
	
	// 수강신청등록정보의 신청상태를 "수강완료"로 변경하고 테이블에 반영시킨다.
	registration.setStatus("신청완료");
	registrationDao.updateRegistration(registration);
	 // 수강신청등록정보에서 과정번호를 조회하고, 과정번호에 해당하는 과정정보를 조회한다.
	// 과정정보의 신청자수를 1증가 시키고, 테이블에 반영시킨다. 
	CourseDao courseDao = CourseDao.getInstace();
	Course course = courseDao.getCourseByNo(registration.getCourse().getNo());
	course.setReqCnt(course.getReqCnt()+1);
	courseDao.updateCourse(course); 
	
	response.sendRedirect("course-registration-list.jsp");
%>








