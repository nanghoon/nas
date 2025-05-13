package egovframework.example.sample.web;

import java.util.List;
import java.util.Properties;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.example.sample.service.impl.SampleDAO;
import egovframework.example.sample.web.utils.Utils;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestMapping("admin")
public class AdminController {
	
	@Resource(name = "globalProperties")
	private Properties globalProperties;
	
	@Resource(name = "sampleDAO")
	private SampleDAO sampleDAO;
	

	@RequestMapping(value="/login.do")
	public String login(HttpServletRequest request, Model model){
		Cookie[] cookies = request.getCookies();
		if(cookies != null) {
			for(int i=0; i<cookies.length; i++){
				if(cookies[i] == null || cookies[i].getName() == null ) continue;
				if(cookies[i].getName().equals("JSESSIONID")) continue;
				model.addAttribute(cookies[i].getName(), cookies[i].getValue());
			}
		}
		return "admin/login";
	}
	
	@ResponseBody
	@RequestMapping(value="/loginProcess.do" , produces = "application/json; charset=utf8")
	public String loginProcess(HttpServletRequest request, HttpServletResponse response){
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String rememberAc = request.getParameter("rememberAc");
		JSONObject obj = new JSONObject();
		obj.put("result", "fail");
		if(Utils.isNull(id)){
			obj.put("msg", Utils.input("아이디"));
			return obj.toJSONString();
		}		
		if(Utils.isNull(pw)){
			obj.put("msg", Utils.input("비밀번호"));
			return obj.toJSONString();
		}		
		EgovMap in = new EgovMap();
		EgovMap info = (EgovMap)sampleDAO.select("checkAdminId",id);
		if(info == null){ 
			obj.put("msg", "아이디가 일치하지 않습니다");
			return obj.toJSONString();
		}else{
			String savePw = info.get("pw").toString();
			if (BCrypt.checkpw(pw, savePw)){
				if (Utils.isNull(rememberAc)) {
				    Cookie[] cookies = request.getCookies();
			        for (int i = 0; i < cookies.length; i++) {
			            if (cookies[i].getName().equals("cookieEmail") || cookies[i].getName().equals("cookiePw") || cookies[i].getName().equals("cookieRemember")) {
			            	cookies[i].setPath(request.getContextPath());
			                cookies[i].setMaxAge(0);
			                response.addCookie(cookies[i]);
			            }
			        }
				} else {
				    Cookie cookieId = new Cookie("cookieEmail", id);
				    cookieId.setPath(request.getContextPath());
				    cookieId.setMaxAge(60 * 60 * 24 * 7); // 7일
				    response.addCookie(cookieId);

				    Cookie cookiePassword = new Cookie("cookiePw", pw);
				    cookiePassword.setPath(request.getContextPath());
				    cookiePassword.setMaxAge(60 * 60 * 24 * 7); // 7일
				    response.addCookie(cookiePassword);

				    Cookie cookieRemember = new Cookie("cookieRemember", "1");
				    cookieRemember.setPath(request.getContextPath());
				    cookieRemember.setMaxAge(60 * 60 * 24 * 7); // 7일
				    response.addCookie(cookieRemember);
				}
				obj.put("result", "suc");
				obj.put("idx", info.get("idx"));
				HttpSession session = request.getSession();
				session.setAttribute("adminIdx", info.get("idx"));
				return obj.toJSONString();
			}else{
				obj.put("msg", "비밀번호가 일치하지 않습니다");
				return obj.toJSONString();
			}
		}
	}
	
	@RequestMapping(value="/logout.do")
	public String logout(HttpServletRequest request){
		HttpSession session = request.getSession();
		session.setAttribute("adminIdx", null);
		return "redirect:login.do";
	}
	
	@RequestMapping(value="/support.do")
	public String support(HttpServletRequest request, Model model){
		String pageIndex = request.getParameter("pageIndex");
		PaginationInfo pi = new PaginationInfo();
		if(Utils.isNull(pageIndex)) pi.setCurrentPageNo(1);
		else pi.setCurrentPageNo(Integer.parseInt(pageIndex));
		pi.setPageSize(10);
		pi.setRecordCountPerPage(10);
		EgovMap in = new EgovMap();
		in.put("first", pi.getFirstRecordIndex());
		in.put("record", pi.getRecordCountPerPage());
		pi.setTotalRecordCount((int)sampleDAO.select("selectSupportListCnt",in));
		List<EgovMap> list = (List<EgovMap>)sampleDAO.list("selectSupportList",in);
		for(EgovMap l : list){
			l.put("email", Utils.decryptGCM(l.get("email").toString(), Utils.getKey(globalProperties)));
			l.put("phone", Utils.decryptGCM(l.get("phone").toString(), Utils.getKey(globalProperties)));
		}
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		return "admin/support";
	}
	@RequestMapping(value="/supportInfo.do")
	public String supportInfo(HttpServletRequest request, Model model){
		String idx = request.getParameter("idx");
		EgovMap info = (EgovMap)sampleDAO.select("selectSupportInfo",idx);
		if(Integer.parseInt(""+info.get("readyn")) == 0)
			sampleDAO.update("updateSupportReadY",idx);
		
		info.put("email", Utils.decryptGCM(info.get("email").toString(), Utils.getKey(globalProperties)));
		info.put("phone", Utils.decryptGCM(info.get("phone").toString(), Utils.getKey(globalProperties)));
		model.addAttribute("info",info );
		return "admin/supportInfo";
	}
}
