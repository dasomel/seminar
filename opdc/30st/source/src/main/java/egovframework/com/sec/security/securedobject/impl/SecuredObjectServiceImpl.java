/*
 * Copyright 2002-2008 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package egovframework.com.sec.security.securedobject.impl;

import java.util.LinkedHashMap;
import java.util.Locale;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.context.MessageSource;
import org.springframework.security.ConfigAttributeDefinition;

import egovframework.com.sec.security.securedobject.ISecuredObjectService;

/**
 * Enabling applications to approach the data of
 * secured object resources from DataBase which is
 * refered to initial data of Spring Security.
 * 
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
 *
 * </pre>
 */

public class SecuredObjectServiceImpl implements ISecuredObjectService, ApplicationContextAware, InitializingBean{
    private MessageSource messageSource;

    private SecuredObjectDAO securedObjectDAO;

    /**
     * set ApplicationContext
     * @param applicationContext to be set by container
     */
    public void setApplicationContext(ApplicationContext applicationContext)
            throws BeansException {
        this.messageSource = (MessageSource) applicationContext.getBean("messageSource");
    }

    /**
     * get messageSource
     * @return MessageSource
     */
    protected MessageSource getMessageSource() {
        return messageSource;
    }
    
    /**
     * setSecuredObjectDAO
     * @param securedObjectDAO SecuredObjectDAO
     */
    public void setSecuredObjectDAO(SecuredObjectDAO securedObjectDAO) {
        this.securedObjectDAO = securedObjectDAO;
    }

    /**
     * afterPropertiesSet
     * @exception Exception
     */
    public void afterPropertiesSet() throws Exception {
        try {
        	ISecuredObjectService.LOGGER.info("ISecuredObjectService afterPropertiesSet() log.");
        } catch (Exception e) {
            if (e instanceof Exception) {
                throw (Exception) e;
            } else {
                if (ISecuredObjectService.LOGGER.isErrorEnabled()) {
                    ISecuredObjectService.LOGGER.error(messageSource
                        .getMessage("error.security.initialize.reason",
                            new String[] {}, Locale.getDefault()));
                    throw e;
                }
            }
        }
    }
    
	/**
	 * url 형식의 role 권한 획득
	 * @return LinkedHashMap
	 * @exception Exception
	 */
    public LinkedHashMap getRolesAndUrl() throws Exception {
        try {
            return securedObjectDAO.getRolesAndUrl();
        } catch (Exception e) {
            ISecuredObjectService.LOGGER.error(getMessageSource().getMessage("error.security.runtime.error", 
            		                                                         new Object[] {"Roles and Url" }, Locale.getDefault()), e);
            if (e instanceof Exception) {
                throw (Exception) e;
            } else {
                throw e;
            }
        }
    }
    
	/**
	 * method 형식의 role 권한 획득
	 * @return LinkedHashMap
	 * @exception Exception
	 */
    public LinkedHashMap getRolesAndMethod() throws Exception {
        try {
            return securedObjectDAO.getRolesAndMethod();
        } catch (Exception e) {
            ISecuredObjectService.LOGGER.error(getMessageSource().getMessage(
                "error.security.runtime.error",
                new Object[] {"Roles and Method" }, Locale.getDefault()), e);
            if (e instanceof Exception) {
                throw (Exception) e;
            } else {
                throw e;
            }
        }
    }

	/**
	 * pointcut 형식의 role 권한 획득
	 * @return LinkedHashMap
	 * @exception Exception
	 */
    public LinkedHashMap getRolesAndPointcut() throws Exception {
        try {
            return securedObjectDAO.getRolesAndPointcut();
        } catch (Exception e) {
            ISecuredObjectService.LOGGER.error(getMessageSource().getMessage(
                "error.security.runtime.error",
                new Object[] {"Roles and Pointcut" }, Locale.getDefault()), e);
            if (e instanceof Exception) {
                throw (Exception) e;
            } else {
            	throw e;
            }
        }
    }

	/**
	 * getMatchedRequestMapping
	 * @return ConfigAttributeDefinition
	 * @exception Exception
	 */    
    public ConfigAttributeDefinition getMatchedRequestMapping(String url)
            throws Exception {
        try {
            return securedObjectDAO.getRegexMatchedRequestMapping(url);
        } catch (Exception e) {
            ISecuredObjectService.LOGGER.error(getMessageSource().getMessage(
                "error.security.runtime.error",
                new Object[] {"MatchedRequestMapping : " + url },
                Locale.getDefault()), e);
            if (e instanceof Exception) {
                throw (Exception) e;
            } else {
            	throw e;
            }
        }
    }

	/**
	 * role 의 계층(Hierarchy) 관계를 조회
	 * @return String
	 * @exception Exception
	 */   
    public String getHierarchicalRoles() throws Exception {
        try {
            return securedObjectDAO.getHierarchicalRoles();
        } catch (Exception e) {
            ISecuredObjectService.LOGGER.error(getMessageSource().getMessage(
                "error.security.runtime.error",
                new Object[] {"Hierarchical Roles" }, Locale.getDefault()), e);
            if (e instanceof Exception) {
                throw (Exception) e;
            } else {
            	throw e;
            }
        }
    }
}
