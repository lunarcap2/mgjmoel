<%
'모바일용임

'------------------------------------------------------------
'	#이력서 - 공통정보 등록/수정(1단계)
'   params)
'       arrParams = {}
'	2009-12-07, 임기정(gidol@career.co.kr)
'------------------------------------------------------------
Sub execResumeCommon_M(strConn, arrParams, errMsg, errAction)

	Dim spName, parameter(29)

	ReDim Preserve arrParams(29)	'최대 파라미터 갯수.

    spName = "usp_이력서_공통정보_등록수정_M"

    'Dim ii
    'For ii=0 To 29
    '    response.Write "ii="&ii &", value=["& arrParams(ii) &"]<br>"
    'Next
   
	'response.end

    parameter(0)    = makeParam("@userid", adVarChar, adParamInput, 20, arrParams(0))
    parameter(1)    = makeParam("@username", adVarChar, adParamInput, 30, arrParams(1))
	parameter(2)    = makeParam("@birth_yy", adChar, adParamInput, 4, arrParams(2))
	parameter(3)    = makeParam("@birth_mm", adChar, adParamInput, 2, arrParams(3))
    parameter(4)    = makeParam("@birth_dd", adChar, adParamInput, 2, arrParams(4))
    parameter(5)    = makeParam("@jumin_code", adChar, adParamInput, 1, arrParams(5))
    parameter(6)    = makeParam("@birth_type", adChar, adParamInput, 1, arrParams(6))
    parameter(7)    = makeParam("@tel", advarChar, adParamInput, 40, arrParams(7))
    parameter(8)    = makeParam("@tel_open", adChar, adParamInput, 1, arrParams(8))
    parameter(9)    = makeParam("@phone", adVarChar, adParamInput, 40, arrParams(9))
    parameter(10)   = makeParam("@phone_open", adChar, adParamInput, 1, arrParams(10))
    parameter(11)   = makeParam("@email", adVarChar, adParamInput, 100, arrParams(11))
    parameter(12)   = makeParam("@email_open", adChar, adParamInput, 1, arrParams(12))
    parameter(13)   = makeParam("@zipcode", adChar, adParamInput, 6, arrParams(13))
    parameter(14)   = makeParam("@addr", adVarChar, adParamInput, 200, arrParams(14))
    parameter(15)   = makeParam("@addr_open", adChar, adParamInput, 1, arrParams(15))
    parameter(16)   = makeParam("@contact_from", adTinyInt, adParamInput, 1, arrParams(16))
    parameter(17)   = makeParam("@contact_to", adTinyInt, adParamInput, 1, arrParams(17))
    parameter(18)   = makeParam("@photo_yn", adChar, adParamInput, 1, arrParams(18))
    parameter(19)   = makeParam("@photo_file", adVarChar, adParamInput, 100, arrParams(19))
    parameter(20)   = makeParam("@photo_open", adChar, adParamInput, 1, arrParams(20))
    parameter(21)   = makeParam("@work_day", adVarChar, adParamInput, 19, arrParams(21))
    parameter(22)   = makeParam("@work_type", adTinyInt, adParamInput, 1, arrParams(22))
    parameter(23)   = makeParam("@homepage", adVarChar, adParamInput, 200, arrParams(23))
    parameter(24)   = makeParam("@user_state", adChar, adParamInput, 1, arrParams(24))
    parameter(25)   = makeParam("@resume_open", adChar, adParamInput, 1, arrParams(25))
    parameter(26)   = makeParam("@pinfo_update", adChar, adParamInput, 1, arrParams(26))
    parameter(27)   = makeParam("@salary_code", adVarChar, adParamInput, 2, arrParams(27))
    parameter(28)   = makeParam("@site_gb", adChar, adParamInput, 1, arrParams(28))
    parameter(29)   = makeParam("@rid", adInteger, adParamInput, 4, arrParams(29))

    Call execSP(strConn, spName, parameter, errMsg, errAction)

End Sub



