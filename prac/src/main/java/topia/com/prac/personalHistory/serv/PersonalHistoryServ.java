package topia.com.prac.personalHistory.serv;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;

public interface PersonalHistoryServ {
	public HashMap<String, Object> userList(HashMap<String,Object> reqMap);
	public HashMap<String, Object> chkUserDupl(HashMap<String,Object> reqMap);
	HashMap<String,Object> registerUser(Object inputdata);
	public int registerUserUpdate(HashMap<String,Object> intputdata);
	public HashMap<String, Object> getRegisterData(HashMap<String, Object> userIdx) throws JsonParseException, JsonMappingException, IOException;
}
