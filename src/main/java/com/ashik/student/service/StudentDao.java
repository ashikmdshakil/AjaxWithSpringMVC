package com.ashik.student.service;

import java.util.List;

import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.object.SqlQuery;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ashik.student.model.Student;

@Service
public class StudentDao {
	@Autowired
	private Student student;
	@Autowired
	private SessionFactory sessionFactory;
	
	@Transactional
	public void saveStudent(String name, String mail, String department) {
		Session session = sessionFactory.getCurrentSession();
		student.setName(name);
		student.setMail(mail);
		student.setDepartment(department);
		session.save(student);
	}
	@Transactional
	public List<Student> getStudents(){
		Session session = sessionFactory.getCurrentSession();
		SQLQuery query = session.createSQLQuery("select * from Student;");
		query.addEntity(Student.class);
		return query.list();
	}
	@Transactional
	public Student getStudent(String mail) {
		Session session = sessionFactory.getCurrentSession();
		SQLQuery query = session.createSQLQuery("select * from Student where mail = '"+mail+"'");
		query.addEntity(Student.class);
		return (Student) query.uniqueResult();
	}
	@Transactional
	public void deleteStudent(int id, String name, String mail, String department) {
		Session session = sessionFactory.getCurrentSession();
		student.setId(id);
		student.setName(name);
		student.setMail(mail);
		student.setDepartment(department);
		session.delete(student);
	}

}
