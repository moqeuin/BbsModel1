<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%
	String id = request.getParameter("id");
	MemberDao dao = MemberDao.getInstance();
	boolean ch = dao.getId(id);
	
	if(ch){
		out.println("yes");
	}
	else{
		out.println("no");
	}
%>



