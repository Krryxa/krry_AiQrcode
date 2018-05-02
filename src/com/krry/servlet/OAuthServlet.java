package com.krry.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.krry.bean.login.SNSUserInfo;
import com.krry.bean.login.WeixinOauth2Token;
import com.krry.util.login.AdvancedUtil;

/**
* 类名: OAuthServlet </br>
* 描述: 授权后的回调请求处理 </br>
* 发布版本：V1.0  </br>
 */
public class OAuthServlet extends HttpServlet {
	
    private static final long serialVersionUID = -1847238807216447030L;
    
    public void doGet(HttpServletRequest request, HttpServletResponse response)
    		throws ServletException, IOException {
        
        doPost(request, response);
    }
    
    public void doPost(HttpServletRequest request, HttpServletResponse response)
    		throws ServletException, IOException {
    	request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");

        //如果上下文作用域是空，则获取
        if(request.getSession().getAttribute("snsUserInfo") == null){
        	
        	//用户同意授权后，能获取到code
        	String code = request.getParameter("code");
        	String state = request.getParameter("state");
        	// 用户同意授权
        	if (!"authdeny".equals(code)) {
        		// 获取网页授权access_token
        		WeixinOauth2Token weixinOauth2Token = AdvancedUtil.getOauth2AccessToken("wxd11020eacc06042f", "cc2801acd990639a970c35ac5ec80f6a", code);
        		// 网页授权接口访问凭证
        		String accessToken = weixinOauth2Token.getAccessToken();
        		// 用户标识
        		String openId = weixinOauth2Token.getOpenId();
        		// 获取用户信息
        		SNSUserInfo snsUserInfo = AdvancedUtil.getSNSUserInfo(accessToken, openId);
        		
        		// 设置要传递的参数
        		request.getSession().setAttribute("snsUserInfo", snsUserInfo);
        		//state暂时没什么用
//        		request.setAttribute("state", state);
        		System.out.println(request.getSession().getAttribute("snsUserInfo"));
        	}
        }
        
        //最终回调页面
        // 跳转到index.jsp，转发
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

    
}



