<!--#include virtual = "/common/common.asp"-->
<!--#include virtual = "/include/header/header.asp"-->

<!--#include virtual = "/wwwconf/function/db/DBConnection.asp"-->

<%
	Call FN_LoginLimit("1")    '개인회원만 접근가능

	ConnectDB DBCon, Application("DBInfo_FAIR")
	
	Dim strSql, site_gubun
	strSql = "SELECT 가입사이트구분코드 FROM 개인회원정보 WITH(NOLOCK) WHERE 개인아이디 = '"& user_id &"'"
	site_gubun = arrGetRsSql(DBCon, strSql, "", "")(0, 0)


	' my 카운트
	Dim resume_cnt, apply_cnt, scrap_cnt, att_company_cnt, rtn_value3
	ReDim param(0)
	param(0) = makeParam("@i_user_id", adVarChar, adParamInput, 20, user_id)
	rtn_value3		= arrGetRsSP(DBCon, "USP_MY_RESUME_STAT", param, "", "")
	
	resume_cnt			= rtn_value3(1,0) + rtn_value3(2,0) + rtn_value3(9,0)	' 이력서
	apply_cnt			= rtn_value3(3,0) + rtn_value3(4,0)						' 입사지원 관리
	scrap_cnt			= rtn_value3(5,0) + rtn_value3(6,0)						' 스크랩 공고
	att_company_cnt		= rtn_value3(7,0)										' 관심 협력사
	
	DisconnectDB DBCon
%>

<script type="text/javascript">	

	$(document).ready(function () {
		var site_gubun = "<%=site_gubun%>";
		if (site_gubun == "31" || site_gubun == "32" || site_gubun == "33" || site_gubun == "34") {
			$('#confirm').css("display","block");
		}
	});


	function fn_keyup() {
		if (event.keyCode == 13) {
			fn_pwchk();
		}
	}

	function fn_pwchk() {
		if($('#user_pw').val() == "") {
			alert("비밀번호를 입력해 주세요");
			$('#user_pw').focus();
            return;	
		}
		else {
			$.ajax({
				type: "POST"
				, url: "/my/search/withdraw_confirm.asp"
				, data: { user_pw: $("#user_pw").val() }
				, dataType: "html"
				, async: true
				, success: function (data) {
					if (data.trim() != '') {
						$('#confirm').css("display","block");	
					}
					else {
						alert("입력한 비밀번호가 일치하지 않습니다.");
						$('#user_pw').focus();
			            return;
					}
				}
				, error: function (XMLHttpRequest, textStatus, errorThrown) {
					//alert(XMLHttpRequest.responseText);
				}
			});
		}
	}

	function fn_submit() {
		if ($('#user_nm').val() == "") {
			alert("필수 입력값을 입력해 주세요");
			$('#user_nm').focus();
			return;
		}
		if ($('#hp_num').val() == "") {
			alert("필수 입력값을 입력해 주세요");
			$('#hp_num').focus();
			return;
		}
		if ($('#user_reason').val() == "") {
			alert("필수 입력값을 입력해 주세요");
			$('#user_reason').focus();
			return;
		}

		if (confirm("정말 탈퇴하시겠습니까?")) {
			$("#frm").attr("action", "/my/search/withdraw_complet.asp");
			$('#frm').submit();
		}

	}
</script>
</head>

