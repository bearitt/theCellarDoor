<!DOCTYPE html>
<html>
  <head>
  	<meta charset="utf-8">
  	<meta name="viewport" content="width=device-width, initial-scale=1">
  	<title>The Cellar Door - Homepage</title>
  	<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
  	<link rel="stylesheet" type="text/css" href="css/custom.css">
  	<style>
  	  .carousel-inner img{
      -webkit-filter: grayscale(90%);
      filter:grayscale(90%);
      margin:auto;
      width:100%;
    }
    .card{
    background-color:#736E6C;
    }
  	</style>
  </head>
<body>
<%@ include file="header.jsp" %>
<div class="container" style="background-color:#A6A29F">
  <div class="row">
        <div class="col-sm-12 p-5">
          <div id="myCarousel" class="carousel slide" data-ride="carousel">
            <!-- Indicators -->
            <ol class="carousel-indicators">
              <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
              <li data-target="#myCarousel" data-slide-to="1"></li>
              <li data-target="#myCarousel" data-slide-to="2"></li>
              <li data-target="#myCarousel" data-slide-to="3"></li>
              <li data-target="#myCarousel" data-slide-to="4"></li>
              <li data-target="#myCarousel" data-slide-to="5"></li>
            </ol>

            <!-- Wrapper -->
            <div class="carousel-inner" role="listbox">
              <div class="carousel-item active">
                <img src="https://lh3.googleusercontent.com/e7wedhrw4JJCFaaAnniQ9j1nVCh6WNTbGtaVssz74Lw4FRIbaNgt_mO-9YHoJ5jJDdSr6YJdz3QezruMlJLFKvvMIJYPv3bWhybEykCbkgfty85vCEOwppQbyrWLKv_y2MUjFaeE9to=w2400" alt="Barrels" class="img-responsive">
              </div>

              <div class="carousel-item">
                <img src="https://lh3.googleusercontent.com/oQvKgPR4WEv-NBoNwBjYEPVDwloQtRUJ3Rgd9ragjo4Zi9pPXlT7xdwMZvNsqmSmF3cXG_6KDL45resZDwDx0cI62os48ZhLep7JmmFSlcU_QMgpcEHtYR4zxvbJ0rNedZ2i0-u6hdw=w2400" alt="Grapes" class="img-responsive">
              </div>

              <div class="carousel-item">
                <img src="https://lh3.googleusercontent.com/pHgmKn3BqrZKbnaa2osTMcAfSyspTTvMRP9dfo5nPFz9i0F0V8aMKO_PWv5MGjT4h4BsqAJ1JRbvDPk0QmbyMWOcGCAa9e9Ic5Y9SvTVXsKPMBsxHPB9YFMgpR0d3TGoQjnM4S8sTvM=w2400" alt="Vineyard" class="img-responsive">
              </div>

              <div class="carousel-item">
                <img src="https://lh3.googleusercontent.com/TWV124WZRXw4jo8bHSTwbnOdAOqRD_JZIA1QlV8Y2u_u06_l6ymE57uFVxI5kAtd5is24ASuP7O5S1_xdKo9u6f6KBzdbkDlL9yO5a87Lw2q8ELeMM0WYepC69OnBRvQ7Q4BM4isLT4=w2400" alt="Bucket" class="img-responsive">
              </div>

              <div class="carousel-item">
                <img src="https://lh3.googleusercontent.com/yzCvsag1XzCRAK4Ad8Ff3RgdlVRt9FYNTnzkQG7P3GbbuxwifHXZMhbqNjQ1GCfr8kgfBtFUgf45yF-Hs-Rw-q7ZpJNW_uv_6ba1p7BVb8yzJnM2EQ6lUAtup23ZraiB6j6x3LQCmdg=w2400" alt="Glasses" class="img-responsive">
              </div>

              <div class="carousel-item">
                <img src="https://lh3.googleusercontent.com/3GEXF14f-XjfSNcSXdU1wu6dVkWgeUlfzOzgIzXViPtVn-Xo_lAPDu_G6Nal_8r1UMaQxcwzhaPEnb4lPFLkswGDbNrUcjtjCDBDJHMeYoVIHhLVcjbf-lXUNOjzhJsyc8JujGXjZUA=w2400" alt="Bottles" class="img-responsive">
              </div>

            </div>

            <!-- Left and right controls -->
            <a class="carousel-control-prev" href="#myCarousel" role="button" data-slide="prev">
              <span class="carousel-control-prev-icon"></span>
              <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#myCarousel" role="button" data-slide="next">
              <span class="carousel-control-next-icon" aria-hidden="true"></span>
              <span class="sr-only">Next</span>
            </a>
          </div>
        </div>
      </div>
    </div>
	<div class="container" style="background-color: #403F3D">
		<div class="row">
			<div class="col-sm-8 p-5">
        <%
        String username = (String) session.getAttribute("fullname");
        if(username != null) {
        	out.println("Welcome to the Cellar Door " + username +
          ", the premiere wine shop showcasing fine wines from BC" +
          " and around the world.</p>");
        } else {
          out.println("<p>Welcome to the Cellar Door, the premiere wine shop" +
        " showcasing fine wines from BC and around the world.</p>");
        }
        %>
		</div>
		<div class="col-sm-4 p-5">

		<div class="card">
			<a href="listprod.jsp">
				<img class="card-img-top img-thumbnail" src="img/prodthumb.jpg" 
				width=250 height=250 alt="Wine bottle">
			</a>
			<div class="card-body">
			<h4 class="card-title">Products</h4>
			<p class="card-text">Start your journey to Bacchanalia</p>
			</div>
		</div>
		<div class="card">
			<a href="login.jsp">
				<img class="card-img-top img-thumbnail" src="img/thumbscrew.jpg" 
				width=250 height=250 alt="Corkscrew">
			</a>
			<div class="card-body">
			<h4 class="card-title">Login</h4>
			<p class="card-text">Welcome back to The Cellar Door, login here!</p>
			</div>
		</div>
		<div class="card">
			
			<div class="card-body">
			<h4 class="card-title">
			<a href="newCustomer.jsp">
				<i class="fas fa-user-circle"></i> Sign up</a></h4>
			<p class="card-text">What's that, you want to join the club? Come on in, everyone is welcome!</p>
			</div>
		</div>	
        
			</div>
		</div>
	</div>
	<script src="js/jquery-3.4.1.min.js"></script>
  <script src="js/bootstrap.min.js"></script>



</body>
