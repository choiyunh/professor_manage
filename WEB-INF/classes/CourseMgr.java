package eduBean;
import java.sql.*;
import java.util.*;
import javax.sql.*;
import oracle.jdbc.driver.*;
import oracle.jdbc.pool.*;
import eduBean.*;

public class CourseMgr {
	private OracleConnectionPoolDataSource ocpds = null;
	private PooledConnection pool = null;

	public CourseMgr() {
		try{
			ocpds = new OracleConnectionPoolDataSource();

			ocpds.setURL("jdbc:oracle:thin:@210.94.199.20:1521:DBLAB");
			ocpds.setUser("FE2016112094");   // ���� ���̵�(ex.FE0000000000)
			ocpds.setPassword("FE2016112094");  // ���� �н�����(ex.FE0000000000)

			pool = ocpds.getPooledConnection();
		} catch(Exception e) {
			System.out.println("Error : Connection Failed");
		}
	}
	// �ش� �⵵ ��ȸ
	public int getCurrentYear() {
		int nYear=0;
		Connection conn = null;
		CallableStatement cstmt = null;
		try {
			//��2-�롽
			conn = pool.getConnection();
			cstmt = conn.prepareCall("{? = call Date2EnrollYear(SYSDATE)}");
			
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
	
	// �ش� �б� ��ȸ
	public int getCurrentSemester() {
		int nSemester=0;
		Connection conn = null;
		CallableStatement cstmt = null;

		try {			
			//��2-�졽 
			conn = pool.getConnection();
			cstmt = conn.prepareCall("{? = call Date2EnrollSemester(SYSDATE)}");

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
    
	// ������û��Ȳ ��ȸ
	public Vector getCourseList() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Vector vecList = new Vector();

		try {			
			//��2-��
			int nYear = getCurrentYear();
         	int nSemester = getCurrentSemester();
			conn = pool.getConnection();
			String mySQL = "SELECT c.c_id cid, c.c_id_no cid_no, c.c_name cname, c.c_unit cunit, p.p_id pid, p.p_name pname FROM course c LEFT OUTER JOIN teach t ON (c.c_id = t.c_id and c.c_id_no=t.c_id_no and t_year=? and t_semester=?) LEFT OUTER JOIN professor p ON (p.p_id=t.p_id) ORDER BY c.c_id , c.c_id_no";
			pstmt = conn.prepareStatement(mySQL);
			pstmt.setInt(1, nYear);
			pstmt.setInt(2, nSemester);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				Course en = new Course();
				en.setCId(rs.getString("cid"));
				en.setCIdNo(rs.getInt("cid_no"));
				en.setCName(rs.getString("cname"));
				en.setCUnit(rs.getInt("cunit"));
				en.setPId(rs.getString("pid"));
				en.setPName(rs.getString("pname"));
				vecList.add(en);
			}
			pstmt.close();
			conn.close();
		} catch (Exception ex) {
			System.out.println("Exception" + ex);
		}
		return vecList;
	}
	
	// ���°�����û
	public void insertTeach(String p_id, String c_id, int c_id_no) {
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {			
			//��2-�
			int nYear = getCurrentYear();
         	int nSemester = getCurrentSemester();

			conn = pool.getConnection();
			String mySQL = "INSERT INTO teach VALUES(?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(mySQL);
			pstmt.setString(1, p_id);
			pstmt.setString(2, c_id);
			pstmt.setInt(3, c_id_no);
			pstmt.setInt(4, nYear);
			pstmt.setInt(5, nSemester);
			pstmt.setNull(6, Types.INTEGER);
			pstmt.setNull(7, Types.VARCHAR);
			pstmt.setInt(8, 5);
			pstmt.executeUpdate();

			pstmt.close();
			conn.close();
		} catch (Exception ex) {
			System.out.println("Exception" + ex);
		}
	}
    
	// ���°�����û ���
	public String deleteTeach(String p_id, String c_id, int c_id_no) {
		Connection conn = null;
		CallableStatement cstmt = null;
		String Result = null;

		try {			
			//��2-�
			conn = pool.getConnection();
			cstmt = conn.prepareCall("{ call DeleteTeach(?, ?, ?, ?)}");
			cstmt.setString(1, p_id);
			cstmt.setString(2, c_id);
			cstmt.setInt(3, c_id_no);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.execute();
			Result = cstmt.getString(4);
			
			cstmt.close();
			conn.close();
		} catch (Exception ex) {
			System.out.println("Exception" + ex);
		}
        
		return Result;
	}
}
