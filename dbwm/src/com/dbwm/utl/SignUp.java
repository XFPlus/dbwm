package com.dbwm.utl;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.*;

import com.dbwm.sql.MySqlHelper;

import jdk.management.resource.internal.ResourceNatives;

@WebServlet(name="SignUp",urlPatterns="/servlet/SignUp")
public class SignUp extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public SignUp() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		response.setContentType("text/xml");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		response.setHeader("content-type", "text/text;charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		JSONObject jsonObj = new JSONObject();
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String telephone = request.getParameter("telephone");
		String address = request.getParameter("address");
		
		System.out.println("username:"+username);
		MySqlHelper myhelper=new MySqlHelper();
		String[] sqlParameter = new String[] { username, password, telephone, address, "" };
		String executString = "call prolog1(?,?,?,?,?)";
		// ���ô洢���̵ĵ��ַ���
		// outPutProcudure�������ǵĴ洢�������ƣ�Ȼ������?��ʾ����������1�����ǲ����Ĳ������ڶ������Ǵ洢���̴�����󷵻ص�ֵ
		CallableStatement proReturnData = myhelper.callProcInputAndOutPut(executString, sqlParameter);
		try {
			// ȡֵ ���ڴ�OUT�����ķ���ֵ�����Ǵ洢�����в�����λ���ǵڶ�λ�������� ʹ��GETINT(2),�����һ����洢����
			int returnValue = proReturnData.getInt(5);
			if (returnValue == 1) {
				String groupAlertString = "����ֵ��:" + returnValue + "--->����ɹ�.";
				System.out.println(groupAlertString);
				out.write("yes");
			} else {
				String groupAlertString = "����ֵ��:" + returnValue + "--->����ʧ�ܣ����û����Ѿ�����.";
				System.out.println(groupAlertString);
				out.write("no");
			}

		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		out.close();
	}	
}
	