<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
	
	var url;
	function searchProductCombination(){
		$("#dg").datagrid('load',{
			"s_productCombination.name":$("#s_productCombinationName").val()
		});
	}
	function openProductCombinationAddDialog(){
		$("#dlg").dialog("open").dialog("setTitle","添加商品套餐信息");
		url="productCombination_save.action";
	}
	
	function saveProductCombination(){
		$("#fm").form("submit",{
			url:url,
			onSubmit:function(){
				if($("#combinationProducts").combogrid("grid").datagrid('getSelections').length==0){
					$.messager.alert("系统提示","请选择套餐商品");
					return false;
				}
				var selecteds = $("#combinationProducts").combogrid("grid").datagrid('getSelections');
				if (selecteds.length == 1) {
					$("#ids").val(selecteds[0].id);
					$("#names").val(selecteds[0].name);
				} else {
					var names = [], ids = [];
					for(var i = 0; i < selecteds.length;i++) {
						names.push(selecteds[i].name)
						ids.push(selecteds[i].id)
					}
					$("#ids").val(ids.join(','));
					$("#names").val(names.join(','));
				}
				return $(this).form("validate");
			},
			success:function(result){
				var result=eval('('+result+')');
				if(result.success){
					$.messager.alert("系统提示","保存成功");
					resetValue();
					$("#dlg").dialog("close");
					$("#dg").datagrid("reload");
				}else{
					$.messager.alert("系统提示","保存失败");
					return;
				}
			}
		});
	}
	function openProductCombinationModifyDialog(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要编辑的数据！");
			return;
		}
		var row=selectedRows[0];
		$("#dlg").dialog("open").dialog("setTitle","编辑商品套餐信息");
		$("#name").val(row.name);
		$("#price").val(row.price);
		$("#stock").val(row.stock);
		$("#image").val(row.image);
		$("#combinationProducts").combogrid("setValues", row.combinationProduct.ids.split(','));
		url="productCombination_save.action?productCombination.id="+row.id;
	}
	function resetValue(){
		$("#name").val("");
		$("#price").val("");
		$("#stock").val("");
		$("#imageShow").val("");
		$("#image").val("");
		$("#combinationProducts").combogrid("setValues", []);
	}
	function closeProductCombinationDialog(){
		$("#dlg").dialog("close");
		resetValue();
	}
	function deleteProductCombination(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length==0){
			$.messager.alert("系统提示","请选择要删除的数据！");
			return;
		}
		var strIds=[];
		for(var i=0;i<selectedRows.length;i++){
			strIds.push(selectedRows[i].id);
		}
		var ids=strIds.join(",");
		$.messager.confirm("系统提示","您确认要删除这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
			if(r){
				$.post("productCombination_delete.action",{ids:ids},function(result){
					if(result.success){
						if(result.exist){
							$.messager.alert("系统提示",result.exist);
						}else{
							$.messager.alert("系统提示","数据已成功删除！");							
						}
						$("#dg").datagrid("reload");
					}else{
						$.messager.alert("系统提示","数据删除失败！");
					}
				},"json");
			}
		});
		
	}

	function formatImage(val,row){
		return "<img width=100 height=100 src='${pageContext.request.contextPath}/"+val+"'>";
	}
	function formatCombinationProductNames(val,row){
		return row.combinationProduct.names;
	}
	
</script>
</head>
<body style="margin:1px;">
	<table id="dg" title="商品套餐管理" class="easyui-datagrid"
	 fitColumns="true" pagination="true" rownumbers="true"
	 url="productCombination_list.action" fit="true" toolbar="#tb">
	 <thead>
	 	<tr>
	 		<th field="cb" checkbox="true" align="center"></th>
	 		<th field="id" width="50" align="center">编号</th>
	 		<th field="name" width="100" align="center">商品套餐名称</th>
	 		<th field="price" width="100" align="center">商品套餐价格</th>
	 		<th field="stock" width="50" align="center">商品套餐库存</th>
	 		<th field="image" formatter="formatImage" width="100" align="center">商品套餐图片</th>
	 		<th field="combinationProduct.names" formatter="formatCombinationProductNames" width="100" align="center">商品套餐内容</th>
	 	</tr>
	 </thead>
	</table>
	
	<div id="tb">
		<div>
			<a href="javascript:openProductCombinationAddDialog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
			<a href="javascript:openProductCombinationModifyDialog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
			<a href="javascript:deleteProductCombination()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
		</div>
		<div>
			&nbsp;商品套餐名称：&nbsp;<input type="text" id="s_productCombinationName" size="20" onkeydown="if(event.keyCode==13) searchProductCombination()"/>
			<a href="javascript:searchProductCombination()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a>
		</div>
	</div>
	
	<div id="dlg" class="easyui-dialog" style="width: 600px;height:350px;padding: 10px 20px"
	  closed="true" buttons="#dlg-buttons">
	 	<form id="fm" method="post" enctype="multipart/form-data">
	 		<table cellspacing="8px">
	 			<tr>
	 				<td>商品套餐名称：</td>
	 				<td colspan="3"><input type="text" id="name" name="productCombination.name" class="easyui-validatebox" required="true"/></td>
	 			</tr>
	 			<tr>
	 				<td>商品套餐价格：</td>
	 				<td colspan="3"><input type="text" id="price" name="productCombination.price" class="easyui-validatebox" required="true"/></td>
	 			</tr>
	 			<tr>
	 				<td>商品套餐库存：</td>
	 				<td colspan="3"><input type="text" id="stock" name="productCombination.stock" class="easyui-validatebox" required="true"/></td>
	 			</tr>
	 			<tr>
	 				<td>商品套餐图片：</td>
	 				<td colspan="4"><input type="file" id="imageShow" name="image" /></td>
	 				<input type="hidden" id="image" name="productCombination.image"/>
	 				<input type="hidden" id="ids" name="productCombination.combinationProduct.ids"/>
	 				<input type="hidden" id="names" name="productCombination.combinationProduct.names"/>
	 			</tr>
	 			<tr>
	 				<td>商品套餐内容：</td>
	 				<td colspan="20">
	 					<select id="combinationProducts" class="easyui-combogrid" style="width:250px" data-options="
						panelWidth: 600,
						multiple: true,
						idField: 'id',
						textField: 'name',
						url: 'product_listCombinationProduct.action?s_product.combine=1',
						method: 'get',
						columns: [[
						{field:'ck',checkbox:true},
						{field:'id',title:'商品编号',width:80},
						{field:'name',title:'商品名称',width:80},
						{field:'price',title:'商品价格',width:120},
						{field:'stock',title:'商品库存',width:80,align:'right'}
						]],
						fitColumns: true
						">
						</select>
	 				</td>
	 			</tr>
	 		</table>
	 	</form>
	</div>
	
	<div id="dlg-buttons">
		<a href="javascript:saveProductCombination()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
		<a href="javascript:closeProductCombinationDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
</body>
</html>