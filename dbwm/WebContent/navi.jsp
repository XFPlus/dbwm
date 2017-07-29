<%@ page language="java" import="java.util.*,java.sql.*"
	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://"
		+ request.getServerName() + ":" + request.getServerPort()
		+ path + "/";
%>

<link href="./css/bootstrap.min.css" rel="stylesheet" />
<link href="./css/bootstrap-responsive.min.css" rel="stylesheet" />
<link href="./css/navi.css" rel="stylesheet"/>

<script src="js/jquery-1.10.2.js" type="text/javascript"></script>
<script src="js/jquery-ui-1.10.4.custom.min.js" type="text/javascript"></script>
<script src="js/jquery.dataTables.min.js" type="text/javascript"></script>
<script src="js/jquery.parser.js" type="text/javascript"></script>

<!-- Fixed navbar -->
<script>
function login_click(){
	window.location.href="login.jsp";
}

function logout_click(){
	$.post("servlet/Logout",{
		
	},function(result){
		if(result!=null){
			alert("您已退出");
			window.location.href="login.jsp";
		}
	},"text");
}

function userinfo_click(){
	window.location.href="info.jsp";
}

function signup_click(){
	window.location.href="signup.jsp";
}
</script>

<div id="navi" class="navbar navbar-default navbar-fixed-top" role="navigation">
	<div class="container">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target=".navbar-collapse">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand " href="index.jsp">飞飞外卖</a>
			
		</div>
		
		<div class="navbar-collapse collapse">
			<ul id="main_logout" class="nav navbar-nav navbar-right" >
				<li><a id=<%=session.getAttribute("userid")==null?"login":"userinfo" %>  onclick=<%=session.getAttribute("userid")==null?"login_click()":"userinfo_click()" %> class="navbar-text" style="cursor:pointer"> <%=session.getAttribute("userid")==null?"登陆":session.getAttribute("userid") %></a></li>
				<li><a id=<%=session.getAttribute("userid")==null?"signup":"logout" %> onclick=<%=session.getAttribute("userid")==null?"signup_click()":"logout_click()" %> class="navbar-text" style="cursor:pointer"> <%=session.getAttribute("userid")==null?"注册":"注销" %></a></li>
				<li><a id="myorder" class="navbar-text" onclick="return window.location.href='info.jsp?sel=myorder'" style="cursor:pointer">我的订单</a></li>
			<%-- 	<p class="navbar-text navbar-left">
					你好，<a href="config.jsp?course_ID=<%=selected_course_ID%>"><%=session.getAttribute("username")%></a>!
					<input style="display: none" id="userid"
						value="<%=session.getAttribute("userid")%>">
				</p>
				<li><a  class="navbar-text" href="login.jsp">注销</a></li> --%>
			</ul>


		</div>
		<!--/.nav-collapse -->
	</div>
</div>
