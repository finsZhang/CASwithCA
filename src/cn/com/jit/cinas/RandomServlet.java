/**
 * Copyright © 1999-2008 JIT Co，Ltd. 
 * All right reserved.
 */
package cn.com.jit.cinas;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class RandomServlet extends HttpServlet {

	private static final long serialVersionUID = 3923090461076418525L;

	private String tempURL = null,propertiesURL = null;
	
	private Properties props = null;
	
	/** 认证地址 */
	private final String KEY_AUTHURL = "authURL";

	/** 应用标识 */
	private final String KEY_APP_ID = "appId";
	
	/** 获取属性列表控制   none：不获取属性；all 获取全部属性 ；portion 获取指定属性 */
	private final String kEY_ATTR_TYPE ="attrType";
	
	/** 当配置文件中attrType 值为portion时 获取查询指定属性   当且仅当attrType为portion时有效*/
	private final String KEY_ATTRIBUTES ="attributes";

	public void init(ServletConfig cfg) throws ServletException {
		// 初始化程序跳转页面
		tempURL = cfg.getInitParameter("url");
		propertiesURL = cfg.getInitParameter("propertiesURL");
	}
	 
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) resp;

		// 设置页面不缓存
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", 0);
	 
		try{
			String parentPath = request.getSession().getServletContext()
			.getRealPath("/WEB-INF");
			InputStream in = new FileInputStream(parentPath + propertiesURL);
			props = new Properties();
			props.load(in);
			this.setProperties(KEY_APP_ID,request.getSession());
			this.setProperties(KEY_AUTHURL,request.getSession());
			this.setProperties(kEY_ATTR_TYPE, request.getSession());
			this.setProperties(KEY_ATTRIBUTES, request.getSession());
			}catch(Exception e){
				 
				System.out.println("从配置文件中获得应用标识，网关地址，属性列表控制项，认证方式发生异常");
		}
			
			String randNum = generateRandomNum();
			if (randNum == null || randNum.trim().equals("")) {
				System.out.println("证书认证数据不完整！");
				response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
				return;
			}
			
			/**************************
			 * 第三步 服务端返回认证原文   *
			 **************************/
			// 设置认证原文到session，用于程序向后传递，通讯报文中使用
			request.getSession().setAttribute("original_data", randNum);

			// 设置认证原文到页面，给页面程序提供参数，用于产生认证请求数据包
			request.setAttribute("original", randNum);

			// 设置跳转页面
			request.getRequestDispatcher(tempURL).forward(request, response);
			
		// 产生认证原文
	
		return;
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws IOException, ServletException {
		doGet(req, resp);
	}
	/**
	 * 产生认证原文
	 */
	private String generateRandomNum() {
		/**************************
		 * 第二步 服务端产生认证原文   *
		 **************************/
		String num = "1234567890abcdefghijklmnopqrstopqrstuvwxyz";
		int size = 6;
		char[] charArray = num.toCharArray();
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < size; i++) {
			sb
					.append(charArray[((int) (Math.random() * 10000) % charArray.length)]);
		}
		return sb.toString();
	}
	 
	/**
	 * 获取文件中的属性值
	 * @param httpSession 
	 */
	private String   setProperties(String key, HttpSession httpSession) {
		
		httpSession.setAttribute(key,props.get(key) == null ? null : (String) props.get(key) );
		return props.get(key) == null ? null : (String) props.get(key);
	}
}