'------------------------------------------------------------
'	#이력서 - 이력서 등록/수정()
'   params)
'       arrParams = {}
'	output)
'		execRid = 이력서등록번호
'	2014-12-03, 신규이력서 등록 및 수정
'------------------------------------------------------------
Function execResumeResumeNew_M(strConn, arrParams, errMsg, errAction)

	Dim spName, parameter(31)

	ReDim Preserve arrParams(30)	'최대 파라미터 갯수.

    spName = "usp_이력서_등록수정_M"

	'Dim ii
	'For ii=0 To 30
	'	response.Write "ii="&ii &", value=["& arrParams(ii) &"]<br>"
	'Next
	'response.end

    parameter(0)    = makeParam("@userid", adVarChar, adParamInput, 20, arrParams(0))
    parameter(1)    = makeParam("@username", adVarChar, adParamInput, 30, arrParams(1))
    parameter(2)    = makeParam("@birth_yy", adChar, adParamInput, 4, arrParams(2))
	parameter(3)    = makeParam("@birth_mm", adChar, adParamInput, 2, arrParams(3))
    parameter(4)    = makeParam("@birth_dd", adChar, adParamInput, 2, arrParams(4))
    parameter(5)    = makeParam("@jumin_code", adChar, adParamInput, 1, arrParams(5))
	parameter(6)    = makeParam("@rid", adInteger, adParamInput, 4, arrParams(6))
	parameter(7)    = makeParam("@base_resume", adChar, adParamInput, 1, arrParams(7))
    parameter(8)    = makeParam("@salary_code", adVarChar, adParamInput, 2, arrParams(8))
    parameter(9)    = makeParam("@resume_open", adChar, adParamInput, 1, arrParams(9))
    parameter(10)   = makeParam("@headhunter_open", adChar, adParamInput, 1, arrParams(10))
    parameter(11)   = makeParam("@site_gubun", adChar, adParamInput, 1, arrParams(11))
    parameter(12)   = makeParam("@resume_title", adVarChar, adParamInput, 250, arrParams(12))
    parameter(13)   = makeParam("@resume_step", adTinyInt, adParamInput, 1, arrParams(13))
    parameter(14)   = makeParam("@jc_code_all", adVarChar, adParamInput, 64, arrParams(14))
    parameter(15)   = makeParam("@ct_code_all", adVarChar, adParamInput, 64, arrParams(15))
    parameter(16)   = makeParam("@area_code_all", adVarChar, adParamInput, 64, arrParams(16))
    parameter(17)   = makeParam("@pinfo_update", adChar, adParamInput, 1, arrParams(17))
    parameter(18)   = makeParam("@hope_com_scale_1", adTinyInt, adParamInput, 1, arrParams(18))
    parameter(19)   = makeParam("@hope_com_scale_2", adTinyInt, adParamInput, 1, arrParams(19))

    parameter(20)    = makeParam("@school_name", adVarChar, adParamInput, 100, arrParams(20))
    parameter(21)    = makeParam("@school_name2", adVarChar, adParamInput, 200, arrParams(21))
    parameter(22)    = makeParam("@school_major", adVarChar, adParamInput, 100, arrParams(22))
    parameter(23)    = makeParam("@school_final_code", adVarChar, adParamInput, 2, arrParams(23))
    parameter(24)    = makeParam("@career_code", adChar, adParamInput, 1, arrParams(24))
    parameter(25)    = makeParam("@career_month", adVarChar, adParamInput, 4, arrParams(25))
    parameter(26)    = makeParam("@career_foreign_month", adVarChar, adParamInput, 4, arrParams(26))
    parameter(27)   = makeParam("@career_foreign_area", adVarChar, adParamInput, 4, arrParams(27))
    parameter(28)   = makeParam("@career_explain", adLongVarWChar, adParamInput, LenB(arrParams(28))+1, arrParams(28))

    parameter(29)   = makeParam("@execRid", adInteger, adParamOutput, 4, 0)

    parameter(30)   = makeParam("@career_flag", adTinyInt, adParamInput, 1, arrParams(29))
    parameter(31)   = makeParam("@rGubun", adChar, adParamInput, 1, arrParams(30))

    Call execSP(strConn, spName, parameter, errMsg, errAction)
    execResumeResumeNew_M = getParamOutputValue(parameter, "@execRid")

End Function

