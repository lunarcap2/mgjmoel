<%
'============================================================
'	이력서 등록 단계별(Step) DB 정보 조회.
'
'	#최초작성일	: 2009-11-30
'	#작성자		    : 임기정(gidol@career.co.kr)
'------------------------------------------------------------
'   #참조페이지 필수인클루드 사항
'       /wwwconf/function/db/DBConnection.asp
'       /wwwconf/function/user/ResumeInfo.asp
'   #참조 페이지
'       /my(myjob)/resume/resume_step1~4.asp
'       /my(myjob)/resume/resume_reg_step1~4.asp
'   #참조 변수
'       stp : 이력서 단계
'       rid : 이력서 등록번호
'============================================================

'g_debug = true
'----------------------------------------
'   constant
'----------------------------------------
Dim svrNm	: svrNm		= Request.ServerVariables("SERVER_NAME")
Dim svrURL	: svrURL	= Request.ServerVariables("URL")
Dim mydir	: mydir		= "/my/resume_list.asp"

Dim baseChk	: baseChk	= False 
Dim rGubun	: rGubun	= request.QueryString("rGubun")

'----------------------------------------
'   chk. 이력서 단계 오류 체크
'----------------------------------------
'-- 이력서번호 유효성검사
If Len(rid) = 0 Or IsEmpty(rid) Or Not IsNumeric(rid) Or rid = "0" Then
    rid = 0
End If

'If rid = 0 And stp = 5 Then
'    '-- 5단계(수정) 이력서 번호 없음
'    ShowAlertMsg "수정할 이력서가 선택되지 않았습니다.", "location.replace('"& mydir &"');", True
'End If

'----------------------------------------
'   이력서 정보 조회
'----------------------------------------
Dim arrData
Dim iResumeCnt		: iResumeCnt	= 0
Dim iResumeCntGnb	: iResumeCntGnb = 0

	ConnectDB DBCon, Application("DBInfo_FAIR")

	'response.Write "user_id : " & user_id & "<Br>"
	'response.Write "stp : " & stp & "<Br>"
	'response.Write "rid : " & rid & "<Br>"

	If set_user_id <> "" Then
		user_id = set_user_id
	End If
	
	'If apply_resume = "Y" Then arrData = getApplyResumeStepDataNew(DBCon, Array(user_id, stp, rid), "", "") Else arrData = getResumeStepDataNew(DBCon, Array(user_id, stp, rid), "", "")
	arrData = getResumeStepDataNew(DBCon, Array(user_id, stp, rid), "", "")
	if not isArray(arrData) Then
		response.Write "<script>"
		response.Write "	alert('이력서 정보가 정확하지 않습니다. 다시 확인하시고 시도해 주시기 바랍니다.');"
		response.Write "	window.close();"
		response.Write "</script>"
		Response.End
	end if

    ' response.Write "arrData(1) : " & arrData(1) & "<Br>"
	
	if arrData(1) = "5" then	rtype = "C"

	'-- 이력서 신규등록 시 : 이력서 총 등록갯수
	If stp = 1 And rid = 0 Then iResumeCnt = getResumeRegCnt(DBCon, user_id)

	'-- 이력서 신규등록 시 : 기존에 작성중인 이력서번호
	if (stp=2 or stp=3) and stp=arrData(1) and rtype="T" then
		baseChk = true
		dim base_chk_id : base_chk_id = getBaseRidByUserID(DBCon, user_id)
		if base_chk_id = rid or base_chk_id = "" then
			baseChk = false
		else
			if base_chk_id <> "" then
				arrData = getResumeStepData(DBCon, Array(user_id, stp, base_chk_id), "", "")
				if not isArray(arrData) then	baseChk = false
			end if
		end if
	end If
	
	iResumeCntGnb = getResumeRegCntGnb(DBCon, user_id)(2,0)

DisconnectDB DBCon

'response.Write "iResumeCnt : " & iResumeCnt & "<Br>"
'response.Write "iResumeCntGnb : " & iResumeCntGnb & "<Br>"

if not isArray(arrData(0)) then
	response.Write "<script>"
	response.Write "	alert('이력서 정보가 정확하지 않습니다. 다시 확인하시고 시도해 주시기 바랍니다.');"
	response.Write "	window.close();"
	response.Write "</script>"
	Response.End
end if

'----------------------------------------
'   단계별 정보 셋팅
'----------------------------------------
Dim arrIngResume
Dim arrBase, arrUser, arrComm, arrResume
Dim arrSchool, arrCareer, arrActivity
Dim arrLanguageUse, arrLanguageExam, arrLicense, arrPrize, arrAcademy, arrAbroad
Dim arrPersonal, arrMilitary, arrEmpSupport
Dim arrPortfolio
Dim arrWorkType, arrArea, arrCtKwd, arrJcKwd
Dim arrNew_Essay

arrIngResume	= arrData(0)(0)	'작성중인 이력서번호(중간저장)
arrBase			= arrData(0)(1)	'기본이력서
arrUser			= arrData(0)(2)	'개인회원정보(이력서용)
arrComm			= arrData(0)(3)	'이력서 공통정보
arrResume		= arrData(0)(4)	'이력서1,2

arrSchool		= arrData(0)(5)	'이력서학력
arrCareer		= arrData(0)(6)	'이력서경력
arrActivity		= arrData(0)(7)	'주요활동사항(인턴,대외활동)

arrLanguageUse	= arrData(0)(8)	'외국어 회화능력
arrLanguageExam	= arrData(0)(9)	'외국어 공인시험
arrLicense		= arrData(0)(10)'자격증
arrPrize		= arrData(0)(11)'수상
arrAcademy		= arrData(0)(12)'교육
arrAbroad		= arrData(0)(13)'해외연수

arrPersonal		= arrData(0)(14)'보훈/장애
arrMilitary		= arrData(0)(15)'병역
arrEmpSupport	= arrData(0)(16)'고용지원금대상

arrPortfolio	= arrData(0)(17)'포트폴리오

arrWorkType		= arrData(0)(18)'희망근무형태
arrArea			= arrData(0)(19)'희망지역
arrCtKwd		= arrData(0)(20)'희망업종
arrJcKwd		= arrData(0)(21)'희망직종

arrNew_Essay	= arrData(0)(22)'자기소개서


%>
