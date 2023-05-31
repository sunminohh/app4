package dao;

import util.DaoHelper;
import vo.Course;
import vo.Registration;
import vo.Student;

public class RegistrationDao {
	
	private static RegistrationDao instance = new RegistrationDao();
	private RegistrationDao() {}
	public static RegistrationDao getInstance() {
		return instance;
	}

	public void insertRegistration(Registration registration) {
		DaoHelper.update("registrationDao.insertRegistration", registration.getCourse().getNo(),
															   registration.getStudent().getId());
	}
	
	public Registration getRegistrationByNo(int registrationNo) {
		return DaoHelper.selectOne("registrationDao.getRegistrationByNo", rs -> {
			Registration registration = new Registration();
			registration.setNo(rs.getInt("reg_no"));
			registration.setCourse(new Course(rs.getInt("course_no")));
			registration.setStudent(new Student(rs.getString("student_id")));
			registration.setStatus(rs.getString("reg_status"));
			registration.setUpdateDate(rs.getDate("reg_update_date"));
			registration.setCreateDate(rs.getDate("reg_create_date"));
			
			return registration;
		}, registrationNo);
	}
	
	public void updateRegistration(Registration registration) {
		DaoHelper.update("registrationDao.updateRegistration", registration.getCourse().getNo(),
															   registration.getStudent().getId(),
															   registration.getStatus(),
															   registration.getNo());
	}
	
	public Registration getRegistrationByCourseAndStudent(int courseNo, String studentId) {
		return DaoHelper.selectOne("registrationDao.getRegistrationByCourseAndStudent", rs -> {
			Registration registration = new Registration();
			registration.setNo(rs.getInt("reg_no"));
			registration.setCourse(new Course(rs.getInt("course_no")));
			registration.setStudent(new Student(rs.getString("student_id")));
			registration.setStatus(rs.getString("reg_status"));
			registration.setUpdateDate(rs.getDate("reg_update_date"));
			registration.setCreateDate(rs.getDate("reg_create_date"));
			
			return registration;
			
		}, courseNo, studentId);
	}
	
}








