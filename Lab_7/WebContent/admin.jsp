<!DOCTYPE html>
<%@ include file="jdbc.jsp" %>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.ArrayList"%>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>The Cellar Door - Daily Totals</title>
  <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
  <link rel="stylesheet" type="text/css" href="css/custom.css">
</head>
<body>
  <%@ include file="auth.jsp"%>
  <%@ include file="header.jsp"%>
  <div class="container" style="background-color: #403F3D;">
  		<div class="row">
  <table class="table table-hover table-borderless table-responsive-md">
    <thead><tr>
      <th>Order Date</th><th>Total Order Amount</th>
    </tr></thead>
    <tbody>
<%
//connection
try {
  getConnection();
	//sql string
	String sql = "SELECT orderDate, SUM(totalAmount) FROM ordersummary GROUP BY orderDate";

	//statement
	PreparedStatement pstsales = con.prepareStatement(sql);
	
	//resultset
	ResultSet rst = pstsales.executeQuery();
	NumberFormat currFormat = NumberFormat.getCurrencyInstance();
	double dailyTotal = 0.0;
	//array lists created to store dates and totals
	ArrayList<String> dates = new ArrayList<String>();
	ArrayList<Double> dailyTotals = new ArrayList<Double>();
	int count = 0;
  while(rst.next()) {
	//get date from database and format
	Date rawDate = rst.getDate(1);
	Calendar cal = Calendar.getInstance();
	cal.setTime(rawDate);	
	StringBuilder date = new StringBuilder();
	date.append(cal.get(Calendar.YEAR));
	String month = "" + cal.get(Calendar.MONTH);
	if(month.length()<2)
		month="0"+month;
	date.append("-" + month);
	date.append("-" + cal.get(Calendar.DAY_OF_MONTH));
	String printDate = date.toString();
	
	//for first entry into arraylists, add date and total to the first position
	if(dates.isEmpty()) {
		dailyTotal = rst.getDouble(2);
		dailyTotals.add(dailyTotal);
		dates.add(printDate);
	}
	//if date from current row of result set is same as previous date
	//increment daily total amount in arraylist with current result set amount
	else if(printDate.equals(dates.get(count))) {
		dailyTotal = dailyTotals.get(count) + rst.getDouble(2);
		dailyTotals.set(count,dailyTotal);
	}
	//if date from current result set is different from previous date, add new
	//entries for date and daily total
	else {
		dates.add(printDate);
		dailyTotals.add(rst.getDouble(2));
		++count;
	}
  }
  //print out the arraylists in a table
  for(int i=0;i<dates.size();++i) {
	  out.print("<tr><td>");
	  out.print(dates.get(i)+"</td>");
	  out.print("<td>"+currFormat.format(dailyTotals.get(i))+"</td>");
	  out.print("</tr>");
  }
} catch(SQLException e){
	//error occured
	System.out.println("SQL exception");
}
%>
</tbody></table>
</div></div>
<script src="js/jquery-3.4.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
</body>
</html>
