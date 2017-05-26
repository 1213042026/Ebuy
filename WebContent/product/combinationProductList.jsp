<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="main">
	<div class="product-list">
			<h2>套餐商品(随意组合成套餐，给予优惠价)</h2>
			<ul class="product clearfix">
				<c:forEach items="${combinationProductList }" var="p">
					<li>
						<dl>
							<dt>
								<img src="${p.proPic }"/>
							</dt>
							<dd class="title">
								${p.name }
							</dd>
							<dd class="price">
								￥${p.price }
							</dd>
						</dl>
					</li>
				</c:forEach>
			</ul>
			<div class="clear"></div>
	</div>
</div>
</body>
</html>