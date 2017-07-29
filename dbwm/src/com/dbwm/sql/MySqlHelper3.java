package com.dbwm.sql;


import java.sql.*;

public class MySqlHelper3 {
	 public static final String url = "jdbc:mysql://localhost/dbwm";  
	    public static final String name = "com.mysql.jdbc.Driver";  
	    public static final String user = "root";  
	    public static final String password = "";  
	  
	    public Connection conn = null;  
	    public PreparedStatement pst = null;
	    public CallableStatement cs =null;
	    
	    public  CallableStatement callProcInputAndOutPut(String sql, String[] inparameters) {
	        try {
	        	Class.forName(name);//指定连接类型  
	            conn = DriverManager.getConnection(url, user, password);//获取连接  
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
	                         cs.registerOutParameter(3, java.sql.Types.VARCHAR);
	                         
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
