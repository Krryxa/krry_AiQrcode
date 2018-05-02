package com.krry.action.editor;

public class Editor {
	
	//样品类型	 如：锁屏
	private String type;
	//样品文件名	如：1
	private String filename;
	//样品主题		如：太空城堡
	private String title;
	//样品价格		如：19.99
	private String price;
	//算法类型		如：0 是热门
	private String arti;
	//是否透明		如：yes是透明
	private String transparent;
	
	//默认方法
	public String execute(){
		//跳转到生成二维码页面
		//地址栏上包含这些参数。将自动注入type和filename和title和price的值，放到作用域中
		return "editorPage";
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getArti() {
		return arti;
	}

	public void setArti(String arti) {
		this.arti = arti;
	}

	public String getTransparent() {
		return transparent;
	}

	public void setTransparent(String transparent) {
		this.transparent = transparent;
	}
}
