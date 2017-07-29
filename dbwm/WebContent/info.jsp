<%@ page language="java" import="java.util.*,java.sql.*"
	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();//   /dbwm 
String basePath = request.getScheme() + "://"//   http://localhost:8080/dbwm/
		+ request.getServerName() + ":" + request.getServerPort()
		+ path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>飞飞外卖</title>
</head>
<jsp:include page="/navi.jsp" flush="true" />

<style>
body {
	margin-top:30px;
	background-color:#f5f5f5;
}

#info_content {
	margin:100px 180px 100px 180px;
	padding:20px 30px;
	min-height:500px;
	background-color:#fafafa;
}

#basic_info {
	display:block;
	min-height:120px;
	border-bottom:2px solid #eee;
	margin-bottom:5px;
}

#basic_info span {
	display:block;
	margin-bottom:10px;
}

#selector {
	float:left;
	display:inline-block;
	padding-right:10px;
	width:120px;
	border-right:2px solid #eee;
	min-height:350px;
}

#selector .btn {
	width:105px;
	margin-top:5px;
}

#right {
	
	display:inline-block;
	box-shadow: 0 2px 2px 0 #f7f7f7;
	border: 1px solid #eee;
	width:680px;
	min-height:340px;
	margin-left:5px;
	padding-left:10px;
}
#title {
	font-size:24px;
}

.row {
	margin:0px;
	min-height:40px;
	margin-bottom:30px;
}
.tag {
	display:inline-block;
	font-size:20px;
	min-width:100px;
}

.note {
	margin-left:40px;
	max-width:300px;
	display:inline-block;
	word-break:break-all;
}

#upload {
	text-align:center;
	margin-top:40px;
	margin-left:100px;
	width:200px;
	font-size:20px;
	background-color:#5bc0de;
}

#showpage {
	padding:10px 20px 0 20px;
}

#updateprofile {
	display:none;
}

#update {
	text-align:center;
	margin-left:100px;
	width:200px;
	font-size:20px;
	background-color:#5bc0de;
}

#addshopitem {
	display:none;
}

#add_item_form input {

}

#showmyorder {
	display:none;	
}

#showshoporder {
	display:none;
}

.ordertitle {
	display:block;
	font-size:20px;
}
.shopname {
	display:inline-block;
	margin:5px 0px;
}

.customer {
	display:inline-block;
	margin:5px 0px;
}
table {
	table-layout:fixed;
	float:left;
}

tr {
	display:block;
	min-height:1px;
}
.order_head_row {
	font-size:18px;
	background-color:#eee;
}
.subject {
	padding:5px 20px;
	width:300px;
}

.unitprice {
	padding:5px 20px;
	text-align:center;
	width:100px;
}
.quantity {
	padding:5px 20px;
	text-align:center;
	width:100px;
	
}
.totalprice {
	padding:5px 20px;
	text-align:right;
	width:100px;
}
.order_item_row {
	margin:10px;
    border-bottom: 1px solid #ddd;
}
.quantity_input input {
	text-align:center;
	width:40px;
	height:34px;
    border: none;
    border-top: 1px solid #ddd;
    border-bottom: 1px solid #ddd;
}
.quantity_input button {
	text-align:center;
	display:inline-block;
	width:20px;
	height:34px;
	padding:0 6px 2px;
	border: 1px solid #ddd;
	border-radius:0px;
}
.item_totalprice {
	color:#f76120;
}
#total_money {
	text-align:right;
	float:right;
}

