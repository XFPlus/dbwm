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

@WebServlet(name="GetShopOrder",urlPatterns="/servlet/GetShopOrder")
public class GetShopOrder extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public GetShopOrder() {
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
			
			String sql = "select ordernum,zhanghao,money from ordering,loging,shop where ordering.number=loging.number and ordering.shopnum=shop.number and ordering.shopnum in (select shopnum from loging where zhanghao='"+userid+"')";
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			Statement stmt1 = conn.createStatement();
			ResultSet rs1;
			while(rs.next()){
				str=str+"<div id='order_"+rs.getString("ordernum")+"' class='order'>";
				str=str+"<span class='ordertitle'>订单编号:<span class='ordernumber'>"+rs.getString("ordernum")+"</span></span>";
				str=str+"<span class='customername'>"+rs.getString("zhanghao")+"</span>";
				str=str+"<table id='buy_table_"+rs.getString("ordernum")+"' class='order_table'>";
				str=str+"<tbody>";
				str=str+"<tr class='order_head_row'>";
				str=str+"<th class='subject'>项目</th>";
				str=str+"<th class='unitprice'>单价</th>";
				str=str+"<th class='quantity'>数量</th>";
				str=str+"<th class='totalprice'>总价</th>";
				str=str+"</tr>";
				
				sql="select foodname,food.foodnum,money,amount from orderfood,food where food.foodnum=orderfood.foodnum and orderfood.ordernum='"+rs.getString("ordernum")+"'";
				rs1=stmt1.executeQuery(sql);
				
				while(rs1.next()){
					str=str+"<tr class='order_item_row'>";
					str=str+"<td class='item_name subject'>";
					str=str+"<a>"+rs1.getString("foodname")+"</a>";
					str=str+"</td>";
					str=str+"<td class='item_unitprice unitprice'>";
					str=str+"¥<span id='unitprice_"+rs1.getString("foodnum")+"'>"+rs1.getString("money")+"</span>";
					str=str+"</td>";
					str=str+"<td class='item_quantity quantity'>";
					str=str+"<div class='quantity_input'>";
					str=str+"<input type='text' maxlength='4' readOnly='true' disabled='true' name='quantity_"+rs1.getString("foodnum")+"' value='"+rs1.getString("amount")+"'>";
					str=str+"</div>";
					str=str+"</td>";
					str=str+"<td class='item_totalprice totalprice'>";
					str=str+"¥<span id='totalprice_"+rs1.getString("foodnum")+"'>"+Integer.parseInt(rs1.getString("amount"))*Integer.parseInt(rs1.getString("money"))+"</span>";
					str=str+"</td>";
					str=str+"</tr>";
				}
				
				str=str+"<tr>";
				str=str+"<td><td>";
				str=str+"<td colspan='3' id='total_money'>";
				str=str+"<strong>应付金额：</strong>";
				str=str+"<span class='money_show'>";
				str=str+"<strong>¥";
				str=str+"<span id='money'>"+rs.getString("money")+"</span></strong>";
				str=str+"</span>";
				str=str+"</td>";
				str=str+"</tr>";
				str=str+"</tbody>";
				str=str+"</table>";
				str=str+"</div>";
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
	