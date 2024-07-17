package com.mobex.etl;  
// https://razorsql.com/articles/ms_sql_server_jdbc_connect.html
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class JdbcToolListJtds {
 
  public void connect() {

      Connection conn = null;

      try {
        // MSSQL_DRIVER = "net.sourceforge.jtds.jdbc.Driver"
        // # busche-sql.BUSCHE-CNC.com (10.1.2.74)
        // host = 'busche-sql'
        // port = '1433'
        // user = 'sa'
        // password = 'buschecnc1'
        // https://stackoverflow.com/questions/32766114/sql-server-jdbc-error-on-java-8-the-driver-could-not-establish-a-secure-connect
        // String dbURL = "jdbc:sqlserver://localhost\\sqlexpress";
        // String user = "sa";
        // String pass = "secret";
          // String dbURL = "jdbc:sqlserver://10.1.2.74:1433;databaseName=cribmaster";
          // jdbc:sqlserver://10.1.2.74:1433;databaseName=cribmaster
          String user = "sa";
          String pass = "buschecnc1";
          System.out.println("Busche ToolList with jTDS jdbc driver"); 

          Class dbDriver = Class.forName("net.sourceforge.jtds.jdbc.Driver");
          // Class dbDriver = Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
          // url = "jdbc:sqlserver://" +serverName + ":1433;DatabaseName=" + dbName + ";encrypt=true;trustServerCertificate=true;
          // String jdbcURL = "jdbc:sqlserver://10.1.3.80:1433;databaseName=sps;encrypt=true;trustServerCertificate=true;";
          String jdbcURL = "jdbc:jtds:sqlserver://10.1.2.74:1433;databaseName=Busche ToolList;encrypt=true;trustServerCertificate=true;";
          // String jdbcURL = "jdbc:jtds:sqlserver://10.1.2.74:1433;databaseName=cribmaster";
          conn = DriverManager.getConnection(jdbcURL, user, pass);
          // String jdbcURL = "jdbc:sqlserver://192.168.1.172:53000;databaseName=sample;selectMethod=cursor"; 
          // Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
          // DriverManager.registerDriver(new com.microsoft.sqlserver.jdbc.SQLServerDriver());          
          Statement statement = conn.createStatement();
          ResultSet rs = statement.executeQuery("select top 5 * from bvDistinctToollists");
          while(rs.next())
          {
            System.out.println("name = " + rs.getInt("processid"));
            System.out.println("id = " + rs.getString("customer"));
          }
          // conn = DriverManager.getConnection(dbURL, user, pass);
          // if (conn != null) {
          //     DatabaseMetaData dm = (DatabaseMetaData) conn.getMetaData();
          //     System.out.println("Driver name: " + dm.getDriverName());
          //     System.out.println("Driver version: " + dm.getDriverVersion());
          //     System.out.println("Product name: " + dm.getDatabaseProductName());
          //     System.out.println("Product version: " + dm.getDatabaseProductVersion());
          // }

      } catch (SQLException ex) {
          ex.printStackTrace();
      } catch (ClassNotFoundException ex) {
        ex.printStackTrace();
      }
      finally {
          try {
              if (conn != null && !conn.isClosed()) {
                  conn.close();
              }
          } catch (SQLException ex) {
              ex.printStackTrace();
          }
      }
  }
}