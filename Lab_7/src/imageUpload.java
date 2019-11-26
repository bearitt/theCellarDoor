import java.sql.*;
import java.io.*;

public class imageUpload {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		System.out.println("Loading database");
		try { // Load driver class
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		} catch (java.lang.ClassNotFoundException e) {
			System.out.println("ClassNotFoundException: " + e);
		}
		String uid = "bjackson";
		String pw = "66122573";
		String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_bjackson;";
		try (Connection con = DriverManager.getConnection(url, uid, pw); Statement stmt = con.createStatement()) {

		} catch (SQLException e) {
			System.err.println(e);
		}
		try (Connection con = DriverManager.getConnection(url, uid, pw); Statement stmt = con.createStatement()) {
			String upprod = "UPDATE product SET productImage = ? WHERE productId = ?";
			PreparedStatement prep = con.prepareStatement(upprod);
			for (int i = 1; i < 47; ++i) {
				File img = new File(".\\WebContent\\img\\" + i + ".jpg");
				FileInputStream input = new FileInputStream(img);
				prep.setBinaryStream(1, input);
				prep.setInt(2, i);
				prep.executeUpdate();
				System.out.println("Image successfully uploaded!");
				input.close();
			}

		} catch (SQLException e) {
			System.err.println(e);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

}
