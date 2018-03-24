package com.krry.util;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.MediaTracker;
import java.awt.Toolkit;
import java.awt.Transparency;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Date;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;

import com.swetake.util.Qrcode;

/**
 * QrcodeText 二维码
 * @author krry
 * @version 1.0
 *
 */
public class QrcodeText{
	
	private static int width = 975;
	private static int height = 975;
	
	//设置偏移量，不设置可能导致解析出错
	private static int pixoff = 25;
	//像素大小
	private static int pix = 25;
	//二维码数组的长度
	private static int codeLength;
	//随机数，生成[0,2]之间的随机整数,取长度为3的数组下标
	private static int max = 3;
	
	//素材图片容器
	private static BufferedImage image_eye;
	private static BufferedImage image11;
	private static BufferedImage image12;
	private static BufferedImage image13;
	private static BufferedImage image21;
	private static BufferedImage image22;
	private static BufferedImage image23;
	private static BufferedImage image31;
	private static BufferedImage image32;
	private static BufferedImage image33;
	private static BufferedImage image41;
	private static BufferedImage image42;
	private static BufferedImage image43;
	
	
	/**
	 * 生成二维码
	 * @param message  二维码内容
	 * @param type	  二维码类型	如：锁屏
	 * @param filename 	二维码类型下的标号  如1
	 * @param arti 	使用算法类型  如0  热门
	 * @param transparent 是否透明     1：透明  0背景是白色
	 * @param request	请求
	 * @return
	 */
	public static String qrcode(String message,String type,String filename,String arti,String transparent,HttpServletRequest request){
		String pathName = null;
		FileOutputStream outputStream = null;

		try{
			//创建二维码对象
			Qrcode qrcode = new Qrcode();
			//设置二维码的纠错级别
			//L(7%) M(15%) Q(25%) H(30%)
			qrcode.setQrcodeErrorCorrect('L'); //一般纠错级别小一点
			//设置二维码的编码模式 Binary(按照字节编码模式)
			qrcode.setQrcodeEncodeMode('B');
			//设置二维码的版本号 1-40  1:20*21    2:25*25   40:177*177
			qrcode.setQrcodeVersion(5);
			
			//获取图片缓存流对象
			BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
			//获取画笔
			Graphics2D gs = image.createGraphics();
			
			//判断是否使用二维码背景颜色是透明
			if(transparent.equals("yes")){
				//设置透明
				image = gs.getDeviceConfiguration().createCompatibleImage(width, height, Transparency.TRANSLUCENT);  
	            gs = image.createGraphics();
			}else{
				gs.setBackground(Color.WHITE);
				gs.clearRect(0, 0, width, height);
			}
			
			//设置内容
			String content = message;
			byte[] contentsBytes = content.getBytes("utf-8");

			//二维码
			boolean[][] code = qrcode.calQrcode(contentsBytes);
			//获取二维码数组的长度
			codeLength = code.length;
			
			//码眼部分全部设置为false
			for(int i=0;i<7;i++){
				for(int j=0;j<7;j++){
					code[i][j]=false;
				}
				for(int j=codeLength-7;j<codeLength;j++){
					code[i][j]=false;
					code[j][i]=false;
				}
			}
			
			//获取资源地址
			String aspath = request.getServletContext().getRealPath("/resource");
			
			//加载图片
			loadImage(aspath,type,filename);
			
			//绘制二维码，选择算法
			if(arti.equals("0")) drawQrcodeHot(gs, code); //热门算法
			else if(arti.equals("1")) drawQrcodeOrdi(gs, code); //最初算法
			else if(arti.equals("2")) drawQrcodeRiTojiao(gs, code); //三角算法
	        
			//如果类型不是单码，则装载背景图片，将二维码写进背景图片中，只有单码没有背景
			if(!type.equals("dan")){
				//装载背景图片
				BufferedImage imageBG = ImageIO.read(new FileInputStream(aspath+"\\images\\ImageMaker\\"+type+"\\"+filename+"\\bg.jpg"));
				//获取背景图片的画笔
				Graphics2D bg = imageBG.createGraphics();
				
				//位置坐标
				int x = 0;
				int y = 0;
				
				//如果类型是方形，判断二维码在背景图片的位置,单码图片缩小到640像素
				if(type.equals("fang")){
					x = (imageBG.getWidth() - 640) / 2;
					y = (imageBG.getHeight() - 640) / 2;
				}
				//如果类型是名片，判断二维码在背景图片的位置,单码图片缩小到640像素
				if(type.equals("ming")){
					x = (imageBG.getWidth() - 100) / 2;
					y = (imageBG.getHeight() - 640) / 2;
				}
				//如果类型是锁屏，判断二维码在背景图片的位置,单码图片缩小到640像素
				if(type.equals("suo")){
					x = (imageBG.getWidth() - 640) / 2;
					y = (imageBG.getHeight() - 1100) / 2;
				}
				
				//将单码图片写进背景图片中,单码图片缩小到640像素
				bg.drawImage(image, x, y, 640, 640, null);
				
				//释放画笔
				bg.dispose();
				gs.dispose();
				//生成二维码图片
				String realPath = request.getRealPath("/");
				//String realPath = 服务器项目的地址;
				pathName = new Date().getTime()+".jpg";
				outputStream = new FileOutputStream(new File(realPath+"upload\\", pathName));
				ImageIO.write(imageBG, "jpg", outputStream);
				
			}else{ //如果类型是单码，直接释放输出
				//释放画笔
				gs.dispose();
				//生成二维码图片
				String realPath = request.getRealPath("/");
				//String realPath = 服务器项目的地址;
				pathName = new Date().getTime()+".png";
				outputStream = new FileOutputStream(new File(realPath+"upload\\", pathName));
				ImageIO.write(image, "png", outputStream);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			try {
				//关闭流
				outputStream.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return pathName;
	}
	
	/**
	 * 加载图片素材
	 * @param aspath
	 * @param type
	 * @param filename
	 */
	public static void loadImage(String aspath,String type,String filename){
		try {
			//加载码眼
			image_eye = ImageIO.read(new FileInputStream(aspath+"\\images\\ImageMaker\\"+type+"\\"+filename+"\\eye.png"));
			//装载50*50的图片素材
			image11 = ImageIO.read(new FileInputStream(aspath+"\\images\\ImageMaker\\"+type+"\\"+filename+"\\11.png"));
			image12 = ImageIO.read(new FileInputStream(aspath+"\\images\\ImageMaker\\"+type+"\\"+filename+"\\12.png"));
			image13 = ImageIO.read(new FileInputStream(aspath+"\\images\\ImageMaker\\"+type+"\\"+filename+"\\13.png"));
			//装载100*50的图片素材
			image21 = ImageIO.read(new FileInputStream(aspath+"\\images\\ImageMaker\\"+type+"\\"+filename+"\\21.png"));
			image22 = ImageIO.read(new FileInputStream(aspath+"\\images\\ImageMaker\\"+type+"\\"+filename+"\\22.png"));
			image23 = ImageIO.read(new FileInputStream(aspath+"\\images\\ImageMaker\\"+type+"\\"+filename+"\\23.png"));
			//装载50*100的图片素材
			image31 = ImageIO.read(new FileInputStream(aspath+"\\images\\ImageMaker\\"+type+"\\"+filename+"\\31.png"));
			image32 = ImageIO.read(new FileInputStream(aspath+"\\images\\ImageMaker\\"+type+"\\"+filename+"\\32.png"));
			image33 = ImageIO.read(new FileInputStream(aspath+"\\images\\ImageMaker\\"+type+"\\"+filename+"\\33.png"));
			//装载100*100的图片素材
			image41 = ImageIO.read(new FileInputStream(aspath+"\\images\\ImageMaker\\"+type+"\\"+filename+"\\41.png"));
			image42 = ImageIO.read(new FileInputStream(aspath+"\\images\\ImageMaker\\"+type+"\\"+filename+"\\42.png"));
			image43 = ImageIO.read(new FileInputStream(aspath+"\\images\\ImageMaker\\"+type+"\\"+filename+"\\43.png"));
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	/**
	 * 绘制 算法0  热门二维码   素材有50*50 50*100 100*50 100*100
	 * @param gs 画笔
	 * @param code 二维码数组
	 */
	public static void drawQrcodeHot(Graphics2D gs,boolean[][] code){
		//把图片素材放进数组
		BufferedImage[] img1 = {image11,image12,image13};
		BufferedImage[] img2 = {image21,image22,image23};
		BufferedImage[] img3 = {image31,image32,image33};
		BufferedImage[] img4 = {image41,image42,image43};
		
		//通用地绘制码眼
		gs.drawImage(image_eye, pix, pix, pix*7, pix*7, null);
		gs.drawImage(image_eye, (codeLength-7)*pix+pixoff, pix, pix*7, pix*7, null);
		gs.drawImage(image_eye, pix, (codeLength-7)*pix+pixoff, pix*7, pix*7, null);
		
        Random random = new Random();
        
        // 绘制
		for (int i = 0; i < codeLength; i++) {
			for (int j = 0; j < codeLength; j++) {
				if (code[i][j]) {
					if (i+1 < codeLength && j+1 < codeLength && code[i][j + 1] && code[i + 1][j + 1] && code[i + 1][j]){
						//随机取图片，画100*100的图
						int s4 = random.nextInt(max);
						gs.drawImage(img4[s4], i * pix + pixoff, j * pix + pixoff, pix * 2, pix * 2, null);
						code[i][j + 1] = code[i + 1][j] = code[i + 1][j + 1] = false;
					} else if(j+1 < codeLength && code[i][j+1]){
						//随机取图片，画50*100的图
						int s3 = random.nextInt(max);
						gs.drawImage(img3[s3], i * pix + pixoff, j * pix + pixoff, pix, pix*2, null);
						code[i][j+1] = false;
					} else if (i+1 < codeLength && code[i+1][j]) {
						//随机取图片，画100*50的图
						int s2 = random.nextInt(max);
						gs.drawImage(img2[s2], i * pix + pixoff, j * pix + pixoff, pix * 2, pix, null);
						code[i+1][j] = false;
					} else {
						//随机取图片，画50*50的图
						int s1 = random.nextInt(max);
						gs.drawImage(img1[s1], i * pix + pixoff, j * pix + pixoff, pix, pix, null);
					}
				}
			}
		}
	}
	
	/**
	 * 绘制  算法2 二维码   素材有50*50 50*100 100*50 100*100  其中100*100是三个角的算法，右上角没有填充
	 * @param gs 画笔
	 * @param code 二维码数组
	 */
	public static void drawQrcodeRiTojiao(Graphics2D gs,boolean[][] code){
		System.out.println("三角啊");
		//把图片素材放进数组
		BufferedImage[] img1 = {image11,image12,image13};
		BufferedImage[] img2 = {image21,image22,image23};
		BufferedImage[] img3 = {image31,image32,image33};
		BufferedImage[] img4 = {image41,image42,image43};
		
		//通用地绘制码眼
		gs.drawImage(image_eye, pix, pix, pix*7, pix*7, null);
		gs.drawImage(image_eye, (codeLength-7)*pix+pixoff, pix, pix*7, pix*7, null);
		gs.drawImage(image_eye, pix, (codeLength-7)*pix+pixoff, pix*7, pix*7, null);
		
        Random random = new Random();
        
        // 绘制
		for (int i = 0; i < codeLength; i++) {
			for (int j = 0; j < codeLength; j++) {
				if (code[i][j]) {
					if (i+1 < codeLength && j+1 < codeLength && code[i][j + 1] && code[i + 1][j + 1]){
						//随机取图片，画100*100的图  右上角没有填充
						int s4 = random.nextInt(max);
						gs.drawImage(img4[s4], i * pix + pixoff, j * pix + pixoff, pix * 2, pix * 2, null);
						code[i][j + 1] = code[i + 1][j + 1] = false;
					} else if(j+1 < codeLength && code[i][j+1]){
						//随机取图片，画50*100的图
						int s3 = random.nextInt(max);
						gs.drawImage(img3[s3], i * pix + pixoff, j * pix + pixoff, pix, pix*2, null);
						code[i][j+1] = false;
					} else if (i+1 < codeLength && code[i+1][j]) {
						//随机取图片，画100*50的图
						int s2 = random.nextInt(max);
						gs.drawImage(img2[s2], i * pix + pixoff, j * pix + pixoff, pix * 2, pix, null);
						code[i+1][j] = false;
					} else {
						//随机取图片，画50*50的图
						int s1 = random.nextInt(max);
						gs.drawImage(img1[s1], i * pix + pixoff, j * pix + pixoff, pix, pix, null);
					}
				}
			}
		}
	}
	
	/**
	 * 绘制  算法1 普通二维码   素材有50*50 50*100 50*150
	 * @param gs 画笔
	 * @param code 二维码数组
	 */
	public static void drawQrcodeOrdi(Graphics2D gs,boolean[][] code){
		//把图片素材放进数组
		BufferedImage[] img1 = {image11,image12,image13};
		BufferedImage[] img2 = {image21,image22,image23};
		BufferedImage[] img3 = {image31,image32,image33};
		
		//通用地绘制码眼
		gs.drawImage(image_eye, pix, pix, pix*7, pix*7, null);
		gs.drawImage(image_eye, (codeLength-7)*pix+pixoff, pix, pix*7, pix*7, null);
		gs.drawImage(image_eye, pix, (codeLength-7)*pix+pixoff, pix*7, pix*7, null);
		
        Random random = new Random();
        
        for(int i = 0;i < codeLength;i++){
			for(int j = 0;j < codeLength;j++){
				//1*3
				if(code[i][j]){
					if(i+2 < codeLength && code[i+1][j] && code[i+2][j]){
						//随机取图片  下标随机[0,2]，画50*150的图
						int s3 = random.nextInt(max);
						gs.drawImage(img3[s3], j*25+pixoff, i*25+pixoff, 25, 75, null);
						code[i+2][j]=false;
						code[i+1][j]=false;
					}else if(i+1 < codeLength && code[i+1][j]){
						//1*2
						//随机取图片，画50*100的图
						int s2 = random.nextInt(max);
						gs.drawImage(img2[s2], j*25+pixoff, i*25+pixoff, 25, 50, null);
						code[i+1][j]=false;
					}else{
						//随机取图片，画50*50的图
						int s1 = random.nextInt(max);
						gs.drawImage(img1[s1], j*25+pixoff, i*25+pixoff, 25, 25, null);
					}
				}
			}
		}
	}


}



