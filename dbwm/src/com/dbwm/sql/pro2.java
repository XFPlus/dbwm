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
          //���ô洢���̵ĵ��ַ���
         String  executString="call prolog1(?,?,?,?,?)";
         //���ô洢���̵ĵ��ַ���  outPutProcudure�������ǵĴ洢�������ƣ�Ȼ������?��ʾ����������1�����ǲ����Ĳ������ڶ������Ǵ洢���̴�����󷵻ص�ֵ
         CallableStatement  proReturnData=myhelper.callProcInputAndOutPut(executString, sqlParameter);
         try {
              //ȡֵ ���ڴ�OUT�����ķ���ֵ�����Ǵ洢�����в�����λ���ǵڶ�λ�������� ʹ��GETINT(2),�����һ����洢����
             int returnValue= proReturnData.getInt(5);
             if (returnValue==1) {
                  String groupAlertString="����ֵ��:"+returnValue+"--->����ɹ�.";
                  System.out.println(groupAlertString);
             }
             else 
             {
              String groupAlertString="����ֵ��:"+returnValue+"--->����ʧ�ܣ����û����Ѿ�����.";
                 System.out.println(groupAlertString);
             }
              
         } catch (SQLException e) {
          
             e.printStackTrace();
         }
	}
}