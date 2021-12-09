<%
'arrPersonal		= arrData(0)(14)'보훈/장애
'arrMilitary		= arrData(0)(15)'병역
'arrEmpSupport		= arrData(0)(16)'고용지원금대상

Dim patriot_flag, protect_flag, handicap_flag, handicap_grd, handicap_grd_nm, emp_support_flag
Dim military_yn, military_nm, kind_class_nm, military_kind, military_class
Dim military_sdate, military_syear, military_smonth, military_edate, military_eyear, military_emonth, military_end

If isArray(arrPersonal) Then
	patriot_flag = arrPersonal(0, 0)	'보훈
	protect_flag = arrPersonal(5, 0)	'취업보호대상
	handicap_flag = arrPersonal(1, 0)	'장애
	handicap_grd = arrPersonal(2, 0)	'장애등급
End If

If isArray(arrEmpSupport) Then 
	emp_support_flag = arrEmpSupport(0, 0) '고용지원금
End If

If isArray(arrMilitary) Then
	military_yn		= arrMilitary(0, 0)
	military_syear	= arrMilitary(3, 0)
	military_smonth	= arrMilitary(4, 0)
	military_eyear	= arrMilitary(5, 0)
	military_emonth	= arrMilitary(6, 0)
	military_kind	= arrMilitary(1, 0)
	military_class	= arrMilitary(2, 0)
	military_end	= arrMilitary(10, 0)
End If

If isDate(military_syear & "-" & military_smonth) Then military_sdate = military_syear & "." & military_smonth
If isDate(military_eyear & "-" & military_emonth) Then military_edate = military_eyear & "." & military_emonth
%>

<script type="text/javascript">
	$(document).ready(function () {
		var patriot_flag, protect_flag, handicap_flag, emp_support_flag, military_yn, military_kind, military_class
		patriot_flag		= "<%=patriot_flag%>";
		protect_flag		= "<%=protect_flag%>";
		handicap_flag		= "<%=handicap_flag%>";
		handicap_grd		= '<%=handicap_grd%>';
		emp_support_flag	= "<%=emp_support_flag%>";
		military_yn			= "<%=military_yn%>";
		military_kind		= "<%=military_kind%>";
		military_class		= "<%=military_class%>";

		if (patriot_flag == "1") {
			$("#patriot_flag").click();
		}
		if (protect_flag == "1") {
			$("#protect_flag").click();
		}
		if (emp_support_flag == "1") {
			$("#emp_support_flag").click();
		}
		
		$('#sel_handicap_grd option').each(function(i) {
			if(this.value == handicap_grd) {
				$('#sel_handicap_grd').initSelectbox(i);
			}
		});

		if (military_yn != "") {
			$('[name="CSN"]').each(function() {
				if (this.value == military_yn) {
					this.checked = true; //checked 처리
				}
			});
			
			if(military_yn == '2' || military_yn == '3' || military_yn == '5') {
				if(military_yn == '2' || military_yn == '3') {
					$('#div_military_end').show();
				}

				$('[name="div_military"]').attr('style','display:none;');
			}
			else {
				$('#sel_military_kind').initSelectbox(military_kind);
				$('#sel_military_class').initSelectbox(military_class);

				$('[name="div_military"]').attr('style','display:block;');
			}
		}
	});

	function fn_military_s_div(obj) {
		if (obj.value.length == 7) {
			$(obj).parents('.cloneTargetDivision').find('#military_syear').val(obj.value.substr(0, 4));
			$(obj).parents('.cloneTargetDivision').find('#military_smonth').val(obj.value.substr(5, 2));
		} else {
			$(obj).parents('.cloneTargetDivision').find('#military_syear').val('');
			$(obj).parents('.cloneTargetDivision').find('#military_smonth').val('');
		}
	}
	function fn_military_e_div(obj) {
		if (obj.value.length == 7) {
			$(obj).parents('.cloneTargetDivision').find('#military_eyear').val(obj.value.substr(0, 4));
			$(obj).parents('.cloneTargetDivision').find('#military_emonth').val(obj.value.substr(5, 2));
		} else {
			$(obj).parents('.cloneTargetDivision').find('#military_eyear').val('');
			$(obj).parents('.cloneTargetDivision').find('#military_emonth').val('');
		}
	}

	function fn_military(obj) {
		var _val = $(obj).val();

		$('#handicap_flag').val('1');

		if(_val == '2' || _val == '3' || _val == '5') {
			if(_val == '2' || _val == '3') {
				$('#div_military_end').show();
			}
			else {
				$('[name="military_end"]').val('');
				$('#div_military_end').hide();
			}
			
			$('#military_kind').val('');
			$('#military_class').val('');
			$('#military_syear').val('');
			$('#military_smonth').val('');
			$('#military_eyear').val('');
			$('#military_emonth').val('');

			$('#sel_military_kind').initSelectbox();
			$('#sel_military_class').initSelectbox();
			$('[name="military_sdate"]').val('');
			$('[name="military_edate"]').val('');

			$('[name="div_military"]').attr('style','display:none;');
		}
		else {
			$('[name="military_end"]').val('');
			$('#div_military_end').hide();

			$('[name="div_military"]').attr('style','display:block;');
		}
	}

	function fn_handicap(obj) {
		if($(obj).val() != '') {
			$('#handicap_flag').val('1');
		}
		else {
			$('#handicap_flag').val('');
		}
	}
