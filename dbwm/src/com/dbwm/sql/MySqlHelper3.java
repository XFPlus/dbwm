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
	        	Class.forName(name);//ָ����������  
	            conn = DriverManager.getConnection(url, user, password);//��ȡ����  
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
