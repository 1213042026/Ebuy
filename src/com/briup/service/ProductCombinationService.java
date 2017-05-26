package com.briup.service;

import java.util.List;

import com.briup.entity.PageBean;
import com.briup.entity.Product;
import com.briup.entity.ProductCombination;

public interface ProductCombinationService {
	public List<ProductCombination> findProductCombinationList(ProductCombination s_productCombination, PageBean pageBean);
	public Long getProductCombinationCount(ProductCombination s_productCombination);
	public void saveProductCombination(ProductCombination productCombination);
}