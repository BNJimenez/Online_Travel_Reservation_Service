<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Browse Flights</title>
</head>
<body>
<%
//Get the database connection
try {
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			boolean search = false;
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the combobox from the index.jsp
			
			String sch = request.getParameter("search");
			
			if(sch != null){
				session.setAttribute("search", sch);
			}
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			//String str = "SELECT * FROM user";
			
			//Run the query against the database.
			//ResultSet result = stmt.executeQuery(str);
			String str = "SELECT * FROM users";
			
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			while(result.next()){
				out.println("User: " + result.getString("username"));
			}
			out.print("<br/>");
			out.println("Filters:");
			out.print("<br/>");
			%>
			Airline:	<form action="rep_Browse.jsp">
  				<select name="item">
    				<option value="1">AL1</option>
    				<option value="2">AL2</option>
    				<option value="3">AL3</option>
  				</select>
  				<input type="submit" value="Submit">
			</form>
			<%
			int flight_num = 5;
			for(int i =0; i < flight_num; i++){
				String flight_name = "Flight"+i;
				out.print(flight_name);
				
				%>
				<form method="get" action="Book.jsp">
  				<input type="submit" value="Book" />
				</form>
				
				<form method="get" action="Account.jsp">
  				<input type="submit" value="Enter Waiting List" />
				</form>

		
				<%
			}
						
					
					
} catch (Exception e) {
	out.print(e);
}
			%>
			
</body>
</html>