import java.sql.*;
import java.io.*;

/*
 * This Class backs up the users in the database to a csv file
 */
public class userBackup {

	public static void main(String[] args) {
		
		String dest = "customer.csv";
		System.out.println(writeCsv(dest));
	}
	
	public static String writeCsv(String dest) {
		String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_bjackson;";
		String uid = "bjackson";
		String pw = "66122573";
		
		try(Connection con=DriverManager.getConnection(url, uid, pw);
				Statement stmt = con.createStatement();) {
			//execute query
			String sql = "SELECT * FROM customer";
			ResultSet rst = stmt.executeQuery(sql);
			//get metadata
			DatabaseMetaData dbmd = con.getMetaData();
			ResultSet rmd = dbmd.getColumns(null, null, "product", "%");
			//set up print writer
			File file = new File(dest);
			if(file.exists()) 
				return "File already exists";
			try(PrintWriter output = new PrintWriter(file);) {
				int j = 0;
				while(rmd.next()) {
					output.print(rmd.getString(4));
					if(++j!=13)
						output.print(",");
					else
						output.print("\n");
				}
				while(rst.next()) {
					for(int i=1;i<=13;++i) {
						output.print(rst.getString(i));
						if(i!=13)
							output.print(",");
						else
							output.print("\n");
					}
				}
			} catch(FileNotFoundException e) {
				e.printStackTrace();
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return "File " + dest + " successfully created!";
	}

}
