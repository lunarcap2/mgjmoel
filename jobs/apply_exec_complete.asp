<%@  codepage="949" language="VBScript" %>

<%
	Option Explicit
	Session.CodePage = 949
	Response.ChaRset = "EUC-KR"


	Dim jid : jid = Request("jid")			' 채용정보등록번호
	Dim rid : rid = Request("rid")			' 이력서등록번호
	Dim applyno								' 입사지원번호
	
	'***** 올바르지 않은 접수번호
	If jid = "" or isNumeric(jid) = false Then
		response.write "<html><head></head><body><script type='text/javascript'>" & vbcrlf &_
						"	alert('공고번호가 올바르지 않습니다.');" & vbcrlf &_
						"	parent.$('div#applyWrap').css('display','none');" & vbcrlf &_
						"</script></body></html>" & vbcrlf
		response.end
	end if

	dim sqlstr, sp_name, i, arrAppData
	Dim l_title : l_title = Request.Form("input_title")					' 지원제목
	Dim l_name : l_name = Request.Form("l_name")						' 지원자명
	Dim l_year : l_year = Request("birth_year")							' 지원자 생년
	dim l_month : l_month = strfix(request.form("birth_month"),"varchar","-")
	dim l_day : l_day = strfix(request.form("birth_day"),"varchar","-")
	Dim l_tel : l_tel = Request.Form("l_tel")							' 전화번호
	dim phone1 : phone1 = request.form("phone1")						' 전화번호 (비회원)
	dim phone2 : phone2 = request.form("phone2")						' 전화번호 (비회원)
	dim phone3 : phone3 = request.form("phone3")						' 전화번호 (비회원)
	' if phone1 <> "" and phone2 <> "" and phone3 <> "" then
		l_tel = phone1 & "-" & phone2 & "-" & phone3
	' end if
	dim phone_flag : phone_flag = strfix(request.form("phone_flag"),"varchar","1")			' 전화번호 공개
	
	Dim l_year2 : l_year2 = l_year '// 2014-12-22

	l_year = right(l_year,2)
	
	Dim l_hp : l_hp = Request.Form("l_hp")								' 휴대폰번호
	dim user_cell1 : user_cell1 = request.form("user_cell1")			' 휴대폰번호 (비회원)
	dim user_cell2 : user_cell2 = request.form("user_cell2")			' 휴대폰번호 (비회원)
	dim user_cell3 : user_cell3 = request.form("user_cell3")			' 휴대폰번호 (비회원)
	if user_cell1 <> "" and user_cell2 <> "" and user_cell3 <> "" then
		l_hp = user_cell1 & "-" & user_cell2 & "-" & user_cell3
	end if
	dim user_cell_flag : user_cell_flag = strfix(request.form("user_cell_flag"),"varchar","1")	' 휴대폰번호 공개
	
	Dim l_email : l_email = request.form("l_email")						' 이메일
	dim email1 : email1 = request.form("email1")						' 이메일 (입력)
	dim email2 : email2 = request.form("email2")						' 이메일 (입력)
	if email1 <> "" and email2 <> "" then
		l_email = email1 & "@" & email2
	end if
	dim email_flag : email_flag = strfix(request.form("email_flag"),"varchar","1")			' 이메일 공개
	
	dim l_gender : l_gender = request.form("gender")					' 성별
	dim l_sex : l_sex = request.form("l_sex")							' 성별 (비회원)
	if l_gender = "" then	l_gender = l_sex
	
	dim final_school : final_school = request.form("final_school")		' 최종학력코드
	dim exp_flag : exp_flag = strfix(request.form("experience_flag"),"varchar","1")		' 경력여부
	dim exp_year : exp_year = strfix(request.form("experience_year"),"int",0)			' 경력기간 년
	dim exp_month : exp_month = strfix(request.form("experience_month"),"int",0)		' 경력기간 월
	dim addcomment : addcomment = request.form("addcomment")			' 전달내용
	if addcomment = "" then	addcomment = "-"

	dim l_company_id : l_company_id = Request.Form("company_id")
	dim l_company_name : l_company_name = Request.Form("company_name")


	'Dim fnm
	Dim guin_title : guin_title = Request.Form("guin_title")
	Dim p_salary
	Dim new_salary : new_salary = Request.Form("new_salary")	' 희망연봉
	Dim mailme : mailme = Request.Form("mailme")				' 메일발송여부 (기본 Y)
	Dim mojip : mojip = Request.Form("mojip")					' 모집분야
	dim filelist : filelist = request.form("filelist")

	dim appnomem : appnomem = request.form("appnomem")
	dim appmethod : appmethod = request.form("appmethod")
	dim appformtype : appformtype = request.form("appformtype")

	dim onlienemail_chk : onlienemail_chk  = request.Form("onlienemail_chk")
	dim rs_resumegb : rs_resumegb = "" ' 간편이력서 구분 'F' 2017-08-03 YYS
	

	'// 프로필 이력서 파일 첨부를 할것인지
	dim rq_profile_file_chk : rq_profile_file_chk = request.form("profile_file_chk")

	dim ansnum(4)	' 사전면접질의 번호
	dim answer(4)	' 사전면접질의 답 (최대 5개)
	for i=0 to 4
		ansnum(i) = request.form("ansnum_"&i)
		answer(i) = request.form("answer_"&i)	'replace(request.form("answer_"&i), "'", "''")
	next

	Dim k_month					'이력서 경력월수
	Dim e_title					'이력서 타이틀
	Dim resume_final_school		'이력서 최종학력
	Dim resume_email_addr		'이력서 전자우편
	Dim resume_address			'이력서 주소
	dim certifi					'인증
	dim resume_salary			'이력서 희망연봉코드
	
	dim l_contact : l_contact = request.form("l_contact") ' 통화가능시간

	dim use_gubun
	if mailme = "Y" then
		use_gubun = "MAILME"
	else
		use_gubun = "ONLINE"
	end If

	if not (appformtype="A" or appformtype="D") then	rid = ""
	
	if appnomem=false and user_id="" then
		response.write "<html><head></head><body><script type='text/javascript'>" & vbcrlf &_
						"	alert('회원정보가 올바르지 않습니다.\n다시 로그인해 주십시오.');" & vbcrlf &_
						"	top.goLogin(1);" & vbcrlf &_
						"</script></body></html>" & vbcrlf
		response.end
	end if

    Dim l_rGubun            '이력서구분
