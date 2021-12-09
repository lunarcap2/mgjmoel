<!--#include virtual="/wwwconf/function/db/DBConnection.asp"-->
<!--#include virtual = "/common/common.asp"-->
<%
'--------------------------------------------------------------------
'   Comment		: 개인회원 가입
' 	History		: 2020-12-01, 이샛별 
'--------------------------------------------------------------------
Session.CodePage  = 949			'한글
Response.CharSet  = "euc-kr"	'한글
Response.AddHeader "Pragma","no-cache"
Response.AddHeader "cache-control", "no-staff"
Response.Expires  = -1

emp_no = Request("emp_no")


ConnectDB DBCon, Application("DBInfo_FAIR")

' 입력 사번 유효성 체크 > 1)인턴 명단 테이블에 해당 정보가 존재하는지 여부 확인
strSql = "SELECT 인턴사번, 성명, 휴대폰, 전자우편, 기관구분, 지자체구분, 센터명, 기관명, 배치부서 " &_
		  "FROM 인턴명단정보 WITH(NOLOCK) "&_
		  "WHERE 인턴사번='"& emp_no &"' "
Rs.Open strSql, DBCon, adOpenForwardOnly, adLockReadOnly, adCmdText
Dim flagRs : flagRs = False 
If Rs.eof = False And Rs.bof = False Then
	flagRs = True 
	rs_EmpNo		= Rs(0)	' 인턴사번
	rs_ItrnNm		= Rs(1)	' 인턴성명
	rs_ItrnPhone	= Rs(2)	' 휴대폰
	rs_ItrnMail		= Rs(3)	' 이메일
	rs_ItrnAgency	= Rs(4)	' 기관구분
	rs_ItrnGover	= Rs(5)	' 지자체구분
	rs_ItrnCenter	= Rs(6) ' 센터명
	rs_ItrnGoverDtl	= Rs(7)	' 기관명
	rs_ItrnDepart	= Rs(8)	' 배치부서
End If

If flagRs = False Then 
	rtn_value = "X"	' 인턴 명단에 포함되지 않은 경우 가입 불가 처리
Else 
	
	' 입력 사번 유효성 체크 > 2)해당 사번으로 가입된 개인회원 정보가 있는지 체크
	strSql2 = "SELECT 개인아이디 FROM 개인회원정보 WITH(NOLOCK) WHERE 개인아이디= ? "
	ReDim parameter(0)
	parameter(0)	= makeParam("@개인아이디", adVarChar, adParamInput, 20, emp_no&"_wk")
	ArrRsDefault	= arrGetRsParam(DBCon, strSql2, parameter, "", "")
	If isArray(ArrRsDefault) Then	
		rtn_value = "N"	' 해당 사번으로 가입된 정보가 존재한다면 중복 가입 제한 처리
	Else 
		rtn_value = "O" 
	End If 

End If 


DisconnectDB DBCon


Response.write rtn_value&"§"

' 인턴 명단에 사번 정보가 있을 경우 인턴 정보 전달
If rtn_value = "O" Then 
	Response.write rs_EmpNo&"§"&rs_ItrnMail&"§"&rs_ItrnPhone&"§"&rs_ItrnNm&"§"
	Response.write "<table class='tb'>"+VBCRLF
	Response.write "<colgroup><col style='width:18%;' /><col /></colgroup><tbody>"+VBCRLF
	Response.write "<tr><th>센터명</th><td>"&rs_ItrnCenter&"</td></tr>"+VBCRLF
	Response.write "<tr><th>기관명</th><td>"&rs_ItrnGoverDtl&"</td></tr>"+VBCRLF
	Response.write "<tr><th>인턴 배치부서</th><td>"&rs_ItrnDepart&"</td></tr>"+VBCRLF
	Response.write "<tr><th>인턴 사번</th><td>"&rs_EmpNo&"</td></tr>"+VBCRLF
	Response.write "<tr><th>이름</th><td>"&rs_ItrnNm&"</td></tr>"+VBCRLF
	Response.write "</tbody></table>"+VBCRLF
End If 
%>
<OBJECT RUNAT="SERVER" PROGID="ADODB.RecordSet" ID="Rs"></OBJECT>