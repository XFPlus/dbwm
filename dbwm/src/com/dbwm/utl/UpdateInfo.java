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

@WebServlet(name="UpdateInfo",urlPatterns="/servlet/UpdateInfo")
public class UpdateInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public UpdateInfo() {
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
		
		String user_tele = request.getParameter("telephone");
		String user_addr = request.getParameter("address");
		String user_id = (String) request.getSession().getAttribute("userid");
		
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
		
		try {
			// 连接数据库
			Class.forName(driverName);
			conn = DriverManager.getConnection(dbURL, userName, userPwd);
			
			String sql = "update customer set phone='"+user_tele+"', deaddress='"+user_addr+"' where number in (select number from loging where zhanghao='"+request.getSession().getAttribute("userid")+"')";
			Statement stmt = conn.createStatement();
			stmt.execute(sql);
			out.print("yes");
		}
		catch (Exception e){
			out.print("no");
			e.printStackTrace();
		}
		out.close();
	}	
}
	