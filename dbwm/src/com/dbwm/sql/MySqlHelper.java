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
	                    //if��ѭ���Ĳ��������ǣ��ڴ洢������Ҫʹ�õ��Ĳ���
	                     if (i<inparameters.length-1) {
	                         cs.setObject(i+1, inparameters[i]);  
	                    }
	                     //else�еĲ��������Ǵ洢����ִ����Ϻ󷵻ظ����ǵ�ֵ�����ᱻ������CallableStatement��������棬
	                     //Ȼ�����ǿ��Ը��ݴ������ʱ���ڵ�λ��,���λ�þ��Ǵ����������±�+1ȥȡ�洢���̷��ظ����ǵ�ֵ
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
