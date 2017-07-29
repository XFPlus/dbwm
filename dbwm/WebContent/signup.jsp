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
<title>注册|飞飞外卖</title>
<jsp:include page="/navi.jsp" flush="true" />
</head>

<style>
body {
	padding-top: 30px;
	background-color:#f5f5f5;
}

#signup_content {
	margin:80px 200px 0 200px;
	min-height:500px;
	background-color:#fafafa;
	padding:40px 100px;
}

#signup_form {
	width:826px;
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

#register {
	text-align:center;
	margin-left:100px;
	width:200px;
	font-size:20px;
	background-color:#5bc0de;
}
</style>
<script src="js/jquery.form.js" type="text/javascript"></script>
<script>
$(document).ready(function(){
	$('#register').on('click', function() {

	    //$('#deal-buy-form').on('submit', function() {
		if($("input[name='username']").val().length>16){
			alert("用户名过长");
			return;
		}
		else if($("input[name='username']").val().length<6){
			alert("用户名过短");
			return;
		}
		if($("input[name='password']").val()==""){
			alert("密码不能为空");
			return;
		}
		else if($("input[name='password']").val()!=$("input[name='repassword']").val()){
			alert("两次密码不一致");
			return;
		}
		
		$("#signup_form").ajaxSubmit({
		    type: 'post', // 提交方式 get/post
		    url: 'servlet/SignUp', // 需要提交的 url
		    datatype:"text",
		    success: function(data) { // result 保存提交后返回的数据，一般为 json 数据
		        // 此处可对 data 作相关处理
		        if(data=="yes"){
			        alert('注册成功！');
			    	window.location.href="login.jsp";
		        }
		        else {
		        	alert("该用户名已被注册");
		        }
		        
		    },
		    error: function(data){
		    	alert('失败');
		    },
		    timeout:3600
		});
		$("#signup_form").resetForm(); // 提交后重置表单
		return false; // 阻止表单自动提交事件
		});
});

</script>

<body>
	<div id="signup_content">
		<form id="signup_form">
			<div id="username_div" class="row">
				<span class="tag">用户名：</span>
				<input type="text" name="username" maxlength=16 minlength=6>
				<span class="note">用于登录和标识（仅可使用6-16位数字和英文大小写）。</span>
			</div>
			
			<div id="password_div" class="row">
				<span class="tag">密码：</span>
				<input type="password" name="password">
				<span class="note">登录时的密码，请牢记此密码，切勿告诉他人（仅可使用6-16位数字和英文大小写）。</span>
			</div>
			
			<div id="passwordagain_div" class="row">
				<span class="tag">再输一次：</span>
				<input type="password" name="repassword">
				<span class="note">请再输入一次密码，和上面相同（仅可使用6-16位数字和英文大小写）。</span>
			</div>
			
			<div id="tele_div" class="row">
				<span class="tag">电话号码：</span>
				<input type="text" name="telephone">
				<span class="note">请输入您的电话号码，以方便我们和您取得联系。</span>
			</div>
			
			<div id="adr_div" class="row">
				<span class="tag">住址：</span>
				<input type="text" name="address">
				<span class="note">请输入您的默认地址，以方便我们为您送达外卖。</span>
			</div>
			
			<input id="register" type="button" class="btn" name="signup" value="立即注册">
		</form>
	</div>
</body>
</html>