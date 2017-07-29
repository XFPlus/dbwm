package com.dbwm.sql;

import java.sql.*;
public class pro2 {
	String str1=null;
	String str2=null;
	String str3=null;
	String str4=null;
	public void seting(String str11,String str22,String str33,String str44){
		str1=str11;
		str2=str22;
		str3=str33;
		str4=str44;
	}
	public void run(){
		MySqlHelper myhelper=new MySqlHelper();
		  String[] sqlParameter=new String[]{str1,str2,str3,str4,""};
          //调用存储过程的的字符串
         String  executString="call prolog1(?,?,?,?,?)";
         //调用存储过程的的字符串  outPutProcudure就是我们的存储过程名称，然后两个?表示两个参数，1是我们参数的参数，第二是我们存储过程处理完后返回的值
         CallableStatement  proReturnData=myhelper.callProcInputAndOutPut(executString, sqlParameter);
         try {
              //取值 由于带OUT参数的返回值在我们存储过程中参数的位置是第二位所以我们 使用GETINT(2),接着我会贴存储过程
             int returnValue= proReturnData.getInt(5);
             if (returnValue==1) {
                  String groupAlertString="返回值是:"+returnValue+"--->插入成功.";
                  System.out.println(groupAlertString);
             }
             else 
             {
              String groupAlertString="返回值是:"+returnValue+"--->插入失败，该用户名已经存在.";
                 System.out.println(groupAlertString);
             }
              
         } catch (SQLException e) {
          
             e.printStackTrace();
         }
	}
}