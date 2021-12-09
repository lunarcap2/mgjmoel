var count = 0; //템플릿HTML안에 혹시라도 체크박스가 있을수있어 선언 체크박스/라디오 label/id값 주기위
function fn_append(val, _self) {
	var $this = $(_self) || $(document);
	var _val = val;
	var _gubun = '';
	if(typeof val === 'object'){
		_val = val.code;
		_gubun = val.gubun;
	}
	if(_val == '2') {
		if(_gubun == '3'){
			$('[name="div_school_high"]').append(createInput2_3(_gubun));
		}else{
			$('[name="div_school_univ"]').append(createInput2(_gubun));
		}
	}
	if(_val == '4') {
		$('[name="div_introduce"]').append(createInput4());
	}
	if(_val == '7') {
		$('[name="div_language"]').append(createInput7());
	}
	if(_val == '8') {
		$('[name="div_license"]').append(createInput8());
	}
	if(_val == '10') {
		$('[name="div_education"]').append(createInput10());
	}
	if(_val == '11') {
		$('[name="div_overseas"]').append(createInput11());
	}
	$('div[name^="div_"]').customTags();
	if($this.closest('div[name^="div_"]').length && $this.closest('.cloneTargetDivision').length){
		$('html,body').stop().animate({
			'scrollTop': $this.closest('div[name^="div_"]').find('.cloneTargetDivision:last')[0].offsetTop
		});
	}
	count++;
}

function fn_remove(_self) {
	var $this = $(_self);
	$this.closest('.cloneTargetDivision').remove();
}


