package com.briup.dao.impl;

import java.io.Console;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.type.StandardBasicTypes;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.briup.entity.CombinationProduct;
import com.briup.entity.PageBean;
import com.briup.entity.ProductCombination;

@Repository("productCombinationDAOImpl")
@SuppressWarnings("all")
public class ProductCombinationDaoImpl {
	private SessionFactory sessionFactory;

	public SessionFactory getSessionFactory() {
		return sessionFactory;
	}
	//自动注入
	@Autowired
	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	//获取当前Session
	private Session getCurrentSession() {
		return sessionFactory.getCurrentSession();
	}
	
	public List<ProductCombination> findWithSQL(String hql, List<Object> param, PageBean pageBean) {
		Query q = this.getCurrentSession().createQuery(hql);
		if (param != null && param.size() > 0) {
			for (int i = 0; i < param.size(); i++) {
				q.setParameter(i, param.get(i));
			}
		}
		List<ProductCombination> list = q.setFirstResult(pageBean.getStart()).setMaxResults(pageBean.getPageSize()).list();
		
		for (ProductCombination productCombination : list) {
			String sql = "SELECT GROUP_CONCAT(productId) AS ids, GROUP_CONCAT(productName) AS names FROM t_combination_product where productCombinationId = " + productCombination.getId() + " GROUP BY productCombinationId;";
			List res = this.getCurrentSession().createSQLQuery(sql).addScalar("ids", StandardBasicTypes.STRING).addScalar("names", StandardBasicTypes.STRING).list();
			Object[] objects = (Object[])res.get(0);
			productCombination.setCombinationProduct(new CombinationProduct(objects[0].toString(), objects[1].toString()));
		}
		return list;
	}
}
