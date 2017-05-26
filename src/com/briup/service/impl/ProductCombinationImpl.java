package com.briup.service.impl;

import java.util.LinkedList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.briup.dao.BaseDAO;
import com.briup.dao.impl.ProductCombinationDaoImpl;
import com.briup.entity.PageBean;
import com.briup.entity.ProductCombination;
import com.briup.service.ProductCombinationService;

@Service("productCombinationService")
public class ProductCombinationImpl implements ProductCombinationService {
	@Resource
	private BaseDAO<ProductCombination> baseDAO;
	
	@Resource
	private ProductCombinationDaoImpl productCombinationDaoImpl;

	public List<ProductCombination> findProductCombinationList(ProductCombination s_productCombination, PageBean pageBean) {
		List<Object> param=new LinkedList<Object>();
		StringBuffer hql=new StringBuffer("from ProductCombination");
		if(s_productCombination!=null){
			if(s_productCombination.getName()!=null){
				hql.append(" where name like ?");
				param.add("%"+s_productCombination.getName()+"%");
			}
		}
		if(pageBean!=null){
			return productCombinationDaoImpl.findWithSQL(hql.toString(), param, pageBean);
		}else{
			return null;
		}
	}

	public Long getProductCombinationCount(ProductCombination s_productCombination) {
		List<Object> param=new LinkedList<Object>();
		StringBuffer hql=new StringBuffer("select count(*) from ProductCombination");
		if(s_productCombination!=null){
			if(s_productCombination.getName()!=null){
				hql.append(" where name like ?");
				param.add("%"+s_productCombination.getName()+"%");
			}
		}
		return baseDAO.count(hql.toString(), param);
	}

	public void saveProductCombination(ProductCombination productCombination) {
		baseDAO.merge(productCombination);
		System.out.println(productCombination.getId());
	}
}
