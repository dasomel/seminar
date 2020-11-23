package egovframework.com.sec.ram.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.security.Authentication;
import org.springframework.security.GrantedAuthority;
import org.springframework.security.context.SecurityContext;
import org.springframework.security.context.SecurityContextHolder;

import egovframework.com.cmm.service.EgovUserDetailsService;
import egovframework.com.sec.security.userdetails.EgovUserDetails;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.fdl.string.EgovObjectUtil;



public class EgovUserDetailsSecurityServiceImpl extends AbstractServiceImpl implements EgovUserDetailsService {

	
	/**
	 * 인증된 사용자객체를 VO형식으로 가져온다.
	 * @return Object - 사용자 ValueObject
	 */
	public Object getAuthenticatedUser() {
		SecurityContext context = SecurityContextHolder.getContext();
		Authentication authentication = context.getAuthentication();
		
		if (EgovObjectUtil.isNull(authentication)) {
			// log.debug("## authentication object is null!!");
			return null;
		}
		
		Object principal = authentication.getPrincipal();
		
		if(principal instanceof EgovUserDetails){
			
			// log.debug("## EgovUserDetailsHelper.getAuthenticatedUser : AuthenticatedUser is " + details.getUsername());			
			EgovUserDetails details = (EgovUserDetails)principal;
			return details.getEgovUserVO();
			
		}else{
			// log.debug("## EgovUserDetailsHelper.getAuthenticatedUser : principal is not type of EgovUserDetails);
			return null;
		}

		
	}

	
	/**
	 * 인증된 사용자의 권한 정보를 가져온다.
	 * 예) [ROLE_ADMIN, ROLE_USER, ROLE_A, ROLE_B, ROLE_RESTRICTED, IS_AUTHENTICATED_FULLY, IS_AUTHENTICATED_REMEMBERED, IS_AUTHENTICATED_ANONYMOUSLY]
	 * @return List - 사용자 권한정보 목록
	 */
	public List<String> getAuthorities() {
		List<String> listAuth = new ArrayList<String>();
		
		SecurityContext context = SecurityContextHolder.getContext();
		Authentication authentication = context.getAuthentication();
		
		if (EgovObjectUtil.isNull(authentication)) {
			// log.debug("## authentication object is null!!");
			return null;
		}
		
		GrantedAuthority[] authorities = authentication.getAuthorities();

		for (int i = 0; i < authorities.length; i++) {
			listAuth.add(authorities[i].getAuthority());

			// log.debug("## EgovUserDetailsHelper.getAuthorities : Authority is " + authorities[i].getAuthority());
		}

		return listAuth;
	}
	
	/**
	 * 인증된 사용자 여부를 체크한다.
	 * @return Boolean - 인증된 사용자 여부(TRUE / FALSE)	
	 */

	public Boolean isAuthenticated() {
		SecurityContext context = SecurityContextHolder.getContext();
		Authentication authentication = context.getAuthentication();
		
		if (EgovObjectUtil.isNull(authentication)) {
			// log.debug("## authentication object is null!!");
			return Boolean.FALSE;
		}
		
		String username = authentication.getName();
		if (username.equals("roleAnonymous")) {
			// log.debug("## username is " + username);
			return Boolean.FALSE;
		}

		Object principal = authentication.getPrincipal();
		
		return Boolean.valueOf(!EgovObjectUtil.isNull(principal));
	}

}
