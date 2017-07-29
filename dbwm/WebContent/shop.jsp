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

#shop_content {
	margin-top:80px;
	margin-left:184px;
	margin-right:184px;
	background-color:#fafafa;
	padding-bottom:60px;
	margin-bottom:100px;
}

#shopinfo {
	box-shadow: 0 2px 2px 0 #f7f7f7;
	border: 1px solid #eee;
	width:860px;
	padding-top:15px;
	padding-left:30px;
	padding-bottom:15px;
	height:130px;
}
#shopname {
	display:block;
	font-size:30px;
}
#shoptele {
	display:inline-lock;
	font-size:14px;
	color:#888;
}

#shopadr {
	display:block;
	font-size:14px;
	color:#888;
}
#food h3 {
	font-size:22px;
	border-bottom: 2px solid #bbb;
}
.onsale-list {
	padding:0px;
}

.onsale-list li{
	list-style:none;	
}

.onsale-item {
	height:96px;
	padding-top:5px;
	border-bottom:1px solid #eee;
}
.item_info {
	width: 320px;
    font-size: 14px;
    color: #888;
    text-decoration: none;
    float:left;
    margin-right:30px;
    
}
.item_info span {
	min-height:1px;
	display:block;
}
.useless {
	float:left;
	min-height:1px;
	width:270px;
	margin-right:30px;
}
.title {
	color:#333;
	margin-bottom:20px;
}
.item_info img {
	margin-right:20px;
	float:left;
}
.item_price {
	float:left;
	font-size:20px;
	color:#f76120;
	margin-top:10px;
}
.item_right {
	display:block;
}
.btn {
	float:right;
	margin-top:5px;
	background-color:#5bc0de;
	box-shadow: 0 2px 2px 0 #ccc;
	width:96px;
}
.cart {
	width:200px;
	float:right;
}
button:hover {
	background-color:#5ba6ff;
}
</style>

<script>
var buyitem="";

var href = window.location.href;
if(href.indexOf("?")>0)
{
	var params = href.substr(href.indexOf("?")+1);
	shopid = params.split("=")[1];
	
	$.post("servlet/GetShopPage", {
		shopid :shopid,
	}, function(result) {
		//result = eval("(" + result + ")");
		if(result.state==false){
			alert("无效的店铺ID");
			window.location.href="idnex.jsp";
		}
		else {
			document.getElementById('shopname').innerHTML = result.shopname;
			document.getElementById('shopadr').innerHTML = result.shopadr;
			document.getElementById('shoptele').innerHTML = result.shoptele;
			document.getElementById('list').innerHTML = result.str;
		}
	},"json");
}

$(document).ready(function(){
	
	$("#food").on("click",".buynow",function(){
		var shopid=$(this).parent().parent().val();
		if(buyitem==""){
			buyitem="" + shopid;
		}
		else{
			buyitem=buyitem+"_"+shopid;
		}
		jumpToCart();
	});
	
	$("#food").on("click",".addtocart",function(){
		var shopid=$(this).parent().parent().val();
		var hasbuy = buyitem.split("_");
		console.log(buyitem);
		console.log(hasbuy);
		var x;
		for(x in hasbuy){
			console.log("x:"+x+"  shopid:"+shopid);
			if(hasbuy[x]==shopid){
				alert("该商品已在购物车中！");
				return false;
			}
		}
		if(buyitem==""){
			buyitem=""+shopid;
		}
		else {
			buyitem=buyitem+"_"+shopid;
		}
		alert("成功添加至购物车！");
	});
});

function jumpToCart(){
	if(buyitem==""){
		alert("购物车是空的啊！");
		return;
	}
	window.location.href="cart.jsp?item="+buyitem;
}
</script>

<body>
	<div id="shop_content">
		<div id="shopinfo">
			<b><span id="shopname"> </span></b>
			<span id="shopadr"> </span>
			<span id="shoptele"> </span>
			<button class="btn cart" onclick="return jumpToCart();">前往购物车结算</button>
		</div>
		
		<div id="food">
			<h3>本店菜品</h3>
			<ul id="list" class="onsale-list">
			<!-- 
				<li class="onsale-item" value="2">
					<div class="item_info">
						<img src="img/shop1.jpg" width="117px" height="70px">
						<span class="title">这是吃的东西</span>
						<span class="salecount">已售0</span>
					</div>
					<span class="useless"></span>
					<b><span class="item_price">￥13.8</span></b>
					<div class="item_right">
						<button class="btn buynow">立即购买</button>
						<button class="btn addtocart">加入购物车</button>
					</div>
				</li>
			 -->
			</ul>
		</div>
		<div>
			<button class="btn cart" onclick="return jumpToCart();">前往购物车结算</button>
		</div>
	</div>
</body>
</html>