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
	body{font-family:"微软雅黑";}
	.clear{clear:both;}
	.none{display:none;}
	.qrcode{max-width:640px;margin:0 auto;}
	.left{float:left;}
	.right{float:right;}
	.span{color:#fb3a19;font-size: 18px;}
	.leftcontainer{width: 92%;margin: 5% 4%;position: relative;}
	.leftcontainer .right_button{float: right;position: absolute;top: 0;right: 0;height: 100%;
    display: block;}
	.qrcode .context_tainer{}
	.qrcode .context_tainer .inputqr{margin: 46px auto;}
	.qrcode .area{margin:0 auto;display:block;width:89%;height:108px;padding:8px;outline:none;font-size:16px;font-family:"微软雅黑";}
	.qrcode .type{margin:19px 13px 27px 0px;}
	.qrcode .kongjian{margin-bottom:40px;}
	.qrcode .inp{display:block;width:88%;height:45px;margin:0 auto;color:#fff;background:#f90;font-size:18px;font-family:"微软雅黑";border:0;outline:none;border-radius:9px;cursor:pointer;transition:.6s;}
	.qrcode .inp:hover{background:red;transition:.6s;}
	#typeQrcode{width:90px;height: 32px;border-radius: 10px;border: none;}
	.leftcontainer .c_d_div{position:relative;}
	.leftcontainer .c_d_div .div_img{float: left;}
	.leftcontainer .c_d_div .div_detil{background: #f3f3f3;padding: 0 4%;width: 42%;line-height: 42px;}
	.leftcontainer .c_d_div .c_title{color:#666;float:left;font-size:14px;}
	.leftcontainer .c_d_div .c_money{color:red;float:right;font-size:14px;}
	.uploadbutton2{	float: right;
					width: 100px;
					height: 100px;
				    border-radius: 50%;
				    border: 0;
				    outline: none;
				    background: #55ce8c;
				    font-size: 16px;
				    color: #fff;
				    cursor: pointer;}
	.transInp{ 	width: 100px;
			    height: 100px;
			    position: absolute;
			    background: transparent;
			    border: none;
			    outline: none;}
	/*解析二维码*/
	.scanqr{display:none;height:182px;margin:18px auto;}
	#uploadQrcode{display:none;}
	.uploadbutton{	background:#fff;
				    width: 40px;
				    height: 40px;
				    cursor: pointer;}
	#qrfile{  
	    position: relative;
	    width:180px;  
	    height:180px;  
	}  
	#qr-canvas{  
	    display:none;  
	}
	#outdiv  
	{  text-align:center;  margin: 0 auto;
	    width:180px;  
	    height:180px;  
	    border:1px dashed darkgrey;
	}  
	#result{  
	    border: solid;  
	    border-width: 1px 1px 1px 1px;  
	    padding:20px;  
	    width:37.3%;  
	}  
	#imghelp{  
	    position: absolute;
	    left: 70px;
	    top: 70px;
	    z-index: 100; 
	}
  </style>
 </head>
 <%
	//如果用户没有在微信授权登录，则跳回授权登录的地方，意思就是网页只能在微信内置浏览器打开
	//if(request.getSession().getAttribute("snsUserInfo") == null){
	//	response.sendRedirect("https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxd11020eacc06042f&redirect_uri=http://www.krrymusic.xin/krry_wecchatLogin/krry&response_type=code&scope=snsapi_userinfo&state=12fggh3#wechat_redirect");
	//}
 	//如果直接输入该地址，则直接跳回首页
 	String type = (String)request.getAttribute("type");
 	if(type == null){
 		response.sendRedirect("index");
 	}
  %>
 <body onload="load();setimg();">
 		<p class="none" id="typeQrcode">${type}</p>
 		<p class="none" id="filenameQrcode">${filename}</p>
 		<p class="none" id="arti">${arti}</p>
 		<p class="none" id="transparent">${transparent}</p>
		<div class="qrcode">
			<div class="context_tainer">
				<div class="inputqr">
					<textarea class="area" name="message" placeholder="在此输入内容，中文字符35个以内，或者英文、数字字符105个以内" oninput="textchange(this)"></textarea>
				</div>
				<div class="scanqr">
					<div id="outdiv">
						<div id="qrfile">
							<canvas id="out-canvas" width="180" height="180"></canvas>
							<div id="imghelp">
								<img src="${basePath}/resource/images/uploadimg.png" width="40" class="uploadbutton" id="uploadfile">
								<input type="file" id="uploadQrcode" accept="image/*" onchange="handleFiles(this.files)"/>
							</div>
							<div id="result" style="display:none;"></div>  
						</div>
					</div>
					<canvas id="qr-canvas" width="800" height="600"></canvas> <!--Canvas to draw image -->  
				</div>
				
				<div class="kongjian">
					<input type="button" class="inp" value="支付 ${price} 生成" />
				</div>
			</div>

			<div class="leftcontainer">
				<div class="c_d_div">
					<img src="${basePath}/resource/images/model/${type}/${filename}.jpg" width="50%" class="div_img"/>
					<div class="div_detil">
						<p class="c_title">${title}</p>
						<p class="c_money">￥${price}</p>
						<div class="clear"></div>
					</div>
				</div>
				<div class="right_button">
					<input type="button" class="uploadbutton2"  value="上传二维码"/>
					<input type="button" class="transInp" id="changebutton">
				</div>
			</div>
		</div>
	<script type="text/javascript" src="${basePath}/resource/js/jquery-1.11.3.min.js"></script>
	<script type="text/javascript" src="${basePath}/resource/js/llqrcode.js"></script>  
	<script type="text/javascript" src="${basePath}/resource/js/webqr.js"></script>
	<script>
		//控制表单长度为120
		function textchange(obj){
			if($(obj).val().length>105){
				var text = $(obj).val().substring(0,105);
				$(obj).val(text);
			}				
		};

		$(function(){
			
			var canvas = document.getElementById("out-canvas");
		    var ctx = canvas.getContext("2d");//获取权限
			//点击上传
			$("#uploadfile").click(function(){
				$("#uploadQrcode").click();
			});
			
			//点击转换
			$("#changebutton").click(function(){
				//清除画布
				ctx.clearRect(0, 0, canvas.width, canvas.height);
				//清除文本
				$(".inputqr .area").val("");
				
				if($(".inputqr").is(":hidden")){ //是隐藏
					$(".right_button .uploadbutton2").val("上传二维码");
					$(".inputqr").show();
					$(".scanqr").hide();
					
				}else{
					$(".right_button .uploadbutton2").val("输入文本");
					$(".inputqr").hide();
					$(".scanqr").show();
				}
			});

			
			$(".inp").click(function(){
				//要生成的二维码内容
				var value = "";
				//如果是上传二维码
				if($(".inputqr").is(":hidden")){
					value = $("#result").text();
					if(isEmpty(value)){ //如果没有上传
						alert("请先上传二维码图片");
						return;
					}
					if(value == "errorxiaoqi"){
						alert("解析错误");
						return;
					}
				}//如果是文本输入
				else{
					value = $(".area").val();
					if(isEmpty(value)){ //如果没有输入
						alert("请先输入信息");
						return;
					}
				}
				
				//进来这里，说明文本有内容，或者解析二维码成功
				//这里执行业务，付款
				
				
				
				//付款成功的函数,生成二维码
				formQrcode(value);
			});
			
			//付款成功的函数，生成二维码
			function formQrcode(message){
				//获取类型和文件名,传到后台，确定应该生成的二维码类型
				var typeQrcode = $("#typeQrcode").text();
				var filenameQrcode = $("#filenameQrcode").text();
				var arti = $("#arti").text();
				var transparent = $("#transparent").text();
				//将参数传递到image页面，再跳转到result页面
				$.ajax({
					url:basePath+"/pages/result/image.jsp",
					type:"post",
					data:{
						message:message,
						typeQrcode:typeQrcode,
						filenameQrcode:filenameQrcode,
						arti:arti,
						transparent:transparent
					},
					success:function(data){
						//去除左右空格
						var str = data.trim();
						//如果长度溢出
						if(str == "error"){
							alert("您输入的字符或解析二维码的字符总长度溢出");
						}else{
							//跳转到result页面,参数是生成的二维码地址
							window.location.href = basePath+"/result?imgsrc="+data;
						}
					}
				});
			}
			
		});
		
		function isEmpty(val) {
			val = $.trim(val);
			if (val == null)
				return true;
			if (val == undefined || val == 'undefined')
				return true;
			if (val == "")
				return true;
			if (val.length == 0)
				return true;
			if (!/[^(^\s*)|(\s*$)]/.test(val))
				return true;
			return false;
		}
	</script>
 </body>
</html>
