<%@page import="vo.Student"%>
<%@page import="dao.StudentDao"%>
<%@page import="vo.Professor"%>
<%@page import="dao.ProfessorDao"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 로그인처리
	// type, id, password를 조회한다.
	
	// 1. 요청 파라미터값 조회
	String type = request.getParameter("type");
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	
	// 2. 아이디에 맞는 학생정보 혹은 교수정보 조회하기 
	ProfessorDao professorDao = ProfessorDao.getInstance();
	StudentDao studentDao = StudentDao.getInstance();
	
	boolean isExist = false;
	String dbId = null;
	String dbPassword = null;
	if ("STUDENT".equals(type)) {
		Student student= studentDao.getStudentById(id);
		if (student != null) {
			isExist = true;
			dbId = student.getId();
			dbPassword = student.getPassword();
		}
		
	} else if ("PROFESSOR".equals(type)) {
		Professor professor = professorDao.getProfessorById(id);
		if (professor != null) {
			isExist = true;
			dbId = professor.getId();
			dbPassword = professor.getPassword();
		}
	}
	
	// 존재하지 않는 아이디라면
	if (!isExist) {
		response.sendRedirect("loginform.jsp?err=fail");
	    return;
	}
	// 비밀번호가 다르다면
	if (!dbPassword.equals(password)) {
		response.sendRedirect("loginform.jsp?err=fail");
		return; 
	} 
	
	session.setAttribute("loginType", type);
	session.setAttribute("loginId", dbId);

	
	// home.jsp를 재요청하는 URL을 응답으로 보낸다.
	response.sendRedirect("home.jsp");
%>









