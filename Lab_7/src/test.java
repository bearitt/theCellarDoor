import java.sql.*;
import java.io.*;
public class test {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
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
				
			} catch(SQLException e) {
				System.err.println(e);
			}
			try(Connection con = DriverManager.getConnection(url,uid,pw); 
					Statement stmt = con.createStatement()) {
				File img = new File("C:\\Users\\barre_000\\Desktop\\20191124_144342.jpg");
				String upprod = "UPDATE product SET productImage = ? WHERE productId = ?";
				FileInputStream input = new FileInputStream(img);
				PreparedStatement prep = con.prepareStatement(upprod);
				
				prep.setBinaryStream(1, input);
				prep.setInt(2, 1002);
				prep.executeUpdate();
				System.out.println("Image successfully uploaded!");
				input.close();
				
			} catch(SQLException e) {
				System.err.println(e);
			} catch(FileNotFoundException e) {
				e.printStackTrace();
			} catch(IOException e) {
				e.printStackTrace();
			}

	}

}