//학력사항 - 고등 코드 3
function createInput2_3(_gubun) {
	var contents = '';

	contents+='<div class="cloneTargetDivision MT30 fnCloneTargetDivision">';
	contents+='	<div class="mmRow border colaps">';
	contents+='		<input type="hidden" id="final_scholar" name="final_scholar" value="">';
	contents+='		<input type="hidden" id="univ_kind" name="univ_kind" value="'+_gubun+'';
	contents+='		<input type="hidden" id="sc_type" name="sc_type" value="2">';
	contents+='		<input type="hidden" id="univ_depth" name="univ_depth" value=""> <!-- 계열코드(X) -->';
	contents+='		<input type="hidden" id="univ_pointavg" name="univ_pointavg" value=""> <!-- 학점기준(X) -->';
	contents+='		<input type="hidden" id="univ_code" name="univ_code" value=""> <!-- 대학코드(X) -->';
	contents+='		<input type="hidden" id="univ_major_code" name="univ_major_code" value=""> <!-- 전공코드(X) -->';
	contents+='		<input type="hidden" id="univ_area" name="univ_area" value=""> <!-- 지역코드(X) -->';
	contents+='		<input type="hidden" id="univ_stype" name="univ_stype" value="1"> <!-- 입학코드(X) -->';
	contents+='		<input type="hidden" id="univ1_grd" name="univ1_grd" value=""> <!-- 학위구분코드(X) -->';
	contents+='		<input type="hidden" id="univ_syear" name="univ_syear" value="">';
	contents+='		<input type="hidden" id="univ_smonth" name="univ_smonth" value="">';
	contents+='		<input type="hidden" id="univ_eyear" name="univ_eyear" value="">';
	contents+='		<input type="hidden" id="univ_emonth" name="univ_emonth" value="">';
	contents+='		<input type="hidden" id="univ_etype" name="univ_etype" value=""> <!-- 졸업상태 -->';
	contents+='		<input type="hidden" id="univ_minor" name="univ_minor" value=""> <!-- 부전공 -->';
	contents+='		<input type="hidden" id="univ_mdepth" name="univ_mdepth" value=""> <!-- 부전공계열코드(X) -->';
	contents+='		<input type="hidden" id="univ_minor_code" name="univ_minor_code" value=""> <!-- 부전공코드(X) -->';
	contents+='		<input type="hidden" id="univ_major" name="univ_major" value="">';
	contents+='		<input type="hidden" id="univ_research" name="univ_research" value="">';
	contents+='		<input type="hidden" id="univ_point" name="univ_point" value="">';
	contents+='		<input type="hidden" id="univ_minornm" name="univ_minornm" value="">';
	contents+='		<div class="mmCol12 ">';
	contents+='			<div class="mmCmmInput">';
	contents+='				<div class="ip">';
	contents+='					<input type="text" value="" id="univ_name" name="univ_name" placeholder="학교명을 입력해 주세요." onkeyup="fn_kwSearchItem(this, \'high\')" autocomplete="off" />';
	contents+='				</div>';
	contents+='				<!-- 검색결과 창 : S -->';
	contents+='				<!-- 상위 클래스 .mmCmmInput 안에 자식으로 있어야함 -->';
	contents+='				<div class="result_box" id="id_result_box">';
	contents+='				</div>';
	contents+='				<!-- 검색결과 창 : E -->';
	contents+='			</div>';
	contents+='		</div>';
	contents+='		<div class="mmCol12">';
	contents+='			<select class="fnCustomSelect" name="select_univ_etype" onchange="fn_sel_value_set(this, \'univ_etype\');">';
	contents+='				<option value="">졸업구분</option>';
	contents+='				<option value="3">재학</option>';
	contents+='				<option value="4">휴학</option>';
	contents+='				<option value="5">중퇴</option>';
	contents+='				<option value="7">졸업(예)</option>';
	contents+='				<option value="8">졸업</option>';
	contents+='			</select>';
	contents+='		</div>';
	contents+='		<div class="mmCol6">';
	contents+='			<div class="mmCmmInput date fnDatePicker">';
	contents+='				<div class="ip">';
	contents+='					<input type="text" value="" name="univ_sdate" placeholder="입학년월" onkeyup="numCheck(this, \'int\'); changeDateType(this); fn_school_s_div(this);" onblur="chkDateType(this)" maxlength="6" />';
	contents+='				</div>';
	contents+='			</div>';
	contents+='		</div>';
	contents+='		<div class="mmCol6">';
	contents+='			<div class="mmCmmInput date fnDatePicker">';
	contents+='				<div class="ip">';
	contents+='					<input type="text" value="" name="univ_edate" placeholder="졸업년월" onkeyup="numCheck(this, \'int\'); changeDateType(this); fn_school_e_div(this);" onblur="chkDateType(this)" maxlength="6" />';
	contents+='				</div>';
	contents+='			</div>';
	contents+='		</div>';
	contents+='		<div class="mmCol12" style="display:none;">';
	contents+='			<div class="mmCmmInput date fnDatePicker">';
	contents+='				<div class="ip">';
	contents+='					<input type="text" value="" name="gde_edate" placeholder="합격년월" onkeyup="numCheck(this, \'int\'); changeDateType(this); fn_school_e_div(this);" onblur="chkDateType(this)" maxlength="6" />';
	contents+='				</div>';
	contents+='			</div>';
	contents+='		</div>';
	contents+='	</div>';
	contents+='	<div class="MT30">';
	contents+='		<div class="mmCmmInput radiochk sm">';
	contents+='			<input type="checkbox" id="CC'+count+'" name="gde" value="1" onclick="fn_chk(this);"/>';
	contents+='			<label for="CC'+count+'" class="lb FWB">대입 검정고시</label>';
	contents+='		</div>';
	contents+='	</div>';
	contents+='	<div class="mmBtnsWrap MT30 TXTC">';
	contents+='		<div class="mmRow">';
	contents+='			<div class="mmCol6">';
	contents+= '				<a href="#;" class="mmBtns blue2 outline FWB" onclick="fn_remove(this, true);">삭제하기</a>';
	contents+='			</div>';
	contents+='		</div>';
	contents+='	</div>';
	contents+='	<div class="mmHr MT35"></div>';
	contents+='</div>';
	return contents;
}

