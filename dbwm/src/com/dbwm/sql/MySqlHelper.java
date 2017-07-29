package com.dbwm.sql;

import java.sql.*;
import java.util.Properties;

public class MySqlHelper {
	 	
	  
	    public Connection conn = null;  
	    public PreparedStatement pst = null;
	    public CallableStatement cs =null;
	    
	    public  CallableStatement callProcInputAndOutPut(String sql, String[] inparameters) {
	    	String driverName = null;
			String dbURL = null;
			String userName = null;
			String userPwd = null;
			try {
				Properties pro = new Properties();
				pro.load(getClass().getResourceAsStream("/jdbc.properties"));
				driverName = pro.getProperty("jdbc.driver");
				dbURL = pro.getProperty("jdbc.url");
				userName = pro.getProperty("jdbc.username");
				userPwd = pro.getProperty("jdbc.password");
			} catch (Exception e) {
				e.printStackTrace();
			}
	        try {
	        	Class.forName(driverName);
				conn = DriverManager.getConnection(dbURL, userName, userPwd); 
	            if(!conn.isClosed())
	            	   System.out.println("Succeeded connecting to the Database!");
	            cs = conn.prepareCall(sql);
	            if(inparameters!=null)
	                for(int i=0;i<inparameters.length;i++)
	                {
	                    //if中循环的参数是我们，在存储过程需要使用到的参数
	                     if (i<inparameters.length-1) {
	                         cs.setObject(i+1, inparameters[i]);  
	                    }
	                     //else中的参数是我们存储过程执行完毕后返回给我们的值，它会被保存在CallableStatement这个类里面，
	                     //然后我们可以根据传入参数时所在的位置,这个位置就是传入的数组参下标+1去取存储过程返回给我们的值
	                     else {
	                         cs.registerOutParameter(5, java.sql.Types.VARCHAR);
	                         
	                    }
	                     
	                }
	                   
	            cs.execute();
	        }
	        catch (Exception e) {
	            e.printStackTrace();
	            throw new RuntimeException(e.getMessage());
	        }finally{
	           
	        }
	        return cs;
	    }
}