'------------------------------------------------------------
'	#이력서 - 이력서 자기소개서 수정
'   params)
'       arrParams = {}
'	output)
'		execRid = 이력서등록번호
'	2009-12-17, 임기정(gidol@career.co.kr)
'------------------------------------------------------------
Sub execResumeSelfIntro_M(strConn, arrParams, errMsg, errAction)

	Dim spName, parameter(3)

	ReDim Preserve arrParams(3)	'최대 파라미터 갯수.

    spName = "usp_이력서_자소서_수정_M"

    parameter(0)    = makeParam("@rid", adInteger, adParamInput, 4, arrParams(0))
    parameter(1)    = makeParam("@userid", adVarChar, adParamInput, 20, arrParams(1))
    parameter(2)    = makeParam("@resume_step", adTinyInt, adParamInput, 1, arrParams(2))
    parameter(3)    = makeParam("@self_intro", adLongVarWChar, adParamInput, LenB(arrParams(3))+1, arrParams(3))

    Call execSP(strConn, spName, parameter, errMsg, errAction)

End Sub

'------------------------------------------------------------
'	이력서 항목 삭제
'------------------------------------------------------------
Sub execResumeItemDel_M(strConn, arrParams, errMsg, errAction)

	Dim spName, parameter(5)

	ReDim Preserve arrParams(5)	'최대 파라미터 갯수.

    spName = "usp_이력서_항목_삭제_M"

    parameter(0)    = makeParam("@user_id", adVarChar, adParamInput, 20, arrParams(0))
    parameter(1)    = makeParam("@rid", adVarChar, adParamInput, 50, arrParams(1))
    parameter(2)    = makeParam("@rsubGubun", adVarChar, adParamInput, 2, arrParams(2))
    parameter(3)    = makeParam("@rsubItem", adVarChar, adParamInput, 2, arrParams(3))
	parameter(4)    = makeParam("@seq_no", adVarChar, adParamInput, 50, arrParams(4))
	parameter(5)    = makeParam("@rtype", adVarChar, adParamInput, 1, arrParams(5))

    Call execSP(strConn, spName, parameter, errMsg, errAction)

End Sub

'------------------------------------------------------------
'	이력서 항목 수정 - 학력
'------------------------------------------------------------
Sub execResumeItemUpdate_school_M(strConn, arrParams, errMsg, errAction)

	Dim spName, parameter(25)

	ReDim Preserve arrParams(25)	'최대 파라미터 갯수.

    spName = "usp_이력서_항목_학력_수정_M"

    parameter(0)    = makeParam("@rid", adInteger, adParamInput, 4, arrParams(0))
    parameter(1)    = makeParam("@step", adInteger, adParamInput, 4, arrParams(1))
    parameter(2)    = makeParam("@seq_no", adTinyInt, adParamInput, 1, arrParams(2))
    parameter(3)    = makeParam("@sc_kind", adChar, adParamInput, 1, arrParams(3))
    parameter(4)    = makeParam("@sc_name", adVarChar, adParamInput, 100, arrParams(4))
    parameter(5)    = makeParam("@sc_major_depth", adVarChar, adParamInput, 50, arrParams(5))
    parameter(6)    = makeParam("@sc_major_name", adVarChar, adParamInput, 100, arrParams(6))
    parameter(7)    = makeParam("@sc_syear", adVarChar, adParamInput, 4, arrParams(7))
    parameter(8)    = makeParam("@sc_eyear", adVarChar, adParamInput, 4, arrParams(8))
    parameter(9)    = makeParam("@sc_point", adVarChar, adParamInput, 10, arrParams(9))
    parameter(10)   = makeParam("@sc_point_avg", adVarChar, adParamInput, 3, arrParams(10))
    parameter(11)   = makeParam("@sc_code", adVarChar, adParamInput, 10, arrParams(11))
    parameter(12)   = makeParam("@sc_major_code", adChar, adParamInput, 5, arrParams(12))
    parameter(13)   = makeParam("@sc_smonth", adVarChar, adParamInput, 2, arrParams(13))
    parameter(14)   = makeParam("@sc_emonth", adVarChar, adParamInput, 2, arrParams(14))
    parameter(15)   = makeParam("@sc_grade", adChar, adParamInput, 1, arrParams(15))
    parameter(16)   = makeParam("@sc_stype", adChar, adParamInput, 1, arrParams(16))
    parameter(17)   = makeParam("@sc_etype", adChar, adParamInput, 1, arrParams(17))
    parameter(18)   = makeParam("@sc_area", adVarChar, adParamInput, 2, arrParams(18))
    parameter(19)   = makeParam("@sc_minor_kind", adVarChar, adParamInput, 5, arrParams(19))
    parameter(20)   = makeParam("@sc_minor_name", adVarChar, adParamInput, 100, arrParams(20))
    parameter(21)   = makeParam("@sc_minor_code", adChar, adParamInput, 5, arrParams(21))
    parameter(22)   = makeParam("@sc_minor_depth", adVarChar, adParamInput, 50, arrParams(22))
    parameter(23)   = makeParam("@sc_exm", adChar, adParamInput, 1, arrParams(23))
    parameter(24)   = makeParam("@abeek_flag", adChar, adParamInput, 1, arrParams(24))
	parameter(25)   = makeParam("@sc_research", adVarChar, adParamInput, LenB(arrParams(25))+1, arrParams(25)) '

    Call execSP(strConn, spName, parameter, errMsg, errAction)

