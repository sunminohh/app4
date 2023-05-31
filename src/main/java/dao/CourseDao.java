package dao;

import java.util.List;

import oracle.net.aso.c;
import util.DaoHelper;
import vo.Course;
import vo.Dept;
import vo.Professor;
import vo.Registration;

public class CourseDao {
	
	private static CourseDao instance = new CourseDao();
	private CourseDao() {}
	public static CourseDao getInstace() {
		return instance;
	}

	public void insertCourse(Course course) {
		DaoHelper.update("courseDao.insertCourse", course.getName(),
												   course.getType(),
												   course.getScore(),
												   course.getQuota(),
												   course.getDescription(),
												   course.getDept().getNo(),
												   course.getProfessor().getId());
	}
	
	public List<Course> getCoursesByProfessorId(String professorId, int begin, int end) {
		return DaoHelper.selectList("courseDao.getCoursesByProfessorId", rs -> {
			Course course = new Course();
			course.setNo(rs.getInt("course_no"));
			course.setType(rs.getString("course_type"));
			course.setName(rs.getString("course_name"));
			course.setDept(new Dept(rs.getString("dept_name")));
			course.setQuota(rs.getInt("course_quota"));
			course.setReqCnt(rs.getInt("course_req_cnt"));
			
			return course;
		}, professorId, begin, end);
	}
	
	public int getTotalRowsByProfessor() {
		return DaoHelper.selectOne("courseDao.getTotalRows", rs -> {
			return rs.getInt("cnt");
		});
	}
	
	public Course getCourseByNo(int CourseNo) {
		return DaoHelper.selectOne("courseDao.getCourseByNo", rs -> {
			Course course = new Course();
			course.setName(rs.getString("course_name"));
			course.setNo(rs.getInt("course_no"));
			course.setType(rs.getString("course_type"));
			course.setScore(rs.getInt("course_score"));
			course.setDept(new Dept(rs.getString("dept_name")));
			
			Professor professor = new Professor();
			professor.setName(rs.getString("professor_name"));
			course.setProfessor(professor);
			
			course.setQuota(rs.getInt("course_quota"));
			course.setReqCnt(rs.getInt("course_req_cnt"));
			course.setDescription(rs.getString("course_description"));
			
			return course;
		} , CourseNo);
	}
	
	public int getTotalRows() {
		return DaoHelper.selectOne("courseDao.getTotalRows", rs -> {
			return rs.getInt("cnt");
		});
	}
	
	public List<Course> getCourses(int begin, int end) {
		return DaoHelper.selectList("courseDao.getCourses", rs -> {
			Course course = new Course();
			course.setNo(rs.getInt("course_no"));
			course.setName(rs.getString("course_name"));
			course.setDept(new Dept(rs.getString("dept_name")));
			course.setQuota(rs.getInt("course_quota"));
			course.setReqCnt(rs.getInt("course_req_cnt"));
			
			Professor professor = new Professor();
			professor.setName(rs.getString("professor_name"));
			course.setProfessor(professor);
			
			return course;
		}, begin, end);
	}
	
	public void updateCourse(Course course) {
		DaoHelper.update("courseDao.updateCourse", course.getName(),
												   course.getType(),
												   course.getScore(),
												   course.getQuota(),
												   course.getReqCnt(),
												   course.getDescription(),
												   course.getNo());
	}
	
	public List<Course> getCoursesByStudentId(String studentId) {
		return DaoHelper.selectList("courseDao.getCoursesByStudentId", rs -> {
			Course course = new Course();
			course.setNo(rs.getInt("course_no"));
			course.setName(rs.getString("course_name"));
			course.setDept(new Dept(rs.getString("dept_name")));
			
			Registration registration = new Registration();
			registration.setNo(rs.getInt("reg_no"));
			registration.setStatus(rs.getString("reg_status"));
			course.setRegistration(registration);
			
			Professor professor = new Professor();
			professor.setName(rs.getString("professor_name"));
			course.setProfessor(professor);
			
			return course;
		}, studentId);
	}
	
	
	
}







