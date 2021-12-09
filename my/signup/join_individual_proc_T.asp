<!--#include virtual="/wwwconf/function/db/DBConnection.asp"-->
<!--#include virtual="/common/common.asp"-->
<!--#include virtual="/wwwconf/function/library/KISA_SHA256.asp"-->
<%
'--------------------------------------------------------------------
'   Comment		: 개인회원 가입
' 	History		: 
'---------------------------------------------------------------------
Session.CodePage  = 949			'한글
Response.CharSet  = "euc-kr"	'한글
Response.AddHeader "Pragma","no-cache"
Response.AddHeader "cache-control", "no-staff"
Response.Expires  = -1


Response.AddHeader "P3P", "CP='ALL CURa ADMa DEVa TAIa OUR BUS IND PHY ONL UNI PUR FIN COM NAV INT DEM CNT STA POL HEA PRE LOC OTC'"

Dim txtId, txtPass, txtName, txtEmail, chkAgrMail, txtPhone, chkAgrSms, compId, encPass, len_txtPhone, strPhone

txtId		= RTrim(LTrim(Replace(Request("txtId"), "'", "''")))				' 아이디
txtPass		= RTrim(LTrim(Replace(Request("txtPass"), "'", "''")))			' 비밀번호	
txtName		= RTrim(LTrim(Replace(Replace(Request("txtName"), "'", "''"), " ", "")))	' 이름
txtEmail	= RTrim(LTrim(LCase(Replace(Request("txtEmail"), " ", ""))))	' 이메일
chkAgrMail	= Request("chkAgrMail")	' 홍보성 메일 수신 동의
txtPhone	= Request("txtPhone")	' 휴대폰번호
chkAgrSms	= Request("chkAgrSms")	' 홍보성 문자 수신 동의

' 연락처에 하이픈 누락된 경우 강제 설정
If InStr(txtPhone,"-")=0 Then 
	len_txtPhone	= Len(txtPhone)
	strPhone		= Left(txtPhone,3)&"-"&Mid(txtPhone,4,len_txtPhone-7)&"-"&Right(txtPhone,4)
Else 
	strPhone		= txtPhone
End If

If Len(strPhone) > 13 Then
	Response.write "<script>"
	Response.write "alert('다시 시도해 주세요.');"
	Response.write "location.href='/my/signup/join.asp';"
	Response.write "</script>"
	Response.end
End If


'2021.05.17 회원가입 추가
Dim txtBirth, gender, selFinalSchType
Dim strBirthYY, strBirthMM, strBirthDD
txtBirth		= Request("txtBirth")
gender			= Request("gender")
selFinalSchType	= Request("sel_finalSchType")

strBirthYY	= Mid(txtBirth,3,2)
strBirthMM	= Mid(txtBirth,5,2)
strBirthDD	= Right(txtBirth,2)


'전역예정장병 입력 정보-S
Dim military_personnel_corps, military_personnel_number, military_group, military_corps, military_rank, military_number, military_end_date
Dim str_military_corps
Dim hopeArea,hopeCheck

military_personnel_corps	= Cstr(Trim(Request("military_personnel_corps")))
military_personnel_number	= Cstr(Trim(Request("military_personnel_number")))
military_group				= Cstr(Trim(Request("military_group")))
military_corps				= Cstr(Trim(Request("military_corps")))
military_rank				= Cstr(Trim(Request("military_rank")))
military_number				= Cstr(Trim(Request("military_number")))
military_end_date			= Cstr(Trim(Request("military_end_date")))

'소속부대명 셋팅
If military_personnel_corps <> "" Then
	'군무원일경우
	str_military_corps = military_personnel_corps
ElseIf military_corps <> "" Then
	'군무원이 아닐경우
	str_military_corps = military_corps
End If
'전역예정장병 입력 정보-E

