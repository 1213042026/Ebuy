package com.briup.action;

import java.io.File;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;

import com.briup.entity.CombinationProduct;
import com.briup.entity.PageBean;
import com.briup.entity.ProductCombination;
import com.briup.service.ProductCombinationService;
import com.briup.util.DateUtil;
import com.briup.util.ResponseUtil;
import com.briup.util.StringUtil;
import com.opensymphony.xwork2.ActionSupport;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

public class ProductCombinationAction extends ActionSupport  implements ServletRequestAware{

	private static final long serialVersionUID = 1L;

	private HttpServletRequest request;

	private ProductCombination s_productCombination;
	private ProductCombination productCombination;
	private File image;
	private String imageFileName;
	private String imageContentType;
	
	public String getImageContentType() {
		return imageContentType;
	}

	public void setImageContentType(String imageContentType) {
		this.imageContentType = imageContentType;
	}

	public File getImage() {
		return image;
	}

	public void setImage(File image) {
		this.image = image;
	}

	public ProductCombination getProductCombination() {
		return productCombination;
	}

	public void setProductCombination(ProductCombination productCombination) {
		this.productCombination = productCombination;
	}

	private String page;  // 鍟嗗搧 绗嚑椤�
	private String rows;
	
	public ProductCombination getS_productCombination() {
		return s_productCombination;
	}

	public void setS_productCombination(ProductCombination s_productCombination) {
		this.s_productCombination = s_productCombination;
	}

	public String getPage() {
		return page;
	}

	public void setPage(String page) {
		this.page = page;
	}

	public String getRows() {
		return rows;
	}

	public void setRows(String rows) {
		this.rows = rows;
	}

	public String getImageFileName() {
		return imageFileName;
	}

	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}

	@Resource
	private ProductCombinationService productCombinationService;

	@Override
	public void setServletRequest(HttpServletRequest request) {
		this.request=request;
	}

	public String list()throws Exception{
		PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		List<ProductCombination> productCombinationList=productCombinationService.findProductCombinationList(s_productCombination, pageBean);
		long total=productCombinationService.getProductCombinationCount(s_productCombination);
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.registerJsonValueProcessor(CombinationProduct.class, new ObjectJsonValueProcessor(new String[]{"ids","names"}, CombinationProduct.class));
		JSONArray rows=JSONArray.fromObject(productCombinationList,jsonConfig);
		JSONObject result=new JSONObject();
		result.put("rows", rows);
		result.put("total", total);
		ResponseUtil.write(ServletActionContext.getResponse(), result);
		return null;
	}

	public String save()throws Exception{
		if(image!=null){
			String imageName=DateUtil.getCurrentDateStr();
			String realPath=ServletActionContext.getServletContext().getRealPath("/images/product");
			String imageFile=imageName+"."+imageFileName.split("\\.")[1];
			File saveFile=new File(realPath,imageFile);
			FileUtils.copyFile(image, saveFile);
			productCombination.setImage("images/product/"+imageFile);
		}else if(StringUtil.isEmpty(productCombination.getImage())){
			productCombination.setImage("");
		}
		System.out.println(productCombination);
		productCombinationService.saveProductCombination(productCombination);
		JSONObject result=new JSONObject();
		result.put("success", true);
		ResponseUtil.write(ServletActionContext.getResponse(), result);
		return null;
	}
}
