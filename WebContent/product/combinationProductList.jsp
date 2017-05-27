<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bootstrap/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bootstrap/bootstrap-theme.min.css">
<link type="text/css" rel="stylesheet" href="css/style.css" />
<style type="text/css">
	.navbar {
		min-height: 0px;
    	margin-bottom: 0px;
	}
</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap/bootstrap.min.js"></script>
<script type="text/javascript">
 	var ids = [];
 	var currentProductId = 0;
 	function removeByValue(arr, val) {
	  for(var i=0; i<arr.length; i++) {
	    if(arr[i] == val) {
	      arr.splice(i, 1);
	      break;
	    }
	  }
	}

	function addCombination(event, productId) {
		if (event.target.checked) {
			ids.push(productId);
		} else {
			removeByValue(ids, productId);
		}
	}

	function generateCombination() {
		$.ajax({
			url : 'productCombination_getCombination.action',
			type : 'get',
			asyn : false,
			data : {
				ids : ids.join(',')
			},
			dataType : 'json',
			success : function(data) {
				var combination = data.data[0];
				if (combination.id != 0) {
					var html = "<div><image src='${pageContext.request.contextPath}/" + combination.image +
					 "' /></div>" +
		        	"<div>套餐名称：" + combination.name + "</div>" +
		        	"<div>套餐价格：" + combination.price + "</div>" +
		        	"<div>套餐库存：" + combination.stock + "</div>";
					$('#combination').html(html);
					$("#show").trigger("click");

					var url = "product_saveWithoutFile.action?product.name=" + combination.name + 
						"&product.price=" + combination.price + "&product.stock=" + combination.stock +
						"&product.proPic=" + combination.image;
					$.ajax({
						url : url,
						type : "get",
						data : {
						},
						dataType : 'json',
						success : function(data) {
							currentProductId = data.id
						}
					})
				} else {
					alert("暂无此套餐");
				}
			},
			error : function() {
			}
		})
	}

	function addCart() {
		if('${currentUser.userName}'==''){
			alert("请先登录，然后购物！");
		}else{
			if (currentProductId == 0) {
				alert("传输数据中,请稍后");
				return;
			}
			$.post("shopping_addShoppingCartItem.action",{productId:currentProductId},
				function(result){
					var result=eval('('+result+')');
					if(result.success){
						alert("已成功加入购物车！");
						location.reload();
					}else{
						alert(result.error);
					}
				}
			);
		}
	}
</script>
</head>
<body>
<div class="main">
	<div class="product-list">
			<h2>套餐商品(随意组合成套餐，给予优惠价)<button class="btn btn-info btn-xs" style="margin-left: 50%;" onclick="generateCombination()">生成套餐</button></h2>
			<ul class="product clearfix">
				<c:forEach items="${combinationProductList }" var="p">
					<li>
						<dl>
							<dt>
								<img src="${p.proPic }"/>
							</dt>
							<dd class="title" style="height: 22px;">
								${p.name }
							</dd>
							<dd class="price">
								￥${p.price }
							</dd>
							<div class="checkbox" style="margin-top: 0px;margin-bottom: 0px;">
							    <label>
							      <input type="checkbox" onclick="addCombination(event, ${p.id })"> 计入套餐
							    </label>
							</div>
						</dl>
					</li>
				</c:forEach>
			</ul>
			<div class="clear"></div>
	</div>

	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">套餐信息</h4>
	      </div>
	      <div class="modal-body">
	        <div id="combination" style="font-size: 18px;">
	        </div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
	        <button type="button" class="btn btn-primary" onclick="addCart()">加入购物车</button>
	      </div>
	    </div>
	  </div>
	</div>

	<button id="show" type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal" style="display:none;">
	</button>
</div>
</body>
</html>