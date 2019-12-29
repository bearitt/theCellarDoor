<nav class="navbar navbar-expand-lg navbar-light bg-light">
	<a class="navbar-brand" href="index.php">
	<img src="https://lh3.googleusercontent.com/rmwKzIc0sCuVZMbjGuomfRYmlxqcecoUA32kRLMc4KqzJoOrFLxZKiIsbRp7pfe8nJNaJPkPOrc9B2d8gg5LyF6mFrH0IZcRpTsqY83aYRf3NocDJx9VHL77nZC6dSQubgH3rM14nAw=w2400"
	alt="Logo" style="width:25px">
	</a>
	<button class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#navbarSupportedContent"
		aria-controls="navbarSupportedContent" aria-expanded="false"
		aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>
	<div class="collapse navbar-collapse" id="navbarSupportedContent">
		<ul class="navbar-nav mr-auto">
			<li class="nav-item"><a class="nav-link" href="listprod.php">
			<i class="fas fa-shopping-basket"></i> Product List</a></li>
			<li class="nav-item"><a class="nav-link" href="showcart.php">
			<i class="fas fa-shopping-cart"></i> Your Shopping Cart</a></li>
			<li class="nav-item dropdown

			<?php
			session_start();
      if(!isset($_SESSION['admin']))
        echo ' d-none';?>

			"><a href="admin.php"
				class="nav-link dropdown-toggle" id="navbardrop"
				data-toggle="dropdown"><i class="fas fa-users-cog"></i> Admin </a>
				<div class="dropdown-menu">
					<a class="dropdown-item" href="listorder.php"
						style="color: #403F3D;"><i class="fas fa-poll-h"></i> Orders List</a>
					<a class="dropdown-item"
						href="admin.php" style="color: #403F3D;">
						<i class="fas fa-search-dollar"></i> Daily Totals</a>
					<a class="dropdown-item"
						href="listCustomer.php" style="color: #403F3D;">
						<i class="fas fa-users"></i> View User Accounts</a>
					<a class="dropdown-item"
						href="addProduct.php" style="color: #403F3D;">
						<i class="far fa-plus-square"></i> Add New Product</a>
					<a class="dropdown-item"
						href="updateProduct.php" style="color: #403F3D;">
						<i class="fas fa-edit"></i> Update Product Record</a>
				</div></li>
			<li class="nav-item"><a
				class="nav-link

      <?php
      if(!isset($_SESSION["authenticatedUser"]))
        echo ' d-none';?>

      "
				href="customer.php"><i class="fas fa-clipboard"></i> Your Information</a></li>
			<li
				class="nav-item dropdown

      <?php
      if(isset($_SESSION["authenticatedUser"]))
        echo ' d-none';?>

      ">
				<a href="login.php" class="nav-link dropdown-toggle"
				data-toggle="dropdown"><i class="fas fa-user-circle"></i> Login</a>
				<div class="dropdown-menu"
					style="background-color: #736E6C; color: #262524;">
					<div class="row">
						<div class="container-fluid">
							<form method=post action="validateLogin.php">
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
								<p>Or create a new account <a href="newCustomer.php">here!</a></p>
							</form>
						</div>
					</div>
				</div>
			</li>
		</ul>
		<span class="navbar-text">

      <?php
      if(!isset($_SESSION["fullname"]))
        echo 'Welcome ' . $_SESSION["fullname"] . '&nbsp';?>

		</span> <a href="logout.php"
			class="btn btn-secondary

         <?php if(!isset($_SESSION['authenticatedUser']))
           echo ' d-none';?>

          "
			role="button">Logout</a>
		<form class="form-inline my-2 my-lg-0" action="listprod.php"
			method="get">
			<input class="form-control mr-sm-2" type="search"
				placeholder="Search" aria-label="Search" name="productName">
			<button class="btn btn-outline-dark my-2 my-sm-0" type="submit">Search
				for Product</button>
		</form>
	</div>
</nav>
<script src="https://kit.fontawesome.com/e9d963041d.js" crossorigin="anonymous"></script>
