<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<html>
	<head>
		<title>수강정원변경</title>
	<head>
	<body>	
	<%@ include file="top.jsp" %>
	<% if (session_id==null) response.sendRedirect("login.jsp"); %>
		<form method="post" action="update_teach_verify.jsp">
			<table width="75%" align="center" border>
				<tr>
					<th>과목번호</th>
					<th>분반</th>
					<th>과목명</th>
					<th>학점</th>
					<th>수강정원</th>
				</tr><br>
	<%
		Connection conn = null;
		PreparedStatement pstmt = null;
		CallableStatement cstmt1 = null;
		CallableStatement cstmt2 = null;
		String mySQL = "";
		String p_id = (String)session.getAttribute("user");
		int nYear = 0;
		int nSemester = 0;
		ResultSet myResultSet = null;
		
		String dburl = "jdbc:oracle:thin:@210.94.199.20:1521:DBLAB";
		String user = "FE2016112094";	// 본인 아이디(ex.FE0000000000)
		String passwd = "FE2016112094";	// 본인 패스워드(ex.FE0000000000)
		String dbdriver = "oracle.jdbc.driver.OracleDriver";    
	
		try {
			//【4-①】
			Class.forName(dbdriver);
			conn = DriverManager.getConnection(dburl, user, passwd);
			
		} catch(SQLException ex) {
			System.err.println("SQLException: " + ex.getMessage());
		}
		
		//【4-②】
		String sql = null;
		sql = "{? = call Date2EnrollYear(SYSDATE)}";
		cstmt1 = conn.prepareCall(sql);
		cstmt1.registerOutParameter(1, java.sql.Types.INTEGER);
		cstmt1.execute();
		nYear= cstmt1.getInt(1);

		sql = "{? = call Date2EnrollSemester(SYSDATE)}";
		cstmt2 = conn.prepareCall(sql);
		cstmt2.registerOutParameter(1, java.sql.Types.INTEGER);
		cstmt2.execute();
		nSemester= cstmt2.getInt(1);

		mySQL = "SELECT c.c_id cid, c.c_id_no cid_no, c.c_name cname, c.c_unit cunit, t.t_max tmax FROM teach t JOIN course c ON(c.c_id = t.c_id and c.c_id_no = t.c_id_no) WHERE t.p_id = '" + session_id + "' and t.t_year = '" + nYear + "' and t.t_semester = '" + nSemester + "'";
		pstmt = conn.prepareStatement(mySQL);
		myResultSet = pstmt.executeQuery();
		
		while (myResultSet.next()) {
			String cid = myResultSet.getString("cid");
			String cid_no = myResultSet.getString("cid_no");
			String cname = myResultSet.getString("cname");
			String cunit = myResultSet.getString("cunit");
			String tmax = myResultSet.getString("tmax");
	%>

				<tr>
					<td align="center"><%=cid%><input type="hidden" name="cid" value=<%=cid%>></td>
					<td align="center"><%=cid_no%><input type="hidden" name="cidno" value="<%=cid_no%>"></td>
					<td align="center"><%=cname%></td>
					<td align="center"><%=cunit%><input type="hidden" name="cunit" value="<%=cunit%>"></td>
					<td align="center"><input type="text" name="tmax" size=5 value="<%=tmax%>"></td>
				</tr>
	<%	
		}
		pstmt.close();  
		conn.close();
	%>
			</table><br>
			<table align="center">
				<tr> 
					<td><input type="submit" name="submit" value="수강정원변경"></td>
				</tr>
			</table>
		</form>		
	</body>
</html>

    