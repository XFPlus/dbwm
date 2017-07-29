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

@WebServlet(name="GetIndexPage",urlPatterns="/servlet/GetIndexPage")
public class GetIndexPage extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public GetIndexPage() {
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
		
		String str="";
		try {
			// 连接数据库
			Class.forName(driverName);
			conn = DriverManager.getConnection(dbURL, userName, userPwd);
			
			String sql = "select * from shop";
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);

			while(rs.next()){
				str=str+"<div id='shop_"+rs.getString("number")+"' class='shop'>";
				str=str+"<img class='imgofshop' src='img/shop/"+rs.getString("number")+".jpg'>";
				str=str+"<div class='info_adr'>";
				str=str+"<p class='shopname'>"+ rs.getString("shopname")+"</p>";
				str=str+"<p class='shopadr'>"+rs.getString("address")+"</p>";
				str=str+"</div>";
				str=str+"<div class='price'>";
				str=str+"<span class='price_least'>";
				str=str+"<span class='leastvalue'>¥15</span>";
				str=str+"<span>起</span>";
				str=str+"</span>";
				str=str+"<span class='price_avg'>";
				str=str+"<span>人均</span>";
				str=str+"<span class='avgvalue'>¥4</span>";
				str=str+"</span>";
				str=str+"</div>";
				str=str+"</div>";
			}
			
			jsonObj.put("str", str);
			out.print(jsonObj);
			out.close();
			conn.close();
			
		} catch (Exception ee) {
			ee.printStackTrace();
		}
	}	
}
	