%>
<!--#include virtual="/common/common.asp"-->
<!--#include virtual="/wwwconf/function/db/DBConnection.asp"-->
<!--#include virtual="/wwwconf/function/common/base_util.asp"-->

<!--include virtual="/wwwconf/conf/job_site_info.asp"-->
<!--include virtual="/wwwconf2/code/code_function_resume.inc"-->
<!--include virtual="/wwwconf2/code/code_function.inc"-->
<!--include virtual="/wwwconf/code/code_function.asp"-->
<!--include virtual="/wwwconf/code/code_function_ac.asp"-->
<!--include virtual="/wwwconf/code/code_function_jc.asp"-->
<!--include virtual="/wwwconf/code/code_resume.asp"-->
<!--include virtual="/wwwconf/code/code_resume_foreign_ac.asp"-->
<!--include virtual="/wwwconf/function/resume_function.asp"-->
<!--include virtual="/wwwconf2/function/resume_function.inc"-->
<!--include virtual="/wwwconf/query_lib/user/ResumeInfo.asp"-->


<% if rid <> "" and (appformtype="A" or appformtype="D") then %>
<!--include virtual="/wwwconf/function/resume/getApplyMyResumeFileForm2014.asp"-->
<!--include virtual="/wwwconf/function/resume/getApplyMyEmailForm.asp"--> 
<!--include virtual="/wwwconf/include/user/resume/getResumeViewDBInfo2014.asp"-->

<!--include virtual="/wwwconf/function/resume/setResumeViewDataBind2014.asp"-->
<!--include virtual="/wwwconf/function/resume/getResumeEmailForm.asp"-->
<!--include virtual="/wwwconf/function/resume/getApplyCompanyOnlineForm.asp"-->
<!--include virtual="/wwwconf/function/resume/getApplyCompanyEmailForm.asp"-->
<!--include virtual="/wwwconf/function/resume/getApplyNoRegiCompanyForm.asp"--> 
<% end if %>

<!--#include virtual="/wwwconf/query_lib/user/MemberCertInfo.asp"-->

