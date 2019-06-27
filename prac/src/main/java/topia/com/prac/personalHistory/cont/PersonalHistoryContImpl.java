package topia.com.prac.personalHistory.cont;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import topia.com.prac.personalHistory.serv.PersonalHistoryServImpl;

@Controller
public class PersonalHistoryContImpl implements PersonalHistoryCont{
	
	@Autowired
	PersonalHistoryServImpl personalHistoryServ;
	
	@Override
	@RequestMapping(value="/personalHistory/userList", method=RequestMethod.POST)
	public @ResponseBody HashMap<String, Object> userList(HttpServletRequest request) {      
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		HashMap<String,Object> reqMap = (HashMap<String, Object>)request.getParameterMap();
		HashMap<String,Object> unlockedReqMap = new HashMap<String,Object>();
		
		// 값 복사를 위한 루프
		for( String key : reqMap.keySet() ){
			unlockedReqMap.put(key, reqMap.get(key));
        }
		
		try {
			resultMap = (HashMap<String, Object>)personalHistoryServ.userList(unlockedReqMap);
		} catch (Exception e) {
			System.out.println("ERROR PersonalHistoryServImpl : " + e);
		}
		
		return resultMap;
		
	}
	
	@Override
	@RequestMapping(value="/personalHistory/chkUserDupl", method=RequestMethod.POST)
	public @ResponseBody HashMap<String, Object> chkUserDupl(HttpServletRequest request) {      
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		HashMap<String,Object> reqMap = (HashMap<String, Object>)request.getParameterMap();
		HashMap<String,Object> unlockedReqMap = new HashMap<String,Object>();
		
		// 값 복사를 위한 루프
		for( String key : reqMap.keySet() ){
			unlockedReqMap.put(key, reqMap.get(key));
        }
		
		try {
			resultMap = (HashMap<String, Object>)personalHistoryServ.chkUserDupl(unlockedReqMap);
		} catch (Exception e) {
			System.out.println("ERROR PersonalHistoryServImpl : " + e);
		}
		
		return resultMap;
		
	}
	
	@Override
	@RequestMapping(value="/personalHistory/registerUser", method=RequestMethod.POST)
	public @ResponseBody HashMap<String,Object> registerUser(HttpServletRequest request) {
		
		// getParameterMap()으로 추출한 맵 객체는 readonly 상태이기 때문에
		// 사용 가능하도록 새로운 맵을 생성하여 값을 복사한다
		HashMap<String,Object> reqMap = (HashMap<String, Object>)request.getParameterMap();
		HashMap<String,Object> unlockedReqMap = new HashMap<String,Object>();
		HashMap<String,Object> resMap = new HashMap<String,Object>();
		
		// 값 복사를 위한 루프
		for( String key : reqMap.keySet() ){
			unlockedReqMap.put(key, reqMap.get(key));
        }
		
		
		try {
			resMap = personalHistoryServ.registerUser(unlockedReqMap);
			
			String userIdx = (String)unlockedReqMap.get("user_idx");
			
			resMap.put("userIdx",userIdx);
		} catch (Exception e) {
			System.out.println("ERROR registerUser : " + e);
		}
		
		
		return resMap;
	}
	
	@Override
	@RequestMapping(value="/personalHistory/registerUserUpdate", method=RequestMethod.POST)
	public @ResponseBody HashMap<String,Object> registerUserUpdate(HttpServletRequest request) {
		
		// getParameterMap()으로 추출한 맵 객체는 readonly 상태이기 때문에
		// 사용 가능하도록 새로운 맵을 생성하여 값을 복사한다
		HashMap<String,Object> reqMap = (HashMap<String, Object>)request.getParameterMap();
		HashMap<String,Object> unlockedReqMap = new HashMap<String,Object>();
		HashMap<String,Object> resMap = new HashMap<String,Object>();
		
		// 값 복사를 위한 루프
		for( String key : reqMap.keySet() ){
			unlockedReqMap.put(key, reqMap.get(key));
        }
		
		try {
			personalHistoryServ.registerUserUpdate(unlockedReqMap);
			String userIdx = (String)unlockedReqMap.get("userIdx");
			resMap.put("userIdx",userIdx);
		} catch (Exception e) {
			System.out.println("ERROR registerUserUpdate : " + e);
		}
				
		
		return resMap;
	}
	
	@Override
	@RequestMapping("/personalHistory/updateUser")
	public int updateUser() {
		// TODO Auto-generated method stub
		return 0;
	}
	
	@Override
	@RequestMapping("/personalHistory/deleteUser")
	public int deleteUser() {
		// TODO Auto-generated method stub
		return 0;
	}

	
	/**
	 * 등록된 데이터 가져오기
	 * 
	 * map -> string,array strng은 고정변수의 값들 key, val 형태로 그냥 받고
	 * 유동변수들은 key 테이블명 : val array 형태 
	 * @throws IOException 
	 * @throws JsonMappingException 
	 * @throws JsonParseException 
	 */
	@Override
	@RequestMapping(value="/personalHistory/getRegisterData", method=RequestMethod.POST)
	public @ResponseBody HashMap<String, Object> getRegisterData(HttpServletRequest request, HttpServletResponse response) throws JsonParseException, JsonMappingException, IOException {
		HashMap<String,Object> reqMap = (HashMap<String, Object>)request.getParameterMap();
		
		HashMap<String, Object> resMap = personalHistoryServ.getRegisterData(reqMap);
		
		return resMap;
	}
}
