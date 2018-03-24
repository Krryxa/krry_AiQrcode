<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../common/basePath.jsp" %>
<!doctype html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
		<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
		<title>dan --krry</title>
		<%@include file="../common/common.jsp" %>
		<style type="text/css">
			*{margin:0;padding:0}
			body{font-family:"微软雅黑";font-size:12px;color:#666;}
			a{text-decoration:none;color:#000;}
			ul li{list-style:none;}
			.clear{clear:both;}
			.conall{max-width:640px;margin:0 auto;}
			.con_dan{padding-bottom: 8px;padding: 0 2%;}
			.con_dan .title{color:#000;font-size:20px;margin:14px 0px 7px 0px;margin-left: 10px;}
			.con_dan .c_d_div{width:48%;float:left;text-align:center;margin:0 1%;background:#f3f3f3;margin-bottom: 9px;cursor: pointer;}
			.con_dan .c_d_div .div_img{}
			.con_dan .c_d_div .div_detil{padding: 0 7%;line-height: 42px;}
			.con_dan .c_d_div .c_title{color:#666;float:left;font-size:14px;}
			.con_dan .c_d_div .c_money{color:red;float:right;font-size:14px;}
	
			.more_right{float:right;margin-right:10px;font-size:16px;line-height:26px;color:#24b13d;}
		</style>
	</head>
	<body>
		<!--开始-->
		<div class="conall">
			<div class="con_dan">
				<p class="title">单码</p>
				<div class="c_d_div" data-src="/dan/1/默认的啦/0.99/1/no">
					<img src="${basePath}/resource/images/model/dan/1.jpg" width="100%" class="div_img"/>
					<div class="div_detil">
						<p class="c_title">默认的啦</p>
						<p class="c_money">￥0.99</p>
						<div class="clear"></div>
					</div>
				</div>
				<div class="c_d_div" data-src="/dan/2/清新叶/99.99/0/no">
					<img src="${basePath}/resource/images/model/dan/2.jpg" width="100%" class="div_img"/>
					<div class="div_detil">
						<p class="c_title">清新叶</p>
						<p class="c_money">￥99.99</p>
						<div class="clear"></div>
					</div>
				</div>
				<div class="c_d_div" data-src="/dan/3/浪漫的美好/80.15/0/no">
					<img src="${basePath}/resource/images/model/dan/3.jpg" width="100%" class="div_img"/>
					<div class="div_detil">
						<p class="c_title">浪漫的美好</p>
						<p class="c_money">￥80.15</p>
						<div class="clear"></div>
					</div>
				</div>
				<div class="c_d_div" data-src="/dan/4/脚印/100.01/0/no">
					<img src="${basePath}/resource/images/model/dan/4.jpg" width="100%" class="div_img"/>
					<div class="div_detil">
						<p class="c_title">测试品</p>
						<p class="c_money">￥0.01</p>
						<div class="clear"></div>
					</div>
				</div>
				<div class="c_d_div" data-src="/dan/5/春风十里三角/12.01/2/no">
					<img src="${basePath}/resource/images/model/dan/5.jpg" width="100%" class="div_img"/>
					<div class="div_detil">
						<p class="c_title">春风十里三角</p>
						<p class="c_money">￥12.01</p>
						<div class="clear"></div>
					</div>
				</div>
				<div class="c_d_div" data-src="/dan/6/枫叶/9.05/0/yes">
					<img src="${basePath}/resource/images/model/dan/6.jpg" width="100%" class="div_img"/>
					<div class="div_detil">
						<p class="c_title">枫叶</p>
						<p class="c_money">￥9.05</p>
						<div class="clear"></div>
					</div>
				</div>
				<div class="c_d_div" data-src="/dan/7/水果/119.05/0/no">
					<img src="${basePath}/resource/images/model/dan/7.jpg" width="100%" class="div_img"/>
					<div class="div_detil">
						<p class="c_title">水果</p>
						<p class="c_money">￥119.05</p>
						<div class="clear"></div>
					</div>
				</div>
				<div class="c_d_div" data-src="/dan/8/花海/18.05/0/no">
					<img src="${basePath}/resource/images/model/dan/8.jpg" width="100%" class="div_img"/>
					<div class="div_detil">
						<p class="c_title">花海</p>
						<p class="c_money">￥18.05</p>
						<div class="clear"></div>
					</div>
				</div>
				<div class="clear"></div>
			</div>
		</div>
		<script type="text/javascript" src="${basePath}/resource/js/model.js"></script>
		<script>
			
		</script>
	</body>
</html>