//학력사항-대학
function createInput2(_gubun) {
	var contents = '';

	contents+='<div class="cloneTargetDivision MT30 fnCloneTargetDivision">';
	contents+='	<div class="mmRow border colaps">';
	contents+='		<input type="hidden" id="final_scholar" name="final_scholar" value="">';
	contents+='		<input type="hidden" id="univ_kind" name="univ_kind" value="'+_gubun+'">';
	contents+='		<input type="hidden" id="sc_type" name="sc_type" value="2">';
	contents+='		<input type="hidden" id="univ_depth" name="univ_depth" value=""> <!-- 계열코드(X) -->';
	contents+='		<input type="hidden" id="univ_pointavg" name="univ_pointavg" value=""> <!-- 학점기준(X) -->';
	contents+='		<input type="hidden" id="univ_code" name="univ_code" value=""> <!-- 대학코드(X) -->';
	contents+='		<input type="hidden" id="univ_major_code" name="univ_major_code" value=""> <!-- 전공코드(X) -->';
	contents+='		<input type="hidden" id="univ_area" name="univ_area" value=""> <!-- 지역코드(X) -->';
	contents+='		<input type="hidden" id="univ_stype" name="univ_stype" value="1"> <!-- 입학코드(X) -->';
	contents+='		<input type="hidden" id="univ1_grd" name="univ1_grd" value=""> <!-- 학위구분코드(X) -->';
	contents+='		<input type="hidden" id="univ_syear" name="univ_syear" value="">';
	contents+='		<input type="hidden" id="univ_smonth" name="univ_smonth" value="">';
	contents+='		<input type="hidden" id="univ_eyear" name="univ_eyear" value="">';
	contents+='		<input type="hidden" id="univ_emonth" name="univ_emonth" value="">';
	contents+='		<input type="hidden" id="univ_etype" name="univ_etype" value=""> <!-- 졸업상태 -->';
	contents+='		<input type="hidden" id="univ_minor" name="univ_minor" value=""> <!-- 부전공 -->';
	contents+='		<input type="hidden" id="univ_mdepth" name="univ_mdepth" value=""> <!-- 부전공계열코드(X) -->';
	contents+='		<input type="hidden" id="univ_minor_code" name="univ_minor_code" value=""> <!-- 부전공코드(X) -->';
	contents+='		<div class="mmCol12 ">';
	contents+='			<div class="mmCmmInput">';
	contents+='				<div class="ip">';
	contents+='					<input type="text" value="" id="univ_name" name="univ_name" placeholder="학교명을 입력해 주세요." onkeyup="fn_kwSearchItem(this, \'univ\')" autocomplete="off" />';
	contents+='				</div>';
	contents+='				<!-- 검색결과 창 : S -->';
	contents+='				<!-- 상위 클래스 .mmCmmInput 안에 자식으로 있어야함 -->';
	contents+='				<div class="result_box" id="id_result_box">';
	contents+='				</div>';
	contents+='				<!-- 검색결과 창 : E -->';
	contents+='			</div>';
	contents+='		</div>';
	contents+='		<div class="mmCol12">';
	contents+='			<select class="fnCustomSelect" name="select_univ_etype" onchange="fn_sel_value_set(this, \'univ_etype\');">';
	contents+='				<option value="">졸업구분</option>';
	contents+='				<option value="3">재학</option>';
	contents+='				<option value="4">휴학</option>';
	contents+='				<option value="5">중퇴</option>';
	contents+='				<option value="7">졸업(예)</option>';
	contents+='				<option value="8">졸업</option>';
	contents+='			</select>';
	contents+='		</div>';
	contents+='		<div class="mmCol6">';
	contents+='			<div class="mmCmmInput date fnDatePicker">';
	contents+='				<div class="ip">';
	contents+='					<input type="text" value="" name="univ_sdate" placeholder="입학년월" onkeyup="numCheck(this, \'int\'); changeDateType(this); fn_school_s_div(this);" onblur="chkDateType(this)" maxlength="6" />';
	contents+='				</div>';
	contents+='			</div>';
	contents+='		</div>';
	contents+='		<div class="mmCol6">';
	contents+='			<div class="mmCmmInput date fnDatePicker">';
	contents+='				<div class="ip">';
	contents+='					<input type="text" value="" name="univ_edate" placeholder="졸업년월" onkeyup="numCheck(this, \'int\'); changeDateType(this); fn_school_e_div(this);" onblur="chkDateType(this)" maxlength="6" />';
	contents+='				</div>';
	contents+='			</div>';
	contents+='		</div>';
	contents+='	</div>';
	//contents+='	<% If schoolGubun = "6" Then %>';
	if(_gubun == '6'){
	contents+='	<div class="mmTit MT55">학위</div>';
	contents+='	<div class="mmRow border colaps MT20">';
	contents+='		<div class="mmCol12">';
	contents+='			<select class="fnCustomSelect" name="select_univ1_grd" onchange="fn_sel_value_set(this, \'univ1_grd\');">';
	contents+='				<option value="">학위구분</option>';
	contents+='				<option value="1">석사</option>';
	contents+='				<option value="2">박사</option>';
	contents+='				<option value="3">석박사</option>';
	contents+='			</select>';
	contents+='		</div>';
	contents+='	</div>';
	}
	//contents+='	<% End If %>';
	contents+='	<!-- 전공 : S-->';
	contents+='	<div class="mmTit MT55">전공</div>';
	contents+='	<div class="mmRow border colaps MT20">';
	contents+='		<!--';
	contents+='		<div class="mmCol12">';
	contents+='			<select class="fnCustomSelect">';
	contents+='				<option value="">전공을 선택해 주세요. </option>';
	contents+='			</select>';
	contents+='		</div>-->';
	contents+='		<div class="mmCol12 ">';
	contents+='			<div class="mmCmmInput">';
	contents+='				<div class="ip">';
	contents+='					<input type="text" value="" id="univ_major" name="univ_major" placeholder="전공을 입력해 주세요." onkeyup="fn_kwSearchItem(this, \'major\')" autocomplete="off" />';
	contents+='				</div>';
	contents+='				<!-- 검색결과 창 : S -->';
	contents+='				<!-- 상위 클래스 .mmCmmInput 안에 자식으로 있어야함 -->';
	contents+='				<div class="result_box" id="id_result_box">';
	contents+='				</div>';
	contents+='				<!-- 검색결과 창 : E -->';
	contents+='			</div>';
	contents+='		</div>';
	contents+='	</div>';
	contents+='	<!-- 전공 : E-->';
	contents+='	<!-- 학점 : S-->';
	contents+='	<div class="mmTit MT55">학점</div>';
	contents+='	<div class="mmRow border colaps MT20">';
	contents+='		<div class="mmCol8">';
	contents+='			<div class="mmCmmInput">';
	contents+='				<div class="ip">';
	contents+='					<input type="text" value="" id="univ_point" name="univ_point" placeholder="학점을 입력해 주세요." maxlength="4" />';
	contents+='				</div>';
	contents+='			</div>';
	contents+='		</div>';
	contents+='		<div class="mmCol4 ">';
	contents+='			<select class="fnCustomSelect" name="select_univ_pointavg" onchange="fn_sel_value_set(this, \'univ_pointavg\');">';
	contents+='				<option value="">총점</option>';
	contents+='				<option value="4.0">4.0</option>';
	contents+='				<option value="4.3">4.3</option>';
	contents+='				<option value="4.5">4.5</option>';
	contents+='				<option value="7.0">7.0</option>';
	contents+='				<option value="100">100</option>';
	contents+='			</select>';
	contents+='		</div>';
	contents+='	</div>';
	contents+='	<!-- 학점 : E-->';
	contents+='	<!-- 전공추가 : S-->';
	contents+='	<div name="div_univ_add_minor" style="display:none;">';
	contents+='		<div class="mmTit MT55">추가전공</div>';
	contents+='		<div class="mmRow border colaps MT20">';
	contents+='			<div class="mmCol8">';
	contents+='				<div class="mmCmmInput">';
	contents+='					<div class="ip">';
	contents+='						<input type="text" value="" id="univ_minornm" name="univ_minornm" placeholder="전공을 입력해 주세요." onkeyup="fn_kwSearchItem(this, \'major\')" autocomplete="off" />';
	contents+='					</div>';
	contents+='					<!-- 검색결과 창 : S -->';
	contents+='					<!-- 상위 클래스 .mmCmmInput 안에 자식으로 있어야함 -->';
	contents+='					<div class="result_box" id="id_result_box">';
	contents+='					</div>';
	contents+='					<!-- 검색결과 창 : E -->';
	contents+='				</div>';
	contents+='			</div>';
	contents+='			<div class="mmCol4 ">';
	contents+='				<select class="fnCustomSelect" name="select_univ_minor" onchange="fn_sel_value_set(this, \'univ_minor\');">';
	contents+='					<option value="">전공선택</option>';
	contents+='					<option value="부">부전공</option>';
	contents+='					<option value="복수">복수전공</option>';
	contents+='				</select>';
	contents+='			</div>';
	contents+='		</div>';
	contents+='	</div>';
	contents+='	<!-- 전공추가 : E-->';
	contents+='	<div class="mmBtnsWrap TXTC MT25">';
	contents+='		<div class="mmRow">';
	contents+='			<div class="mmCol6"><a href="javascript:;" class="mmBtns blue FWB" onclick="fn_univ_minor(this);"><small class="MR10">+</small>전공 추가</a></div>';
	contents+='		</div>';
	contents+='	</div>';
	contents+='	<!-- 이수과목 및 연구내용 : S-->';
	contents+='	<div class="mmTit MT65">이수과목 및 연구내용</div>';
	contents+='	<div class="mmRow border colaps MT20">';
	contents+='		<div class="mmCol12">';
	contents+='			<div class="mmCmmInput">';
	contents+='				<div class="ip">';
	contents+='					<input type="text" value="" id="univ_research" name="univ_research" placeholder="이수과목 및 연구내용을 입력해 주세요." />';
	contents+='				</div>';
	contents+='			</div>';
	contents+='		</div>';
	contents+='	</div>';
	contents+='	<!-- 이수과목 및 연구내용 : E-->';
	contents+='<div class="mmBtnsWrap MT30 TXTC">';
	contents+='	<div class="mmRow">';
	contents+='		<div class="mmCol6">';
	contents+= '				<a href="#;" class="mmBtns blue2 outline FWB" onclick="fn_remove(this, true);">삭제하기</a>';
	contents+='		</div>';
	contents+='	</div>';
	contents+='</div>';
	contents+='<div class="mmHr MT35"></div>';
	contents+='</div>';

	return contents;
}

