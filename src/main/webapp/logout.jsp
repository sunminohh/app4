<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 로그아웃 처리
	// 해당 클라이언트의 HttpSession객체를 무효화(폐기)시킨다.
	session.invalidate();
	
	//home.jsp를 재용청하는 URL을 응답으로 보낸다.
	response.sendRedirect("home.jsp");
%>