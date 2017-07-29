package com.dbwm.utl;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.*;

@WebServlet(name="GetBasicInfo",urlPatterns="/servlet/GetBasicInfo")
public class GetBasicInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public GetBasicInfo() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		response.setContentType("text/xml");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		JSONObject jsonObj = new JSONObject();
		
		String userid = (String) request.getSession().getAttribute("userid");
		
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
		String str="";
	
		try {
			// 连接数据库
			Class.forName(driverName);
			conn = DriverManager.getConnection(dbURL, userName, userPwd);
			
			String sql = "select zhanghao,phone,deaddress from customer,loging where customer.number=loging.number and zhanghao='"+userid+"'";
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			if(rs.next()){
				jsonObj.put("username", rs.getString("zhanghao"));
				jsonObj.put("telephone",rs.getString("phone"));
				jsonObj.put("address", rs.getString("deaddress"));
				jsonObj.put("state", true);
			}
			else {
				jsonObj.put("state", false);
			}

			out.println(jsonObj);
			out.close();
			conn.close();
			
		} catch (Exception ee) {
			ee.printStackTrace();
		}
	}	
}
	