End Sub

'------------------------------------------------------------
'	이력서 항목 수정 - 경력
'------------------------------------------------------------
Sub execResumeItemUpdate_career_M(strConn, arrParams, errMsg, errAction)

	Dim spName, parameter(25)

	ReDim Preserve arrParams(25)	'최대 파라미터 갯수.

    spName = "usp_이력서_항목_경력_수정_M"

    parameter(0)    = makeParam("@rid", adInteger, adParamInput, 4, arrParams(0))
    parameter(1)    = makeParam("@step", adInteger, adParamInput, 4, arrParams(1))
    parameter(2)    = makeParam("@seq_no", adTinyInt, adParamInput, 1, arrParams(2))
    parameter(3)    = makeParam("@com_name", adVarChar, adParamInput, 150, arrParams(3))
    parameter(4)    = makeParam("@com_ct", adVarChar, adParamInput, 4, arrParams(4))
    parameter(5)    = makeParam("@dept", adVarChar, adParamInput, 50, arrParams(5))
    parameter(6)    = makeParam("@duty", adVarChar, adParamInput, 50, arrParams(6))
    parameter(7)    = makeParam("@now_status", adChar, adParamInput, 1, arrParams(7))
    parameter(8)    = makeParam("@s_year", adVarChar, adParamInput, 4, arrParams(8))
    parameter(9)    = makeParam("@s_month", adVarChar, adParamInput, 2, arrParams(9))
    parameter(10)   = makeParam("@e_year", adVarChar, adParamInput, 4, arrParams(10))
    parameter(11)   = makeParam("@e_month", adVarChar, adParamInput, 2, arrParams(11))
    parameter(12)   = makeParam("@career_open", adChar, adParamInput, 1, arrParams(12))
    parameter(13)   = makeParam("@com_scale", adChar, adParamInput, 1, arrParams(13))
    parameter(14)   = makeParam("@com_kind", adChar, adParamInput, 1, arrParams(14))
    parameter(15)   = makeParam("@com_stock", adChar, adParamInput, 1, arrParams(15))
    parameter(16)   = makeParam("@com_jc", adVarChar, adParamInput, 4, arrParams(16))
    parameter(17)   = makeParam("@salary", adVarChar, adParamInput, 6, arrParams(17))
    parameter(18)   = makeParam("@work_type", adVarChar, adParamInput, 2, arrParams(18))
    parameter(19)   = makeParam("@duty_year", adVarChar, adParamInput, 2, arrParams(19))
    parameter(20)   = makeParam("@salary_code", adTinyInt, adParamInput, 1, arrParams(20))
    parameter(21)   = makeParam("@duty_work", adVarChar, adParamInput, 512, arrParams(21))
    parameter(22)   = makeParam("@com_id", adVarChar, adParamInput, 20, arrParams(22))
    parameter(23)   = makeParam("@com_name_open", adChar, adParamInput, 1, arrParams(23))
    parameter(24)   = makeParam("@rca_part_skill", adVarChar, adParamInput, LenB(arrParams(24))+1 , arrParams(24))
	parameter(25)   = makeParam("@com_jc3", adVarChar, adParamInput, 6, arrParams(25))

    Call execSP(strConn, spName, parameter, errMsg, errAction)

