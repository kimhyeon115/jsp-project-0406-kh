<%@page import="java.sql.*"%>
<%@page import="org.apache.el.util.ConcurrentCache"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입 성공</title>
</head>
<body>	
	<%
		String mid = request.getParameter("userID");
		String mpw = request.getParameter("userPW");
		String memail = request.getParameter("userMAIL");
		
		String driverName = "com.mysql.cj.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/jspdb";
		String username = "root";
		String password = "1234";
		
		String sql = "INSERT INTO members(id, pass, email) VALUES(?,?,?)";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			Class.forName(driverName);			
			conn = DriverManager.getConnection(url, username, password);
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, mid);
			pstmt.setString(2, mpw);
			pstmt.setString(3, memail);
			
			int dbFlag = pstmt.executeUpdate();
			if(dbFlag == 1) {
				System.out.print("회원가입 성공");
				response.sendRedirect("signupSuccess.jsp");
			} else {
				System.out.print("회원가입 실패");
				response.sendRedirect("signup.jsp");
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) {
					pstmt.close();
				}
				if(conn != null) {
					conn.close();
				}
			} catch(Exception e) { 
				e.printStackTrace();
			  }			
		}
	%>
</body>
</html>