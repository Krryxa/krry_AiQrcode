package com.krry.action.result;

public class Result {
	
	//二维码生成后的地址
	private String imgsrc;
	
	//默认方法
	public String execute(){
		//跳转到结果页
		return "resultImg";
	}

	public String getImgsrc() {
		return imgsrc;
	}

	public void setImgsrc(String imgsrc) {
		this.imgsrc = imgsrc;
	}

}