//외국어
function createInput7() {
	var language_sel_option = $("#language_sel_option").html();

	var contents = '';

	contents += '<div class="cloneTargetDivision MT30 fnCloneTargetDivision">';
	contents += '	<div class="mmRow border colaps">';
	contents += '		<div class="mmCol12">';
	contents += '			<select class="fnCustomSelect" onchange="fn_language_reset(this);">';
	contents += '				<option value="">선택</option>';
	contents += '				<option value="1">회화능력</option>';
	contents += '				<option value="2">공인시험</option>';
	contents += '			</select>';
	contents += '		</div>';
	contents += '	</div>';
	contents += '	<!--회화-->';
	contents += '	<div class="mmRow border colaps MT60" name="language_type1" style="display:none;">';
	contents += '		<input type="hidden" id="language_name" name="language_name" value="" />';
	contents += '		<input type="hidden" id="language_talk" name="language_talk" value="" />';
	contents += '		<input type="hidden" id="language_read" name="language_read" value="" />';
	contents += '		<input type="hidden" id="language_write" name="language_write" value="" />';
	contents += '		<div class="mmCol12">';
	contents += '			<select class="fnCustomSelect" id="language_title_name" onchange="fn_sel_value_set(this, \'language_name\');">';
	contents += '				<option value="">외국어명을 선택해 주세요.</option>';
	contents += 				language_sel_option;
	contents += '			</select>';
	contents += '		</div>';
	contents += '		<div class="mmCol12">';
	contents += '			<select class="fnCustomSelect" id="language_title_talk" onchange="fn_sel_value_set(this, \'language_talk\');">';
	contents += '				<option value="">회화 능력을 선택해 주세요.</option>';
	contents += '				<option value="1">상</option>';
	contents += '				<option value="2">중</option>';
	contents += '				<option value="3">하</option>';
	contents += '			</select>';
	contents += '		</div>';
	contents += '	</div>';
	contents += '	<!--회화-->';
	contents += '	<!--공인-->';
	contents += '	<div class="mmRow border colaps MT60" name="language_type2" style="display:none;">';
	contents += '		<input type="hidden" id="language_exam_group" name="language_exam_group" value="" />';
	contents += '		<input type="hidden" id="language_exam" name="language_exam" value="" />';
	contents += '		<input type="hidden" id="language_year" name="language_year" value="" />';
	contents += '		<input type="hidden" id="language_month" name="language_month" value="" />';
	contents += '		<input type="hidden" id="language_exam_etc" name="language_exam_etc" value="" />';
	contents += '		<input type="hidden" id="language_grade_opic" name="language_grade_opic" value="" />';
	contents += '		<div class="mmCol12">';
	contents += '			<select class="fnCustomSelect" id="language_title_exam_group" onchange="fn_sel_value_set(this, \'language_exam_group\'); fn_chgLanguage(this);">';
	contents += '				<option value="">외국어명을 선택해 주세요.</option>';
	contents += '				<option value="1">영어</option>';
	contents += '				<option value="2">일본어</option>';
	contents += '				<option value="3">중국어</option>';
	contents += '				<option value="4">프랑스어</option>';
	contents += '				<option value="5">독일어</option>';
	contents += '			</select>';
	contents += '		</div>';
	contents += '		<div class="mmCol12">';
	contents += '			<select class="fnCustomSelect" id="language_title_exam" onchange="fn_sel_value_set(this, \'language_exam\');">';
	contents += '				<option value="">공인 시험 선택</option>';
	contents += '			</select>';
	contents += '		</div>';
	contents += '		<div class="mmCol8">';
	contents += '			<div class="mmCmmInput">';
	contents += '				<div class="ip">';
	contents += '					<input type="text" value="" name="language_grade" placeholder="취득점수/급수를 입력해 주세요." />';
	contents += '				</div>';
	contents += '			</div>';
	contents += '		</div>';
	contents += '		<div class="mmCol4">';
	contents += '			<select class="fnCustomSelect" onchange="fn_sel_value_set(this, \'language_exam_etc\');">';
	contents += '				<option value="">점수/급수 선택</option>';
	contents += '				<option value="1">점수</option>';
	contents += '				<option value="2">급수</option>';
	contents += '			</select>';
	contents += '		</div>';
	contents += '		<div class="mmCol12">';
	contents += '			<div class="mmCmmInput date fnDatePicker">';
	contents += '				<div class="ip">';
	contents += '					<input type="text" value="" name="language_date" placeholder="취득년월" onkeyup="numCheck(this, \'int\'); changeDateType(this); fn_language_div(this);" onblur="chkDateType(this)" maxlength="6" />';
	contents += '				</div>';
	contents += '			</div>';
	contents += '		</div>';
	contents += '	</div>';
	contents += '	<!--공인-->';
	contents += '	<div class="mmBtnsWrap MT30 TXTC">';
	contents += '		<div class="mmRow">';
	contents += '			<div class="mmCol7">';
	contents += '				<a href="#;" class="mmBtns blue2 outline FWB" onclick="fn_remove(this, true);">삭제하기</a>';
	contents += '			</div>';
	contents += '		</div>';
	contents += '	</div>';
	contents += '	<div class="mmHr MT35"></div>';
	contents += '</div>';

	return contents;
}

