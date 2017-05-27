package com.briup.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.type.StandardBasicTypes;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.briup.entity.Product;
import com.briup.entity.ProductCombination;

@Repository("productDAOImpl")
@SuppressWarnings("all")
public class ProductDaoImpl {
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
	
	public int save(Product product) {
		int result = 0;
		String sql = "select id from t_product where name = '" + product.getName() + "' and price = '" + product.getPrice() + "' and stock='" + product.getStock() + "' and proPic = '" + product.getProPic() + "';";
		List res = this.getCurrentSession().createSQLQuery(sql).addScalar("id", StandardBasicTypes.INTEGER).list();
		
		if (res.size() == 0) {
			this.getCurrentSession().save(product);
			result = product.getId();
		} else {
			result = Integer.valueOf(res.get(0).toString());
		}
		
		return result;
	}
}
