<!DOCTYPE html>
<%@ page import="java.text.NumberFormat"%>
<%@ include file="jdbc.jsp"%>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>The Cellar Door - Customer List</title>
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/custom.css">
</head>
<body>
	<%@ include file="auth.jsp"%>
	<%@ include file="adminAuth.jsp"%>
	<%@ include file="header.jsp"%>
	<div class="container" style="background-color: #403F3D;">
		<div class="row">
			<div class="col-sm-6 p-5">
			<h1>Active Users</h1>
				<%
					try {
						getConnection();
						String sql = "Select * From customer";
						PreparedStatement pstmt = con.prepareStatement(sql);

						ResultSet rst = pstmt.executeQuery();
						out.print("<table class=\"table table-hover table-borderless table-responsive-md\"><tbody>");
						while (rst.next()) {
							String[] fields = { "", "Id", "First Name", "Last Name", "Email", "Phone", "Address", "City",
									"State", "Postal Code", "Country", "User Id" };
							int count = rst.getInt(1);
							//print id
							out.print("<tr><td><strong>" + fields[11] + "</strong></td>");
							out.print("<td>"+rst.getString(11)+"</td></tr>");
							//create button to display user info
							out.print("<tr><td colspan=\"2\">");
							out.print("<button data-toggle=\"collapse\" data-target=\"#userInfo"+count+"\" type=\"button\"" +
							" class=\"btn btn-secondary\">Click for user information</button>");
							//create nested table for user information
							out.print("<div id=\"userInfo" + count + "\" class = \"collapse\">");
							out.print("<table class=\"table table-hover\">");
							/*
							out.println("<tr align=\"right\"><td colspan=\"5\">"
								+ "<button data-toggle=\"collapse\" data-target=\"#prodList" + j
								+ "\" type=\"button\" class=\"btn btn-secondary\">Click for list of products</button>"
								+ "<div id=\"prodList" + (j++) + "\" class=\"collapse\">" +
								"<table class=\"table-hover\">"
								+ "<thead><th>Product Id</th> <th>Quantity</th>" + "<th>Price</th></tr></thead>");
							*/
							
							
							
							for (int i = 1; i < 12; ++i) {
								out.println("<tr>");
								out.print("<td><strong>" + fields[i] + "</strong></td>");
								String temp;
								if (rst.getString(i).equals("") || rst.getString(i) == null)
									temp = "NA";
								else
									temp = rst.getString(i);
								out.println("<td>" + temp + "</td></tr>");
							}
							out.print("<td><strong>User Type</strong></td>");
							out.print("<td>" + (rst.getInt(13) == 1 ? "admin" : "customer") +
							"</td>");
							out.println("</table></div></td></tr>");
						}
						out.println("</tbody></table>");
					} catch (SQLException e) {
						System.err.println(e);
					} finally {
						closeConnection();
					}
				%>
			</div>
		</div>
	</div>
	<script src="js/jquery-3.4.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</body>
</html>