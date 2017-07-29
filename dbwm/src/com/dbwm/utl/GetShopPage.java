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

@WebServlet(name="GetShopPage",urlPatterns="/servlet/GetShopPage")
public class GetShopPage extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public GetShopPage() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		response.setContentType("text/xml");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		JSONObject jsonObj = new JSONObject();
		
		String shopid=request.getParameter("shopid");
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
			
			String sql = "select * from shop where number='" + Integer.parseInt(shopid)+"'";
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			if(rs.next()){
				jsonObj.put("shopname", rs.getString("shopname"));
				jsonObj.put("shopadr", rs.getString("address"));
				jsonObj.put("shoptele", rs.getString("phone"));
				request.getSession().setAttribute("shopid", shopid);
			}
			else {
				jsonObj.put("state", false);
			}
			
			sql = "select * from food where number='" + Integer.parseInt(shopid) + "'";
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				str=str+"<li class='onsale-item' value='"+rs.getString("foodnum")+"'>";
				str=str+"<div class='item_info'>";
				str=str+"<img src='img/food/"+rs.getString("foodnum")+".jpg' width='117px' height='70px'>";
				str=str+"<span class='title'>"+rs.getString("foodname")+"</span>";
				str=str+"<span class='salecount'>已售"+rs.getString("count")+"</span>";
				str=str+"</div>";
				str=str+"<span class='useless'></span>";
				str=str+"<b><span class='item_price'>￥"+rs.getString("money")+"</span></b>";
				str=str+"<div class='item_right'>";
				str=str+"<button class='btn buynow'>立即购买</button>";
				str=str+"<button class='btn addtocart'>加入购物车</button>";
				str=str+"</div>";
				str=str+"</li>";
			}
			
			jsonObj.put("str", str);
			out.println(jsonObj);
			out.close();
			conn.close();
			
		} catch (Exception ee) {
			ee.printStackTrace();
		}
	}	
}
	