'희망지역, 취업상담 희망여부
hopeArea	= Cstr(Trim(Request("hope_area")))
hopeCheck	= Cstr(Trim(Request("hopeCheck")))
'전역예정장병 입력 정보-E

Response.write str_military_corps & "<br>"
Response.write hopeArea & "<br>"
Response.write hopeCheck & "<br>"
Response.end


' 정상적인 경로로 이동하지 않은 경우 회원가입 화면으로 리턴
If Trim(txtId) = "" Or Trim(txtPass) = "" Then Response.Write "<meta http-equiv='refresh' content='0; url=http://" & Request.ServerVariables("SERVER_NAME") & "/my/signup/join.asp'>"


compId	= txtId&"_wk"				' 개인회원아이디+"_wk" 조합		
encPass = SHA256_Encrypt(txtPass)	' 비번 암호화(sha256 방식)


ConnectDB DBCon, Application("DBInfo_FAIR")

'군무원정보
Dim strSql, arrRs
If military_personnel_corps <> "" Then
	strSql = "SELECT 직급, 구분코드 FROM 군무원명단 WHERE 이름 = '" & txtName & "' AND 순번 = '" & military_personnel_number & "' AND 연락처 = '" & strPhone & "'"
	arrRs = arrGetRsSql(DBCon, strSql, "", "")

	If isArray(arrRs) Then
		military_rank	= arrRs(0,0)
		military_group	= arrRs(1,0)
	End If
End If


' 입력 아이디 중복 체크
SpName="usp_ID_CheckAll"
	Dim chkparam(1)
	chkparam(0)=makeParam("@user_id", adVarChar, adParamInput, 20, compId)
	chkparam(1)=makeParam("@rtn", adChar, adParamOutput, 1, "")

	Call execSP(DBCon, SpName, chkparam, "", "")

	rsltCmt = getParamOutputValue(chkparam, "@rtn")


