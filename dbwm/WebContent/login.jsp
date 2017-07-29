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
<title>登录|飞飞外卖</title>
<jsp:include page="/navi.jsp" flush="true" />
<style type="text/css">
body {
	padding-top: 30px;
	background-color:#f5f5f5;
}

#left_side {
	width:700px;
	height:500px;
	float:left;
}

#left_img {
	position:relative;
	top:40px;
	left:60px;
}

#login_box {
	width:300px;
	float:right;
	font-size:20px;
	margin-top:160px;
	margin-right:100px;
	margin-left:100px;
}

#login_info input {
	display:inline-block;
	width:180px;
	margin:5px;
}

#login_info span {
	display:inline-block;
	width:70px;
}

#login_info div {
	margin-top:12px;
}

button:hover {
	background-color:#5ba6ff;
}

.btn {
	width:261px;
	background-color:#5bc0de;
}
#forgetpwd {
	float:right;
	font-size:12px;
	margin-right:28px;
	margin-bottom:10px;
}

#sign {
	font-size:16px;
	margin-top:16px;
}
</style>
<script src="js/jquery-1.10.2.js" type="text/javascript"></script>
<script src="js/jquery-ui-1.10.4.custom.min.js" type="text/javascript"></script>
<script src="js/jquery.dataTables.min.js" type="text/javascript"></script>
<script src="js/jquery.parser.js" type="text/javascript"></script>
<script>
function log_in(){
	var id=$("#username").val();
	var pwd=$("#password").val();
	$.post("servlet/Login",{
		username:id,
		password:pwd
	},function(result){
		if(result==null||result.status=="wrong"){
			alert("用户名无效或密码错误！");
		}
		else {
			window.location.href="index.jsp";
		}
	},"json");
}
</script>
</head>


<body>
	<div id="login_content">
		<div id="left_side">
			<p id="left_img">
				<img id="left_img" src="img/meituan.jpg" alt="图片来自美团外卖">
			</p>
		</div>
		<div id="login_box">
			<p>账号登陆</p>
			<div id="login_info">
				<div>
					<span class="username_label">用户名:</span>
					<input id="username" type="text" size="25" maxlength="16">
				</div>
				<div>
					<span class="password_label">密 码:</span>
					<input id="password" type="password" size="25" maxlength="16">
				</div>
				<div>
					<a id="forgetpwd" href="">忘记密码？</a>
				</div>
				<div>
					<button id="login" class="btn" onclick="log_in()">登录</button>
				</div>
			</div>
			<p id="sign">还没有账号？
				<a href="signup.jsp">注册</a>
			</p>
		</div>
	</div>
</body>
</html>