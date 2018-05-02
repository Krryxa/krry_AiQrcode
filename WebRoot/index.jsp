<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="pages/common/basePath.jsp" %>
<!doctype html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
		<meta name="Keywords" content="关键词,关键词">
		<meta name="Description" content="网页描述">
		<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
		<title>二维码首页 --krry</title>
		<%@include file="pages/common/common.jsp" %>
		<style type="text/css">
			*{margin:0;padding:0}
			body{font-family:"微软雅黑";font-size:12px;color:#666;}
			a{text-decoration:none;color:#666;}
			ul li{list-style:none;}
			.conall{max-width:640px;margin:0 auto;position:relative;}
			.header{border-bottom:1px solid #e0e0e0;height:40px;width:100%;background:#fff;position:fixed;top:0;}
			.header ul li a.active{color:#ff5722;}
			.header span{float:left;margin-top:12px;color:#e0e0e0;width: 1.25%;}
			.header ul li{height:40px;float:left;width:19%;text-align:center;line-height:40px;}
			.header ul li a{color:#000;display:block;font-size:16px;}
			.header ul li:last-child{border-right:none;}
			.container{margin-top:40px;}

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
	%>
	
	
		<!--导航-->
		<div class="conall">
			<div class="header">
				<ul>
					<li><a class="active" href="${basePath}/pages/detail/all.jsp" target="iframe_all">全部</a></li>
					<span>|</span>
					<li><a href="${basePath}/pages/detail/dan.jsp" target="iframe_all">单码</a></li>
					<span>|</span>
					<li><a href="${basePath}/pages/detail/fang.jsp" target="iframe_all">方形</a></li>
					<span>|</span>
					<li><a href="${basePath}/pages/detail/ming.jsp" target="iframe_all">名片</a></li>
					<span>|</span>
					<li><a href="${basePath}/pages/detail/suo.jsp" target="iframe_all">锁屏</a></li>
				</ul>
			</div>
			<div class="container">
				<iframe id="mainFrame" src="${basePath}/pages/detail/all.jsp" width="100%" height="1008" scrolling="no" name="iframe_all" frameborder="0" onload="loadFrame(this)"></iframe>
			</div>
			<div class="footer">
				<div class="f_ling">
					<a href="javascript:void(0)">这里放首页地址</a>
					<p>Copyright @ 2017-2020</p>
				</div>
			</div>
		</div>
		
		<script>
			function setIframeHeight(iframe) {
				if (iframe) {
					var iframeWin = iframe.contentWindow || iframe.contentDocument.parentWindow;
					if (iframeWin.document.body) {
						iframe.height = iframeWin.document.documentElement.scrollHeight || iframeWin.document.body.scrollHeight;
					}
				}
			};
			window.onload = function () {
				//动态适应iframe的高度
				setIframeHeight(document.getElementById('mainFrame'));
				//设置header的宽度
				var hwidth = $(".conall").width();
				$(".header").width(hwidth);
			};
			//窗口改变大小
			$(window).resize(function(){
				//动态适应iframe的高度
				setIframeHeight(document.getElementById('mainFrame'));
				//设置header的宽度
				var hwidth = $(".conall").width();
				$(".header").width(hwidth);
			});
			//导航条点击改变样式
			$(".header ul li a").click(function(){
				$(this).addClass("active").parents().siblings().find("a").removeClass("active");
			});

			//点击更多后，监听iframe的src改变
			function loadFrame(obj){
				//动态适应iframe的高度
				setIframeHeight(document.getElementById('mainFrame'));

				//点击更多后，设置滚动条置顶
				$("html,body").animate({
					scrollTop:0
				},0);

				//获取iframe跳转的url
				var url = obj.contentWindow.location.href;
				var index = url.lastIndexOf("\/");
				//获取url最后面斜杠之后的字符串
				var urlhtml = url.substring(index + 1,url.length);
				
				//设置index导航条的样式
				if(urlhtml == "dan.jsp") $(".header li").eq(1).find("a").addClass("active").parents().siblings().find("a").removeClass("active");
				if(urlhtml == "fang.jsp") $(".header li").eq(2).find("a").addClass("active").parents().siblings().find("a").removeClass("active");
				if(urlhtml == "ming.jsp") $(".header li").eq(3).find("a").addClass("active").parents().siblings().find("a").removeClass("active");
				if(urlhtml == "suo.jsp") $(".header li").eq(4).find("a").addClass("active").parents().siblings().find("a").removeClass("active");
				
			}     
			       
			//父页面的方法，在子页面中调用，点击某一个样板后，跳转到生成二维码页面
			//type 类型   filename 文件名   title 主题名称    price 价格   arti 算法  transparent 是否透明
			//url要跳转的地址，params：以上的参数
			function skipEditor(url,params){
				//将类型和文件名和价格，传递到后台，再传递到editor页面
				//window.location.href = basePath+"/editor?type="+type+"&filename="+filename+"&title="+title+"&price="+price+"&arti="+arti+"&transparent="+transparent;
				//创建一个form表单
				var temp = document.createElement("form");
			    temp.action = url;
			    temp.method = "post";
			    temp.style.display = "none";
			    for (var x in params) {        
			        var opt = document.createElement("input");        
			        opt.name = x;        
			        opt.value = params[x];        
			        temp.appendChild(opt);      
			    }        
			    document.body.appendChild(temp);        
			    temp.submit();
			}
		</script>
	</body>
</html>
