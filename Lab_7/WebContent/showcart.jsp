<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.util.Map"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>The Cellar Door - Your Shopping Cart</title>
	<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="css/custom.css">
	<style>
	.btn-group {
		vertical-align: middle;
	}
	</style>
	</head>
<body>
<script>
	function update(newid,newqty)
	{
		window.location="showcart.jsp?update="+newid+"&newqty="+newqty;
	}
</script>
<%@ include file="header.jsp"%>
	<div class="container" style="background-color: #403F3D; text-align:center;">
		<div class="col-sm-12 p-5">
			<%
				// Get the current list of products
				@SuppressWarnings({ "unchecked" })
				HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session
						.getAttribute("productList");
				String delete = request.getParameter("delete");
				if ((delete!=null && productList!=null) && (!delete.equals("-1") && productList.containsKey(delete)))
					productList.remove(delete);
				String newId = request.getParameter("newid");
				String newQty = request.getParameter("newqty");
				if(newId!=null&&newQty!=null&&productList.containsKey(newId)&&newQty.equals("0"))
					productList.remove(newId);
				if(productList==null || productList.size()==0) {
					session.setAttribute("productList",null);
					productList=null;
				}
				else if(delete!=null&&delete.equals("-1")) {
					session.setAttribute("productList",null);
					productList=null;
				}
				if (productList == null) {
					out.println("<H1>Your shopping cart is empty!</H1>");
					productList = new HashMap<String, ArrayList<Object>>();
				} else {
					NumberFormat currFormat = NumberFormat.getCurrencyInstance();

					out.println("<h1>Your Shopping Cart</h1>");
					out.print("<table class=\"table table-borderless table-hover table-responsive-md\""+
					" style=\"color:#F2E8DF\"><thead><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th>");
					out.println("<th>Price</th><th>Subtotal</th><th></th><th></th></tr></thead><tbody>");
					out.println("<form method=\"get\" class=\"form-inline\" name=\"form1\""+
					" action=\"showcart.jsp\">");
					double total = 0;
					Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
					while (iterator.hasNext()) {
						Map.Entry<String, ArrayList<Object>> entry = iterator.next();
						ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
						if (product.size() < 4) {
							out.println("Expected product with four entries. Got: " + product);
							continue;
						}
						if(newId!=null&&newId.equals(product.get(0).toString()))
							product.set(3,request.getParameter("newqty"));
						//make orderId read only
						out.print("<tr><td><input type=\"text\" class=\"form-control\""+
						" name=\"newid\" value=\""+product.get(0)+"\" readonly>");
						out.print("<td>" + product.get(1) + "</td>");
						//form for changing quantity
						out.print("<td><input type=\"text\" class=\"form-control\""+
							"name=\"newqty\" value=\""+product.get(3)+"\">");
						Object price = product.get(2);
						Object itemqty = product.get(3);
						double pr = 0;
						int qty = 0;

						try {
							pr = Double.parseDouble(price.toString());
						} catch (Exception e) {
							out.println("Invalid price for product: " + product.get(0) + " price: " + price);
						}
						try {
							qty = Integer.parseInt(itemqty.toString());
						} catch (Exception e) {
							out.println("Invalid quantity for product: " + product.get(0) + " quantity: " + qty);
						}

						out.print("<td align=\"right\">" + currFormat.format(pr) + "</td>");
						out.print("<td align=\"right\">" + currFormat.format(pr * qty) + "</td>");

						//delete entry
						out.print("<td><a href=\"showcart.jsp?delete="+product.get(0)+"\">");
						out.print("Remove from cart</a></td><td></td>");
						//button to update cart
						out.print("<td><button type=\"submit\" class=\"btn btn-secondary\">"+
						 "Update Quantity</button></td>");
						//end table row
						out.println("</tr></tr>");


						total = total + pr * qty;
					}
					out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>" + "<td align=\"right\">"
							+ currFormat.format(total) + "</td></tr></tbody></form></table>");



				}

			%>
		</div>
		<div class="col-sm-12 p-5">
			<div class="btn-group btn-group-lg">
				<a href="showcart.jsp?delete=-1" class="btn btn-secondary" role="button">Clear Cart</a>
				<a href="order.jsp" class="btn btn-secondary" role="button">Check Out</a>
				<a href="listprod.jsp" class="btn btn-secondary" role="button">Continue Shopping</a>
			</div>
		</div>
	</div>
	<script src="js/jquery-3.4.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</body>
</html>
