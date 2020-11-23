package egovframework.com.sec.security.userdetails.jdbc;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;

import javax.sql.DataSource;

import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.object.MappingSqlQuery;

/**
 * MappingSqlQuery 클래스 재정의
 * 
 * @author sjyoon
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    -------------    ----------------------
 *   2009.03.10  sjyoon    최초 생성
 *
 * </pre>
 */

public abstract class EgovUsersByUsernameMapping  extends MappingSqlQuery {

	/**
	 * 사용자정보를 테이블에서 조회하여 사용자객체에 매핑한다.
	 * @param ds DataSource
	 * @param usersByUsernameQuery String
	 */
	public EgovUsersByUsernameMapping(DataSource ds, String usersByUsernameQuery) {
        super(ds, usersByUsernameQuery);
        declareParameter(new SqlParameter(Types.VARCHAR));
        compile();
    }

	/* (non-Javadoc)
	 * @see org.springframework.jdbc.object.MappingSqlQuery#mapRow(java.sql.ResultSet, int)
	 */
	/**
	 * mapRow 추상클래스
	 * jdbc-user-service 에서 지정된 users-by-username-query 의 쿼리문을 조회하여
	 * ResultSet에 매핑된다.
	 * 
	 * 사용 예)
	 * protected Object mapRow(ResultSet rs, int rownum) throws SQLException; {
	 * 	 String userid = rs.getString(0);
	 *   String password = rs.getString(1);
     *   boolean enabled = rs.getBoolean(2);
     *
     *   EgovUserVO userVO = new EgovUserVO();
     *   userVO.setUserId(userid);
     *   userVO.setPassWord(password);
     *
     *   return new EgovUser(userid, password, enabled, userVO);
     * }
	 */
	@Override
    protected abstract Object mapRow(ResultSet rs, int rownum) throws SQLException;
}
