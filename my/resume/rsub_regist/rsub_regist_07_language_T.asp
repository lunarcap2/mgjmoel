<%
If isArray(arrDetail) Then
	If rsubItem = "1" Then
		'회화
		Dim lan_use, lan_use_talk
		lan_use			= arrDetail(2,0)
		lan_use_talk	= arrDetail(3,0)
	Else
		'공인시험
		Dim lan_exam, lan_exam_nm, lan_exam_grade, lan_exam_etc, lan_exma_sYY, lan_exam_sMM
		lan_exam		= arrDetail(2,0)
		lan_exam_nm		= arrDetail(6,0)
		lan_exam_grade	= arrDetail(7,0)
		lan_exam_etc	= arrDetail(10,0)
		lan_exma_sYY	= arrDetail(8,0)
		lan_exam_sMM	= arrDetail(9,0)

		Dim lan_exam_DT
		If isDate(lan_exma_sYY & "-" & lan_exam_sMM) Then lan_exam_DT = lan_exma_sYY & "." & lan_exam_sMM

	End If
End If
%>

<script type="text/javascript" src="https://job3.career.co.kr/js/language_exam.js"></script>
<script>
	$(document).ready(function () {
		var _rsubItem = '<%=rsubItem%>';

		//language_type 선택
		$('[name="select_language_reset"] option').each(function(i) {
			if(this.value == _rsubItem) {
				$('[name="select_language_reset"]').initSelectbox(i);

				if(this.value == '1') {
					$('[name="language_type1"]').show();
				}
				else if(this.value == '2') {
					$('[name="language_type2"]').show();
				}

				fn_language_set();
			}
		});
	});

	function fn_language_set() {
		var _lan_use		= '<%=lan_use%>';
		var _lan_use_talk	= '<%=lan_use_talk%>';
		var _lan_exam		= '<%=lan_exam%>';
		var _lan_exam_nm	= '<%=lan_exam_nm%>';
		var _lan_exam_etc	= '<%=lan_exam_etc%>';

		//회화(외국어명)
		$('[name="language_title_name"] option').each(function(i) {
			if(this.value == _lan_use) {
				$('[name="language_title_name"]').initSelectbox(i);
			}
		});

		//회화(능력)
		$('[name="language_title_talk"] option').each(function(i) {
			if(this.value == _lan_use_talk) {
				$('[name="language_title_talk"]').initSelectbox(i);
			}
		});

		//공인시험(외국어명)
		$('[name="language_title_exam_group"] option').each(function(i) {
			if(this.value == _lan_exam) {
				$('[name="language_title_exam_group"]').initSelectbox(i);
				fn_chgLanguage(this);
			}
		});
		
		//공인시험(공인시험)
		$('[name="language_title_exam"] option').each(function(i) {
			if(this.value == _lan_exam_nm) {
				$('[name="language_title_exam"]').initSelectbox(i);
			}
		});
		
		//공인시험(점수/급수선택)
		$('[name="select_language_exam_etc"] option').each(function(i) {
			if(this.value == _lan_exam_etc) {
				$('[name="select_language_exam_etc"]').initSelectbox(i);
			}
		});
	}

	function fn_language_reset(obj) {
		if($(obj).val() == 1) {
			//input hidden 초기화
			$(obj).parents('.cloneTargetDivision').find('#language_exam_group').val("");
			$(obj).parents('.cloneTargetDivision').find('#language_exam').val("");
			$(obj).parents('.cloneTargetDivision').find('#language_year').val("");
			$(obj).parents('.cloneTargetDivision').find('#language_month').val("");

			//input text 초기화
			$(obj).parents('.cloneTargetDivision').find('#language_grade').val("");
			$(obj).parents('.cloneTargetDivision').find('#language_date').val("");

			//select 초기화
			$(obj).parents('.cloneTargetDivision').find('#language_title_exam_group').initSelectbox();
			$(obj).parents('.cloneTargetDivision').find('#language_title_exam').initSelectbox();

			$(obj).parents('.cloneTargetDivision').find('[name="language_type1"]').show();
			$(obj).parents('.cloneTargetDivision').find('[name="language_type2"]').hide();
		}
		else if($(obj).val() == 2) {
			//input hidden 초기화
			$(obj).parents('.cloneTargetDivision').find('[name="language_name"]').val('');
			$(obj).parents('.cloneTargetDivision').find('[name="language_talk"]').val('');

			//select 초기화
			$(obj).parents('.cloneTargetDivision').find('#language_title_name').initSelectbox();
			$(obj).parents('.cloneTargetDivision').find('#language_title_talk').initSelectbox();

			$(obj).parents('.cloneTargetDivision').find('[name="language_type1"]').hide();
			$(obj).parents('.cloneTargetDivision').find('[name="language_type2"]').show();
		}
	}

	function fn_language_div(obj) {
		if (obj.value.length == 7) {
			$(obj).parents( '.cloneTargetDivision').find("#language_year").val(obj.value.substr(0, 4));
			$(obj).parents( '.cloneTargetDivision').find("#language_month").val(obj.value.substr(5, 2));
		} else {
			$(obj).parents('.cloneTargetDivision').find("#language_year").val("");
			$(obj).parents('.cloneTargetDivision').find("#language_month").val("");
		}
	}

	// 공인시험 언어선택에 따른 어학시험 bind
	function fn_chgLanguage(obj) {
		//공인시험(시험명)값 초기화
		$(obj).parents('.cloneTargetDivision').find("#language_exam").val('');

		//공인시험(시험명)선택 셀렉트 각 언어에맞는 시험리스트
		var li_html = '';
		var _val = $(obj).val();
		if (trim(_val)) {
			for (var i = 0; i < langex_cd1[_val].length; i++) {
				li_html += '<option value="' + langex_cd1[_val][i] + '">' + langex_nm1[_val][i] + '</option>';
			}

			li_html += '<option value="99">기타</option>';
		}

		$(obj).parents('.cloneTargetDivision').find('#language_title_exam').html(li_html);
	}
