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

@WebServlet(name="ViewCart",urlPatterns="/servlet/ViewCart")
public class ViewCart extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ViewCart() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		response.setContentType("text/xml");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		JSONObject jsonObj = new JSONObject();
		
		String[] foodstr = request.getParameter("foodstr").split("_");
		String shopid = (String) request.getSession().getAttribute("shopid");
		
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
		str=str+"<tbody>";
		str=str+"<tr class='order_head_row'>";
		str=str+"<th class='subject'>项目</th>";
		str=str+"<th class='unitprice'>单价</th>";
		str=str+"<th class='quantity'>数量</th>";
		str=str+"<th class='totalprice'>总价</th>";
		str=str+"</tr>";
		try {
			// 连接数据库
			Class.forName(driverName);
			conn = DriverManager.getConnection(dbURL, userName, userPwd);
			
			String sql = "";
			Statement stmt = conn.createStatement();
			ResultSet rs;
			int index=0;
			while(index<foodstr.length){
				sql="select * from food where foodnum='"+Integer.parseInt(foodstr[index])+"' and number='"+Integer.parseInt(shopid)+"'";
				rs = stmt.executeQuery(sql);
				if (rs.next()) {
					str=str+"<tr class='order_item_row'>";
					str=str+"<td class='item_name subject'>";
					str=str+"<a>"+rs.getString("foodname")+"</a>";
					str=str+"</td>";
					str=str+"<td class='item_unitprice unitprice'>";
					str=str+"¥<span id='unitprice_"+rs.getString("foodnum")+"'>"+rs.getString("money")+"</span>";
					str=str+"</td>";
					str=str+"<td class='item_quantity quantity'>";
					str=str+"<div class='quantity_input'>";
					str=str+"<button type='button' class='minus btn'>-</button>";
					str=str+"<input type='text' maxlength='4' name='quantity_"+rs.getString("foodnum")+"' value='1'>";
					str=str+"<button type='button' class='add btn'>+</button>";
					str=str+"</div>";
					str=str+"</td>";
					str=str+"<td class='item_totalprice totalprice'>";
					str=str+"¥<span id='totalprice_"+rs.getString("foodnum")+"'>"+rs.getString("money")+"</span>";
					str=str+"</td>";
					str=str+"</tr>";

				}
				index+=1;
			}
			
			sql="select deaddress from customer where number in (select number from loging where zhanghao='"+request.getSession().getAttribute("userid")+"')";
			rs = stmt.executeQuery(sql);
			String addr = null;
			if (rs.next()) {
				addr=rs.getString("deaddress");
			}
			str=str+"<tr  id='addr_row'>";
			str=str+"<td class='subject'><td>";
			str=str+"<td class='unitprice'><td>";
			str=str+"<td colspan='0'>";
			str=str+"<strong>收货地址：</strong>";
			str=str+"<span class='addr_text'>";
			str=str+"<input type='text' id='addr' value='"+addr+"' width='200px'>";
			str=str+"</span>";
			str=str+"</td>";
			str=str+"</tr>";
		
			str=str+"<tr>";
			str=str+"<td><td>";
			str=str+"<td colspan='3' id='total_money'>";
			str=str+"<strong>应付金额：</strong>";
			str=str+"<span class='money_show'>";
			str=str+"<strong>¥";
			str=str+"<span id='money'>13.8</span></strong>";
			str=str+"</span>";
			str=str+"</td>";
			str=str+"</tr>";
			str=str+"</tbody>";
			
			jsonObj.put("shopname", "这里是店名");
			jsonObj.put("shopadr", "这里是地址");
			jsonObj.put("shoptele", "这里是电话");
			jsonObj.put("str", str);

			out.println(jsonObj);
			out.close();
			conn.close();
			
		} catch (Exception ee) {
			ee.printStackTrace();
		}
	}	
}
	