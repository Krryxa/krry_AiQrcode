$(".conall .con_dan .c_d_div").click(function(){
	var url = $(this).data("src");
	//如果最后是一个数字，该数字是图片名称，则点击进入生成二维码页面
	//urlhtml是文件名称，imgname图片上一级的名称
	var preurl = url.split("/");
	//获取图片上一级的文件名dan
	var imgname = preurl[preurl.length-6];
	//获取文件名称1
	var urlhtml = preurl[preurl.length-5];
	//获取主题名称
	var title = preurl[preurl.length-4];
	//获取价格
	var price = preurl[preurl.length-3];
	//获取算法使用的不同
	var arti = preurl[preurl.length-2];
	//获取二维码背景是否透明
	var transparent = preurl[preurl.length-1];
	
	var jsonMsg = {type:imgname,filename:urlhtml,title:title,price:price,arti:arti,transparent:transparent};
	//调用父级的方法
	parent.window.skipEditor(basePath+"/editor",jsonMsg);
});