//자기소개서
function createInput4() {
	var contents = '';

	contents+='<div class="cloneTargetDivision MT30 fnCloneTargetDivision">';
	contents+='	<div class="mmRow border colaps">';
	contents+='		<input type="hidden" id="res_seq" name="res_seq" value="0">';
	contents+='		<div class="mmCol12">';
	contents+='			<div class="mmCmmInput">';
	contents+='				<div class="ip">';
	contents+='					<input type="text" value="" name="res_quotation" placeholder="항목을 입력해 주세요" />';
	contents+='				</div>';
	contents+='			</div>';
	contents+='		</div>';
	contents+='	</div>';
	contents+='	<div class="mmRow colaps MT15">';
	contents+='		<div class="mmCol12">';
	contents+='			<div class="mmCmmInput">';
	contents+='				<div class="ip">';
	contents+='					<textarea value="" id="res_content" name="res_content" placeholder="해당 내용을 입력해 주세요." style="height: 24rem;"></textarea>';
	contents+='				</div>';
	contents+='			</div>';
	contents+='		</div>';
	contents+='	</div>';
	contents += '	<div class="mmBtnsWrap MT30 TXTC">';
	contents += '		<div class="mmRow">';
	contents += '			<div class="mmCol6">';
	contents += '				<a href="#;" class="mmBtns blue2 FWB" onclick="fn_append(\'4\', this);"><small class="MR10">+</small>추가하기</a>';
	contents += '			</div>';
	contents += '			<div class="mmCol6">';
	contents += '				<a href="#;" class="mmBtns blue2 outline FWB" onclick="fn_remove(this, true);">삭제하기</a>';
	contents += '			</div>';
	contents += '		</div>';
	contents += '	</div>';
	contents+='<div class="mmHr MT35"></div>';
	contents+='</div>';

	return contents;
}

