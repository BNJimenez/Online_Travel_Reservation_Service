<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User List</title>
</head>
<body>
<%
//Get the database connection
try {
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			//Create a SQL statement
			Statement stmt = con.createStatement();		
			String str = "SELECT * FROM user";
			
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			out.print("All Customer Repersentatives: <br/>");
			while (result.next()) {
				if(result.getInt("type1")==(1)){				 	
					out.print(result.getString("username")+ "<br/>");
					%>
					<form method="get" action="EditUser.jsp" > 
	  				<input type="submit" value="Edit" />
					</form>
					<%
					out.print("<br/>");
				}			
			}		
			out.print("<br/>All Users: <br/>");
			ResultSet result2 = stmt.executeQuery(str);
			while (result2.next()) {
				if(result2.getInt("type1")!=(0)&&result2.getInt("type1")!=(1)){				 	
					out.print(result2.getString("username")+ "<br/>");
					%>
					<form method="get" action="AdminViewUserInfo.jsp"> 
	  				<input type="submit" value="More Info" />
					</form>
					<%
					out.print("<br/>");
				
				}			
			}	
			
} catch (Exception e) {
	out.print(e);
}
%>			
</body>
</html>