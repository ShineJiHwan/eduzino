package com.edu.zino.model.admin;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.edu.zino.domain.Adminboard;

@Service
public class AdminboardServiceImpl implements AdminboardService{
	
	private Logger logger=LoggerFactory.getLogger(this.getClass().getName());
	
	@Autowired
	private AdminboardDAO adminboardDAO;
	
	
	public List selectAll() {
		return adminboardDAO.selectAll();
	}

	
	public Adminboard select(int adminboard_idx) {

		return adminboardDAO.select(adminboard_idx);
	}

	
	public void insert(Adminboard adminboard) {
		adminboardDAO.insert(adminboard);
		
	}


	public void update(Adminboard adminboard) {
		logger.info("adminboard",adminboard);
		
		adminboardDAO.update(adminboard);	
	}

	
	public void delete(int adminboard_idx) {
		adminboardDAO.delete(adminboard_idx);
		
	}






}
