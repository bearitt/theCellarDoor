import java.sql.*;
import java.io.*;

/*
 * This Class is where I would test out different methods, queries, and updates
 */
public class test {

	public static void main(String[] args) {
//		// TODO Auto-generated method stub
//		System.out.println("Loading database");
//		try
//		{	// Load driver class
//			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
//		}
//		catch (java.lang.ClassNotFoundException e)
//		{
//			System.out.println("ClassNotFoundException: " +e);
//		}
//			String uid = "bjackson";
//			String pw = "66122573";
//			String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_bjackson;";
//			try(Connection con = DriverManager.getConnection(url,uid,pw);
//					Statement stmt = con.createStatement()) {
//				
//			} catch(SQLException e) {
//				System.err.println(e);
//			}
//			try(Connection con = DriverManager.getConnection(url,uid,pw); 
//					Statement stmt = con.createStatement()) {
//				File img = new File("C:\\Users\\barre_000\\Desktop\\20191124_144342.jpg");
//				String upprod = "UPDATE product SET productImage = ? WHERE productId = ?";
//				FileInputStream input = new FileInputStream(img);
//				PreparedStatement prep = con.prepareStatement(upprod);
//				
//				prep.setBinaryStream(1, input);
//				prep.setInt(2, 1002);
//				prep.executeUpdate();
//				System.out.println("Image successfully uploaded!");
//				input.close();
//				
//			} catch(SQLException e) {
//				System.err.println(e);
//			} catch(FileNotFoundException e) {
//				e.printStackTrace();
//			} catch(IOException e) {
//				e.printStackTrace();
//			}
		System.out.println("Loading database");
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
					Statement stmt = con.createStatement()) {
				
//				String sql = "UPDATE customer SET admin=1 WHERE userid='jailbreakjake'";
//				stmt.executeUpdate(sql);
//				String sql1 = "SELECT * FROM inCart";
//				ResultSet rs = stmt.executeQuery(sql1);
//				while(rs.next()) {
//					for(int i=1;i<=4;++i ) {
//						System.out.println(rs.getString(i));
//					}
//				}
				String sqlReview = "SELECT reviewId, reviewRating, reviewDate, customerId"+
						" FROM review WHERE ";
				PreparedStatement psrev = con.prepareStatement(sqlReview);
				//psrev.setInt(1, 1);
				ResultSet rsrev = psrev.executeQuery();
				while(rsrev.next()) {
					for(int i=1;i<5;++i)
						System.out.println(rsrev.getString(i));
				}
//				DatabaseMetaData dmd = con.getMetaData();
//				ResultSet rs1 = dmd.getColumns(null, null, "review", "%");
//				while(rs1.next()) {
//					System.out.println(rs1.getString(4));
//				}
			} catch(SQLException e) {
				System.err.println(e);
			} finally {
				System.out.println("All done!");
			}
	}

}