</script>

<!-- container -->
<div id="language_sel_option" style="display:none;">
	<% Call putCodeToSelectOption("getLanguageCode", 1, 99, "") %>
</div>

<div id="contents" class="sub_page">
	<div class="contents">
		<!-- 이력서등록수정관련:S -->
		<div class="mmResumeWrap">
			<div class="resumCreateWrap">
				<div class="innerWrap">

					<div class="mmResumeVarTable borderNone" name="div_language">
						<!-- 클론영역:S -->
						<div class="cloneTargetDivision MT30 fnCloneTargetDivision">
							<div class="mmRow border colaps">
								<input type="hidden" id="language_type" name="language_type" value="<%=rsubItem%>">

								<div class="mmCol12">
									<select class="fnCustomSelect" name="select_language_reset" onchange="fn_language_reset(this); fn_sel_value_set(this, 'language_type');">
										<option value="">선택</option>
										<option value="1">회화능력</option>
										<option value="2">공인시험</option>
									</select>
								</div>
							</div>

							<!--회화-->
							<div class="mmRow border colaps MT60" name="language_type1" style="display:none;">
								<input type="hidden" id="language_name" name="language_name" value="<%=lan_use%>" />
								<input type="hidden" id="language_talk" name="language_talk" value="<%=lan_use_talk%>" />
								<input type="hidden" id="language_read" name="language_read" value="" />
								<input type="hidden" id="language_write" name="language_write" value="" />

								<div class="mmCol12">
									<select class="fnCustomSelect" id="language_title_name" name="language_title_name" onchange="fn_sel_value_set(this, 'language_name');">
										<option value="">외국어명을 선택해 주세요.</option>
										<% Call putCodeToSelectOption("getLanguageCode", 1, 99, "") %>
									</select>
								</div>
								<div class="mmCol12">
									<select class="fnCustomSelect" id="language_title_talk" name="language_title_talk" onchange="fn_sel_value_set(this, 'language_talk');">
										<option value="">회화 능력을 선택해 주세요.</option>
										<option value="1">상</option>
										<option value="2">중</option>
										<option value="3">하</option>
									</select>
								</div>
							</div>
							<!--회화-->

							<!--공인-->
							<div class="mmRow border colaps MT60" name="language_type2" style="display:none;">
								<input type="hidden" id="language_exam_group" name="language_exam_group" value="<%=lan_use%>" />
								<input type="hidden" id="language_exam" name="language_exam" value="<%=lan_exam_nm%>" />
								<input type="hidden" id="language_year" name="language_year" value="<%=lan_exam_sYY%>" />
								<input type="hidden" id="language_month" name="language_month" value="<%=lan_exam_sMM%>" />

								<input type="hidden" id="language_exam_etc" name="language_exam_etc" value="<%=lan_exam_etc%>" />
								<input type="hidden" id="language_grade_opic" name="language_grade_opic" value="" />

								<div class="mmCol12">
									<select class="fnCustomSelect" id="language_title_exam_group" name="language_title_exam_group" onchange="fn_sel_value_set(this, 'language_exam_group'); fn_chgLanguage(this);">
										<option value="">외국어명을 선택해 주세요.</option>
										<option value="1">영어</option>
										<option value="2">일본어</option>
										<option value="3">중국어</option>
										<option value="4">프랑스어</option>
										<option value="5">독일어</option>
									</select>
								</div>

								<div class="mmCol12">
									<select class="fnCustomSelect" id="language_title_exam" name="language_title_exam" onchange="fn_sel_value_set(this, 'language_exam');">
										<option value="">공인 시험 선택</option>
									</select>
								</div>
								<div class="mmCol8">
									<div class="mmCmmInput">
										<div class="ip">
											<input type="text" value="<%=lan_exam_grade%>" name="language_grade" placeholder="취득점수/급수를 입력해 주세요." />
										</div>
									</div>
								</div>
								<div class="mmCol4">
									<select class="fnCustomSelect" name="select_language_exam_etc" onchange="fn_sel_value_set(this, 'language_exam_etc');">
										<option value="">점수/급수 선택</option>
										<option value="1">점수</option>
										<option value="2">급수</option>
									</select>
								</div>
								<div class="mmCol12">
									<div class="mmCmmInput date fnDatePicker">
										<div class="ip">
											<input type="text" value="<%=lan_exam_DT%>" name="language_date" placeholder="취득년월" onkeyup="numCheck(this, 'int'); changeDateType(this); fn_language_div(this);" onblur="chkDateType(this)" maxlength="6" />
										</div>
									</div>
								</div>
							</div>
							<!--공인-->

							<% If rsub_seq_no = "" Then %>
							<div class="mmBtnsWrap MT30 TXTC">
								<div class="mmRow">
									<div class="mmCol6">
										<a href="javascript:;" class="mmBtns blue2 FWB" onclick="fn_append('<%=rsubGubun%>', this);"><small class="MR10">+</small>외국어 추가하기</a>
									</div>
								</div>
							</div>
							<% End If %>

							<div class="mmHr MT35"></div>
						</div>

					</div><!-- mmResumeVarTable -->



					<div class="mmBtnsWrap MT80 TXTC">
						<div class="mmRow">
							<div class="mmCol6">
								<a href="javascript:;" class="mmBtns navy outline FWB" onclick="fn_move();">취소하기</a>
							</div>
							<div class="mmCol6">
								<% If rsub_seq_no <> "" Then %>
								<a href="javascript:;" class="mmBtns navy FWB" onclick="fn_resume_update();">저장하기</a>
								<% Else %>
									<% If rtype = "C" Then %>
									<a href="javascript:;" class="mmBtns navy FWB" onclick="fn_resume_save2();">저장하기</a>
									<% Else %>
									<a href="javascript:;" class="mmBtns navy FWB" onclick="fn_resume_save_imsi();">저장하기</a>
									<% End If %>
								<% End If %>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 이력서등록수정관련:S -->
	</div>
</div>
<!-- //container -->