package egovframework.com.sec.security.intercept;

import java.lang.reflect.Method;

import org.springframework.beans.factory.support.MethodReplacer;
import org.springframework.security.ConfigAttributeDefinition;

import egovframework.com.sec.security.securedobject.ISecuredObjectService;

/**
 * 매 request 마다 요청 url 에 대한 best matching 보호자원-권한 맵핑정보를 DB 기반으로 찾기 위해
 * DefaultFilterInvocationDefinitionSource 의 lookupAttributes 메서드를 가로채어 수행하기 위한 MethodReplacer 이다.
 * @author ByungHun Woo
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    -------------    ----------------------
 *   2009.03.10  ByungHun Woo    최초 생성
 *   2009.03.20  이문준          UPDATE
 *
 * </pre>
 */

public class LookupAttributesMethodReplacer implements MethodReplacer {

    private ISecuredObjectService securedObjectService;

    public void setSecuredObjectService(ISecuredObjectService securedObjectService) {
        this.securedObjectService = securedObjectService;
    }

    /*
     * (non-Javadoc)
     * @see org.springframework.beans.factory.support.MethodReplacer#reimplement(java.lang.Object,
     *      java.lang.reflect.Method,
     *      java.lang.Object[])
     */
    public Object reimplement(Object target, Method method, Object[] args) throws Exception {
        ConfigAttributeDefinition attributes = null;

        // DB 검색
        attributes = securedObjectService.getMatchedRequestMapping((String) args[0]);

        return attributes;
    }
	
}