#total_money span {
	color:#f76120;
	font-size:20px;
}
</style>
<script src="js/jquery.form.js" type="text/javascript"></script>
<script>
var img;
var id="<%=session.getAttribute("userid") %>";
console.log(id);
if(id==null||id=="null"){
	alert("您还未登录，请先登录");
	window.location.href="login.jsp";
}
else {
	$.post("servlet/GetBasicInfo", {
		
	}, function(data) {
		if(data.state==true){
			$("#name").html(data.username);
			$("#tele").html(data.telephone);
			$("#adr").html(data.address);
			
			$("#username_div input").val(data.username);
			$("#tele_div input").val(data.telephone);
			$("#adr_div input").val(data.address);
		}
		else {
			alert("无效的用户名！");
			window.location.href="login.jsp";
		}
	},"json");
}
$(document).ready(function(){
	var id="<%=session.getAttribute("userid") %>";
	var level="<%=session.getAttribute("level") %>";
	if(level<3){
		document.getElementById("add_item").style.display="none";
		document.getElementById("shoporder").style.display="none";
	}
	var href = window.location.href;
	if(href.indexOf("?")>0)
	{
		var params = href.substr(href.indexOf("?")+1).split("=");
		var sel;
		if(params[0]=="sel"){
			sel=params[1];
		}
		else {
			sel="wrong"
		}
		console.log(sel);
		document.getElementById("updateprofile").style.display="none";
		document.getElementById("showmyorder").style.display="none";
		document.getElementById("addshopitem").style.display="none";
		document.getElementById("showshoporder").style.display="none";
		if(sel=="profile"){
			$("#title strong").html("个人资料");
			document.getElementById("updateprofile").style.display="inline";
		}
		else if(sel=="myorder"){
			$("#title strong").html("我的订单");
			$.post("servlet/GetMyOrder",{
				
			},function(data){
				$("#showmyorder").html(data.str);
			},"json");
			document.getElementById("showmyorder").style.display="inline";
		}
		else if(sel=="add_item"&&level>=3){
			$("#title strong").html("添加商品");
			document.getElementById("addshopitem").style.display="inline";
		}
		else if(sel=="shoporder"&&level>=3){
			$("#title strong").html("收到订单");
			$.post("servlet/GetShopOrder",{
				
			},function(data){
				$("#showshoporder").html(data.str);
			},"json");
			document.getElementById("showshoporder").style.display="inline";
		}
		else {
			$("#title strong").html("");
		}
	}
	
	$('#update').on('click', function() {
		$("#update_info_form").ajaxSubmit({
		    type: 'post', // 提交方式 get/post
		    url: 'servlet/UpdateInfo', // 需要提交的 url
		    datatype:"text",
		    success: function(data) { // result 保存提交后返回的数据，一般为 json 数据
		        // 此处可对 data 作相关处理
		        if(data=="yes"){
			        alert("更新成功");
			        window.location.reload();
		        }
		        else {
		        	alert("更新失败");
		        	window.location.reload();
		        }
		        
		    },
		    error: function(data){
		    	alert('失败');
		    },
		    timeout:3600
		});
	});
	
	$('#upload').on('click', function() {
		$("#picsel").attr("type","text");
		$("#picsel").val(img);
		$("#add_item_form").ajaxSubmit({
		    type: 'post', // 提交方式 get/post
		    url: 'servlet/AddItem', // 需要提交的 url
		    datatype:"text",
		    success: function(data) { // result 保存提交后返回的数据，一般为 json 数据
		        // 此处可对 data 作相关处理
		        if(data=="yes"){
			        alert("添加成功");
			        window.location.reload();
		        }
		        else {
		        	alert("添加失败");
		        	window.location.reload();
		        }
		        
		    },
		    error: function(data){
		    	alert('失败');
		    },
		    timeout:3600
		});
	});
});

function imgChange(e) {
    console.info(e.target.files[0]);//图片文件
    var dom =$("input[id='picsel']")[0];
    console.info(dom.value);//这个是文件的路径 C:\fakepath\icon (5).png
    console.log(e.target.value);//这个也是文件的路径和上面的dom.value是一样的
    var reader = new FileReader();
    reader.readAsDataURL(e.target.files[0]);
    reader.onload=function(e){
    	img=this.result;
    };
}

</script>

