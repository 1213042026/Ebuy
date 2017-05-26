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

	public void save(ProductCombination productCombination) {
		if (productCombination.getId() == 0) {
			this.getCurrentSession().save(productCombination);
		} else {
			this.getCurrentSession().merge(productCombination);
			String deleteSQL = "delete from t_combination_product where productCombinationId = " + productCombination.getId();
			this.getCurrentSession().createSQLQuery(deleteSQL).executeUpdate();
		}
		String ids[] = productCombination.getCombinationProduct().getIds().split(",");
		String names[] = productCombination.getCombinationProduct().getNames().split(",");
		String id = "";
		String name = "";
		String sql = "";
		for (int i = 0; i< ids.length;i++) {
			id = ids[i];
			name = names[i];
			sql = "insert into t_combination_product(productCombinationId, productId, productName) values(" + productCombination.getId() + "," + id + ",'" + name + "');";
			this.getCurrentSession().createSQLQuery(sql).executeUpdate();
		}
	}

	public void deleteById(String id) {
		String deleteSQL = "delete from t_combination_product where productCombinationId = " + id;
		this.getCurrentSession().createSQLQuery(deleteSQL).executeUpdate();
		deleteSQL = "delete from t_product_combination where id = " + id;
		this.getCurrentSession().createSQLQuery(deleteSQL).executeUpdate();
	}
	
	public ProductCombination queryCombinationByIds(String ids) {
		int count = ids.split(",").length;
		String sql = "select * from t_product_combination where id = (select productCombinationId from t_combination_product where productCombinationId in " +
  "(select productCombinationId from t_combination_product where productId in (" + ids + ") group by productCombinationId having count(productCombinationId) = " + count + ")" + 
  " group by productCombinationId having count(productCombinationId) =  " + count +");";
		List res = this.getCurrentSession().createSQLQuery(sql).addScalar("id", StandardBasicTypes.INTEGER).addScalar("name", StandardBasicTypes.STRING).addScalar("price", StandardBasicTypes.STRING).addScalar("stock", StandardBasicTypes.STRING).addScalar("image", StandardBasicTypes.STRING).list();
		Object[] objects = (Object[])res.get(0);
		
		return new ProductCombination(Integer.valueOf(objects[0].toString()), objects[1].toString(), objects[2].toString(), objects[3].toString(), objects[4].toString());
	}
}