//자격증
function createInput8(){
	var contents = '';

	contents+='<div class="cloneTargetDivision MT30 fnCloneTargetDivision">';
	contents+='	<div class="mmRow border colaps">';
	contents+='		<input type="hidden" name="license_code" value="" />';
	contents+='		<input type="hidden" id="license_year" name="license_year" value="" />';
	contents+='		<input type="hidden" id="license_month" name="license_month" value="" />';
	contents+='		<div class="mmCol12 ">';
	contents+='			<div class="mmCmmInput">';
	contents+='				<div class="ip">';
	contents+='					<input type="text" value="" id="license_name" name="license_name" placeholder="자격증명을 입력해 주세요." onkeyup="fn_kwSearchItem(this, \'license\')" autocomplete="off" />';
	contents+='				</div>';
	contents+='				<!-- 검색결과 창 : S -->';
	contents+='				<!-- 상위 클래스 .mmCmmInput 안에 자식으로 있어야함 -->';
	contents+='				<div class="result_box" id="id_result_box">';
	contents+='				</div>';
	contents+='				<!-- 검색결과 창 : E -->';
	contents+='			</div>';
	contents+='		</div>';
	contents+='		<div class="mmCol12 ">';
	contents+='			<div class="mmCmmInput">';
	contents+='				<div class="ip">';
	contents+='					<input type="text" value="" name="license_org" placeholder="발행기관을 입력해 주세요." />';
	contents+='				</div>';
	contents+='			</div>';
	contents+='		</div>';
	contents+='		<div class="mmCol12">';
	contents+='			<div class="mmCmmInput date fnDatePicker">';
	contents+='				<div class="ip">';
	contents+='					<input type="text" value="" name="license_date" placeholder="취득년월" onkeyup="numCheck(this, \'int\'); changeDateType(this); fn_license_div(this);" onblur="chkDateType(this)" maxlength="6" />';
	contents+='				</div>';
	contents+='			</div>';
	contents+='		</div>';
	contents+='	</div>';
	contents+='	<div class="mmBtnsWrap MT30 TXTC">';
	contents+='		<div class="mmRow">';
	contents+='			<div class="mmCol7">';
	contents+='				<a href="#;" class="mmBtns blue2 outline FWB" onclick="fn_remove(this, true);">삭제하기</a>';
	contents+='			</div>';
	contents+='		</div>';
	contents+='	</div>';
	contents+='	<div class="mmHr MT35"></div>';
	contents+='</div>';

	return contents;
}

