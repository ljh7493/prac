<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<html>
<head>

	<script src="./resources/compnent/jquery-3.3.1.min.js"></script>
	<script src="./resources/compnent/jquery-ui-1.12.1.custom/jquery-ui.min.js"></script>
	
	<script src="./resources/compnent/jquery-loading-master/dist/jquery.loading.min.js"></script>
	<script src="./resources/compnent/jqueryPrint/jqueryPrint.js"></script>

	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js?autoload=false"></script>
	
	<script src="./resources/js/util/util.js"></script>
	
	<script src="./resources/js/personalHistory/personalHistory.js"></script>
	<script src="./resources/js/personalHistory/personalHistoryFunc.js"></script>
	
	<link rel="stylesheet" type="text/css" href="./resources/compnent/jquery-ui-1.12.1.custom/jquery-ui.min.css">
	<link rel="stylesheet" type="text/css" href="./resources/compnent/jquery-loading-master/dist/jquery.loading.min.css">
	<link rel="stylesheet" type="text/css" href="./resources/css/personalHistory/personalHistory.css">
	<!-- <link rel="stylesheet" type="text/css" href="./resources/css/personalHistory/print.css"> -->
	<title>Home</title>
</head>
<body>
	<div class="custom-loading"><div class="loading-image"></div></div>
	<%-- 새 작성건의 경우 해당 인풋값은 비어있고 수정 및 조회건은 들어감 --%>
	<div>
		<input id="userIdx" type="hidden" autocomplete="off">
	</div>

	<div class="user-info-list-pannel">
		<div class="personal-history-title-pannel">
			<h3>개 인 이 력 카 드</h3>
		</div>
		
		<div class="top-header-pannel">
			
			<div class="status-display-pannel">
				<h5>※ 새 이력 작성</h5>
			</div>
			
			<div class="function-btn-pannel">
				<button class="printBtn" title="출력"></button>
				<button class="newHistoryCreateBtn" title="새로작성"></button>
				<button class="personalHistoryResetBtn" title="초기화"></button>
				<button class="personalHistorySaveBtn" title="저장"></button>
			</div>
		</div>
		
		
		<table class="user-info-table1">
		
			<tbody>
				<tr>
					<td>*성명</td>
					<td><input type="text" id="userName" autocomplete="off"></td>
					<td>*주민등록번호</td>
					<td colspan="3">
						<input type="password" id="userSocialSecunum" maxlength="13" placeholder='  "-" 제외한 숫자만 입력' autocomplete="off">
						<button id="findDuplitedUserInfoBtn">중복확인</button>
					</td>
					<td>성별</td>
					<td>
						<select id="userSex">
							<option value="">선택없음</option>
							<option value="남성">남성</option>
							<option value="여성">여성</option>
						</select>
					</td>
				</tr>
				
				<tr>
					<td>소속회사</td>
					<td colspan="5"><input type="text" id="userComp" autocomplete="off"></td>
					<td>입사일</td>
					<td><input type="text" id="userCompEnterdate" class="dateInput" autocomplete="off"></td>
				</tr>
				
				<tr>
					<td>부서</td>
					<td><input type="text" id="userDept" autocomplete="off"></td>
					<td>직위</td>
					<td><input type="text" id="userSpot" autocomplete="off"></td>
					<td>병역</td>
					<td><input type="text" id="userArmyServ" autocomplete="off"></td>
					<td>결혼</td>
					<td>
						<select id="userMaritalStatus">
							<option value="">선택없음</option>
							<option value="기혼">기혼</option>
							<option value="미혼">미혼</option>
						</select>
					</td>
				</tr>
				
				<tr>
					<td>병역<br> 입대 ~ 제대일</td>
					<td colspan="2"><input type="text" id="userArmyServEnter" class="dateInput prevDate" autocomplete="off"></td>
					<td> ~ </td>
					<td colspan="2"><input type="text" id="userArmyServLeave" class="dateInput laterDate" autocomplete="off"></td>
					<td>역종/병과</td>
					<td><input type="text" id="userArmyServPeriod" autocomplete="off"></td>
				</tr>
			</tbody>
			
		</table>
		
		
		
		
		
		
		
		<table class="user-info-table2">

			<tbody>
				<tr>
					<td>전화</td>
					<td><input type="tel" placeholder='   휴대전화 "-" 포함' id="userTelnumWireless" autocomplete="off"></td>
					<td><input type="tel" placeholder='   유선 "-" 포함' id="userTelnumWired" autocomplete="off"></td>
				</tr>
				
				<tr>
					<td>E-Mail</td>
					<td colspan="2"><input type="email" id="userEmail" autocomplete="off"></td>
				</tr>
				
				<tr>
					<td>주소</td>
					<td>
						<div>
							<input type="text" id="userZipcode" placeholder="우편번호" autocomplete="off">
							<input type="button" id="personalZipcodeSearchBtn" value="우편번호 찾기" autocomplete="off">
							<div class="clear-pannel"></div>
						</div>
					</td>
					<td>
						<input type="text" id="userAddress" placeholder="   주소" autocomplete="off">
						<!-- <input type="text" id="userAddress"> -->
					</td>
				</tr>
			</tbody>
			
		</table>
		
		
		
		
		
		
		
		
		<%-- 학력 / 자격증 --%>
		<div class="edu-and-qualifi-pannel">
			<div class="edu-table-pannel">
				<table class="edu-table flexibleTable" tb="edu">
					<thead>
						<tr>
							<td>학교명</td>
							<td>상태</td>
							<td colspan="2">년</td>
							<td colspan="2">월</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" data="eduSchoolName" class="eduSchoolName" autocomplete="off"></td>
							<td>
								<select data="eduStatus" class="eduStatus">
									<option value="">선택없음</option>
									<option value="입학">입학</option>
									<option value="재학">재학</option>
									<option value="졸업">졸업</option>
									<option value="졸업예정">졸업예정</option>
								</select>
							</td>
							<td><input type="text" data="eduYear" placeholder="" class="eduYear" autocomplete="off"></td>
							<td>년</td>
							<td><input type="text" data="eduMonth" placeholder="" class="eduMonth" autocomplete="off"></td>
							<td>월</td>
						</tr>
					</tbody>
					
				</table>
				
				<div class="add-row-btn-pannel">
					<button class="add-row-btn addRowBtn" title="행 추가">+</button>
				</div>
				
			</div>
			
			<div class="qualifi-table-pannel">
				<table class="qualifi-table flexibleTable" tb="qualifi">
				
					<thead>
						<tr>
							<td>
								자격증명
							</td>
							<td>
								취득일
							</td>
						</tr>
					</thead>
					
					<tbody>
						<tr>
							<td><input type="text" data="qualifiName" class="qualifiName" autocomplete="off"></td>
							<td><input type="text" data="qualifiGetdate" class="qualifiGetdate dateInput" autocomplete="off"></td>
						</tr>
					</tbody>
					
				</table>
				
				<div class="add-row-btn-pannel">
					<button class="add-row-btn addRowBtn" title="행 추가">+</button>
				</div>
				
			</div>
		</div>






		<div class="clear-pannel"></div>
		
		
		
		
		
		<div class="career-info-pannel">
			<table class="career-info flexibleTable" tb="career">
				<thead>
					<tr>
						<td rowspan="2">회사명</td>
						<td colspan="2">재직기간</td>
						<td rowspan="2">직위</td>
						<td rowspan="2">담당업무</td>
					</tr>
					<tr>
						<td>시작일</td>
						<td>종료일</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type="text" data="careerCompName" class="careerCompName" ></td>
						<td><input type="text" data="careerEnterdate" class="careerEnterdate dateInput prevDate" autocomplete="off"></td>
						<td><input type="text" data="careerLeavedate" class="careerLeavedate dateInput laterDate" autocomplete="off"></td>
						<td><input type="text" data="careerSpot" class="careerSpot" autocomplete="off"></td>
						<td><input type="text" data="careerResponsib" class="careerResponsib" autocomplete="off"></td>
					</tr>
				</tbody>
			</table>
			
			<div class="add-row-btn-pannel">
				<button class="add-row-btn addRowBtn" title="행 추가">+</button>
			</div>
			
		</div>
		
		
		
		
		
		
		
		
		<%-- 학력 / 자격증 --%>
		<div class="training-and-licen-pannel">
			<div class="training-table-pannel">
				<table class="training-table flexibleTable" tb="training">
					<thead>
						<tr>
							<td>
								교육명
							</td>
							<td>
								시작일
							</td>
							<td>
								종료일
							</td>
							<td>
								기관
							</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" data="trainingName" class="trainingName" autocomplete="off"></td>
							<td><input type="text" data="trainingStratdate" class="trainingStratdate dateInput prevDate" autocomplete="off"></td>
							<td><input type="text" data="trainingEnddate" class="trainingEnddate dateInput laterDate" autocomplete="off"></td>
							<td><input type="text" data="trainingAgency" class="trainingAgency" autocomplete="off"></td>
						</tr>
					</tbody>
				</table>
				
				<div class="add-row-btn-pannel">
					<button class="add-row-btn addRowBtn" title="행 추가">+</button>
				</div>
				
			</div>
			
			<div class="training-table-pannel">
				<table class="licen-table flexibleTable" tb="licen">
					<thead>
						<tr>
							<td>
								보유기술 및 외국어능력
							</td>
							<td>
								숙련도<br>(A,B,C)
							</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" data="licenName" class="licenName" autocomplete="off"></td>
							<td><input type="text" data="licenSkillLevel" class="licenSkillLevel" autocomplete="off"></td>
						</tr>
					</tbody>
				</table>
				
				<div class="add-row-btn-pannel">
					<button class="add-row-btn addRowBtn" title="행 추가">+</button>
				</div>
				
			</div>
		</div>
		
		
	
	
	
		
		
		<div class="clear-pannel"></div>
		
		
		
		
		
		
		
		
		<div class="skill-inventory-table-pannel">
			<table class="skill-inventory-table flexibleTable" tb="skill">
				<thead>
					<tr>
						<td rowspan="2">프로젝트명<br>업무명</td>
						<td colspan="2">참여기간</td>
						<td rowspan="2">고객사</td>
						<td rowspan="2">근무회사</td>
						<td colspan="2">개발분야</td>
						<td rowspan="2">역할</td>
						<td colspan="7">개발환경</td>
					</tr>
					<tr>
						<td>시작일</td>
						<td>종료일</td>
						<td>산업</td>
						<td>응용</td>
						<td>기종</td>
						<td>O.S</td>
						<td>언어</td>
						<td>DBMS</td>
						<td>TOOL</td>
						<td>통신</td>
						<td>기타</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><textarea data="skillProjectName" class="skillProjectName"></textarea></td>
						<td><input type="text" data="skillStartdate" class="skillStartdate dateInput prevDate" autocomplete="off"></td>
						<td><input type="text" data="skillEnddate" class="skillEnddate dateInput laterDate" autocomplete="off"></td>
						<td><textarea data="skillCustomerComp" class="skillCustomerComp"></textarea></td>
						<td><textarea data="skillWorkComp" class="skillWorkComp"></textarea></td>
						<td><textarea data="skillIndustry" class="skillIndustry"></textarea></td>
						<td><textarea data="skillApplied" class="skillApplied"></textarea></td>
						<td><textarea data="skillRole" class="skillRole"></textarea></td>
						<td><textarea data="skillModel" class="skillModel"></textarea></td>
						<td><textarea data="skillOS" class="skillOS"></textarea></td>
						<td><textarea data="skillLang" class="skillLang"></textarea></td>
						<td><textarea data="skillDBMS" class="skillDBMS"></textarea></td>
						<td><textarea data="skillTool" class="skillTool"></textarea></td>
						<td><textarea data="skillComm" class="skillComm"></textarea></td>
						<td><textarea data="skillETC" class="skillETC"></textarea></td>
					</tr>
				</tbody>
			</table>
			
			<div class="add-row-btn-pannel">
				<button class="add-row-btn addRowBtn" title="행 추가">+</button>
			</div>
		</div>
		
	</div>
	
	
	<div class="pop-user-register-pannel popUserRegisterPannelMinimize" id="drag-ele1">
		<span class="pop-user-register-list-span">※ 개인이력목록</span>
		<!-- 검색창 패널 -->
		<div class="pop-user-search-pannel">
			
			<input type="hidden" id="userInfoTotalCnt" autocomplete="off">
			<input type="hidden" id="userInfoPageSize" value="10" autocomplete="off">
			<input type="hidden" id="userInfoPageNo" value="1" autocomplete="off">
			
			<select id="userListSearchPeriod">
				<option value="">검색조건</option>
				<option value="userName">이름</option>
				<option value="userComp">소속회사</option>
				<option value="userDept">부서</option>
			</select>
			
			<input type="text" id="userListSearchWord" autocomplete="off">
			
			<select id="userCareerLength">
				<option value="">경력사항</option>
				<option value="1">1년이상</option>
				<option value="2">2년이상</option>
				<option value="3">3년이상</option>
				<option value="4">4년이상</option>
				<option value="5">5년이상</option>
				<option value="6">6년이상</option>
				<option value="7">7년이상</option>
				<option value="8">8년이상</option>
				<option value="9">9년이상</option>
				<option value="10">10년이상</option>
			</select>
			
			<select id="userInfoDataSize">
				<option value="10">10개씩</option>
				<option value="20">20개씩</option>
				<option value="40">40개씩</option>
			</select>
			
			<button id="userListSearchBtn" class="user-list-search-btn" title="검색"></button>
			
			<div class="search-cnt-pannel">
				<span class="search-cnt-prev">검색결과 : </span>
				<span class="search-cnt-cnt"></span>
				<span class="search-cnt-later"> 건</span>
			</div>
			
		</div>		
		
		<!-- 불러오기 최소화 버튼 -->
		<div class="pop-user-top-btn-pannel minimizeUserPannelBtn">
			<div class="pop-user-minimize-btn">
			</div>
		</div>
		<div class="pop-user-top-btn-pannel maximizeUserPannelBtn">
			<div class="pop-user-maximize-btn">
			</div>
		</div>
		
		<div class="clear-pannel"></div>
		
		<div class="keyword-add-pannel">			
			<div class="keywordInputPannel keyword-input-pannel keyword-input-pannel-invisible">#<input maxlength="16"></div>
			<!-- 개발환경 키워드 추가 버튼 -->
			<div class="pop-keyword-add-btn-pannel keywordAddPannelBtn tooltip">
				<div class="pop-user-keyword-add-btn keywordAddBtn">
				+
				</div>
				<span class="tooltiptext">진행 했던 프로젝트의 개발환경을 키워드로 추가하여 조회</span>
			</div>
		</div>
		
		<div class="pop-register-list-pannel">
		
			<table class="pop-register-list">
				<thead>
					<tr>
						<td>등록번호</td>
						<td>성명</td>
						<td>소속회사</td>
						<td>부서</td>
						<td>등록날짜</td>
					</tr>
				</thead>
				<tbody>
				</tbody>
			</table>
			
			<div class="pop-paging-pannel">
			</div>
		</div>
	</div>
	
</body>
</html>
