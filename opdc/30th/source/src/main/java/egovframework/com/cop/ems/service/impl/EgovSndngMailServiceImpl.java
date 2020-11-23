package egovframework.com.cop.ems.service.impl;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.stereotype.Service;

import egovframework.com.cop.ems.service.EgovMultiPartEmail;
import egovframework.com.cop.ems.service.EgovSndngMailService;
import egovframework.com.cop.ems.service.SndngMailVO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
/**
 * 메일 솔루션과 연동해서 이용해서 메일을 보내는 서비스 구현 클래스
 * @since 2011.09.09
 * @version 1.0
 * @see
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2011.09.09  서준식       최초 작성
 *  2011.12.06  이기하       메일 첨부파일이 기능 추가 
 *  
 *  </pre>
 */
@Service("egovSndngMailService")
public class EgovSndngMailServiceImpl extends AbstractServiceImpl implements EgovSndngMailService {
	
//	첨부파일 미사용시
	@Resource(name="EMSMailSender")
    private MailSender emsMailSender;
	
	@Resource(name="egovMultiPartEmail")
    private EgovMultiPartEmail egovMultiPartEmail;
	
	/** SndngMailRegistDAO */
    @Resource(name="sndngMailRegistDAO")
    private SndngMailRegistDAO sndngMailRegistDAO;
	
	private static final Logger LOG = Logger.getLogger(EgovSndngMailServiceImpl.class.getClass());
	
	/**
	 * 메일을 발송한다
	 * @param vo SndngMailVO
	 * @return boolean
	 * @exception Exception
	 */
	public boolean sndngMail(SndngMailVO sndngMailVO) throws Exception {
		
		/*String recptnPerson = (sndngMailVO.getRecptnPerson() == null) ? "" : sndngMailVO.getRecptnPerson();		// 수신자
		String subject = (sndngMailVO.getSj() == null) ? "" : sndngMailVO.getSj();								// 메일제목
		String emailCn = (sndngMailVO.getEmailCn() == null) ? "" : sndngMailVO.getEmailCn();					// 메일내용
		String atchmnFileNm = (sndngMailVO.getOrignlFileNm() == null) ? "" : sndngMailVO.getOrignlFileNm();		// 첨부파일이름		
		String atchmnFilePath = (sndngMailVO.getFileStreCours() == null) ? "" : sndngMailVO.getFileStreCours();	// 첨부파일경로		
		
        try{
  		  // 첨부할 attachment 정보를 생성합니다
  		  EmailAttachment attachment = new EmailAttachment();
  		  attachment.setPath(atchmnFilePath);	
  		  attachment.setDisposition(EmailAttachment.ATTACHMENT);
  		  attachment.setDescription("첨부파일입니다");
  		  attachment.setName(atchmnFileNm); 
   
  		  // 기본 메일 정보를 생성합니다
  		  	egovMultiPartEmail.addTo(recptnPerson); 
	  		egovMultiPartEmail.setSubject(subject);
	  		egovMultiPartEmail.setMsg(emailCn);
   
  		  // 생성한 attachment를 추가합니다
	  		egovMultiPartEmail.attach(attachment);
   
  		  // 메일을 전송합니다
	  		egovMultiPartEmail.send();
        	
        }catch(MailParseException ex){
        	sndngMailVO.setSndngResultCode("F");	// 발송결과 실패
        	sndngMailRegistDAO.updateSndngMail(sndngMailVO);	// 발송상태를 DB에 업데이트 한다.
        	LOG.error("Sending Mail Exception : " +  ex.getCause() + " [failure when parsing the message]");
        	return false;
        }catch(MailAuthenticationException ex){
        	sndngMailVO.setSndngResultCode("F");	// 발송결과 실패
        	sndngMailRegistDAO.updateSndngMail(sndngMailVO);	// 발송상태를 DB에 업데이트 한다.
        	LOG.error("Sending Mail Exception : " +  ex.getCause() + " [authentication failure]");
        	return false;
        }catch(MailSendException ex){
        	sndngMailVO.setSndngResultCode("F");	// 발송결과 실패
        	sndngMailRegistDAO.updateSndngMail(sndngMailVO);	// 발송상태를 DB에 업데이트 한다.
        	LOG.error("Sending Mail Exception : " +  ex.getCause() + " [failure when sending the message]");
        	return false;
        }catch(Exception ex){
        	sndngMailVO.setSndngResultCode("F");	// 발송결과 실패
        	sndngMailRegistDAO.updateSndngMail(sndngMailVO);	// 발송상태를 DB에 업데이트 한다.
        	LOG.error("Sending Mail Exception : " +  ex.getCause() + " [unknown Exception]");
        	return false;
        }*/
		
		// 첨부파일 미사용시
		String recptnPerson = (sndngMailVO.getRecptnPerson() == null) ? "" : sndngMailVO.getRecptnPerson();          // 수신자
        String subject = (sndngMailVO.getSj() == null) ? "" : sndngMailVO.getSj();                                   // 메일제목
        String emailCn = (sndngMailVO.getEmailCn() == null) ? "" : sndngMailVO.getEmailCn();                         // 메일내용

        SimpleMailMessage msg = new SimpleMailMessage();
        msg.setTo(recptnPerson);
        msg.setSubject(subject);
        msg.setText(emailCn);
        emsMailSender.send(msg);
		
		return true;
	}

}
