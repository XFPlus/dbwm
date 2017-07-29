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

@WebServlet(name="AddItem",urlPatterns="/servlet/AddItem")
public class AddItem extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AddItem() {
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
		
		
		String item_img=request.getParameter("item_pic");
		String item_price=request.getParameter("item_price");
		String item_name=request.getParameter("item_name");
		String item_path=request.getServletContext().getRealPath("");
		String usernumber = null;
		int item_id = 0;
		
		
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
			
			String sql = "select max(foodnum) max from food";
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			if (rs.next()) {
				item_id = Integer.parseInt(rs.getString("max"))+1;
			}
			
			sql="select number from loging where zhanghao ='"+ request.getSession().getAttribute("userid")+"'";
			//System.out.println(sql);
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				usernumber = rs.getString("number");
			}
			sql="insert into food values ('"+usernumber+"','"+item_id+"','"+item_name+"','"+item_price+"','0')";
			//System.out.println(sql);
			stmt.execute(sql);
			out.print("yes");
		}
		catch (Exception e){
			out.print("no");
			e.printStackTrace();
		}
		item_path=item_path+"img\\food\\"+item_id+".jpg";
		System.out.println(item_path);
		Base64ToImg.Base64ToImg(item_img.split("base64,")[1],item_path);
		out.close();
	}	
}
	