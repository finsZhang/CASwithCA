<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
String successStr = (String)request.getAttribute("isSuccess");
boolean isSuccess = false;
if(successStr!=null&&!successStr.equals("")) {
	isSuccess = Boolean.valueOf(successStr).booleanValue();
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="Content-Language" content="zh-cn">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>集中认证JAVA BSDemoV2.7</title>
		<link href="images/body.css" rel="stylesheet" type="text/css">
	</head>
	<body topmargin="0" leftmargin="0">
		<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" >
			<tr><td valign="top" align="center">
					<table width="100%" height="119" border="0" cellpadding="0"
						cellspacing="0">
						<tr>
							<td width="47%"><img src="images/testtop2.gif" width="570"></td>
							<td width="53%" valign="top" background="images/topall_42.gif">
								<div align="right"><img src="images/topall_43.gif" width="187" height="60"></div>
							</td>
						</tr>
					</table>
					<table width="780" border="0" cellpadding="0" cellspacing="0" bgcolor="#E4E9E0" >
						<tr><td valign="top" align="center"><br>
							<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#7D8873">
								<tr><td class="listmenutxt" colspan="3">结果</td></tr>
								<tr class="listtxt">
									<td width="10%">身份认证：</td>
									<td width="90%" colspan="2"><%=isSuccess?"成功":"失败" %></td>
									 
								</tr>
								
								<%if(isSuccess) { 
									%>
									<tr><td colspan="3">证书信息</td></tr>
									<%
									
									Map certAttributeNodeMap = (Map)request.getAttribute("certAttributeNodeMap");
									Map pmsAttributeNodeMap = (Map)request.getAttribute("pmsAttributeNodeMap");
									Map umsAttributeNodeMap = (Map)request.getAttribute("umsAttributeNodeMap");
									if((certAttributeNodeMap==null||certAttributeNodeMap.size()==0)&&(umsAttributeNodeMap == null || umsAttributeNodeMap.size()==0)&&(pmsAttributeNodeMap==null || pmsAttributeNodeMap.size() == 0)){
										%>
										
										
										<tr class="listtxt">
										<td width="10%">属性值：</td>
										<td colspan="2" width="90%" 
										    style="width: 680px; word-wrap: break-word; margin: 5 auto; line-height: 22px;">
										  无
										</td>	 
							 </tr>
										
										<%
									}else{
									if(certAttributeNodeMap !=null && certAttributeNodeMap.size() > 0){
									Iterator iter =   certAttributeNodeMap.entrySet().iterator();
									/*Iterator attrsIterator = attrs.entrySet().iterator();
									while(attrsIterator.hasNext()){
										Map.Entry entry = (Map.Entry) attrsIterator.next(); 
								        Object key = entry.getKey();
								        Object value = entry.getValue();
								        out.println(key+"============="+value+"<br />");
									}*/
								    while (iter.hasNext()){ 
								        Map.Entry entry = (Map.Entry) iter.next(); 
								        Object key = entry.getKey(); 
								        String [] keys =null;
								        if(key!=null && !key.equals("")){
								        	keys = (String[])key;
								        	Object val = entry.getValue(); 
								        	if(val !=null ){
								  %>
								  <tr class="listtxt">
											<td width="10%">属性名：</td>
											<%
											if(keys[1]!=null){
											%>
											<td width="60%"> <%=keys[0] %></td>
											<td width="30%">
											上级机构：<%=keys[1] %>
											</td>
											<%	
											}else{
											%>
											<td colspan="2" width="90%"> <%=keys[0] %></td>
											<%	
											}
											%>
										</tr>
										<tr class="listtxt">
											<td width="10%">属性值：</td>
											<td colspan="2" width="90%" 
											    style="width: 680px; word-wrap: break-word; margin: 5 auto; line-height: 22px;">
											  
											  <%=val.toString() %> 
											</td>	 
								 </tr>
								  <%      		
								        	}
								        	
								        }
								    }   
									}else{
										%>
										<tr class="listtxt">
											<td width="10%">属性值：</td>
											<td colspan="2" width="90%" 
											    style="width: 680px; word-wrap: break-word; margin: 5 auto; line-height: 22px;">
											 无
											</td>	 
								 </tr>
										<%
									}
								  %>
								  <tr><td colspan="3">UMS信息</td></tr>
								  <%
								  if(umsAttributeNodeMap != null && umsAttributeNodeMap.size() >0) {
								  Iterator umsIter =   umsAttributeNodeMap.entrySet().iterator();
								  while (umsIter.hasNext()){ 
								        Map.Entry entry = (Map.Entry) umsIter.next(); 
								        Object key = entry.getKey(); 
								        String [] keys =null;
								        if(key!=null && !key.equals("")){
								        	keys = (String[])key;
								        	Object val = entry.getValue(); 
								        	if(val !=null ){
								        	%>	
								        	<tr class="listtxt">
												<td width="10%">属性名：</td>
												<%
												if(keys[1]!=null){
												%>
												<td width="60%"> <%=keys[0] %></td>
												<td width="30%">
												上级机构：<%=keys[1] %>
												</td>
												<%	
												}else{
												%>
												<td colspan="2" width="90%"> <%=keys[0] %></td>
												<%	
												}
												%>
										</tr>
										<tr class="listtxt">
											<td width="10%">属性值：</td>
											<td colspan="2" width="90%" 
											    style="width: 680px; word-wrap: break-word; margin: 5 auto; line-height: 22px;">
											 
											  <%=val.toString() %> 
											</td>	 
								 </tr>
								        	<%
								        	}
								        }
								    }
								  }else{
									  %>
										<tr class="listtxt">
											<td width="10%">属性值：</td>
											<td colspan="2" width="90%" 
											    style="width: 680px; word-wrap: break-word; margin: 5 auto; line-height: 22px;">
											 无
											</td>	 
								 </tr>
										<%
								  }
								  %>
									  <tr><td colspan="3">PMS信息</td></tr>
									 <%
								  if(pmsAttributeNodeMap != null && pmsAttributeNodeMap.size() >0 ){
								  Iterator pmsIter =   pmsAttributeNodeMap.entrySet().iterator();
								  while (pmsIter.hasNext()){ 
								        Map.Entry entry = (Map.Entry) pmsIter.next(); 
								        Object key = entry.getKey(); 
								        String [] keys =null;
								        if(key!=null && !key.equals("")){
								        	keys = (String[])key;
								        	Object val = entry.getValue(); 
								        	if(val !=null ){
								        	%>	
								        	<tr class="listtxt">
												<td width="10%">属性名：</td>
												<%
												if(keys[1]!=null){
												%>
												<td width="60%"> <%=keys[0] %></td>
												<td width="30%">
												上级机构：<%=keys[1] %>
												</td>
												<%	
												}else{
												%>
												<td colspan="2" width="90%"> <%=keys[0] %></td>
												<%	
												}
												%>
										</tr>
										<tr class="listtxt">
											<td width="10%">属性值：</td>
											<td colspan="2" width="90%" 
											    style="width: 680px; word-wrap: break-word; margin: 5 auto; line-height: 22px;">
											  
											  <%=val.toString() %> 
											</td>	 
								 </tr>
								        	<%
								        	}
								        }
								    }
								  %>
								<%}else{
									%>
									<tr class="listtxt">
										<td width="10%">属性值：</td>
										<td colspan="2" width="90%" 
										    style="width: 680px; word-wrap: break-word; margin: 5 auto; line-height: 22px;">
										 无
										</td>	 
							 </tr>
									<%
								}
									}} else {
									String errCode = (String)request.getAttribute("errCode");
									String errDesc = (String)request.getAttribute("errDesc");
									if(errCode!=null&&!errCode.equals("")) {%>
										<tr class="listtxt">
											<td>错误码：</td>
											<td><%=errCode%></td>
										</tr>
									<%} if(errDesc!=null&&!errDesc.equals("")) {%>
										<tr class="listtxt">
											<td>错误描述：</td>
											<td><%=errDesc%></td>
										</tr>
									<%} %>
								<%} %>
					</table>
				<br></td></tr></table>
			</td></tr>
		</table>
	</body>
</html>
