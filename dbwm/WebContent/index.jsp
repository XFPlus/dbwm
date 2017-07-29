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

<style type="text/css">
body {
	padding-top: 30px;
	background-color:#f5f5f5;
}

.shop_show {
	margin-top:100px;
	margin-left:90px;
}

.shop_row {
	height:340px;
}

.shop {
	width:348px;
	height:340px;
	margin-right:18px;
	margin-bottom:18px;
	display:inline-block;
	box-sizing:border-size;
	cursor:pointer;
}

.shop img{
	width:346px;
	height:216px;
}

.info_adr {
	width:346px;
	height:53px;
	background-color:#fff;
	padding-top:5px;
	padding-bottom:5px;
	padding-left:10px;
	padding-right:10px;
}
.shopname {
	font-size:18px;
	float:left;
	width:346px;
	margin:0px;
}
.shopadr {
	font-size:12px;
	float:right;
	margin:0px;
}
.price {
	background-color:#eee;
	padding-top:5px;
	padding-bottom:5px;
	padding-left:10px;
	padding-right:10px;
}
.leastvalue {
	font-size:20px;
	color:#f76120;
}
.price_avg{
	float:right;
	margin-top:6px;
}
</style>
<script>
var shop;
$.post("servlet/GetIndexPage",{
	
},function(data){
	document.getElementById('shop_list').innerHTML = data.str;
},"json");

$(document).ready(function(){
	$("#shop_list").on("click",".shop",function(){
		window.location.href="shop.jsp?shop="+$(this).attr("id").split("_")[1];
	});
});
</script>
<body>
	<div class="shop_show" id="shop_list">
		<!-- 
		<div id="shop_1" class="shop">
			<img class="imgofshop" src="img/shop1.jpg">
			<div class="info_adr">
				<p class="shopname">三元梅园（朝阳大悦城店）</p>
				<p class="shopadr">美食 朝阳大悦城</p>
			</div>
			<div class="price">
				<span class="price_least">
					<span class="leastvalue">¥15</span>
					<span>起</span>
				</span>
				
				<span class="price_avg">
					<span>人均</span>
					<span class="avgvalue">¥4</span>
				</span>
			</div>
		</div> 
		-->
	</div>
</body>
</html>