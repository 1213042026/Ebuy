package com.briup.service.impl;

import java.util.LinkedList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.briup.dao.BaseDAO;
import com.briup.entity.Comment;
import com.briup.entity.Notice;
import com.briup.entity.PageBean;
import com.briup.service.CommentService;

/**
 * ¡Ù—‘Service¿‡
 * @author Administrator
 *
 */
@Service("commentService")
public class CommentServiceImpl implements CommentService {

	@Resource
	private BaseDAO<Comment> baseDAO;
	//≤È—Ø¡Ù—‘
	public List<Comment> findCommentList(Comment s_comment,PageBean pageBean) {
		List<Object> param=new LinkedList<Object>();
		StringBuffer hql=new StringBuffer("from Comment");
		//∞¥¡Ù—‘ ±º‰Ωµ–Ú≈≈–Ú
		hql.append(" order by createTime desc");
		if(pageBean!=null){
			return baseDAO.find(hql.toString().replaceFirst("and", "where"), param, pageBean);
		}else{
			return null;
		}
	}
	//ªÒ»°¡Ù—‘ ˝¡ø
	public Long getCommentCount(Comment s_Comment) {
		List<Object> param=new LinkedList<Object>();
		StringBuffer hql=new StringBuffer("select count(*) from Comment");
		return baseDAO.count(hql.toString().replaceFirst("and", "where"), param);
	}
	//±£¥Ê¡Ù—‘
	public void saveComment(Comment comment) {
		// TODO Auto-generated method stub
		baseDAO.merge(comment);
	}
	//…æ≥˝¡Ù—‘
	public void delete(Comment comment) {
		// TODO Auto-generated method stub
		baseDAO.delete(comment);
	}
	//Õ®π˝ID≤È—Ø¡Ù—‘
	public Comment getCommentById(int commentId) {
		return baseDAO.get(Comment.class, commentId);
	}

}
