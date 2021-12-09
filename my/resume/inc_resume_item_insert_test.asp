<!--#include virtual = "/wwwconf/function/db/DBConnection.asp"-->

<%

user_id				= "1234_wk"
save_resume_id		= ""
complete_resume_id	= "82"

ConnectDB DBCon, Application("DBInfo_FAIR")

ReDim parameter(3)
parameter(0)    = makeParam("@gubun", adVarChar, adParamInput, 20, "Mobile")
parameter(1)    = makeParam("@userid", adVarChar, adParamInput, 20, user_id)
parameter(2)    = makeParam("@save_resume_id", adInteger, adParamInput, 4, save_resume_id)
parameter(3)    = makeParam("@complete_resume_id", adInteger, adParamInput, 4, complete_resume_id)		

Call execSP(DBCon, "usp_이력서_등록_LOG", parameter, "", "")

DisconnectDB DBCon
%>