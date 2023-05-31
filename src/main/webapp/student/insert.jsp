<%@page import="dao.StudentDao"%>
<%@page import="vo.Dept"%>
<%@page import="vo.Student"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 학생으로 회원가입 시킨다.
	
	// 요청 파라미터값 조회 
	int grade = Integer.parseInt(request.getParameter("grade"));
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	int deptNo = Integer.parseInt(request.getParameter("deptNo"));
	
	Student student = new Student();
	student.setGrade(grade);
	student.setId(id);
	student.setPassword(password);
	student.setName(name);
	student.setDept(new Dept(deptNo));
	
	// 업무로직 수행
	StudentDao studentDao = StudentDao.getInstance();
	
	// 아이디 중복체크
	if (studentDao.getStudentById(id) != null) {
		response.sendRedirect("form.jsp?err=dup");
		return;
	}
	
	// 학생 회원가입 완 
	studentDao.insertStudent(student);
	
	response.sendRedirect("../home.jsp");
%>