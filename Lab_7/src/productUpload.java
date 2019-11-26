import java.sql.*;
import java.io.*;

public class productUpload {

	public static void main(String[] args) {
		String src = ".\\data\\newProducts.csv";
		String result = upload(src);
		System.out.println(result);
	}
	
	public static String upload(String src) {
		String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_bjackson;";
		String uid = "bjackson";
		String pw = "66122573";
		
		try(Connection con=DriverManager.getConnection(url, uid, pw);
				Statement stmt = con.createStatement();) {
			String sql = "INSERT INTO product(productName,productPrice,"
					+ "productDesc,categoryId) VALUES (?,?,?,?)";
			PreparedStatement pstmt = con.prepareStatement(sql);
			
			try {
			BufferedReader csvReader = new BufferedReader(new FileReader(src));
			
			String row;
			csvReader.readLine();
			while((row = csvReader.readLine()) != null) {
				String data[] = row.split(",");
				
				pstmt.setString(1, data[1]);
				pstmt.setDouble(2, Double.parseDouble(data[2]));
				pstmt.setString(3, data[5]);
				pstmt.setInt(4, Integer.parseInt(data[6]));
				pstmt.executeUpdate();
			}
			csvReader.close();
			
			
			}catch(FileNotFoundException e) {
				e.printStackTrace();
			}catch(IOException i) {
				i.printStackTrace();
			}
			
			return "Product uploaded!";
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return "Hey man! Ya fucked up!";
	}

}
