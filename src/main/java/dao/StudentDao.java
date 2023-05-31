package dao;

import java.util.List;

import util.DaoHelper;
import vo.Course;
import vo.Dept;
import vo.Registration;
import vo.Student;

public class StudentDao {
	
	private static StudentDao instance = new StudentDao();
	private StudentDao() {}
	public static StudentDao getInstance() {
		return instance;
	}

	public void insertStudent(Student student) {
		DaoHelper.update("studentDao.insertStudent", student.getId(),
												     student.getPassword(),
												     student.getName(),
												     student.getGrade(),
												     student.getDept().getNo());
	}
	
	public Student getStudentById(String studentId) {
		return DaoHelper.selectOne("studentDao.getStudentById", rs -> {
			Student student = new Student();
			student.setId(rs.getString("student_id"));
			student.setPassword(rs.getString("student_password"));
			student.setName(rs.getString("student_name"));
			student.setGrade(rs.getInt("student_grade"));
			student.setUpdateDate(rs.getDate("student_update_date"));
			student.setCreateDate(rs.getDate("student_create_date"));
			
			student.setDept(new Dept(rs.getInt("dept_no")));
			
			return student;
		}, studentId);
	}
	
	public List<Student> getStudentsByCourseNo(int courseNo) {
		return DaoHelper.selectList("studentDao.getStudentsByCourseNo", rs -> {
			Student student = new Student();
			student.setRegistration(new Registration(rs.getInt("reg_no")));
			student.setId(rs.getString("student_id"));
			student.setName(rs.getString("student_name"));
			student.setDept(new Dept(rs.getString("dept_name")));
			student.setGrade(rs.getInt("student_grade"));
			
			return student; 
		}, courseNo);
	}
}