End Sub

'------------------------------------------------------------
'	이력서 항목 수정 - 자격증
'------------------------------------------------------------
Sub execResumeItemUpdate_license_M(strConn, arrParams, errMsg, errAction)

	Dim spName, parameter(7)

	ReDim Preserve arrParams(7)	'최대 파라미터 갯수.

    spName = "usp_이력서_항목_자격증_수정_M"

    parameter(0)    = makeParam("@rid", adInteger, adParamInput, 4, arrParams(0))
    parameter(1)    = makeParam("@step", adInteger, adParamInput, 4, arrParams(1))
    parameter(2)    = makeParam("@seq_no", adTinyInt, adParamInput, 1, arrParams(2))
    parameter(3)    = makeParam("@license_name", adVarChar, adParamInput, 100, arrParams(3))
    parameter(4)    = makeParam("@license_org", adVarChar, adParamInput, 50, arrParams(4))
    parameter(5)    = makeParam("@license_year", adVarChar, adParamInput, 4, arrParams(5))
    parameter(6)    = makeParam("@license_month", adVarChar, adParamInput, 2, arrParams(6))
    parameter(7)    = makeParam("@license_code", adInteger, adParamInput, 4, arrParams(7))

    Call execSP(strConn, spName, parameter, errMsg, errAction)

End Sub

'------------------------------------------------------------
'	이력서 항목 수정 - 외국어(회화)
'------------------------------------------------------------
Sub execResumeItemUpdate_language_use_M(strConn, arrParams, errMsg, errAction)

	Dim spName, parameter(6)

	ReDim Preserve arrParams(6)	'최대 파라미터 갯수.

    spName = "usp_이력서_항목_어학능력_수정_M"

    parameter(0)    = makeParam("@rid", adInteger, adParamInput, 4, arrParams(0))
    parameter(1)    = makeParam("@step", adInteger, adParamInput, 4, arrParams(1))
    parameter(2)    = makeParam("@seq_no", adTinyInt, adParamInput, 1, arrParams(2))
    parameter(3)    = makeParam("@language_code", adVarChar, adParamInput, 2, arrParams(3))
    parameter(4)    = makeParam("@language_talk", adChar, adParamInput, 1, arrParams(4))
    parameter(5)    = makeParam("@language_write", adChar, adParamInput, 1, arrParams(5))
    parameter(6)    = makeParam("@language_read", adChar, adParamInput, 1, arrParams(6))

    Call execSP(strConn, spName, parameter, errMsg, errAction)

End Sub

'------------------------------------------------------------
'	이력서 항목 수정 - 외국어(공인시험)
'------------------------------------------------------------
Sub execResumeItemUpdate_language_exam_M(strConn, arrParams, errMsg, errAction)

	Dim spName, parameter(8)

	ReDim Preserve arrParams(8)	'최대 파라미터 갯수.

    spName = "usp_이력서_항목_어학시험_수정_M"

    parameter(0)    = makeParam("@rid", adInteger, adParamInput, 4, arrParams(0))
    parameter(1)    = makeParam("@step", adInteger, adParamInput, 4, arrParams(1))
    parameter(2)    = makeParam("@seq_no", adTinyInt, adParamInput, 1, arrParams(2))
    parameter(3)    = makeParam("@language_code", adVarChar, adParamInput, 2, arrParams(3))
    parameter(4)    = makeParam("@exam_code", adVarChar, adParamInput, 2, arrParams(4))
    parameter(5)    = makeParam("@exam_score", adVarChar, adParamInput, 30, arrParams(5))
    parameter(6)    = makeParam("@exam_year", adVarChar, adParamInput, 4, arrParams(6))
    parameter(7)    = makeParam("@exam_month", adVarChar, adParamInput, 2, arrParams(7))
    parameter(8)    = makeParam("@exam_etc_name", adVarChar, adParamInput, 50, arrParams(8))

    Call execSP(strConn, spName, parameter, errMsg, errAction)

End Sub