<body>
	<div id="info_content">
		<div id="basic_info">
			<span id="name" style="font-size:24px">XXX</span>
			<span id="tele" style="font-size:18px">130</span>
			<span id="adr" style="font-size=:18px">xxxfxxxx</span>
		</div>
		<div id="other_info">
			<div id="selector">
				<button id="profile" class="btn" onclick="return window.location.href='info.jsp?sel=profile'">个人资料</button>
				<button id="myorder" class="btn" onclick="return window.location.href='info.jsp?sel=myorder'">我的订单</button>
				<button id="add_item" class="btn" onclick="return window.location.href='info.jsp?sel=add_item'">添加商品</button>
				<button id="shoporder" class="btn" onclick="return window.location.href='info.jsp?sel=shoporder'">收到订单</button>
			</div>
			<div id="right">
				<h3 id="title"><strong> </strong></h3>
				<div id="showpage">
					<div id="updateprofile">
						<form id="update_info_form">
							<div id="username_div" class="row">
								<span class="tag">用户名：</span>
								<input type="text" name="username" readOnly="true"  disabled="true">
							</div>
							
							<div id="tele_div" class="row">
								<span class="tag">电话号码：</span>
								<input type="text" name="telephone">
							</div>
							
							<div id="adr_div" class="row">
								<span class="tag">住址：</span>
								<input type="text" name="address">
							</div>
							
							<input id="update" type="button" class="btn" name="update" value="保存更改">
						</form>
					</div>
					
					<div id="showmyorder">
						<div id="order_1" class="order">
							
							<span class="ordertitle">订单编号:<span class="ordernumber">1</span></span>
							<span class="shopname">这是一家店的名字</span>
							<table id="buy_table_1" class="order_table">
								<tbody>
									<tr class="order_head_row">
										<th class="subject">项目</th>
										<th class="unitprice">单价</th>
										<th class="quantity">数量</th>
										<th class="totalprice">总价</th>
									</tr>
									<tr class="order_item_row">
										<td class="item_name subject">
											<a>这里是菜的名字</a>
										</td>
										<td class="item_unitprice unitprice">
											¥
											<span id="unitprice_0">13.8</span>
										</td>
										<td class="item_quantity quantity">
											<div class="quantity_input">
												<input type="text" maxlength="4" name="quantity_0" value="1" readOnly="true" disabled="true">
											</div>
										</td>
										<td class="item_totalprice totalprice">
											¥
											<span id="totalprice_0">13.8</span>
										</td>
									</tr>
									
									<tr>
										<td><td>
										<td colspan="3" id="total_money">
											<strong>应付金额：</strong>
											<span class="money_show">
												<strong>¥
												<span id="money">13.8</span></strong>
											</span>
										</td>
									</tr>
								</tbody>
							</table>
							</div>
							
							<div id="order_2" class="order">
							<span class="ordertitle">订单编号:<span class="ordernumber">1</span></span>
							<span class="shopname">这是一家店的名字</span>
							<table id="buy_table_2" class="order_table">
								<tbody>
									<tr class="order_head_row">
										<th class="subject">项目</th>
										<th class="unitprice">单价</th>
										<th class="quantity">数量</th>
										<th class="totalprice">总价</th>
									</tr>
									<tr class="order_item_row">
										<td class="item_name subject">
											<a>这里是菜的名字</a>
										</td>
										<td class="item_unitprice unitprice">
											¥
											<span id="unitprice_0">13.8</span>
										</td>
										<td class="item_quantity quantity">
											<div class="quantity_input">
												<input type="text" maxlength="4" name="quantity_0" value="1" readOnly="true" disabled="true">
											</div>
										</td>
										<td class="item_totalprice totalprice">
											¥
											<span id="totalprice_0">13.8</span>
										</td>
									</tr>
									
									<tr>
										<td><td>
										<td colspan="3" id="total_money">
											<strong>应付金额：</strong>
											<span class="money_show">
												<strong>¥
												<span id="money">13.8</span></strong>
											</span>
										</td>
									</tr>
								</tbody>
							</table>
							</div>
						</div>
						
						<div id="addshopitem">
							<form id="add_item_form">
								<div id="item_name_div" class="row">
									<span class="tag">商品名称：</span>
									<input type="text" name="item_name">
								</div>
								
								<div id="item_price_div" class="row">
									<span class="tag">商品价格：</span>
									<input type="text" name="item_price">
								</div>
								<div>
									<span class="tag">商品配图：</span>
									<input type="file" name="item_pic" onchange="imgChange(event)" accept=".jpg" id="picsel" style="display:inline-block;">
									<img src="" id="showImage" alt="">
								</div>
								<input id="upload" type="button" class="btn" name="upload" value="立即添加">
							</form>
						</div>
						
						<div id="showshoporder">
							<div id="order_1" class="order">
							<span class="ordertitle">订单编号:<span class="ordernumber">1</span></span>
							<span class="customername">这是用户的名字</span>
							<table id="buy_table_1" class="order_table">
								<tbody>
									<tr class="order_head_row">
										<th class="subject">项目</th>
										<th class="unitprice">单价</th>
										<th class="quantity">数量</th>
										<th class="totalprice">总价</th>
									</tr>
									<tr class="order_item_row">
										<td class="item_name subject">
											<a>这里是菜的名字</a>
										</td>
										<td class="item_unitprice unitprice">
											¥
											<span id="unitprice_0">13.8</span>
										</td>
										<td class="item_quantity quantity">
											<div class="quantity_input">
												<input type="text" maxlength="4" name="quantity_0" value="1" readOnly="true" disabled="true">
											</div>
										</td>
										<td class="item_totalprice totalprice">
											¥
											<span id="totalprice_0">13.8</span>
										</td>
									</tr>
									
									<tr>
										<td><td>
										<td colspan="3" id="total_money">
											<strong>应付金额：</strong>
											<span class="money_show">
												<strong>¥
												<span id="money">13.8</span></strong>
											</span>
										</td>
									</tr>
								</tbody>
							</table>
							</div>
							
							<div id="order_2" class="order">
							<span class="ordertitle">订单编号:<span class="ordernumber">1</span></span>
							<span class="customername">这是用户的名字</span>
							<table id="buy_table_2" class="order_table">
								<tbody>
									<tr class="order_head_row">
										<th class="subject">项目</th>
										<th class="unitprice">单价</th>
										<th class="quantity">数量</th>
										<th class="totalprice">总价</th>
									</tr>
									<tr class="order_item_row">
										<td class="item_name subject">
											<a>这里是菜的名字</a>
										</td>
										<td class="item_unitprice unitprice">
											¥
											<span id="unitprice_0">13.8</span>
										</td>
										<td class="item_quantity quantity">
											<div class="quantity_input">
												<input type="text" maxlength="4" name="quantity_0" value="1" readOnly="true" disabled="true">
											</div>
										</td>
										<td class="item_totalprice totalprice">
											¥
											<span id="totalprice_0">13.8</span>
										</td>
									</tr>
									
									<tr>
										<td><td>
										<td colspan="3" id="total_money">
											<strong>应付金额：</strong>
											<span class="money_show">
												<strong>¥
												<span id="money">13.8</span></strong>
											</span>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					
					
				</div>
			</div>
		</div>
	</div>
</body>
</html>
