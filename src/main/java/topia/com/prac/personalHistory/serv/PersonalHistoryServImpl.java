package topia.com.prac.personalHistory.serv;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;

import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import topia.com.prac.personalHistory.dao.AbstractDAO;
import topia.com.util.Sha256;

@Service
public class PersonalHistoryServImpl implements PersonalHistoryServ{
	
	@Autowired
	AbstractDAO dbCon;
	
	@Override
	/**
	 * 기존 등록된 개인 이력카드 가져오기
	 */
	public HashMap<String, Object> userList(HashMap<String,Object> reqMap) {
		HashMap<String, Object> resMap = new HashMap<String, Object>();
		ArrayList<Object> list;
		String totalCnt = "";
		String careerIdxs = "";
		String keywordIdxs = "";
		
		try {
			
			// 경력에 대한 조회가 있을 경우 해당 조건에 맞는 사용자의 pk를 조회하여 WHERE FIND_IN_SET에 사용할 텍스트를 가져옴
			if(!((String[])reqMap.get("userCareerLength"))[0].equals("")) {
				careerIdxs = (String)dbCon.selectOne("personalHistory.getUserCareerLength", reqMap);
				if(!careerIdxs.equals("null")) reqMap.put("careerIdxs", careerIdxs);
			}
			
			// 경력에 대한 조회가 있을 경우 해당 조건에 맞는 사용자의 pk를 조회하여 WHERE FIND_IN_SET에 사용할 텍스트를 가져옴
			if(!((String[])reqMap.get("keywords"))[0].equals("")) {
				keywordIdxs = (String)dbCon.selectOne("personalHistory.getUserIdxHasKeyword", reqMap);
				if(!keywordIdxs.equals("null")) reqMap.put("keywordIdxs", keywordIdxs);
			}
			
			list = (ArrayList<Object>)dbCon.selectList("personalHistory.userList", reqMap);
			totalCnt = String.valueOf(dbCon.selectOne("personalHistory.userListCount", reqMap));
			
			resMap.put("list", list);
			resMap.put("totalCnt", totalCnt);
		} catch (Exception e) {
			//System.out.println("ERROR PersonalHistoryDAOImpl : " + e);
			e.printStackTrace();
		}
		
		return resMap;
	}
	
	
	