'------------------------------------------------------------
'	이력서 항목 수정 - 수상
'------------------------------------------------------------
Sub execResumeItemUpdate_awards_M(strConn, arrParams, errMsg, errAction)

	Dim spName, parameter(6)

	ReDim Preserve arrParams(6)	'최대 파라미터 갯수.

    spName = "usp_이력서_항목_수상_수정_M"

    parameter(0)    = makeParam("@rid", adInteger, adParamInput, 4, arrParams(0))
    parameter(1)    = makeParam("@step", adInteger, adParamInput, 4, arrParams(1))
    parameter(2)    = makeParam("@seq_no", adTinyInt, adParamInput, 1, arrParams(2))
    parameter(3)    = makeParam("@prize_org", adVarChar, adParamInput, 100, arrParams(3))
    parameter(4)    = makeParam("@prize_name", adVarChar, adParamInput, 100, arrParams(4))
    parameter(5)    = makeParam("@prize_year", adVarChar, adParamInput, 4, arrParams(5))
    parameter(6)    = makeParam("@prize_month", adVarChar, adParamInput, 2, arrParams(6))

    Call execSP(strConn, spName, parameter, errMsg, errAction)

End Sub

'------------------------------------------------------------
'	이력서 항목 수정 - 교육
'------------------------------------------------------------
Sub execResumeItemUpdate_education_M(strConn, arrParams, errMsg, errAction)

	Dim spName, parameter(8)

	ReDim Preserve arrParams(8)	'최대 파라미터 갯수.

    spName = "usp_이력서_항목_교육_수정_M"

    parameter(0)    = makeParam("@rid", adInteger, adParamInput, 4, arrParams(0))
    parameter(1)    = makeParam("@step", adInteger, adParamInput, 4, arrParams(1))
    parameter(2)    = makeParam("@seq_no", adTinyInt, adParamInput, 1, arrParams(2))
    parameter(3)    = makeParam("@edu_org", adVarChar, adParamInput, 100, arrParams(3))
    parameter(4)    = makeParam("@edu_syear", adVarChar, adParamInput, 4, arrParams(4))
    parameter(5)    = makeParam("@edu_smonth", adVarChar, adParamInput, 2, arrParams(5))
    parameter(6)    = makeParam("@edu_eyear", adVarChar, adParamInput, 4, arrParams(6))
    parameter(7)    = makeParam("@edu_emonth", adVarChar, adParamInput, 2, arrParams(7))
    parameter(8)    = makeParam("@edu_name", adVarChar, adParamInput, 100, arrParams(8))

    Call execSP(strConn, spName, parameter, errMsg, errAction)

End Sub

'------------------------------------------------------------
'	이력서 항목 수정 - 해외
'------------------------------------------------------------
Sub execResumeItemUpdate_overseas_M(strConn, arrParams, errMsg, errAction)

	Dim spName, parameter(9)

	ReDim Preserve arrParams(9)	'최대 파라미터 갯수.

    spName = "usp_이력서_항목_해외_수정_M"

    parameter(0)    = makeParam("@rid", adInteger, adParamInput, 4, arrParams(0))
    parameter(1)    = makeParam("@step", adInteger, adParamInput, 4, arrParams(1))
    parameter(2)    = makeParam("@seq_no", adTinyInt, adParamInput, 1, arrParams(2))
    parameter(3)    = makeParam("@nation_code", adVarChar, adParamInput, 3, arrParams(3))
    parameter(4)    = makeParam("@abroad_org", adVarChar, adParamInput, 100, arrParams(4))
    parameter(5)    = makeParam("@abroad_syear", adVarChar, adParamInput, 4, arrParams(5))
    parameter(6)    = makeParam("@abroad_smonth", adVarChar, adParamInput, 2, arrParams(6))
    parameter(7)    = makeParam("@abroad_eyear", adVarChar, adParamInput, 4, arrParams(7))
    parameter(8)    = makeParam("@abroad_emonth", adVarChar, adParamInput, 2, arrParams(8))
    parameter(9)    = makeParam("@abroad_name", adVarChar, adParamInput, 100, arrParams(9))

    Call execSP(strConn, spName, parameter, errMsg, errAction)

End Sub
%>