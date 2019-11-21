<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand" href="shop.html">The Cellar Door</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse"
    data-target="#navbarSupportedContent"
    aria-controls="navbarSupportedContent" aria-expanded="false"
    aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active"><a class="nav-link"
        href="shop.html">Home <span class="sr-only">(current)</span></a></li>
      <li class="nav-item"><a class="nav-link" href="listorder.jsp">Orders
          List</a></li>
      <li class="nav-item"><a class="nav-link" href="listprod.jsp">Product
          List</a></li>
      <li class="nav-item"><a class="nav-link" href="showcart.jsp">Your
          Shopping Cart</a></li>
    </ul>
    <form class="form-inline my-2 my-lg-0" action="listprod.jsp"
      method="get">
      <input class="form-control mr-sm-2" type="search"
        placeholder="Search" aria-label="Search" name="productName">
      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search
        for Product</button>
    </form>
  </div>
</nav>
