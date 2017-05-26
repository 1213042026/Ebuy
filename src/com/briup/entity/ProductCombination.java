package com.briup.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="t_product_combination")
public class ProductCombination {
	private int id; // 编号
	private String name; 
	private String price; // 价格
	private String stock; // 库存
	private String image; // 商品图片

	private CombinationProduct combinationProduct = new CombinationProduct();

	public ProductCombination(int id, String name, String price, String stock,
			String image) {
		this.id = id;
		this.name = name;
		this.price = price;
		this.stock = stock;
		this.image = image;
	}

	@Id
	@GeneratedValue(generator="_native")
	@GenericGenerator(name="_native",strategy="native")
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getStock() {
		return stock;
	}

	public void setStock(String stock) {
		this.stock = stock;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	@Transient
	public CombinationProduct getCombinationProduct() {
		return combinationProduct;
	}

	public void setCombinationProduct(CombinationProduct combinationProduct) {
		this.combinationProduct = combinationProduct;
	}

	@Override
	public String toString() {
		return "ProductCombination [id=" + id + ", name=" + name + ", price=" + price + ", stock=" + stock
				+ ", combinationProduct=" + combinationProduct + "]";
	}
	
}
