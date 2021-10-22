//Made by Isakhar "Alex" Aminov


package jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.sql.ResultSetMetaData;
import javax.swing.JFrame; 
import javax.swing.JScrollPane; 
import javax.swing.JTable; 

public class jdbcWithJTable {

	public static StringBuilder runQuery(String database, String user, String password, String query) {	
      StringBuilder results = new StringBuilder();
      JFrame f= new JFrame();
      f.setTitle("Results of Query");
      JTable jt;
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
          
          String[] columnNames=new String[columnsNumber+1];
          
          columnNames[0]="Row Number";
          
          for(int i=1; i<=columnsNumber;i++) {
        	  columnNames[i]=rsmd.getColumnName(i);
          }
          int rowNumber=0;
          ArrayList<ArrayList<String>> data=new ArrayList<>();  
          
          while (resultSet.next()) {    
        	  	data.add(new ArrayList<String>());
          		data.get(rowNumber).add(rowNumber+1+"");
	            for (int i=1; i<=columnsNumber;i++) {
	          		data.get(rowNumber).add(resultSet.getString(i));
	            } 
	            rowNumber++;

          }
          
          
          String[][] array = new String[data.size()][];
          for (int i = 0; i < data.size(); i++) {
              ArrayList<String> row = data.get(i);
              array[i] = row.toArray(new String[row.size()]);
          }

          jt = new JTable(array, columnNames); 
          jt.setBounds(30, 40, 200, 300); 
          JScrollPane sp = new JScrollPane(jt); 
          f.add(sp); 
          f.setSize(1000, 700); 
          f.setVisible(true); 
      }
      catch (SQLException e) {
          e.printStackTrace();
      }
  		
		return results;
		
		
	}
  public static void main(String[] args) {
      
      System.out.println(runQuery("QueensClassScheduleFall2020","sa","PH@123456789", 
    		   "EXEC Project3.loadqueenscourseschedule"));
      
      System.out.println(runQuery("QueensClassScheduleFall2020","sa","PH@123456789", 
   		   "EXEC Process.usp_ShowWorkflowSteps @GroupMemberUserAuthorizationKey = 1"));
      
      System.out.println(runQuery("QueensClassScheduleFall2020","sa","PH@123456789", 
    		  "select UserAuthorizationKey, sum(DATEDIFF(millisecond, StartingDateTime, EndingDateTime)) as total_time_in_ms, COUNT(*) AS number_of_procedures from Process.WorkflowSteps group by UserAuthorizationKey" ));
      
      System.out.println(runQuery("QueensClassScheduleFall2020","sa","PH@123456789", 
    		  "select sum(DATEDIFF(millisecond, StartingDateTime, EndingDateTime)) as total_time_in_ms_for_entire_database from Process.WorkflowSteps group by classtime"));
     

	}
}


