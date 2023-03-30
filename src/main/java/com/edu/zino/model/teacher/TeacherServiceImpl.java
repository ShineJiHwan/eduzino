package com.edu.zino.model.teacher;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.edu.zino.domain.Teacher;
import com.edu.zino.exception.TeacherException;

@Service
public class TeacherServiceImpl implements TeacherService {
	
	@Autowired
	private TeacherDAO teacherDAO;

	@Override
	public Teacher select(int member_idx) {
		return teacherDAO.select(member_idx);
	}
	
	//------------------------------------------------------------

	@Override
	public List selectAll() {
		return teacherDAO.selectAll();
	}

	@Transactional(propagation = Propagation.REQUIRED)
	public void insert(Teacher teacher) throws TeacherException{
		teacherDAO.insert(teacher);
	}


}