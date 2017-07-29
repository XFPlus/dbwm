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
		// 调用存储过程的的字符串
		// outPutProcudure就是我们的存储过程名称，然后两个?表示两个参数，1是我们参数的参数，第二是我们存储过程处理完后返回的值
		CallableStatement proReturnData = myhelper.callProcInputAndOutPut(executString, sqlParameter);
		try {
			// 取值 由于带OUT参数的返回值在我们存储过程中参数的位置是第二位所以我们 使用GETINT(2),接着我会贴存储过程
			int returnValue = proReturnData.getInt(5);
			if (returnValue == 1) {
				String groupAlertString = "返回值是:" + returnValue + "--->插入成功.";
				System.out.println(groupAlertString);
				out.write("yes");
			} else {
				String groupAlertString = "返回值是:" + returnValue + "--->插入失败，该用户名已经存在.";
				System.out.println(groupAlertString);
				out.write("no");
			}

		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		out.close();
	}	
}
	