//교육
function createInput10(){
	var contents = '';

	contents+='<div class="cloneTargetDivision MT30 fnCloneTargetDivision">';
	contents+='	<div class="mmRow border colaps">';
	contents+='		<input type="hidden" id="academy_syear" name="academy_syear" value="" />';
	contents+='		<input type="hidden" id="academy_smonth" name="academy_smonth" value="" />';
	contents+='		<input type="hidden" id="academy_eyear" name="academy_eyear" value="" />';
	contents+='		<input type="hidden" id="academy_emonth" name="academy_emonth" value="" />';
	contents+='		<div class="mmCol12">';
	contents+='			<div class="mmCmmInput">';
	contents+='				<div class="ip">';
	contents+='					<input type="text" value="" name="academy_name" placeholder="교육명을 입력해 주세요." />';
	contents+='				</div>';
	contents+='			</div>';
	contents+='		</div>';
	contents+='		<div class="mmCol12">';
	contents+='			<div class="mmCmmInput">';
	contents+='				<div class="ip">';
	contents+='					<input type="text" value="" name="academy_org_name" placeholder="교육기관을 입력해 주세요." />';
	contents+='				</div>';
	contents+='			</div>';
	contents+='		</div>';
	contents+='		<div class="mmCol6">';
	contents+='			<div class="mmCmmInput date fnDatePicker">';
	contents+='				<div class="ip">';
	contents+='					<input type="text" value="" name="academy_sdate" placeholder="시작년월" onkeyup="numCheck(this, \'int\'); changeDateType(this); fn_education_s_div(this);" onblur="chkDateType(this)" maxlength="6" />';
	contents+='				</div>';
	contents+='			</div>';
	contents+='		</div>';
	contents+='		<div class="mmCol6">';
	contents+='			<div class="mmCmmInput date fnDatePicker">';
	contents+='				<div class="ip">';
	contents+='					<input type="text" value="" name="academy_edate" placeholder="종료년월" onkeyup="numCheck(this, \'int\'); changeDateType(this); fn_education_e_div(this);" onblur="chkDateType(this)" maxlength="6" />';
	contents+='				</div>';
	contents+='			</div>';
	contents+='		</div>';
	contents+='	</div>';
	contents+='	<div class="mmBtnsWrap MT30 TXTC">';
	contents+='		<div class="mmRow">';
	contents+='			<div class="mmCol7">';
	contents+='				<a href="#;" class="mmBtns blue2 outline FWB" onclick="fn_remove(this, true);">삭제하기</a>';
	contents+='			</div>';
	contents+='		</div>';
	contents+='	</div>';
	contents+='	<div class="mmHr MT35"></div>';
	contents+='</div>';

	return contents;
}

