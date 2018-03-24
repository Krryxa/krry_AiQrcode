<%@page import="com.krry.util.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String message = request.getParameter("message");
	String typeQrcode = request.getParameter("typeQrcode");
	String filenameQrcode = request.getParameter("filenameQrcode");
	String arti = request.getParameter("arti");
	String transparent = request.getParameter("transparent");
	//默认出错，如果执行了生成二维码的方法，则更新成文件名
	String imgName = "error";
	
	byte[] contentsBytes = message.getBytes("utf-8");
	int length = contentsBytes.length;
	//如果长度小于105，则执行生成二维码的方法，更新成文件名
	if(length <= 105){
		imgName = QrcodeText.qrcode(message,typeQrcode,filenameQrcode,arti,transparent,request);  //调用方法，绘制二维码图片并保存,并获得图片名称		
	}
	out.print(imgName);
%>