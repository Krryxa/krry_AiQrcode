# krry_AiQrcode
> Java 开发精美艺术二维码

看到网络上各种各样的二维码层出不穷，好像很炫酷的样子，一时兴起，我也要制作这种炫酷二维码效果

例如：
![](https://raw.githubusercontent.com/Krryxa/krry_AiQrcode/master/WebRoot/resource/images/cutImg/ext.jpg)


## 根据以往例子

根据之前所做的小项目 java 开发二维码系统

![](https://raw.githubusercontent.com/Krryxa/krry_AiQrcode/master/WebRoot/resource/images/cutImg/new.jpg)

以这个为基础，将实现精美艺术二维码

基本代码：
```java
// 创建二维码对象
Qrcode qrcode = new Qrcode();
// 设置二维码的纠错级别
// L(7%) M(15%) Q(25%) H(30%)
qrcode.setQrcodeErrorCorrect('L'); // 一般纠错级别小一点
// 设置二维码的编码模式 Binary(按照字节编码模式)
qrcode.setQrcodeEncodeMode('B');
// 设置二维码的版本号 1-40  1:20*21    2:25*25   40:177*177
qrcode.setQrcodeVersion(7);
// 生成二维码中要存储的信息
String qrData = "https://ainyi.com";
// 设置一下二维码的像素
int width = 300;
int height = 300;
BufferedImage bufferedImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
// 绘图
Graphics2D gs = bufferedImage.createGraphics();
gs.setBackground(Color.WHITE);
gs.setColor(Color.BLACK);
gs.clearRect(0, 0, width, height); // 清除下画板内容

// 设置下偏移量，如果不加偏移量，有时会导致出错
int pixoff = 2;

byte[] d = qrData.getBytes("utf-8");
if(d.length > 0 && d.length <120){
  boolean[][] s = qrcode.calQrcode(d);
  for(int i=0;i<s.length;i++){
    for(int j=0;j<s.length;j++){
      if(s[j][i]){
        gs.fillRect(j*3+pixoff, i*3+pixoff, 3, 3);
      }
    }
  }
}
gs.dispose();
bufferedImage.flush();
ImageIO.write(bufferedImage, "png", new File("E:/code/qrcode.png"));
```

## 准备工作
java 可以实现生成二维码，需要用到 Qrcode 的 jar 包
1. java、jsp
2. struts2 以及相关 jar 包
3. Qrcode.jar
4. 文件上传相关 jar 包

- 自己编写摸索出来的艺术二维码算法
- 响应式

## 实现流程
因为要实现精美艺术二维码，把黑白二维码的黑色部分，点状部分替换成有颜色的点，汇聚成一张精美的二维码

那么实现的关键点就是：替换

## 项目截图
![](https://raw.githubusercontent.com/Krryxa/krry_AiQrcode/master/WebRoot/resource/images/cutImg/1.jpg)
![](https://raw.githubusercontent.com/Krryxa/krry_AiQrcode/master/WebRoot/resource/images/cutImg/2.jpg)
![](https://raw.githubusercontent.com/Krryxa/krry_AiQrcode/master/WebRoot/resource/images/cutImg/3.jpg)
![](https://raw.githubusercontent.com/Krryxa/krry_AiQrcode/master/WebRoot/resource/images/cutImg/4.jpg)

## 相关地址
项目地址：[https://www.ainyi.com/krry_AiQrcode](https://www.ainyi.com/krry_AiQrcode)

krryblog：[https://ainyi.com](https://ainyi.com)