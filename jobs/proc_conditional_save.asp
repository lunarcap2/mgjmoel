<!--#include virtual="/common/common.asp"-->
<!--#include virtual="/wwwconf/function/db/DBConnection.asp"-->
<%
Dim jc_val, ec_val, sc_val, wc_val, ac_val, kw_val
jc_val = request("jc_val")
ec_val = request("ec_val")
sc_val = request("sc_val")
wc_val = request("wc_val")
ac_val = request("ac_val")
kw_val = request("kw_val")

ConnectDB DBCon, Application("DBInfo_FAIR")

	Dim spName : spName = "usp_개인_멘토링_신청_등록"
	
	ReDim parameter(6)
	parameter(0)    = makeParam("@USER_ID", adVarChar, adParamInput, 20, user_id)
	parameter(1)    = makeParam("@JC", adVarChar, adParamInput, 100, jc_val)
	parameter(2)    = makeParam("@EC", adVarChar, adParamInput, 100, ec_val)
	parameter(3)    = makeParam("@SC", adVarChar, adParamInput, 100, sc_val)
	parameter(4)    = makeParam("@WC", adVarChar, adParamInput, 100, wc_val)
	parameter(5)    = makeParam("@AC", adVarChar, adParamInput, 100, ac_val)
	parameter(6)    = makeParam("@KW", adVarChar, adParamInput, 100, kw_val)
	
	Call execSP(DBCon,spName,parameter, "", "")

	Response.write "1"

DisconnectDB DBCon
%>