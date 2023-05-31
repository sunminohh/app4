package dao;

import util.DaoHelper;
import vo.Course;
import vo.Dept;
import vo.Professor;

public class ProfessorDao {
	
	private static ProfessorDao instance = new ProfessorDao();
	private ProfessorDao() {}
	public static ProfessorDao getInstance() {
		return instance;
	}

	public void insertProfessor(Professor professor) {
		DaoHelper.update("professorDao.insertProfessor", professor.getId(),
														 professor.getPassword(),
														 professor.getName(),
														 professor.getPosition(),
														 professor.getDept().getNo());
	}
	
	public Professor getProfessorById(String professorId) {
		return DaoHelper.selectOne("professorDao.getProfessorById", rs -> {
			Professor professor = new Professor();
			professor.setId(rs.getString("professor_id"));
			professor.setPassword(rs.getString("professor_password"));
			professor.setName(rs.getString("professor_name"));
			professor.setPosition(rs.getString("professor_position"));
			professor.setUpdateDate(rs.getDate("professor_update_date"));
			professor.setCreateDate(rs.getDate("professor_create_date"));
			
			professor.setDept(new Dept(rs.getInt("dept_no")));
			
			return professor;
		}, professorId);
	}
	
	
}









