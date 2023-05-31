<%@page import="dao.CourseDao"%>
<%@page import="vo.Student"%>
<%@page import="vo.Course"%>
<%@page import="vo.Registration"%>
<%@page import="dao.RegistrationDao"%>
<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 과정 신청을 처리한다.
	// 요청 URL
	//localhost/app4/student/course-request.jsp?cno=XXX
	
	// 요청 파라미터값 조회 (코스번호)
	int cno = Integer.parseInt(request.getParameter("cno"));
	
	//세션에서 로그인된 사용자 정보를 조회한다
	String loginType = (String) session.getAttribute("loginType");
	String loginId = (String) session.getAttribute("loginId");
	
	// 세션에 속성으로 저장된 로그인한 학생의 아이디 조회하기
	if (loginId == null) {
		response.sendRedirect("../loginform.jsp?err=req&job="+URLEncoder.encode("수강신청", "utf-8"));
		return;
	}
	
	// 세션에 속성으로 저장된 로그인한 타입 조회하기
	if (!"STUDENT".equals(loginType)) {
		response.sendRedirect("../home.jsp?err=deny&job="+URLEncoder.encode("수강신청", "utf-8"));
		return;
	}
	
	// Registration객체를 생성해서 요청파라미터 값 및 학생아이디 저장하기
	Registration registration = new Registration();
	registration.setCourse(new Course(cno));
	registration.setStudent(new Student(loginId));
	
	// Registration객체에 저장된 수강신청정보를 테이블에 저장시킨다.
	RegistrationDao registrationDao = RegistrationDao.getInstance();
	registrationDao.insertRegistration(registration);
	
	// 해당 개설과정의 신청자수를 1증가 시킨다.
	//(과정번호에 해당하는 과정정보를 조회하고, 신청자수를 증가시킨다음 테이블에 반영시킨다.)
	CourseDao courseDao = CourseDao.getInstace();
	Course course = courseDao.getCourseByNo(cno);
	
	// 모집인원과 신청자수 체크하기
	if (course.getQuota() == course.getReqCnt()) {
		response.sendRedirect("course-list.jsp?err=full");
		return;
	}
	
	course.setReqCnt(course.getReqCnt()+1);
	courseDao.updateCourse(course);
		
	
	
	response.sendRedirect("course-registration-list.jsp");
%>








