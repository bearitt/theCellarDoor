<%@ page import="java.sql.*" %> 

<% 
	String url = "jdbc:mysql://cosc304.ok.ubc.ca/workson"; 
	String uid = "bjackson"; 
	String pw = "66122573"; 
	try { 
		// Load driver class 
		Class.forName("com.mysql.jdbc.Driver"); 
		
	} 
	catch (java.lang.ClassNotFoundException e) { 
		System.err.println("ClassNotFoundException: " +e); } 
	try (Connection con = DriverManager.getConnection(url, uid, pw);
			Statement stmt = con.createStatement();) { 
		ResultSet rst = stmt.executeQuery("SELECT ename,salary FROM emp"); 
	out.println(""); 
	while (rst.next()) { 
		out.println(""+""); 
		} 
	out.println("		Name	Salary "+rst.getString(1)+"	"+rst.getDouble(2)+" "); 
	} 
	catch (SQLException ex) { out.println(ex); } 
	%>