	@Override
	/**
	 * 사용자 중복 여부 확인
	 */
	public HashMap<String, Object> chkUserDupl(HashMap<String,Object> reqMap) {
		HashMap<String, Object> resMap = new HashMap<String, Object>();
		
		try {
			String duplicated = "N";
			
			String socialNum = ((String[])reqMap.get("userSocialSecunum"))[0]; // 주민등록번호 암호화
			String encodedSocialNum = Sha256.encrypt(socialNum);
			reqMap.replace("userSocialSecunum", encodedSocialNum);
			
			ArrayList<Object> duplitedList = (ArrayList<Object>)dbCon.selectList("personalHistory.findDuplitedUserInfo", reqMap);
						
			if(duplitedList.size() > 0) duplicated = "Y";
			
			resMap.put("duplicated", duplicated);
		} catch (Exception e) {
			//System.out.println("ERROR PersonalHistoryDAOImpl : " + e);
			e.printStackTrace();
		}
		
		return resMap;
	}

	
	/**
	 * 새로 작성한 개인 이력카드 등록
	 * 
	 * @param Object inputdata : map 형태의 고정데이터와 json string 형태의 유동데이터 포함
	 * @return statusNum 등록 성공여부
	 */
	@Override
	public HashMap<String,Object> registerUser(Object inputdata) {
		
		int statusNum = 0;
		HashMap<String,Object> resMap = new HashMap<String,Object>(); 
		
		try {
			
			HashMap<String,Object> map = (HashMap<String,Object>)inputdata;
			String socialNum = ((String[])map.get("userSocialSecunum"))[0]; // 주민등록번호 암호화
			
			String encodedSocialNum = Sha256.encrypt(socialNum);
			
			map.replace("userSocialSecunum", encodedSocialNum);
			
			
			//------------------------------------ 중복 여부 확인
			ArrayList<Object> duplitedList = (ArrayList<Object>)dbCon.selectList("personalHistory.findDuplitedUserInfo", map);
			
			if(duplitedList.size() > 0) {
				
				resMap.put("errorCode","1001");
				resMap.put("errorMsg","중복된 사용자입니다.");
				
				return resMap; // 중복일 경우 에러코드 리턴
			}else {
				
				statusNum = (Integer)dbCon.insert("personalHistory.registerUser", map);

				// 유동형 데이터 json String -> ArrayList<HashMap<String, Object>> parsing 
				
				String[] strList = (String[])map.get("flexibleData");
				String listJsonStr = strList[0];
				
				String userIdx = (String)map.get("user_idx"); // 고정 데이터로 등록된 pk를 유동데이터의 fk로 사용
				
				ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
				ObjectMapper mapper = new ObjectMapper();
				list=mapper.readValue(listJsonStr,ArrayList.class);
				
				
				
				// 리스트 내부 요소 하나씩 루프돌면서 등록
				
				Iterator it = list.iterator();
				while(it.hasNext()){
					
					HashMap<String,Object> nowLoopObj = (HashMap<String,Object>)it.next();
					
					nowLoopObj.put("userIdx", userIdx);
					
					System.out.println("nowLoopObj : ");
					System.out.println(nowLoopObj);
					
					statusNum = (Integer)dbCon.insert("personalHistory.insertUserFlexibleData", nowLoopObj);
					
				}
				
				resMap.put("userIdx",userIdx);
				
			}
			
			
			
		} catch (Exception e) {
			System.out.println("ERROR registerUserDAOImpl : " + e);
			e.printStackTrace();
		}
		
		return resMap;
	}
	
	
	/**
	 * 기존 개인이력카드 등록건에 대한 수정처리
	 * 
	 * @HashMap<String,Object> inputdata : map 형태의 고정데이터와 json string 형태의 유동데이터 포함
	 * @return statusNum 등록 성공여부
	 */
	@Override
	public int registerUserUpdate(HashMap<String,Object> inputdata) {
		
		int statusNum = 0;
		
		try {
			statusNum = (Integer)dbCon.update("personalHistory.registerUserUpdate", inputdata);
			
			String[] strList = (String[])inputdata.get("flexibleData");
			String listJsonStr = strList[0];
			
			String[] userIdxArr = (String[])inputdata.get("userIdx");
			String userIdx = userIdxArr[0];
			
			inputdata.replace("userIdx", userIdx);
			
			ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
			ObjectMapper mapper = new ObjectMapper();
			list=mapper.readValue(listJsonStr,ArrayList.class);	
			
			
			// 유동데이터 삭제처리
			// 수정건에 대해서만 로직처리로 변경하면 좋을것
			// 현재 로직 : 고정데이터 업데이트, 유동데이터 전체삭제 후 재등록
			dbCon.delete("personalHistory.deleteCareerData", inputdata);
			dbCon.delete("personalHistory.deleteEduData", inputdata);
			dbCon.delete("personalHistory.deleteLicenData", inputdata);
			dbCon.delete("personalHistory.deleteQualifiData", inputdata);
			dbCon.delete("personalHistory.deleteSkillData", inputdata);
			dbCon.delete("personalHistory.deleteTrainingData", inputdata);
			
			
			// 유동데이터 재등록
			Iterator it = list.iterator();
			while(it.hasNext()){
				
				HashMap<String,Object> nowLoopObj = (HashMap<String,Object>)it.next();
				
				System.out.println("nowLoopObj : ");
				System.out.println(nowLoopObj);
				
				nowLoopObj.put("userIdx", userIdx);
				
				statusNum = (Integer)dbCon.insert("personalHistory.insertUserFlexibleData", nowLoopObj);
				
			}
			
		} catch (Exception e) {
			System.out.println("ERROR registerUserDAOImpl : " + e);
		}
		
		return statusNum;
	}

	@SuppressWarnings("unchecked")
	@Override
	public HashMap<String, Object> getRegisterData(HashMap<String, Object> reqMap) throws JsonParseException, JsonMappingException, IOException {
		HashMap<String, Object> resMap = new HashMap<String, Object>(); 
		
		
		String[] strList = (String[])reqMap.get("tbNames");
		String listJsonStr = strList[0];
		String[] userIdxList = (String[])reqMap.get("userIdx");
		String userIdx = userIdxList[0];
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		ObjectMapper mapper = new ObjectMapper();
		list = mapper.readValue(listJsonStr,ArrayList.class);
		
		
		//---------------------------------------- 고정 컬럼 데이터 처리
		HashMap<String, Object> fixedMap = new HashMap<String, Object>();
		
		fixedMap.put("userIdx", userIdx);
		
		ArrayList<Object> arr = (ArrayList<Object>)dbCon.selectList("personalHistory.getRegisterData", fixedMap);
		resMap.put("fixedData", arr);
		
		
		Iterator it = list.iterator();
		while(it.hasNext()){
			String tbName = (String)it.next();
			
			System.out.println(tbName);
			
			HashMap<String, Object> iterMap = new HashMap<String, Object>();
			iterMap.put("tbName", tbName);
			iterMap.put("userIdx", userIdx);
			
			resMap.put(tbName, dbCon.selectList("personalHistory.getRegisterFlexibleData", iterMap));
		}
		
		
		return resMap;
	}
	
}
