package eduBean;

import java.sql.*;
import java.util.*;
import javax.sql.*;
import oracle.jdbc.driver.*;
import oracle.jdbc.pool.*;
import eduBean.*;

public class GradeMgr {

	private OracleConnectionPoolDataSource ocpds = null;
	private PooledConnection pool = null;

	public GradeMgr() {
		try{
			ocpds = new OracleConnectionPoolDataSource();
			ocpds.setURL("jdbc:oracle:thin:@210.94.199.20:1521:DBLAB");
			ocpds.setUser("FE2016112094");  // 본인 아이디(ex.FE0000000000)
			ocpds.setPassword("FE2016112094");  // 본인 패스워드(ex.FE0000000000)
			pool = ocpds.getPooledConnection();
		} catch(Exception e) {
			System.out.println("Error : Connection Failed");
		}
	}
	
	// 현재 년도/학기에 담당하고 있는 강의과목의 학생 성적 조회
	public Vector getScoreList(String p_id, int nYear, int nSemester) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Vector vecList = new Vector();
		
		try {			
			//【5-⑤】	
			conn = pool.getConnection();
			String mySQL = "SELECT t.c_id cid, t.c_id_no cid_no, c.c_name cname, e.s_id sid, s.s_name sname, e.e_score escore, e.e_grade egrade FROM teach t JOIN enroll e ON (t.c_id=e.c_id and t.c_id_no=e.c_id_no and t.t_year=e.e_year and t.t_semester=e.e_semester) JOIN student s ON(e.s_id=s.s_id) JOIN course c ON(c.c_id=t.c_id and c.c_id_no = t.c_id_no) where t.p_id=? and t.t_year=? and t.t_semester=?";

			// String mySQL = 'SELECT t.c_id cid, t.c_id_no cid_no, c.c_name cname,';
			// mySQL = mySQL + 'e.s_id sid, s.s_name sname, e.e_score escore, e.e_grade egrade';
			// mySQL = mySQL + 'FROM teach t';
			// mySQL = mySQL + 'INNER JOIN course c ON t.c_id = c.c_id and t.c_id_no = c.c_id_no';
			// mySQL = mySQL + 'INNER JOIN enroll e ON c.c_id = e.c_id and c.c_id_no = e.c_id_no';
			// mySQL = mySQL + 'INNER JOIN student s ON e.s_id = s.s_id';
			// mySQL = mySQL + 'WHERE t.p_id = ? and t.t_year = ? and t.t_semester = ?;';	

			pstmt = conn.prepareStatement(mySQL);
			pstmt.setString(1, p_id);
			pstmt.setInt(2, nYear);
			pstmt.setInt(3, nSemester);
			rs = pstmt.executeQuery();
			System.out.println(nYear);
			while(rs.next()){
				Grade tr = new Grade();
				tr.setCId(rs.getString("cid"));
				tr.setCIdNo(rs.getInt("cid_no"));
				tr.setCName(rs.getString("cname"));
				tr.setSId(rs.getString("sid"));
				tr.setSName(rs.getString("sname"));
				tr.setEScore(rs.getInt("escore"));
				tr.setEGrade(rs.getString("egrade"));
				vecList.add(tr);
			}
			pstmt.close();
			conn.close();
		} catch(Exception ex) {
			System.out.println("Exception" + ex);
		}
		return vecList;
	}

	// 성적등록
	public String setScore(String score, String sid, String cid, int cidno, int year, int semester) {
		String sMessage = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		try {
			//【5-⑥】
			conn = pool.getConnection();	
			cstmt = conn.prepareCall("{ call InsertGrade(?, ?, ?, ?, ?, ?, ?)}");

			cstmt.setString(1, score);
            cstmt.setString(2, sid);
            cstmt.setString(3, cid);
            cstmt.setInt(4, cidno);
			cstmt.setInt(5, year);
			cstmt.setInt(6, semester);
			cstmt.registerOutParameter(7,java.sql.Types.VARCHAR);
			cstmt.execute();
			sMessage = cstmt.getString(7);

			conn.close();
			cstmt.close();
		} catch(SQLException ex) {
			if(ex.getErrorCode() == 20002) {
				sMessage = Integer.toString(ex.getErrorCode());
			}else if(ex.getErrorCode() == 20003) {
				sMessage = Integer.toString(ex.getErrorCode());
			}			
			System.out.println("Exception" + ex);
		} 
		return sMessage;		
	}
	
	// 현재 년도 조회
	public int getCurrentYear() {
		int nYear = 0;
		Connection conn = null;
		CallableStatement cstmt = null;		
		try {			
			//【5-⑦】
			conn = pool.getConnection();
			cstmt = conn.prepareCall("{? = call Date2GradeYear(SYSDATE)}");

			cstmt.registerOutParameter(1, java.sql.Types.INTEGER);
			cstmt.execute();
			nYear = cstmt.getInt(1);

			conn.close();
			cstmt.close();
		} catch (Exception ex) {
			System.out.println("Exception" + ex);
		}
		return nYear;
	}
	
	// 현재 학기 조회
	public int getCurrentSemester() {
		int nSemester=0;
		Connection conn = null;
		CallableStatement cstmt = null;

		try {			
			//【5-⑧】
			conn = pool.getConnection();
			cstmt = conn.prepareCall("{? = call Date2GradeSemester(SYSDATE)}");

			cstmt.registerOutParameter(1, java.sql.Types.INTEGER);
			cstmt.execute();
			nSemester = cstmt.getInt(1);	

			conn.close();
			cstmt.close();		
		} catch (Exception ex) {
			System.out.println("Exception" + ex);
		}

		return nSemester;
	}
}
