<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.util.Map"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ include file="jdbc.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>The Cellar - Register</title>
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/custom.css">
</head>

<body>
	
			<%
				String addMessage = "<h1>Create a new account</h1>";
				try {
					getConnection();
					String userId = (String) request.getParameter("userId");
					//check if username exists in DB
					String sqlUser = "SELECT * FROM customer WHERE userId = ?";
					PreparedStatement psu = con.prepareStatement(sqlUser);
					psu.setString(1,userId);
					ResultSet urs = psu.executeQuery();
					if(!urs.next()) {
					
					if (userId != null && !userId.equals("")) {
						int updateQuery;
						String firstName = (String) request.getParameter("firstName");
						String lastName = (String) request.getParameter("lastName");
						String email = (String) request.getParameter("email");
						String phoneNum = (String) request.getParameter("phoneNum");
						String address = (String) request.getParameter("address");
						String city = (String) request.getParameter("city");
						String state = (String) request.getParameter("state");
						String postalCode = (String) request.getParameter("postalCode");
						String country = (String) request.getParameter("country");

						String password = request.getParameter("password");
						String SQL = "insert into customer (firstName, lastName, email, phoneNum, address,"
								+ "city, state, postalCode, country, userId, password, admin) Values(?,?,?,?,?,?,?,?,?,?,?,?)";
						PreparedStatement pstmt = con.prepareStatement(SQL, Statement.RETURN_GENERATED_KEYS);
						pstmt.setString(1, firstName);
						pstmt.setString(2, lastName);
						pstmt.setString(3, email);
						pstmt.setString(4, phoneNum);
						pstmt.setString(5, address);
						pstmt.setString(6, city);
						pstmt.setString(7, state);
						pstmt.setString(8, postalCode);
						pstmt.setString(9, country);
						pstmt.setString(10, userId);
						pstmt.setString(11, password);
						pstmt.setInt(12, 0);
						String fullname = firstName + " " + lastName;
						session.setAttribute("fullname", fullname);
						updateQuery = pstmt.executeUpdate();
						ResultSet keys = pstmt.getGeneratedKeys();
						String custID = null;
						if(keys.next())
							custID = keys.getString(1);
						//TODO: test this!!!
						session.setAttribute("uid", custID);
						session.setAttribute("authenticatedUser", userId);
						if (updateQuery != 0) {
							addMessage = "<h2>Account Created Successfully! Welcome to the Cellar Door.</h2>";
						}
					}
					} else {
						addMessage = "<h2>Username already taken, select another one!</h2>";
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
			%>
	<%@ include file="header.jsp"%>
	<div class="container" style="background-color: #403F3D">
		<div class="col-sm-6 p-5">
		<%
		if(addMessage!=null && !addMessage.equals(""))
			out.print(addMessage); 
		%>
				
				<form action="newCustomer.jsp" method="post">
		<div class="form-group">
			<input type="text" name="firstName" id="firstName"
				placeholder="First Name:" class="form-control" required>
		</div>
		<div class="form-group">
			<input type="text" name="lastName" id="lastName"
				placeholder="Last Name:" class="form-control" required>
		</div>
		<div class="form-group">
			<input type="email" name="email" id="email"
				placeholder="Email:" class="form-control" required>
		</div>
		<div class="form-group">
			<input type="text" name="phoneNum" id="phoneNum"
				placeholder="Phone Number:" class="form-control" required>
		</div>
		<div class="form-group">
			<input type="text" name="address" id="address"
				placeholder="Address:" class="form-control" required>
		</div>
		<div class="form-group">
			<input type="text" name="city" id="city"
				placeholder="City:" class="form-control" required>
		</div>
		<div class="form-group">
			<input type="text" name="state" id="state"
				placeholder="State/Province:" class="form-control" required>
		</div>
		<div class="form-group">
			<input type="text" name="postalCode" id="postalCode"
				placeholder="Postal Code:" class="form-control" required>
		</div>
		<div class="form-group">
			<input type="text" name="country" id="country"
				placeholder="Country:" class="form-control" required>
		</div>
		<div class="form-group">
			<input type="text" name="userId" id="userId"
				placeholder="Username:" class="form-control" required>
		</div>
		<div class="form-group">
			<input type="password" name="password" id="password"
				placeholder="Password:" class="form-control" required>
		</div>
		<button type="submit" class="btn btn-secondary btn-sm btn-block">Submit</button>
	</form>
		</div>
	</div>
</body>
</html>