</script>

<!-- container -->
<div id="contents" class="sub_page">
	<div class="contents">
		<!-- 이력서등록수정관련:S -->
		<div class="mmResumeWrap">
			<div class="resumCreateWrap MT30">
				<div class="innerWrap">

					<div class="mmResumeVarTable borderNone">
						<div class="cloneTargetDivision MT30 fnCloneTargetDivision">
							<div class="mmRow border colaps">
								<!-- 장애 -->
								<input type="hidden" id="handicap_grd" name="handicap_grd" value="<%=handicap_grd%>" />

								<input type="hidden" id="handicap_flag" name="handicap_flag" value="" />

								<!-- 병역정보 -->
								<input type="hidden" id="military_yn" name="military_yn" value="<%=military_yn%>" />
								<input type="hidden" id="military_syear" name="military_syear" value="<%=military_syear%>" />
								<input type="hidden" id="military_smonth" name="military_smonth" value="<%=military_smonth%>" />
								<input type="hidden" id="military_eyear" name="military_eyear" value="<%=military_eyear%>" />
								<input type="hidden" id="military_emonth" name="military_emonth" value="<%=military_emonth%>" />
								<input type="hidden" id="military_work" name="military_work" value="" />
								
								<input type="hidden" id="military_kind" name="military_kind" value="<%=military_kind%>" />
								<input type="hidden" id="military_class" name="military_class" value="<%=military_class%>" />

								<div class="mmCol12 absRight absRight150">
									<div class="mmCmmInput">
										<div class="ip">
											<input type="text" value="" name="" placeholder="보훈 대상" />
										</div>
									</div>
									<div class="absTarget TXTR">
										<div class="mmCmmInput radiochk sm inline">
											<input type="checkbox" id="patriot_flag" name="patriot_flag" value="1">
											<label for="patriot_flag" class="lb FWB">대상</label>
										</div>
									</div>
								</div>
								<div class="mmCol12 absRight absRight150">
									<div class="mmCmmInput">
										<div class="ip">
											<input type="text" value="" name="" placeholder="취업보호 대상" />
										</div>
									</div>
									<div class="absTarget TXTR">
										<div class="mmCmmInput radiochk sm inline">
											<input type="checkbox" id="protect_flag" name="protect_flag" value="1">
											<label for="protect_flag" class="lb FWB">대상</label>
										</div>
									</div>
								</div>
								<div class="mmCol12 absRight absRight150">
									<div class="mmCmmInput">
										<div class="ip">
											<input type="text" value="" name="" placeholder="고용지원금 대상" />
										</div>
									</div>
									<div class="absTarget TXTR">
										<div class="mmCmmInput radiochk sm inline">
											<input type="checkbox" id="emp_support_flag" name="emp_support_flag" value="1">
											<label for="emp_support_flag" class="lb FWB">대상</label>
										</div>
									</div>
								</div>
							</div>
							
							<div class="mmTit MT50">장애</div>
							<div class="mmRow border colaps MT20">
								<div class="mmCol12">
									<select class="fnCustomSelect" id="sel_handicap_grd" onchange="fn_sel_value_set(this, 'handicap_grd'); fn_handicap(this);">
										<option value="">장애등급 선택</option>
										<option value="1">1급</option>
										<option value="2">2급</option>
										<option value="3">3급</option>
										<option value="4">4급</option>
										<option value="5">5급</option>
										<option value="6">6급</option>
									</select>
								</div>
							</div>
							
								
							<div class="mmTit borderBottom MT50">병역사항</div>
							<div class="mmGridBoxWrap isCheckRadio MT20">
								<div class="mmRow allPadding">
									<%
									For ii=1 To 5
										Dim mili_chk_txt
										Select Case ii
											Case 1 mili_chk_txt = "군필"
											Case 2 mili_chk_txt = "미필"
											Case 3 mili_chk_txt = "면제"
											Case 4 mili_chk_txt = "복무중"
											Case 5 mili_chk_txt = "해당없음"
										End Select
									%>
									<div class="mmCol4">
										<input type="radio" id="CS<%=ii%>" value="<%=ii%>" name="CSN" onclick="fn_sel_value_set(this, 'military_yn'); fn_military(this);">
										<label for="CS<%=ii%>" class="mmGridBox">
											<span class="mgbInner"><%=mili_chk_txt%></span>
										</label>
									</div>
									<% Next %>
									<div class="mmCmmInput" id="div_military_end" style="display:none;">
										<div class="ip">
											<input type="text" value="<%=military_end%>" name="military_end" placeholder="사유입력" />
										</div>
									</div>
								</div>
							</div>
							<div class="mmRow border colaps MT30" name="div_military" style="display:none;">
								<div class="mmCol6">
									<select class="fnCustomSelect" id="sel_military_kind" onchange="fn_sel_value_set(this, 'military_kind');">
										<option value="">군별</option>
										<% Call putCodeToSelectOption("getMilitaryKind", 1, 99, "") %>
									</select>
								</div>
								<div class="mmCol6">
									<select class="fnCustomSelect" id="sel_military_class" onchange="fn_sel_value_set(this, 'military_class');">
										<option value="">계급</option>
										<% Call putCodeToSelectOption("getMilitaryClass", 1, 19, "") %>
									</select>
								</div>
								<div class="mmCol6" style="border-left: none;">
									<div class="mmCmmInput date fnDatePicker">
										<div class="ip">
											<input type="text" value="<%=military_sdate%>" name="military_sdate" placeholder="시작년월" onkeyup="numCheck(this, 'int'); changeDateType(this); fn_military_s_div(this);" onblur="chkDateType(this)" maxlength="6" />
										</div>
									</div>
								</div>
								<div class="mmCol6">
									<div class="mmCmmInput date fnDatePicker">
										<div class="ip">
											<input type="text" value="<%=military_edate%>" name="military_edate" placeholder="종료년월" onkeyup="numCheck(this, 'int'); changeDateType(this); fn_military_e_div(this);" onblur="chkDateType(this)" maxlength="6" />
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="mmCmmLst indent indent15 MT30">
							<div class="cmmtp mmFontSize21 FWB mmColorBlack">※ 민감정보 수집에 대한 사전 안내</div>
							<div class="cmmtp mmFontSize18 mmColorBlack">① 수집ㆍ이용목적 : 개인회원 의사에 따른 구직활동</div>
							<div class="cmmtp mmFontSize18 mmColorBlack">② 수집 항목 : 병역사항</div>
							<div class="cmmtp mmFontSize18 mmColorBlack">③ 보유 및 이용기간 : 서비스 이용시 까지</div>
							<div class="cmmtp mmFontSize18 mmColorBlack">④ 민감정보는 선택항목이며, 입력하지 않더라도 이력서 작성에 제한을 두지 않습니다.</div>
						</div>


						<div class="mmBtnsWrap MT80 TXTC">
							<div class="mmRow">
								<div class="mmCol6">
									<a href="javascript:;" class="mmBtns navy outline FWB" onclick="fn_move();">취소하기</a>
								</div>
								<div class="mmCol6">
									<% If rtype = "C" Then %>
									<a href="javascript:;" class="mmBtns navy FWB" onclick="fn_resume_save2();">저장하기</a>
									<% Else %>
									<a href="javascript:;" class="mmBtns navy FWB" onclick="fn_resume_save_imsi();">저장하기</a>
									<% End If %>
								</div>
							</div>
						</div>
					</div><!-- mmResumeVarTable -->


				</div>
			</div>
		</div>
		<!-- 이력서등록수정관련:S -->
	</div>
</div>
<!-- //container -->