<%
	 g_debug = False


	'// 면접배정이 되었을때 입사재지원 불가능처리
	Dim strQuery, arrRsApplyCnt
	If (appformtype="A" Or appformtype="D") Then
		strQuery = ""
		strQuery = strQuery & " SELECT COUNT(A.등록번호) AS CNT"
		strQuery = strQuery & " FROM 인터넷입사지원 AS A WITH(NOLOCK)"
		strQuery = strQuery & " INNER JOIN 면접배정정보 AS B WITH(NOLOCK)"
		strQuery = strQuery & " ON A.채용정보등록번호 = B.채용등록번호"
		strQuery = strQuery & " AND A.등록번호 = B.입사지원등록번호"
		strQuery = strQuery & " WHERE 1=1"
		strQuery = strQuery & " AND A.채용정보등록번호 = ? "
		strQuery = strQuery & " AND A.개인아이디 = ? "
		strQuery = strQuery & " AND A.이력서등록번호 = ? "
		strQuery = strQuery & " AND ISNULL(삭제, '') <> '1'"

		ReDim parameter(2)
		parameter(0)	= makeParam("@채용등록번호", adInteger, adParamInput, 4, jid)
		parameter(1)	= makeParam("@개인아이디", adVarchar, adParamInput, 20, user_id)
		parameter(2)	= makeParam("@이력서번호", adInteger, adParamInput, 4, rid)
	Else
		strQuery = ""
		strQuery = strQuery & " SELECT COUNT(A.등록번호) AS CNT"
		strQuery = strQuery & " FROM 인터넷입사지원 AS A WITH(NOLOCK)"
		strQuery = strQuery & " INNER JOIN 면접배정정보 AS B WITH(NOLOCK)"
		strQuery = strQuery & " ON A.채용정보등록번호 = B.채용등록번호"
		strQuery = strQuery & " AND A.등록번호 = B.입사지원등록번호"
		strQuery = strQuery & " WHERE 1=1"
		strQuery = strQuery & " AND A.채용정보등록번호 = ? "
		strQuery = strQuery & " AND A.개인아이디 = ? "
		strQuery = strQuery & " AND A.이력서등록번호 IS NULL "
		strQuery = strQuery & " AND ISNULL(삭제, '') <> '1'"

		ReDim parameter(1)
		parameter(0)	= makeParam("@채용등록번호", adInteger, adParamInput, 4, jid)
		parameter(1)	= makeParam("@개인아이디", adVarchar, adParamInput, 20, user_id)
	End If

	ConnectDB dbCon, Application("DBInfo_FAIR")
	arrRsApplyCnt = arrGetRsParam(dbCon, strQuery, parameter, "", "")(0, 0)
	DisconnectDB dbCon

	If CInt(arrRsApplyCnt) > 0 Then 
		Response.write "<script>alert('해당공고의 면접배정이 이미 완료되어 재지원 할 수 없습니다.'); history.back();</script>"
		Response.End 
	End If 


	'// 
	'// 2015-05-11
	'// 등록서비스 27, 회사아이디 = '' 수급공고 기준 추가
	'// 
	dim com_name, job_title, job_close_type, job_close_date, job_source, job_id, job_reg_services
	Dim r_upfile_name, r_upfile_url, r_savefile_name
	sqlstr = "select a.회사명, a.모집내용제목, a.접수마감종류, a.접수마감일, b.등록출처, a.회사아이디, a.등록서비스 from 채용정보 a left outer join 채용정보2  b on a.등록번호 = b.등록번호 where a.등록번호 = ?"
	
	ConnectDB dbCon, Application("DBInfo_FAIR")
	redim parameter(0)
	parameter(0) = makeParam("@등록번호", adInteger, adParamInput, 4, jid)
	arrAppData = arrGetRsParam(dbCon, sqlstr, parameter, "", "")
	DisconnectDB dbCon

	if isArray(arrAppData) then
		com_name = arrAppData(0,0)
		job_title = arrAppData(1,0)
		job_close_type = arrAppData(2,0)
		job_close_date = arrAppData(3,0)
        job_source = arrAppData(4,0)
        job_id = arrAppData(5,0)
        job_reg_services = arrAppData(6,0)		'// 2015-05-11 등록서비스 27, 회사아이디 = '' 수급공고 기준 추가

		com_name = replace(com_name, "(주)", "㈜")
		If job_reg_services = "27" And job_id = "" Then '//27=수급공고(사람인) '//22= W : 기업공고 A : 관리자입력공고
			job_source = "2" '수급공고
		Else
			If job_source <> "관리자" Then	'// 2016-09-12 관리자 공고 추가
				job_source = "1" '진성공고
			End If
		End If

	Else
		Response.write "<script>alert('해당공고가 마감되었거나 존재하지 않는 공고입니다.'); history.back();</script>"
		Response.End 
	end if
	


	Dim toeic, toefl, teps, jpt
	' 커리어양식일 경우
	if rid <> "" and user_id <> "" and (appformtype="A" or appformtype="D") then
		ConnectDB dbCon, Application("DBInfo_FAIR")
		
		' 이력서공통정보에 반영
		sqlstr = "update 이력서공통정보 set 전화번호 = ?, 전화번호공개 = ?, 휴대폰 = ?, 휴대폰공개 = ?, 전자우편 = ?, 전자우편공개 = ? where 개인아이디 = ?"
		redim parameter(6)
		parameter(0) = makeParam("@전화번호", adVarchar, adParamInput, 20, l_tel)
		parameter(1) = makeParam("@전화번호공개", adChar, adParamInput, 1, phone_flag)
		parameter(2) = makeParam("@휴대폰", adVarchar, adParamInput, 20, l_hp)
		parameter(3) = makeParam("@휴대폰공개", adChar, adParamInput, 1, user_cell_flag)
		parameter(4) = makeParam("@전자우편", adVarchar, adParamInput, 50, l_email)
		parameter(5) = makeParam("@전자우편공개", adChar, adParamInput, 1, email_flag)
		parameter(6) = makeParam("@개인아이디", adVarchar, adParamInput, 20, user_id)
		
		call execSqlParam(dbCon, sqlstr, parameter, "", "")

		
		Dim sqlstr_f, arrAppData_f
		sqlstr_f = "SELECT ISNULL(이력서구분,'') from 이력서 where 등록번호 = ? and 단계 = '5' and 개인아이디 = ?"
		redim parameter_f(1)
		parameter_f(0) = makeParam("@등록번호", adInteger, adParamInput, 4, rid)
		parameter_f(1) = makeParam("@개인아이디", adVarchar, adParamInput, 20, user_id)
		arrAppData_f = arrGetRsParam(dbCon, sqlstr_f, parameter_f, "", "")

		if isArray(arrAppData_f) then
			rs_resumegb = arrAppData_f(0,0)
		End If

	' 커리어양식 아닐 경우 회원정보 조회
	elseif user_id <> "" and appformtype <> "A" and appformtype <> "D" then	
		sqlstr = "select isnull(a.최종학력코드,b.최종학력코드), isnull(b.경력코드,'1'), isnull(b.경력월수,0), b.희망연봉코드, a.주민번호년, a.주민번호월, a.주민번호일, b.이력서구분 from 개인회원정보 a (nolock) left outer join 이력서 b (nolock) on a.개인아이디 = b.개인아이디 and b.기본이력서 = '1' where a.개인아이디 = ?"
		ConnectDB dbCon, Application("DBInfo_FAIR")
		redim parameter(0)
		parameter(0) = makeParam("@개인아이디", adVarChar, adParamInput, 20, user_id)
		arrAppData = arrGetRsParam(dbCon, sqlstr, parameter, "", "")
		
		if isArray(arrAppData) then
			if l_year = "" then	l_year = arrAppData(4,0)
			if l_month = "" then	l_month = arrAppData(5,0)
			if l_day = "" then	l_day = arrAppData(6,0)
            if l_rGubun = "" then	l_rGubun = arrAppData(7,0)
		end if
	end if


	if l_year = "" then
		Response.write "<script>alert('개인정보 중 생년정보가 기재되지 않았거나 바르지 않습니다.\n\n생년정보를 입력 후 다시 시도해 주십시오.'); history.back();</script>"
		Response.End 
	end If
	
    Function getAge(yyyy)
        If IsNumeric(yyyy) And yyyy <> "" Then
            getAge = (Year(Date()) - yyyy)+1
        Else
            getAge = "-"
        End If
    End Function

	' 실제 입사지원 저장
	'***** 폼에서 받은 값처리
	dim mail_title,mail_fromer,charge_email,company_id,company_name
	charge_email=Request.Form("charge_email")
	company_id=Request.Form("company_id")
	company_name=replace(Request.Form("company_name"),"(주)","㈜")

	if charge_email <> "" then
		dim arrmail
		arrmail = split(charge_email, ";")

		if ubound(arrmail,1) = 0 then
			if ubound(split(charge_email, "@")) > 1 then
				Response.write "<script>alert('잘못된 메일 정보 입니다.'); history.back();</script>"
				Response.End 
			end if
		else
			if ubound(split(arrmail(0), "@")) > 1 or ubound(split(arrmail(1), "@")) > 1 Then
				Response.write "<script>alert('잘못된 메일 정보 입니다.'); history.back();</script>"
				Response.End 
			end if
		end If
	Else 
		charge_email = "expo@career.co.kr"	'2016-01-09 채용담당자 메일 없을경우 추가 (채용공고 등록 담당자 이메일 필수값)
	end if
	
	dim usrid : usrid = user_id
	if usrid = "" then	usrid = "unknown"	' 비회원
	
	Dim age : age = getAge(l_year2)

	dim aplcode : aplcode = "1"
	'if instrrev("DEF",appformtype) > 0 then	aplcode = "2"

	'// 
	'// 2015-06-10
	'// tab 클릭하면 온라인입사지원으로 접수방법코드가 변경되어 파라미터 추가
	'// 

	If onlienemail_chk = "A" Then '// 온라인
		aplcode = "1"
	Else
		aplcode = "2" '// 이메일
	End If 
	
	' response.write "usrid=" & usrid & "<br/>"
	' response.write "new_salary=" & new_salary & "<br/>"
	' response.write "exp_flag=" & exp_flag & "<br/>"
	' response.write "final_school=" & final_school & "<br/>"
	' response.write "l_gender=" & l_gender & "<br/>"
	' response.write "age=" & age & "<br/>"
	 
	' response.write "company_id=" & company_id & "<br/>"
	' response.write "appformtype=" & appformtype & "<br/>"
	' response.write "l_name=" & l_name & "<br/>"
	' response.write "l_email=" & l_email & "<br/>"
	' response.write "l_tel=" & l_tel & "<br/>"
	' response.write "l_hp=" & l_hp & "<br/>"
	' response.write "exp_months=" & (strfix(exp_year,"int",0) * 12 + strfix(exp_month,"int",0)) & "<br/>"
	' response.write "l_month=" & l_month & "<br/>"
	' response.write "l_day=" & l_day & "<br/>"
	' response.write "l_title=" & l_title & "<br/>"


	'/// 도배지원 금지 추가 2017-01-24 : 1분내 등록번호, 아이디 같은 지원 있을시 경고창과 돌려보냄 (usrid, jid)
	Dim no_reinsert
	no_reinsert = "1"

	sp_name = "USP_APPLY_CHECK_HIST" '프로시저 변경: 채용담당자 이메일 추가 2017-01-06
	redim parameter(2)  
	parameter(0) = makeParam("@param1", adVarChar, adParamInput, 20, usrid)
	parameter(1) = makeParam("@param2", adInteger, adParamInput,4, jid)
	parameter(2) = makeParam("@RTN", adInteger, adParamOutput, 4, 0)

	Call execSP(dbCon, sp_name, parameter, "", "")
	no_reinsert = getParamOutputValue(parameter, "@RTN")	' 1: 돌려보냄, 0: 계속진행

	If no_reinsert = "1" Then 
		Response.write "<script>alert('이미 지원한 채용공고 입니다.\n해당공고에 재지원을 희망할 원하시면 1분 후 재지원 하시기 바랍니다.'); history.back();</script>"
		Response.End 
	End If


	Dim apply_no, arrApplyNoData, arrApplyNoData2

	'response.write "<bR>debug:"&jpt
	'response.End

	
	'Response.write "usrid : " & usrid & "<br>"
	'Response.write "jid : " & jid & "<br>"
	'Response.write "rid : " & rid & "<br>"
	'Response.write "company_name : " & company_name & "<br>"
	'Response.write "new_salary : " & new_salary & "<br>"
	'Response.write "experience_flag : <br>"
	'Response.write "final_school : " & final_school & "<br>"
	'Response.write "l_gender : " & l_gender & "<br>"
	'Response.write "age : " & age & "<br>"
	'Response.write "toeic : " & toeic & "<br>"
	'Response.write "toefl : " & toefl & "<br>"
	'Response.write "teps : " & teps & "<br>"
	'Response.write "jpt : " & jpt & "<br>"
	'Response.write "company_id : " & company_id & "<br>"
	'Response.write "guin_title : " & guin_title & "<br>"
	'Response.write "aplcode : " & aplcode & "<br>"
	'Response.write "mojip : " & mojip & "<br>"

	'Response.write "appformtype : " & appformtype & "<br>"
	'Response.write "l_name : " & l_name & "<br>"
	'Response.write "l_email : " & l_email & "<br>"
	'Response.write "email_flag : " & email_flag & "<br>"
	'Response.write "l_tel : " & l_tel & "<br>"
	'Response.write "phone_flag : " & phone_flag & "<br>"
	'Response.write "l_hp : " & l_hp & "<br>"
	'Response.write "user_cell_flag : " & user_cell_flag & "<br>"
	'Response.write "zipcode : <br>"
	'Response.write "address : <br>"
	'Response.write "address_opn : 0 <br>"
	'Response.write "usrid : " & usrid & "<br>"
	'Response.write "exp_months : " & (strfix(exp_year,"int",0) * 12 + strfix(exp_month,"int",0)) & "<br>"
	'Response.write "l_year : " & right(l_year,2) & "<br>"
	'Response.write "l_month : " & l_month & "<br>"
	'Response.write "l_day : " & l_day & "<br>"
	'Response.write "l_title : " & l_title & "<br>"
	'Response.write "charge_email : " & charge_email & "<br>"



