<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*" %>
<html>
	<head>
		<title>수강정원변경</title>
	</head>
	<body>
 		<script>
 			var message = "";
		<%
			String p_id = (String)session.getAttribute("user");
			String result = null;		       
			String cid[] = request.getParameterValues("cid");
			String cidno[] = request.getParameterValues("cidno");
			String cunit[] = request.getParameterValues("cunit");
			String tmax[] = request.getParameterValues("tmax");		   
		   
			Connection myConn = null;     
			CallableStatement cstmt = null;
			String mySQL = "";
		
			String dburl = "jdbc:oracle:thin:@210.94.199.20:1521:DBLAB";
			String user = "FE2016112094";	// 본인 아이디(ex.FE0000000000)
			String passwd = "FE2016112094";	// 본인 패스워드(ex.FE0000000000)
			String dbdriver = "oracle.jdbc.driver.OracleDriver";    
			
			try {
				//【4-③】
				Class.forName(dbdriver);
				myConn = DriverManager.getConnection(dburl, user, passwd);
			} catch (SQLException ex) {
				System.err.println("SQLException: " + ex.getMessage());
			}
			try {	
				mySQL = "{call UpdateTeach(?, ?, ?, ?)}";
				for (int i = 0; i < cid.length; i++) {				
					cstmt = myConn.prepareCall(mySQL);
					cstmt.setString(1, cid[i]);
					cstmt.setString(2, cidno[i]);
					cstmt.setString(3, tmax[i]);
					cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
					cstmt.execute();
					result = cstmt.getString(4);

		%>
				//【4-④】
				message = message + "<%=result%>" + "\n";      
		<%         
				}
			} catch(SQLException ex) {
				System.err.println("SQLException: " + ex.getMessage());
			} 
		%>
			alert(message);
			location.href = "update_teach.jsp";
		</script> 
	</body>
</html>