If rsltCmt = "O" Then ' 입력한 아이디로 기존 가입된 정보가 없으면 회원 가입
	
	DBCon.BeginTrans() '트랜잭션 시작
	
		Dim sp_rtn, sp_rtn2

		'dbo.개인회원정보 insert
		ReDim param(13)
		param(0)	= makeParam("@개인아이디"			, adVarChar	, adParamInput	, 20	, compId)
		param(1)	= makeParam("@암호화_비밀번호"		, adVarChar	, adParamInput	, 100	, encPass)
		param(2)	= makeParam("@성명"				, adVarChar	, adParamInput	, 30	, txtName)
		param(3)	= makeParam("@전자우편"			, adVarChar	, adParamInput	, 100	, txtEmail)
		param(4)	= makeParam("@휴대폰"				, adVarChar	, adParamInput	, 20	, strPhone)
		param(5)	= makeParam("@메일수신여부"		, adChar	, adParamInput	, 1		, chkAgrMail)
		param(6)	= makeParam("@SMS수신"			, adChar	, adParamInput	, 1		, chkAgrSms)
		param(7)	= makeParam("@사이트구분"			, adChar	, adParamInput	, 2		, "W")
		param(8)	= makeParam("@가입사이트구분코드"	, adVarChar	, adParamInput	, 2		, "1")
		param(9)	= makeParam("@주민번호년"			, adChar	, adParamInput	, 2		, strBirthYY)
		param(10)	= makeParam("@주민번호월"			, adChar	, adParamInput	, 2		, strBirthMM)
		param(11)	= makeParam("@주민번호일"			, adChar	, adParamInput	, 2		, strBirthDD)
		param(12)	= makeParam("@주민번호성별"		, adChar	, adParamInput	, 1		, gender)
		param(13)	= makeParam("@rtn"				, adChar	, adParamOutput	, 1		, "X")		

		Call execSP(DBCon, "usp_회원가입_개인_암호화", param, "", "")
		sp_rtn = getParamOutputValue(param, "@rtn")
		
		'dbo.사용자정보 insert
		ReDim param(14)
		param(0)	= makeParam("@userID"				, adVarChar	, adParamInput	, 40	, compId)
		param(1)	= makeParam("@userPW"				, adVarChar	, adParamInput	, 200	, encPass)
		param(2)	= makeParam("@userName"				, adVarChar	, adParamInput	, 60	, txtName)
		param(3)	= makeParam("@userHp"				, adVarChar	, adParamInput	, 15	, strPhone)
		param(4)	= makeParam("@userEmail"			, adVarChar	, adParamInput	, 200	, txtEmail)		
		param(5)	= makeParam("@SType"				, adChar	, adParamInput	, 1		, military_group)
		param(6)	= makeParam("@cName"				, adVarChar	, adParamInput	, 200	, str_military_corps)
		param(7)	= makeParam("@SNum"					, adVarChar	, adParamInput	, 20	, military_number)
		param(8)	= makeParam("@SRank"				, adVarChar	, adParamInput	, 20	, military_rank)
		param(9)	= makeParam("@StYearE"				, adVarChar	, adParamInput	, 20	, military_end_date)
		param(10)	= makeParam("@militaryPersonnelNum"	, adVarChar	, adParamInput	, 20	, military_personnel_number)
		param(11)	= makeParam("@finalSchType"			, adVarChar	, adParamInput	, 1		, selFinalSchType)
		param(12)	= makeParam("@hopeArea"				, adChar	, adParamInput	, 8		, hopeArea)
		param(13)	= makeParam("@hopeCheck"			, adVarChar	, adParamInput	, 1		, hopeCheck)
		param(14)	= makeParam("@rtn"					, adChar	, adParamOutput	, 1		, "0")

		Call execSP(DBCon, "usp_moti_school_member_insert", param, "", "")
		sp_rtn2 = getParamOutputValue(param, "@rtn")

		
		If sp_rtn = "X" Or sp_rtn2 = "0" Then	'에러가 있을 경우
			DBCon.rollbacktrans() '트랜잭션 취소

			Response.write "<script type='text/javascript'>"
			Response.write "alert('입력하신 휴대폰 번호로 가입된 아이디가 존재합니다.');"
			Response.write "location.href='/my/signup/join.asp';"
			Response.write "</script>"
			Response.end
		Else
			DBCon.commitTrans() '트랜잭션 실행

			'#### 유입 경로 저장
			Dim strSql2, strRemoteAddr, strUserAgent
			strRemoteAddr	= Request.ServerVariables("REMOTE_ADDR")
			strUserAgent	= Request.ServerVariables("HTTP_USER_AGENT")	
			strSql2 = "INSERT INTO LOG_회원가입환경정보(회원아이디, 가입아이피, 가입환경) VALUES('"&compId&"', '"&strRemoteAddr&"', '"&strUserAgent&"')"
			DBCon.Execute(strSql2)

			'#### 로그인 LOG - 2020.12.30
			Dim strSql3
			strSql3 = " INSERT INTO LOG_로그인접속정보(구분, 접속아이디, 접속IP, 접속경로) VALUES('개인', '"&compId&"', '"&strRemoteAddr&"', '"&strUserAgent&"') "
			DBCon.Execute(strSql3)

			'#### 회원가입 완료 메일 전송
			Dim strSql4, arrRsView, mailForm
			strSql4 = "SELECT 개인아이디, 등록일 FROM 개인회원정보 WITH(NOLOCK) WHERE 개인아이디 ='" & compId & "'"
			arrRsView = arrGetRsSql(DBCon, strSql4, "", "")
			
			mailForm = "<html>"&_
						"<head>"&_
							"<title>" & site_name & "</title>"&_
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
												"안녕하세요. <strong>" & txtName & "</strong>님<br>"&_
												site_name & " 회원으로 가입해 주셔서 감사합니다.<br>"&_
												site_name & "의 다양한 채용정보를 확인하세요.<br>"&_
											"</p>"&_
											"<table border=""0"" cellspacing=""0"" cellpadding=""0"" align=""center"" style=""width:100%;"">"&_
												"<colgroup>"&_
													"<col style=""width:44%;"">"&_
													"<col style=""width:56%;"">"&_
												"</colgroup>"&_
												"<tbody>"&_
													"<tr>"&_
														"<th style=""width:44%;padding:20px 20px 20px 0;vertical-align:top;text-align:right;font-size:17px;"">가입일시</th>"&_
														"<td style=""width:56%;padding:20px 0 20px 20px;vertical-align:top;text-align:left;font-size:17px;"">" & arrRsView(1,0) & "</td>"&_
													"</tr>"&_
													"<tr>"&_
														"<th style=""width:44%;padding:20px 20px 20px 0;vertical-align:top;text-align:right;font-size:17px;"">가입ID</th>"&_
														"<td style=""width:56%;padding:20px 0 20px 20px;vertical-align:top;text-align:left;font-size:17px;"">" & Replace(arrRsView(0,0),"_wk","") & "</td>"&_
													"</tr>"&_
													"<tr>"&_
														"<td colspan=""2"" style=""padding:20px 20px 0 50px;"">"&_
															"<p style=""font-size:15px;line-height:1.5;letter-spacing:0;color:#000;text-align:left;"">"&_
																"※" & site_name & "는 온라인으로만 채용이 진행됩니다.<br>"&_
																"※ 원하는 공고에 지원하려면 온라인 이력서를 작성해야만 지원이 가능합니다."&_
															"</p>"&_
														"</td>"&_
													"</tr>"&_
													"<tr>"&_
														"<td colspan=""2"" style=""padding:20px 20px 0 20px;text-align:right;"">"&_
															"<a href=""http://" & Request.ServerVariables("SERVER_NAME") & "/my/resume/resume_regist.asp"" target=""_blank"">이력서 등록하러 가기</a>"&_
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

			dim iConf
			dim mailer
			set mailer = Server.CreateObject("CDO.Message")

			set iConf = mailer.Configuration
			with iConf.Fields
			.item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 1
			.item("http://schemas.microsoft.com/cdo/configuration/smtpserverpickupdirectory") = "C:\inetpub\mailroot\Pickup"
			.item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "127.0.0.1"
			.item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 10
			.update
			end with

			mailer.From		= site_helpdesk_mail '"expohelp@career.co.kr"
			mailer.To		= txtEmail
			mailer.Subject	= "["& site_name & "] " & "회원가입이 완료되었습니다."
			mailer.HTMLBody = mailForm
			mailer.BodyPart.Charset		= "ks_c_5601-1987"
			mailer.HTMLBodyPart.Charset	= "ks_c_5601-1987"
			mailer.Send
			set mailer = Nothing

			'#### 회원정보 쿠키 할당
			Response.Cookies(site_code & "WKP_F")("id")			= Replace(compId, "_wk", "")
			Response.Cookies(site_code & "WKP_F")("name")		= txtName
			Response.Cookies(site_code & "WKP_F")("email")		= txtEmail
			Response.Cookies(site_code & "WKP_F")("cellphone")	= strPhone
			Response.Cookies(site_code & "WKP_F").Domain		= "career.co.kr"
			'Response.Cookies("WKP_F").Domain	= Request.ServerVariables("SERVER_NAME")	' 도메인 설정
			
			Response.Write "<script language=javascript>"&_
				"alert('회원가입이 완료되었습니다.');"&_
				"location.href='/';" &_
				"</script>"
			Response.End
		End If
Else	' 입력한 아이디로 가입된 정보가 존재할 경우 회원 가입 페이지 리턴
	Response.Write "<script language=javascript>"&_
	 "alert('입력하신 아이디로 가입된 정보가 존재합니다.\n다른 아이디로 다시 시도해 주세요.');"&_
	"location.href='/my/signup/join.asp';"&_
	"</script>"
	response.End 
End If 
%>