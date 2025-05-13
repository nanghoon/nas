package egovframework.example.sample.web;

import java.util.Base64;
import java.util.Properties;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.example.sample.service.impl.SampleDAO;
import egovframework.example.sample.web.utils.Utils;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class MainController {
	
	@Resource(name = "globalProperties")
	private Properties globalProperties;
	
	@Resource(name = "sampleDAO")
	private SampleDAO sampleDAO;
	
	@RequestMapping(value="/main.do")
	public String main(){
		return "user/main";
	}
	
	@RequestMapping(value="/intro.do")
	public String intro(){
		return "user/intro";
	}
	
	@RequestMapping(value="/xosome.do")
	public String xosome(){
		return "user/xosome";
	}

	@RequestMapping(value="/booster.do")
	public String booster(){
		return "user/booster";
	}
	
	@RequestMapping(value="/support.do")
	public String support(){
		return "user/support";
	}
	
	@ResponseBody
	@RequestMapping(value="/supportInsert.do" , produces = "application/json; charset=utf8")
	public String supportInsert(HttpServletRequest request){
		String company = request.getParameter("company");
		String name = request.getParameter("name");
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");
		String text = request.getParameter("text");
		JSONObject obj = new JSONObject();
		obj.put("result", "fail");
		if(Utils.isNull(company)){
			obj.put("msg", Utils.input("병원/업체명"));
			return obj.toJSONString();
		}
		if(Utils.isNull(name)){
			obj.put("msg", Utils.input("이름"));
			return obj.toJSONString();
		}
		if(Utils.isNull(phone)){
			obj.put("msg", Utils.input("휴대폰"));
			return obj.toJSONString();
		}
		if(!Utils.checkPhoneNumber(phone)){
			obj.put("msg", "올바른 휴대폰 번호를 입력해주세요");
			return obj.toJSONString();
		}
		if(Utils.isNull(email)){
			obj.put("msg", Utils.input("이메일"));
			return obj.toJSONString();
		}
		if(!Utils.checkEmail(email)){
			obj.put("msg", "올바른 이메일을 입력해주세요");
			return obj.toJSONString();
		}
		if(Utils.isNull(text)){
			obj.put("msg", Utils.input("문의내용"));
			return obj.toJSONString();
		}

		EgovMap in = new EgovMap();
		in.put("company", company);
		in.put("name", name);
		in.put("phone", Utils.encryptGCM(phone, Utils.getKey(globalProperties)));
		in.put("email", Utils.encryptGCM(email, Utils.getKey(globalProperties)));
		in.put("text", text);
		sampleDAO.insert("insertSupport",in);
		obj.put("result","success");
		obj.put("msg", "문의등록이 완료되었습니다");
		return obj.toJSONString();
		
	}
}
