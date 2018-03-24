<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../common/basePath.jsp" %>
<!doctype html>
<html>
 <head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
  <link rel="stylesheet" href="${basePath}/resource/css/animate.css">
  <link rel="stylesheet" type="text/css" href="${basePath}/resource/css/sg.css" />
  <title>Java开发微信二维码系统 --krry</title>
  <%@include file="../common/common.jsp" %>
  <style type="text/css">
    *{margin:0;padding:0}
	body{font-family:"微软雅黑";color:#666;}
	a{text-decoration:none;color:#666;}
	ul li{list-style:none;}
	.clear{clear:both;}
	.title{ margin-left: 24px;
			margin-top: 22px;
			font-size: 17px;}
	.png{width:98%;margin:10px auto;}
	.png .png_img{display:block;margin:20px auto;}

	.footer{text-align:center;}
	.footer .f_ling{margin:46px auto;}
	.footer .f_ling p{line-height:30px;}
  </style>
 </head>
 <body>
  <%
	//如果用户没有在微信授权登录，则跳回授权登录的地方，意思就是网页只能在微信内置浏览器打开
	//if(request.getSession().getAttribute("snsUserInfo") == null){
	//	response.sendRedirect("https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxd11020eacc06042f&redirect_uri=http://www.krrymusic.xin/krry_wecchatLogin/krry&response_type=code&scope=snsapi_userinfo&state=12fggh3#wechat_redirect");
	//}
  
 	//如果直接输入该地址，则直接跳回首页
 	String type = (String)request.getAttribute("imgsrc");
 	if(type == null){
 		response.sendRedirect("index");
 	}
  %>
	<p class="title">长按保存</p>
	<div class="png"><img src="${basePath}/upload/${imgsrc}" width="78%" class="png_img"/></div>
	<div class="footer">
		<div class="f_ling">
			<a href="javascript:void(0)">这里放首页地址</a>
			<p>Copyright @ 2017-2020</p>
		</div>
	</div>
	<script src="${basePath}/resource/js/jquery-1.11.3.min.js"></script>
	<script>
		
	</script>
 </body>
</html>