'	sp_name = "인터넷입사지원정보입력3"
	sp_name = "USP_APPLY_HIST_INSERT" '프로시저 변경: 채용담당자 이메일 추가 2017-01-06
	redim parameter(35)  
	parameter(0) = makeParam("RETURN_VALUE", adInteger, adParamReturnValue, 4, 0)
	parameter(1) = makeParam("@param1", adVarChar, adParamInput, 20, usrid)
	parameter(2) = makeParam("@param2", adInteger, adParamInput,4, jid)
	parameter(3) = makeParam("@param3", adInteger, adParamInput,4, rid)
	parameter(4) = makeParam("@param4", adVarChar, adParamInput, 50, company_name)
	parameter(5) = makeParam("@param5", adVarChar, adParamInput, 2, new_salary)
	parameter(6) = makeParam("@param6", adVarChar, adParamInput, 10, " ")
	parameter(7) = makeParam("@param7", adChar, adParamInput, 1, exp_flag)
	parameter(8) = makeParam("@param8", adVarChar, adParamInput, 2, final_school)
	parameter(9) = makeParam("@param9", adChar, adParamInput, 1, l_gender)
	parameter(10) = makeParam("@param10", adVarChar, adParamInput, 2, age)
	parameter(11) = makeParam("@param11", adVarChar, adParamInput, 4, toeic)
	parameter(12) = makeParam("@param12", adVarChar, adParamInput, 4, toefl)
	parameter(13) = makeParam("@param13", adVarChar, adParamInput, 4, teps)
	parameter(14) = makeParam("@param14", adVarChar, adParamInput, 4, jpt)
	parameter(15) = makeParam("@param15", adVarChar, adParamInput, 20, company_id)
	parameter(16) = makeParam("@param16", adVarChar, adParamInput, 100, guin_title)
	parameter(17) = makeParam("@param17", adChar, adParamInput, 1, aplcode)
	parameter(18) = makeParam("@param18", adInteger, adParamInput, 0, mojip)

	' 추가 파라미터 (201201, 입사지원 개편)
	parameter(19) = makeParam("@apltype", adChar, adParamInput, 1, appformtype)
	parameter(20) = makeParam("@user_name", adVarchar, adParamInput, 20, l_name)
	parameter(21) = makeParam("@email", adVarchar, adParamInput, 50, l_email)
	parameter(22) = makeParam("@email_opn", adChar, adParamInput, 1, email_flag)
	parameter(23) = makeParam("@phone", adVarchar, adParamInput, 20, l_tel)
	parameter(24) = makeParam("@phone_opn", adChar, adParamInput, 1, phone_flag)
	parameter(25) = makeParam("@mobile", adVarchar, adParamInput, 20, l_hp)
	parameter(26) = makeParam("@mobile_opn", adChar, adParamInput, 1, user_cell_flag)
	parameter(27) = makeParam("@zipcode", adVarchar, adParamInput, 7, " ")
	parameter(28) = makeParam("@address", adVarchar, adParamInput, 100, " ")
	parameter(29) = makeParam("@address_opn", adChar, adParamInput, 1, "0")
	parameter(30) = makeParam("@exp_months", adInteger, adParamInput, 4, (strfix(exp_year,"int",0) * 12 + strfix(exp_month,"int",0)))
	parameter(31) = makeParam("@birthYY", adVarchar, adParamInput, 4, right(l_year,2))
	parameter(32) = makeParam("@birthMM", adVarchar, adParamInput, 2, l_month)
	parameter(33) = makeParam("@birthDD", adVarchar, adParamInput, 2, l_day)
	parameter(34) = makeParam("@l_title", adVarchar, adParamInput, 250, l_title)
	parameter(35) = makeParam("@applyemail", adVarchar, adParamInput, 100, charge_email) '채용담당자 이메일 추가 2017-01-06
	

	Call execSP(dbCon, sp_name, parameter, "", "")
	apply_no = getParamOutputValue(parameter, "RETURN_VALUE")	' 사이버채용정보 등록번호

	'입사지원 이력서 생성 (2021-02-05 추가)
	ReDim parameter(2)
	parameter(0) = makeParam("@USER_ID", adVarChar, adParamInput, 20, user_id)
	parameter(1) = makeParam("@RESUME_NO", adVarChar, adParamInput, 4, rid)
	parameter(2) = makeParam("@APPLY_NO", adInteger, adParamInput, 4, apply_no)
	
	sp_name = "USP_입사지원_이력서_등록"
	Call execSP(dbCon, sp_name, parameter, "", "")


	'첨부파일 셋팅 함수
	Function setMailFileAttach(objMail, arrFile)

		Dim ii
		Dim fRealFileName, fUpFileName, fGubun, fRealUpFileName
		Dim execSqlStmt : execSqlStmt = ""

		execSqlStmt = ""

		'fRealFileName = ATTACH_FILE_PATH & arrFile(0) &"\"& arrFile(1)
		'fRealUpFileName = ATTACH_FILE_PATH & arrFile(0) &"\"& arrFile(2)
		fUpFileName = arrFile(2)
		fGubun = arrFile(4)

		'이메일 파일첨부
		'objMail.AddAttachment fRealFileName, fUpFileName

		'파일다운로드를 위한 실행쿼리 담기
		execSqlStmt = execSqlStmt & "Insert into 인터넷입사지원파일첨부 (지원번호, 채용등록번호, 이력서등록번호, 일련번호, 개인아이디, 업파일명, 업파일경로, 실파일명, 구분, 등록일, 파일크기) " &_
									" select '"&apply_no&"', '"&jid&"', '"&strfix(rid,"int",0)&"', (SELECT ISNULL(MAX(일련번호+1), 1) FROM 인터넷입사지원파일첨부 (nolock) WHERE (지원번호 = '"& apply_no &"'))" &_
									", '"& user_id &"', '"& arrFile(1) &"', '"& arrFile(0) &"', '"& fUpFileName &"', '" & fGubun & "', getdate(), '" & arrFile(3) & "'; "

		'execSqlStmt = execSqlStmt & " if not EXISTS (select 실파일명 FROM  파일저장서비스 with(nolock) where  업파일명='"& arrFile(1) &"' and 개인아이디='"& user_id &"') begin Insert into 파일저장서비스 (개인아이디, 구분, 순차번호, 제목, 업파일명, 업파일경로, 실파일명, 파일사이즈, 등록일) " &_
		'							" select '"& user_id &"', '" & fGubun & "', (SELECT ISNULL(MAX(순차번호+1), 1) FROM 파일저장서비스 (nolock) WHERE (개인아이디 = '"& user_id &"'))" &_
		'							", '1', '"& arrFile(1) &"', '"& arrFile(0) &"', '"& fUpFileName &"', '" & arrFile(3) & "', getdate() ; end "

		setMailFileAttach = execSqlStmt

	End Function

	
	'파일첨부
	dim arrfilelist1, arrfilelist2, strsql_in
	if filelist <> "" then
		strsql_in = ""
		arrfilelist1 = split(filelist,":")
		for i = 0 to ubound(arrfilelist1)

			arrfilelist2 = split(arrfilelist1(i),"|") '// 201412|1412159211074.gif|캡처.GIF|113192|C
			if isArray(arrfilelist2) then
				strsql_in = strsql_in & setMailFileAttach("", arrfilelist2)
			end if
		Next
	end If
	
	if strsql_in <> "" Then
		call execSql(dbCon, strsql_in, "", "")
	end If


	dim errcnt : errcnt = dbCon.Errors.Count
	DisconnectDB dbCon
	
	If errcnt = "0" Then
		' 이름블러처리
		Dim marking
		For i=1 To Fix(Len(l_name)-1)
			marking = marking & "*"
		Next

		' 나이셋팅
		Dim birth_age
		If l_gender = "1" Or l_gender = "2" Then 
			birth_age = Left(Date(), 4) - l_year2 + 1
		ElseIf l_gender = "3" Or l_gender = "4" Then 
			birth_age = Left(Date(), 4) - l_year2 + 1
		End If

		' 최종학력셋팅
		ConnectDB dbCon, Application("DBInfo_FAIR")
		Dim arrRsSchool
		sqlstr = " SELECT 학교명, 전공명, 졸업구분 FROM 이력서학력 WHERE 등록번호 = '" & rid & "' AND 학력종류 = '" & final_school & "' "
		arrRsSchool = arrGetRsParam(dbCon, sqlstr, "", "", "")
		
		Dim SchoolNM, DepartmentNM, GraduatedState
		If isArray(arrRsSchool) Then
			schoolNM = arrRsSchool(0,0)
			DepartmentNM = arrRsSchool(1,0)
			Select Case arrRsSchool(2,0)
				Case "3" : GraduatedState = "재학"
				Case "4" : GraduatedState = "휴학"
				Case "5" : GraduatedState = "중퇴"
				Case "7" : GraduatedState = "졸업(예)"
				Case "8" : GraduatedState = "졸업"
			End Select
		End If
		DisconnectDB dbCon

		' 신입/경력구분
		Dim strCareer
		If (strfix(exp_year,"int",0) * 12 + strfix(exp_month,"int",0)) > 0 Then
			strCareer = "경력"
		Else
			strCareer = "신입"
		End If

		Dim mailForm, iConf, mailer
		mailForm = "<html>"&_
					"<head>"&_
						"<title>"& site_name &"</title>"&_
						"<meta content=""text/html; charset=euc-kr"" http-equiv=""Content-Type"" />"&_
						"<meta http-equiv=""X-UA-Compatible"" content=""IE=Edge"">"&_
					"</head>"&_
					"<body style=""text-align: center; padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; font-family: Dotum, '돋움', Times New Roman, sans-serif; background: #ffffff; color: #666; font-size: 12px; padding-top: 0px"">"&_
						"<table border=""0"" cellspacing=""0"" cellpadding=""0"" align=""center"" style=""width:738px;border:solid 1px #e4e4e4; border-top:0 none; border-bottom:0 none;table-layout: fixed;"">"&_
							"<colgroup>"&_
								"<col style=""width:20px;"">"&_
								"<col style=""width:699px;"">"&_
								"<col style=""width:20px;"">"&_
							"</colgroup>"&_
							"<tbody>"&_
								"<tr>"&_
									"<td style=""width:20px;""></td>"&_
									"<td style=""width:698px;padding:20px 0;border-collapse: inherit;background:#f0f0f0;border:1px dashed #c10e2c;text-align:center;"">"&_
										"<p style=""font-size:20px;line-height:1.8;letter-spacing: -1px;color:#000;"">"&_
											"안녕하세요. <strong>채용담당자</strong>님<br>"&_
											"<strong>진행중인 채용공고에 지원자가 지원했습니다.</strong><br>"&_
											"지금 바로 지원자의 이력서를 확인해 주세요."&_
										"</p>"&_
										"<table border=""0"" cellspacing=""0"" cellpadding=""0"" align=""center"" style=""width:100%;"">"&_
											"<colgroup>"&_
												"<col style=""width:32%;"">"&_
												"<col style=""width:68%;"">"&_
											"</colgroup>"&_
											"<tbody>"&_
												"<tr>"&_
													"<th style=""width:32%;padding:10px 10px 10px 0;vertical-align:top;text-align:right;font-size:17px;"">채용공고문</th>"&_
													"<td style=""width:68%;padding:10px 0 10px 10px;vertical-align:top;text-align:left;font-size:17px;"">" & job_title & "</td>"&_
												"</tr>"&_
												"<tr>"&_
													"<th style=""width:32%;padding:10px 10px 10px 0;vertical-align:top;text-align:right;font-size:17px;"">이름</th>"&_
													"<td style=""width:68%;padding:10px 0 10px 10px;vertical-align:top;text-align:left;font-size:17px;"">" & Left(l_name,1) & marking & "(" & l_year2 & "년생/" & birth_age & "세)" & "</td>"&_
												"</tr>"&_
												"<tr>"&_
													"<th style=""width:32%;padding:10px 10px 10px 0;vertical-align:top;text-align:right;font-size:17px;"">지원일</th>"&_
													"<td style=""width:68%;padding:10px 0 10px 10px;vertical-align:top;text-align:left;font-size:17px;"">" & Left(Date(), 10) & "</td>"&_
												"</tr>"&_
												"<tr>"&_
													"<th style=""width:32%;padding:10px 10px 10px 0;vertical-align:top;text-align:right;font-size:17px;"">최종학력</th>"&_
													"<td style=""width:68%;padding:10px 0 10px 10px;vertical-align:top;text-align:left;font-size:17px;"">" & SchoolNM & "&nbsp;" & DepartmentNM & "&nbsp;" & GraduatedState & "</td>"&_
												"</tr>"&_
												"<tr>"&_
													"<th style=""width:32%;padding:10px 10px 10px 0;vertical-align:top;text-align:right;font-size:17px;"">경력</th>"&_
													"<td style=""width:68%;padding:10px 0 10px 10px;vertical-align:top;text-align:left;font-size:17px;"">" & strCareer & "</td>"&_
												"</tr>"&_
												"<tr>"&_
													"<td colspan=""2"" style=""padding:10px 10px 10px 10px;text-align:center;"">"&_
														"<a href=""" & g_partner_wk & "/company/applyjob/apply.asp?jid=" & jid &"&pid=0"" target=""_blank"">"&_
															"<img border=""0"" alt=""지원자 이력서 열람"" src=""http://image.career.co.kr/career_new/event/2020/starfield/open_btn.jpg"">"&_
														"</a>"&_
													"</td>"&_
												"</tr>"&_
											"</tbody>"&_
										"</table>"&_
									"</td>"&_
									"<td style=""width:20px;""></td>"&_
								"</tr>"&_
							"</tbody>"&_
						"</table>"&_
					"</body>"&_
					"</html>"

		Set mailer	= Server.CreateObject("CDO.Message")
		Set iConf	= mailer.Configuration
		With iConf.Fields
		.item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 1
		.item("http://schemas.microsoft.com/cdo/configuration/smtpserverpickupdirectory") = "C:\inetpub\mailroot\Pickup"
		.item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "127.0.0.1"
		.item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 10
		.update
		End With 

		mailer.From = "expo@career.co.kr"
		mailer.To	= charge_email
		mailer.Subject	= "["&site_name&"] 진행중인 공고에 지원자가 지원했습니다."
		mailer.HTMLBody	= mailForm
		mailer.BodyPart.Charset="ks_c_5601-1987"
		mailer.HTMLBodyPart.Charset="ks_c_5601-1987"
		mailer.Send
		Set mailer = Nothing 

		Response.write "<script>alert('입사지원이 완료되었습니다.'); location.replace('/jobs/view.asp?id_num="&jid&"');</script>"
		Response.End 

	End If


%>