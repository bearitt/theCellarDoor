import java.sql.*;
public class test {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		try
		{	// Load driver class
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		}
		catch (java.lang.ClassNotFoundException e)
		{
			System.out.println("ClassNotFoundException: " +e);
		}
			String uid = "bjackson";
			String pw = "66122573";
			String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_bjackson;";
			try(Connection con = DriverManager.getConnection(url,uid,pw); 
					Statement stmt = con.createStatement();) {
//				String updateUser = "INSERT INTO Customer (firstName,lastName,email,phonenum,address,"
//						+ "city,state,postalCode,country,userid,password)"
//						+ "  VALUES ('Joe','Blow','joe@joe.something',"
//						+ "'555-555-5555','5 Fake Street','Jacksonville','Florida','12345','USA',"
//						+ "'theBlowestJoe','password')";
//				int rowcount = stmt.executeUpdate(update, Statement.RETURN_GENERATED_KEYS );
//				ResultSet autoKeys = stmt.getGeneratedKeys();
//				System.out.println(autoKeys.getInt(1));
//				System.out.println(rowcount);
//				String removeUser = "DELETE FROM Customer WHERE customerId=6";
//				stmt.executeUpdate(removeUser);
				String sql = "SELECT O.orderId, orderDate, C.customerId, CONCAT(firstName, ' ', lastName) " + 
						"AS name, totalAmount, P.productId, quantity, price " +
						"FROM ordersummary O JOIN customer C ON O.customerId = C.customerId " +
						"JOIN orderproduct P ON O.orderId = P.orderId";
				String query = "SELECT * FROM ordersummary";
				ResultSet rst = stmt.executeQuery(sql);
				while(rst.next()) 
					for(int i=1;i<9;++i)
						System.out.println(rst.getString(i));
				
		} catch(SQLException e) {
			System.err.println(e);
		}		
	}

}
