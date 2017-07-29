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

@WebServlet(name="Login",urlPatterns="/servlet/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Login() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		response.setContentType("text/xml");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		JSONObject jsonObj = new JSONObject();
		
		String userid=request.getParameter("username");
		String pwd=request.getParameter("password");
		
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
			
			String sql = "select * from loging where zhanghao='" + userid + "' and mima='" + pwd +"'";
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			if (rs.next()) {
				request.getSession().setAttribute("userid", userid);
				request.getSession().setAttribute("level", rs.getString("quanxian"));
				jsonObj.put("status", "true");
				out.write(jsonObj.toString());
			}
			else{
				jsonObj.put("status", "wrong");
				out.write(jsonObj.toString());
			}
			out.close();
			conn.close();
			
		} catch (Exception ee) {
			ee.printStackTrace();
		}
	}	
}
	