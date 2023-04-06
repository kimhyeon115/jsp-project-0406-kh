<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 리스트</title>
</head>
<body>
	<h2>회원 리스트</h2>
	<hr>
	아이디  /  이메일  /  가입일시<br>
	<%
		String driverName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/jspdb";
		String username = "root";
		String password = "1234";
		
		String sql = "SELECT id, email, signuptime FROM members";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int membercount = 0;
		
		try {
			Class.forName(driverName);
			conn = DriverManager.getConnection(url, username, password);
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				String id = rs.getString("id");
				String email = rs.getString("email");
				String jointime = rs.getString("signuptime");
				membercount++;
				out.println(id + "/" + email + "/" + jointime + "<br>");
			}
			
			out.println("총 회원 수 : " + membercount + "명");
			
		} catch (ClassNotFoundException e) {
			out.println("DB 드라이버 로딩 실패");
		} catch(SQLException e) {
			out.println("DB 연결 실패");
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
	<br>
	<hr>
	<input type="button" value="회원정보수정 ▶▶" onclick="script:window.location.href='modifyInput.jsp'">
</body>
</html>