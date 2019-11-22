<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand" href="index.jsp">The Cellar Door</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse"
    data-target="#navbarSupportedContent"
    aria-controls="navbarSupportedContent" aria-expanded="false"
    aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
<!--
      <li class="nav-item active"><a class="nav-link"
        href="login.jsp">Login <span class="sr-only">(current)</span></a></li> -->

      <li class="nav-item"><a class="nav-link" href="listprod.jsp">Product
          List</a></li>
      <li class="nav-item"><a class="nav-link" href="showcart.jsp">Your
          Shopping Cart</a></li>
      <li class="nav-item dropdown">
      <a href="admin.jsp" class="nav-link dropdown-toggle" id="navbardrop" data-toggle="dropdown">
        Admin
      </a>
      <div class="dropdown-menu">
        <a class="dropdown-item" href="listorder.jsp" style="color: #403F3D;">Orders List</a>
        <a class="dropdown-item" href="admin.jsp" style="color: #403F3D;">Daily Totals</a>
      </div>
    </li>
    <li class="nav-item"><a class="nav-link
      <%
      boolean auth = session.getAttribute("authenticatedUser") == null ? false : true;
      if (!auth)
        out.print(" d-none");
       %>
      " href="customer.jsp">Your
        Information</a></li>
<!---->
    <li class="nav-item dropdown
      <%
      auth = session.getAttribute("authenticatedUser") == null ? false : true;
      if (auth)
        out.print(" d-none");
       %>
      ">
      <a href="login.jsp" class="nav-link dropdown-toggle" data-toggle="dropdown">
						Login</a>
      <div class="dropdown-menu" style="background-color: #736E6C; color: #262524;">
        <div class="row">
          <div class="container-fluid">
              <form method=post action="validateLogin.jsp">
                  <div class="form-group">
                      <label class="">Username</label>
                      <input class="form-control" name="username" id="username" type="text">
                  </div>
                  <div class="form-group">
                      <label class="">Password</label>
                      <input class="form-control" name="password" id="password" type="password">
                      <br class="">
                  </div>
                  <button type="submit" id="btnLogin" class="btn btn-secondary btn-sm">Login</button>
              </form>
          </div>
        </div>
      </div>
    </li>
        <!---->
    </ul>
       <a href="logout.jsp" class="btn btn-secondary
         <%
         auth = session.getAttribute("authenticatedUser") == null ? false : true;
         if (!auth)
           out.print(" d-none");
          %>
          " role="button">Logout</a>
    <form class="form-inline my-2 my-lg-0" action="listprod.jsp"
      method="get">
      <input class="form-control mr-sm-2" type="search"
        placeholder="Search" aria-label="Search" name="productName">
      <button class="btn btn-outline-dark my-2 my-sm-0" type="submit">Search
        for Product</button>
    </form>
  </div>
</nav>
