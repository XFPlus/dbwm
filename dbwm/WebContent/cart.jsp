<%@ page language="java" import="java.util.*,java.sql.*"
	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://"
		+ request.getServerName() + ":" + request.getServerPort()
		+ path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>购物车|飞飞外卖</title>
<jsp:include page="/navi.jsp" flush="true" />
</head>

<style>
body {
	padding-top: 30px;
	background-color:#f5f5f5;
}

#cart_content {
	margin-top:60px;
	margin-left:180px;
	margin-right:180px;
	min-height:500px;
	background-color:#fafafa;
}

#deal-buy-form {

}

#buy_table {
	width:882px;
}
table {
	table-layout:fixed;
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
	width:491px;
}

.unitprice {
	padding:5px 20px;
	text-align:center;
	width:110px;
}
.quantity {
	padding:5px 20px;
	text-align:center;
	width:170px;
	
}
.totalprice {
	padding:5px 20px;
	text-align:right;
	width:110px;
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

#addr_row {
	text-align:right;
	margin:20px 0 8px 20px;
}

.form-submit {
	float:right;
}

.form-submit input {
	background-color:#5bc0de;
}
</style>

<script src="js/jquery.form.js" type="text/javascript"></script>
<script>
$(document).ready(function(){
	var href = window.location.href;
	if(href.indexOf("?")>0)
	{
		var params = href.substr(href.indexOf("?")+1);
		foodstr = params.split("=")[1];
		
		$.post("servlet/ViewCart", {
			foodstr :foodstr,
		}, function(result) {
			console.log(result);
			//result = eval("(" + result + ")");
			if(result.state==false){
				alert("无效的订单内容");
				window.location.href="idnex.jsp";
			}
			else {
				document.getElementById("buy_table").innerHTML=result.str;
				updateMoney();
			}
			$(".minus").on("click",function(){
				var value=Number($(this).parent().children("input").attr("value"));
				if(value<=0){
					alert("已经只有0个了！");
					$(this).parent().children("input").attr("value",0);
					return;
				}
				$(this).parent().children("input").attr("value",value-1);
				updateTotalPrice($(this).parent().parent().parent(),value-1);
			});
			
			$(".add").on("click",function(){
				var value=Number($(this).parent().children("input").attr("value"));
				$(this).parent().children("input").attr("value",value+1);
				updateTotalPrice($(this).parent().parent().parent(),value+1);
			});
		},"json");
	}
	
	
	
	$('.quantity input').bind('blur',function(){
		if(this.value==null||this.value==""){
			this.value=0;
		}else{
			this.value=String(Number(this.value));
		}
		updateTotalPrice($(this).parent().parent().parent(),Number(this.value));
	});
	
	$('#submitbtn').on('click', function() {

	    //$('#deal-buy-form').on('submit', function() {
	        var title = "";
			if($("#addr").val()==""){
				alert("收货地址不能为空！");
				return false;
			}
			if($("#money").val()==0){
				alert("购物车为空。");
				return false;
			}
	        $("#deal-buy-form").ajaxSubmit({
	            type: 'post', // 提交方式 get/post
	            url: 'servlet/OrderSubmit', // 需要提交的 url
	            datatype:"text",
	            success: function(data) { // result 保存提交后返回的数据，一般为 json 数据
	                // 此处可对 data 作相关处理
	                alert('提交成功！');
	            	window.location.href="info.jsp?sel=myorder";
	            },
	            error: function(data){
	            	alert('失败');
	            },
	            timeout:3600
	        });
	        return false; // 阻止表单自动提交事件
	    });
	//});
});

function updateTotalPrice(rowNode,amount){
	rowNode.children(".totalprice").children("span").html((Number(rowNode.children(".unitprice").children("span").html())*amount).toFixed(1));
	updateMoney();
}

function updateMoney(){
	$("#money").html("0");
	$(".item_totalprice").each(function(key,value){
		$("#money").html((Number($("#money").html())+Number($(this).children("span").html())).toFixed(1));
	});
}
</script>

<body>
	<div id="cart_content">
		<form id="deal-buy-form" name="item-form">
			<div class="summary_table">
				<table id="buy_table">
					<tbody>
						<tr class="order_head_row">
							<th class="subject">项目</th>
							<th class="unitprice">单价</th>
							<th class="quantity">数量</th>
							<th class="totalprice">总价</th>
						</tr>
						
						<!-- 
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
									<button type="button" class="minus btn">-</button>
									<input type="text" maxlength="4" name="quantity_0" value="1">
									<button type="button" class="add btn">+</button>
								</div>
							</td>
							<td class="item_totalprice totalprice">
								¥
								<span id="totalprice_0">13.8</span>
							</td>
						</tr>
						 -->
						<tr  id="addr_row">
							<td class="subject"><td>
							<td class="unitprice"><td>
							<td colspan="0">
								<strong>收货地址：</strong>
								<span class="addr_text">
									<input type="text" id="addr" value="1" width="200px">
								</span>
							</td>
						</tr>
						
						<tr>
							<td colspan="3"><td>
							<td  id="total_money">
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
			
			<div class="form-submit">
				<input type="submit" id="submitbtn" class="btn" name="buy" value="提交订单">
			</div>
		</form>
	</div>
</body>
</html>