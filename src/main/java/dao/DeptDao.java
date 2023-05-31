package dao;

import java.util.List;

import util.DaoHelper;
import vo.Dept;

public class DeptDao {
	
	private static DeptDao instance = new DeptDao();
	private DeptDao() {}
	public static DeptDao getInstance() {
		return instance;
	}

	public List<Dept> getDepts() {
		return DaoHelper.selectList("deptDao.getDepts", rs -> {
			Dept dept = new Dept();
			dept.setName(rs.getString("dept_name"));
			dept.setNo(rs.getInt("dept_no"));
			
			return dept;
		});
	}
	
}
