<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>The Cellar - Checkout</title>
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/custom.css">
</head>
<body>
	<%@ include file="jdbc.jsp"%>
	<%@ include file="header.jsp"%>
	<div class="container" style="background-color: #403F3D">
		<div class="col-sm-12 p-5">
			<%
				//check for validate user
				boolean authorized = session.getAttribute("authenticatedUser") == null ? false : true;

				if (!authorized) {
			%>
			<div class="container-fluid">
				<h1>Login to complete the transaction:</h1>
				<form method=post action="validateLogin.jsp">
					<div class="form-group">
						<label class="">Username</label> <input class="form-control"
							name="username" id="username" type="text">
					</div>
					<div class="form-group">
						<label class="">Password</label> <input class="form-control"
							name="password" id="password" type="password"> <br
							class="">
					</div>
					<button type="submit" id="btnLogin"
						class="btn btn-secondary btn-sm">Login</button>
				</form>
			</div>
			<%
				}else{
					String redirectURL = "order.jsp";
				    response.sendRedirect(redirectURL);
				}
			%>

			
		</div>
	</div>
	<script src="js/jquery-3.4.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</body>
</html>