<body>
	<!-- header -->
	<div  id="header">
		<div class="header-wrap detail">
			<div class="detail_box">
				<a href="/">이전</a>
				<p>회원탈퇴</p>
			</div>
			
		</div>
	</div>
	<!-- //header -->

	<!-- container -->
	<div id="contents" class="sub_page">
		<div class="contents">
			<div class="signup_area">
				<div class="layoutBox">
					<div class="titArea">
						<h3>
							회원확인<br>
							<% If site_gubun = "31" Then %>
							<span class="txt">네이버을(를) 통해 가입한 회원입니다.</span>
							<% ElseIf site_gubun = "32" Then %>
							<span class="txt">카카오을(를) 통해 가입한 회원입니다.</span>
							<% ElseIf site_gubun = "33" Then %>
							<span class="txt">구글을(를) 통해 가입한 회원입니다.</span>
							<% ElseIf site_gubun = "34" Then %>
							<span class="txt">페이스북을(를) 통해 가입한 회원입니다.</span>
							<% Else %>
							<span class="txt">본인 확인을 위해 비밀번호를 다시 한번 입력 부탁드립니다.</span>
							<% End If %>
						</h3>
					</div><!-- .titArea -->

					<div class="inputArea">
						<div class="inp bgNone">
							<label for="user_id">아이디</label>
							<input type="text" id="user_id" class="txt tahoma" name="user_id" value="<%=Replace(user_id, "_wk", "")%>" disabled="">
						</div><!-- .inp -->
						
						<% If site_gubun <> "31" And site_gubun <> "32" And site_gubun <> "33" And site_gubun <> "34" Then %>
						<div class="inp bgNone btn">
							<label for="user_pw">비밀번호</label>
							<input type="password" id="user_pw" class="txt" name="user_pw" placeholder="비밀번호 입력" onkeyup="FC_ChkTextLen(this,32); fn_keyup();">
							<div class="rt">
								<button type="button" class="btn typeSky" onclick="fn_pwchk();">확인</button>
							</div><!-- .rt -->
						</div><!-- .inp -->
						<% End If %>
					</div><!-- .inputArea -->
			
					<!-- 개인회원 -->
					<div id="memberPer" class="memberInfo">
						<div class="currentArea">
							<strong class="tit">회원탈퇴 시 <em>다음의 정보가 삭제되어 이용할 수 없게 됩니다.</em></strong>
							<ul class="spl4">
								<li>
									<dl>
										<dt>지원서</dt>
										<dd><a><%=resume_cnt%></a></dd>
									</dl>
								</li>
								<li>
									<dl>
										<dt>입사지원 관리</dt>
										<dd><a><%=apply_cnt%></a></dd>
									</dl>
								</li>
								<li>
									<dl>
										<dt>스크랩 공고</dt>
										<dd><a><%=scrap_cnt%></a></dd>
									</dl>
								</li>
								<li>
									<dl>
										<dt>관심 협력사</dt>
										<dd><a><%=att_company_cnt%></a></dd>
									</dl>
								</li>
							</ul>
						</div><!-- .currentArea -->

						<form name="frm" id="frm" method="post" action="">
							<input type="hidden" name="site_gubun" value="<%=site_gubun%>">
							
							<div id="confirm" style="display:none;">
								
								<% If site_gubun <> "31" And site_gubun <> "32" And site_gubun <> "33" And site_gubun <> "34" Then %>
								<div class="inputArea">
									<div class="inp">
										<label for="user_nm">이름</label>
										<input type="txt" id="user_nm" class="txt placehd" name="user_nm" placeholder="이름 (실명입력)" />
									</div><!-- .inp -->
									<div class="inp">
										<label for="hp_num">휴대폰 번호</label>
										<input type="txt" id="hp_num" class="txt placehd" name="hp_num" placeholder="휴대폰 번호" maxlength="13" />
									</div><!-- .inp -->
									<div class="inp">
										<label for="user_reason">탈퇴사유</label>
										<input type="txt" id="user_reason" class="txt placehd" name="user_reason" placeholder="탈퇴사유" />
									</div><!-- .inp -->
								</div><!-- .inputArea -->
								<% End If %>

								<div class="btnWrap">
									<button type="button" class="btn typeSky" onclick="fn_submit()">회원탈퇴 신청</button>
								</div>
							</div>
						</form>

						<div class="notiArea">
							<strong class="tit">회원탈퇴 신청에 시 <em>다음의 사항을 반드시 확인하시기 바랍니다.</em></strong>
							<ul>
								<li>· 현대자동차그룹 협력사 수시채용 마당에 로그인을 할 수 없습니다.</li>
								<li>· 추후 재가입하더라도 동일한 아이디로 재가입이 불가능합니다.</li>
								<li>· 박람회 관련 소식을 받을 수 없습니다.</li>
							</ul>
						</div><!-- .notiArea -->
					</div><!-- .memberInfo -->
				 </div><!-- layoutBox -->
			</div><!-- signup_area-->
		</div><!-- contents -->
	</div><!-- contents -->
	<!-- //container -->


<!-- 하단 -->
<!--#include virtual = "/include/footer.asp"-->
<!-- 하단 -->

</body>
</html>