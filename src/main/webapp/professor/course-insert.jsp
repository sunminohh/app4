<%@page import="dao.CourseDao"%>
<%@page import="vo.Professor"%>
<%@page import="vo.Dept"%>
<%@page import="vo.Course"%>
<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 신규 개설과정을 등록시킨다.
	
	// 세션에서 로그인된 사용자 정보를 조회한다
	String loginType = (String) session.getAttribute("loginType");
	String loginId = (String) session.getAttribute("loginId");
	
	// 세션에 속성으로 저장된 로그인한 교수의 아이디 조회하기
	if (loginId == null) {
		response.sendRedirect("../loginform.jsp?err=req&job="+URLEncoder.encode("과정등록", "utf-8"));
		return;
	}
	
	// 세션에 속성으로 저장된 로그인한 타입 조회하기
	if (!"PROFESSOR".equals(loginType)) {
		response.sendRedirect("../home.jsp?err=deny&job="+URLEncoder.encode("과정등록", "utf-8"));
		return;
	}
	
	// 요청 파라미터값 조회
	String name = request.getParameter("name");
	String type = request.getParameter("type");
	int deptNo = Integer.parseInt(request.getParameter("deptNo"));
	int score = Integer.parseInt(request.getParameter("score"));
	int quota = Integer.parseInt(request.getParameter("quota"));
	String description = request.getParameter("description");
	
	// Course객체를 생성해서 요청파라미터 값 저장하기
	Course course = new Course();
	course.setName(name);
	course.setType(type);
	course.setDept(new Dept(deptNo));
	course.setScore(score);
	course.setQuota(quota);
	course.setDescription(description);
	course.setProfessor(new Professor(loginId));
	
	// 업무로직 수행 - 새 과정정보를 저장시킨다. 
	CourseDao courseDao = CourseDao.getInstace();
	courseDao.insertCourse(course);
	
	// 재요청URL 응답
	response.sendRedirect("course-list.jsp");
%>








