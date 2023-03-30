package com.edu.zino.controller.teacher;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.edu.zino.domain.OrderSummary;
import com.edu.zino.model.root.OrderService;

@RestController
@RequestMapping("/rest")
public class RestTeacherController {
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private OrderService orderService;
	
	
	@PostMapping("/salescaculate/sales")
	public List<OrderSummary> getSales(HttpServletRequest request, @RequestBody OrderSummary ordersummary){
		
		List dateList = orderService.selectByDate(ordersummary);
		
		return dateList;
	}
	
}
