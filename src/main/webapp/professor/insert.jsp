<%@page import="vo.Dept"%>
<%@page import="dao.ProfessorDao"%>
<%@page import="vo.Professor"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 교수로 회원가입 시킨다.
	
	// 요청 파라미터값 조회 
	String position = request.getParameter("position");
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	int deptNo = Integer.parseInt(request.getParameter("deptNo"));
	
	Professor professor = new Professor();
	professor.setPosition(position);
	professor.setId(id);
	professor.setPassword(password);
	professor.setName(name);
	professor.setDept(new Dept(deptNo));
	
	// 업무로직 수행
	ProfessorDao professorDao = ProfessorDao.getInstance();
	
	// 아이디 중복체크
	if (professorDao.getProfessorById(id) != null) {
		response.sendRedirect("form.jsp?err=dup");
		return;
	}
	
	// 교수 회원가입 완 
	professorDao.insertProfessor(professor);
	
	// 재요청URL 응답
	response.sendRedirect("../home.jsp");
%>