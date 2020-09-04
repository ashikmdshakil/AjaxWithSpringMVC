package com.ashik.student.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.ashik.student.model.Student;
import com.ashik.student.service.StudentDao;
import com.google.gson.Gson;

@Controller
public class AppController {
	@Autowired
	private StudentDao studentdao;
	
	@RequestMapping("save")
	@ResponseBody
	public String saveStudent(@RequestParam("name") String name, String mail, String department){
		System.out.println(name);
		System.out.println(mail);
		System.out.println(department);
		String message = null;
		try {
			studentdao.saveStudent(name, mail, department);
			message = "success";
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			message = "wrong";
		}
		return message;
	}
	
	@RequestMapping("students")
	@ResponseBody
	public String getStudents(){
		Gson gson = new Gson();
		String json = gson.toJson(studentdao.getStudents());
		return json;
	}
	@RequestMapping("student")
	@ResponseBody
	public String getStudent(@RequestParam("mail") String mail){
		System.out.println(mail);
		Gson gson = new Gson();
		// String json = gson.toJson(studentdao.getStudent(mail));
		return gson.toJson(studentdao.getStudent(mail));
	}
	@RequestMapping("delete")
	@ResponseBody
	public String deleteStudent(@RequestParam("id") String sid, @RequestParam("name") String name, @RequestParam("mail") String mail, @RequestParam("department") String department) {
		String result = null;
		try {
			int id = Integer.parseInt(sid);
			studentdao.deleteStudent(id, name, mail, department);
			result = "success";
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			result = "wrong";
		}
		return result;
	}
	
}
