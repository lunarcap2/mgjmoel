/*
-----------------------------------------------------------------------
-- 스크랩
-----------------------------------------------------------------------
*/
function fn_scrap(loginChk, id_num, obj) {
	if (loginChk != "1") {
		var result = confirm("개인회원 로그인 후 이용가능합니다. 로그인하시겠습니까?");

		if(result) {
			location.href = '/my/login.asp?redir=' + location.pathname;
		}
	}
	else {
		$.ajax({
			type: "POST"
			, url: "/jobs/scrap.asp"
			, data: { id_num: id_num }
			, dataType: "html"
			, async: true
			, success: function (data) {
				if (data == "1") {
					alert("스크랩되었습니다.");
					$(obj).addClass('on');
				}
				else if (data == "2") {
					alert("스크랩을 삭제했습니다.");
					$(obj).removeClass('on');
				}
				else if (data == "0") {
					alert("스크랩 실패했습니다.");
					return false;
				}
			}
			, error: function (XMLHttpRequest, textStatus, errorThrown) {
				alert(textStatus);
			}
		});
	}
}

/*
-----------------------------------------------------------------------
-- 관심기업
-----------------------------------------------------------------------
*/
function fn_attention(loginChk, com_idnum, company_name, company_id, obj) {
	if (loginChk != "1") {
		var result = confirm("개인회원 로그인 후 이용가능합니다. 로그인하시겠습니까?");

		if(result) {
			location.href = '/my/login.asp?redir=' + location.pathname;
		}
	}
	else {
		$.ajax({
			type: "POST"
			, url: "/jobs/attention.asp"
			, data: { com_idnum: com_idnum, company_name: escape(company_name), company_id: company_id }
			, dataType: "html"
			, async: true
			, success: function (data) {
				if (data == "1") {
					alert("관심기업에 추가되었습니다.");
					$(obj).addClass('on');
				}
				else if (data == "2") {
					alert("관심기업에 삭제했습니다.");
					$(obj).removeClass('on');
				}
				else if (data == "0") {
					alert("관심기업추가 실패했습니다.");
					return false;
				}
			}
			, error: function (XMLHttpRequest, textStatus, errorThrown) {
				alert(textStatus);
			}
		});
	}
}

/*
-----------------------------------------------------------------------
-- 로그인
-----------------------------------------------------------------------
*/
function goLogin(loginChk, isTargetObj, isSelfClose, location_url, popupName)
{	
	var loginUrl = '';
	var redir = escape(location.href);
	if(isTargetObj) redir = escape(isTargetObj.location.href);
	if(location_url) redir = escape(location_url);
	//alert(loginChk)
	switch (loginChk)
	{
		case 1 :
			loginUrl = '/login/login.asp?redir=';
			break;

		case 2 :
			loginUrl = '/login/login.asp?redir=';
			break;

		default :
			loginUrl = '/my/login.asp?redir=';
			break;
	}

	if(popupName){
		var pop = window.open(loginUrl + redir, popupName);
		pop.focus();
	}else{
		if(loginUrl && !isTargetObj) location.href = loginUrl + redir;
		if(loginUrl && isTargetObj) isTargetObj.location.href = loginUrl + redir;
		if(isSelfClose) self.close();
	}
}