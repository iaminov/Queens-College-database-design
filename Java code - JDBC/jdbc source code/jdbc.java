//Made by Isakhar "Alex" Aminov

package jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSetMetaData;

public class jdbc {

	public static StringBuilder runQuery(String database, String user, String password, String query) {	
        StringBuilder results = new StringBuilder();

		String connectionUrl =
                "jdbc:sqlserver://localhost:12001;"
                + "database="+database+";"
                + "user="+user+";"
                + "password=" + password+";"
                + "encrypt=false;"
                + "trustServerCertificate=false;"
                + "loginTimeout=30;";
        
        ResultSet resultSet = null;

        try (Connection connection = DriverManager.getConnection(connectionUrl);
                Statement statement = connection.createStatement();) {

            resultSet = statement.executeQuery(query);
            ResultSetMetaData rsmd = resultSet.getMetaData();
            int columnsNumber = rsmd.getColumnCount();
            
            
            for(int i=1; i<=columnsNumber;i++) {
            	results.append(rsmd.getColumnName(i)+ " ");
            }
            results.append("\n");
            int rowNumber=1;
            
            while (resultSet.next()) {    
	            results.append(rowNumber+". ");
	            for (int i=1; i<=columnsNumber;i++) {            	       	
	               results.append(resultSet.getString(i)+" ");
	            } 
	            results.append("\n");
	            rowNumber++;

            }

        }
        catch (SQLException e) {
            e.printStackTrace();
        }
    		
		return results;
		
		
	}
    public static void main(String[] args) {
        
        System.out.println(runQuery("Northwinds2020TSQLV6","sa","PH@123456789", 
         		 "SELECT TOP(5) O.OrderID, C.CustomerID, YEAR(O.OrderDate) AS OrderDate, O.EmployeeID FROM Sales.Customer AS C LEFT JOIN Sales.[Order] AS O ON O.CustomerId = C.CustomerId GROUP BY O.OrderId, C.CustomerId, YEAR(O.OrderDate), O.EmployeeId"
   ));

	}
}