//해외경험
function createInput11(){
	var overseas_sel_option = $("#overseas_sel_option").html();

	var contents = '';

	contents+='<div class="cloneTargetDivision MT30 fnCloneTargetDivision">';
	contents+='	<div class="mmRow border colaps">';
	contents+='		<input type="hidden" id="abroad_nation_code" name="abroad_nation_code" value="" />';
	contents+='		<input type="hidden" id="abroad_org_name" name="abroad_org_name" value="" />';
	contents+='		<input type="hidden" id="abroad_syear" name="abroad_syear" value="" />';
	contents+='		<input type="hidden" id="abroad_smonth" name="abroad_smonth" value="" />';
	contents+='		<input type="hidden" id="abroad_eyear" name="abroad_eyear" value="" />';
	contents+='		<input type="hidden" id="abroad_emonth" name="abroad_emonth" value="" />';
	contents+='		<div class="mmCol12">';
	contents+='			<select class="fnCustomSelect" name="select_abroad_nation_code" onchange="fn_sel_value_set(this, \'abroad_nation_code\');">';
	contents+='				<option value="">국가선택</option>';
	contents+=				overseas_sel_option;
	contents+='			</select>';
	contents+='		</div>';
	contents+='		<div class="mmCol6">';
	contents+='			<div class="mmCmmInput date fnDatePicker">';
	contents+='				<div class="ip">';
	contents+='					<input type="text" value="" name="abroad_sdate" placeholder="시작년월" onkeyup="numCheck(this, \'int\'); changeDateType(this); fn_overseas_s_div(this);" onblur="chkDateType(this)" maxlength="6" />';
	contents+='				</div>';
	contents+='			</div>';
	contents+='		</div>';
	contents+='		<div class="mmCol6">';
	contents+='			<div class="mmCmmInput date fnDatePicker">';
	contents+='				<div class="ip">';
	contents+='					<input type="text" value="" name="abroad_edate" placeholder="종료년월" onkeyup="numCheck(this, \'int\'); changeDateType(this); fn_overseas_e_div(this);" onblur="chkDateType(this)" maxlength="6" />';
	contents+='				</div>';
	contents+='			</div>';
	contents+='		</div>';
	contents+='	</div>';
	contents+='	<!-- 해외경험 서술 : S-->';
	contents+='	<div class="mmTit MT55">해외경험 서술</div>';
	contents+='	<div class="mmRow border colaps MT20">';
	contents+='		<div class="mmCol12">';
	contents+='			<div class="mmCmmInput">';
	contents+='				<div class="ip">';
	contents+='					<textarea name="abroad_academy_name" value="" placeholder="해외경험 (ex.어학연수, 교환학생, 워킹 홀리데이,해외근무)을 서술해 주세요. "></textarea>';
	contents+='				</div>';
	contents+='			</div>';
	contents+='		</div>';
	contents+='	</div>';
	contents+='	<!-- 해외경험 서술 : E-->';
	contents+='	<div class="mmBtnsWrap MT30 TXTC">';
	contents+='		<div class="mmRow">';
	contents+='			<div class="mmCol7">';
	contents+='				<a href="#;" class="mmBtns blue2 outline FWB" onclick="fn_remove(this, true);">삭제하기</a>';
	contents+='			</div>';
	contents+='		</div>';
	contents+='	</div>';
	contents+='	<div class="mmHr MT35"></div>';
	contents+='</div>';

	return contents;
}
