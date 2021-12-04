<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
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
			//String sch1 = request.getParameter("search");
		
			if(sch != null){
				session.setAttribute("search", sch);
			}
			String sch2 = request.getParameter("search2");
			//String sch1 = request.getParameter("search");
		
			if(sch2 != null){
				session.setAttribute("search2", sch2);
			}
			
			//out.print(request.getParameter("button0"));
			//out.print("test");
			if(request.getParameter("button0") == "") {
				out.print("test");
	        }
			else if(request.getParameter("button1") == "") {
				out.print("test");
	        }
			//out.print(session.getAttribute("selected_flight"));
			
			//out.print("You have selected the date " + sch + " do you want to book?");
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			//ONE way Search
			String str = "";
			if(session.getAttribute("search2") == null){
				if(!request.getParameter("airStart").equals("") && !request.getParameter("airEnd").equals("")){
					str = "SELECT * FROM otrs.flight where departing_airport =\"" + request.getParameter("airStart") + "\" and arriving_airport = \"" + request.getParameter("airEnd") + "\" and date(departure_time) = \"" + session.getAttribute("search") + "\"";
				}else if (!request.getParameter("airStart").equals("")){
					str = "SELECT * FROM otrs.flight where departing_airport =\"" + request.getParameter("airStart") + "\" and date(departure_time) = \"" + session.getAttribute("search") + "\"";
				}else if (!request.getParameter("airEnd").equals("")){
					str = "SELECT * FROM otrs.flight where arriving_airport = \"" + request.getParameter("airEnd") + "\" and date(departure_time) = \"" + session.getAttribute("search") + "\"";
				}else{
					str = "SELECT * FROM otrs.flight where date(departure_time) = \"" + session.getAttribute("search") + "\"";
				}
				//Run the query against the database.
			// Round trip search
			}else{
				
				if(!request.getParameter("airStart").equals("") && !request.getParameter("airEnd").equals("")){
					str = "SELECT * FROM otrs.flight where departing_airport =\"" + request.getParameter("airStart") + "\" and arriving_airport = \"" + request.getParameter("airEnd") + "\" and date(departure_time) = \"" + session.getAttribute("search") + "\"";
				}else if (!request.getParameter("airStart").equals("")){
					str = "SELECT * FROM otrs.flight where departing_airport =\"" + request.getParameter("airStart") + "\" and date(departure_time) = \"" + session.getAttribute("search") + "\"";
				}else if (!request.getParameter("airEnd").equals("")){
					str = "SELECT * FROM otrs.flight where arriving_airport = \"" + request.getParameter("airEnd") + "\" and date(departure_time) = \"" + session.getAttribute("search") + "\"";
				}else{
					str = "SELECT * FROM otrs.flight where date(departure_time) = \"" + session.getAttribute("search") + "\"";
				}
			}
				
			ResultSet result = stmt.executeQuery(str);
			int count = 0;
			while(result.next()){
				out.print("Flight number:" + result.getInt("flight_number") + ", Start: " + result.getString("departing_airport") + ", End: " + result.getString("arriving_airport") + ", Time: " + result.getTime("departure_time") + ", Price: " + result.getInt("base_price"));
				int flight_num = result.getInt("flight_number");
				%>
				<form name = <%="form" + count %> method="get" action = "Book.jsp">
				<input type = "hidden" name = <%=flight_num %>>
  				<input type="submit" value="Book" onclick = <%="func" + count %>()/>
				</form>
				
				<form method="get" action="Account.jsp">
  				<input type="submit" value="Enter Waiting List" />
				</form>

				<script language = "JavaScript">
					function <%="func" + count %>(){
						document.<%="form" + count %>.<%=flight_num%>.value = "yes";
						<%="form" + count %>.submit();
					}
				</script>
				<%
				count++;
			}
			
			
				
						
					
					
} catch (Exception e) {
	out.print(e);
}
			%>
			
</body>
</html>