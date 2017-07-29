package com.dbwm.utl;

import java.io.IOException;
import java.io.PrintWriter;
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

import com.dbwm.sql.MySqlHelper2;
import com.dbwm.sql.MySqlHelper3;
import com.mysql.jdbc.CallableStatement;
import com.sun.jndi.cosnaming.IiopUrl.Address;
import com.sun.xml.internal.messaging.saaj.soap.ver1_1.Envelope1_1Impl;

@WebServlet(name="OrderSubmit",urlPatterns="/servlet/OrderSubmit")
public class OrderSubmit extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public OrderSubmit() {
		// TODO Auto-generated constructor stub
    	super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		response.setContentType("text/xml");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		JSONObject jsonObj = new JSONObject();
		
		response.setHeader("content-type", "text/text;charset=UTF-8");
		
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
		Connection conn;
		String usernumber = "";
		String shopnumber = "";
		String useraddr = "";
		
		try {
			Class.forName(driverName);
			conn = DriverManager.getConnection(dbURL, userName, userPwd);
			
			String sql = "select loging.number,deaddress from loging,customer where zhanghao='"+request.getSession().getAttribute("userid")+"' and loging.number=customer.number";
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			
			if(rs.next()){
				usernumber=rs.getString("number");
				shopnumber=(String) request.getSession().getAttribute("shopid");
				useraddr=rs.getString("deaddress");
			}
		
		}
		catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		
		MySqlHelper2 myhelper = new MySqlHelper2();
		String[] sqlParameter = new String[] { usernumber, shopnumber, useraddr, "" };
		System.out.println(usernumber + "   " + shopnumber +"  " + useraddr);
		// 调用存储过程的的字符串
		String executString = "call proorder1(?,?,?,?)";
		// 调用存储过程的的字符串
		// outPutProcudure就是我们的存储过程名称，然后两个?表示两个参数，1是我们参数的参数，第二是我们存储过程处理完后返回的值
		CallableStatement proReturnData = (CallableStatement) myhelper.callProcInputAndOutPut(executString, sqlParameter);
		try {
			// 取值 由于带OUT参数的返回值在我们存储过程中参数的位置是第二位所以我们 使用GETINT(2),接着我会贴存储过程
			int returnValue = proReturnData.getInt(4);
			if (returnValue == 1) {
				String groupAlertString = "返回值是:" + returnValue + "--->插入成功.";
				System.out.println(groupAlertString);
			} else {
				String groupAlertString = "返回值是:" + returnValue + "--->插入失败";
				System.out.println(groupAlertString);
			}

		} catch (SQLException e) {

			e.printStackTrace();
		}

		MySqlHelper3 myhelper3 = new MySqlHelper3();
		Enumeration en = request.getParameterNames();  
		while(en.hasMoreElements()){  
		    String el = en.nextElement().toString();
		    System.out.println("||||"+el+"="+request.getParameter(el));
		    
		    if(request.getParameter(el).equals("0"))
		    	continue;
			String[] sqlParameter3 = new String[] {el.split("_")[1], request.getParameter(el), "" };
			System.out.println(el.split("_")[1] + "  " + request.getParameter(el));
			// 调用存储过程的的字符串
			String executString3 = "call procai1(?,?,?)";
			// 调用存储过程的的字符串
			// outPutProcudure就是我们的存储过程名称，然后两个?表示两个参数，1是我们参数的参数，第二是我们存储过程处理完后返回的值
			CallableStatement proReturnData3 = (CallableStatement) myhelper3.callProcInputAndOutPut(executString3, sqlParameter3);
			try {
				// 取值 由于带OUT参数的返回值在我们存储过程中参数的位置是第二位所以我们 使用GETINT(2),接着我会贴存储过程
				int returnValue = proReturnData3.getInt(3);
				if (returnValue == 1) {
					String groupAlertString = "返回值是:" + returnValue + "--->插入成功";
					System.out.println(groupAlertString);
				} else {
					String groupAlertString = "返回值是:" + returnValue + "--->插入失败,有相同项";
					System.out.println(groupAlertString);
				}
			} catch (SQLException e) {

				e.printStackTrace();
			}
		}
		
		out.close();
	}	
}
	