<%
If isArray(arrDetail) Then
	Dim univ_nm, univ_etype, univ_sYY, univ_sMM, univ_eYY, univ_eMM, univ_major, univ_point, univ_pointavg, univ_research, univ_minornm, univ_minor, univ_grd
	univ_nm			= arrDetail(3,0)
	univ_etype		= arrDetail(16,0)
	univ_sYY		= arrDetail(6,0)
	univ_sMM		= arrDetail(12,0)
	univ_eYY		= arrDetail(7,0)
	univ_eMM		= arrDetail(13,0)
	univ_major		= arrDetail(5,0)
	univ_point		= arrDetail(8,0)
	univ_pointavg	= arrDetail(9,0)
	univ_research	= arrDetail(25,0)
	univ_minornm	= arrDetail(19,0)
	univ_minor		= arrDetail(18,0)
	univ_grd		= arrDetail(14,0)
End If

Dim univ_sDT, univ_eDT
If isDate(univ_sYY & "-" & univ_sMM) Then univ_sDT = univ_sYY & "." & univ_sMM
If isDate(univ_eYY & "-" & univ_eMM) Then univ_eDT = univ_eYY & "." & univ_eMM
%>

<script type="text/javascript">
	$(document).ready(function () {
		var _univ_etype		= '<%=univ_etype%>';
		var _univ_pointavg	= '<%=univ_pointavg%>';
		var _univ_grd		= '<%=univ_grd%>';
		var _univ_minor		= '<%=univ_minor%>';
		var _univ_minornm	= '<%=univ_minornm%>';
		
		//졸업구분
		$('[name="select_univ_etype"] option').each(function(i) {
			if(this.value == _univ_etype) {
				$('[name="select_univ_etype"]').initSelectbox(i);
			}
		});

		//총점
		$('[name="select_univ_pointavg"] option').each(function(i) {
			if(this.value == _univ_pointavg) {
				$('[name="select_univ_pointavg"]').initSelectbox(i);
			}
		});

		//학위
		$('[name="select_univ1_grd"] option').each(function(i) {
			if(this.value == _univ_grd) {
				$('[name="select_univ1_grd"]').initSelectbox(i);
			}
		});

		//추가전공
		if(_univ_minor != '' || _univ_minornm != '') {
			$('[name="div_univ_add_minor"]').attr('style', 'display:block;');
			$('[name="div_univ_add_minor"]').next().children().children().children().text('추가전공 삭제');

			$('[name="select_univ_minor"] option').each(function(i) {
				if(this.value == _univ_minor) {
					$('[name="select_univ_minor"]').initSelectbox(i);
				}
			});
		}
	});

	function fn_school_s_div(obj) {
		if (obj.value.length == 7) {
			$(obj).parents('.cloneTargetDivision').find('#univ_syear').val(obj.value.substr(0, 4));
			$(obj).parents('.cloneTargetDivision').find('#univ_smonth').val(obj.value.substr(5, 2));
		} else {
			$(obj).parents('.cloneTargetDivision').find('#univ_syear').val('');
			$(obj).parents('.cloneTargetDivision').find('#univ_smonth').val('');
		}
	}

	function fn_school_e_div(obj) {
		if (obj.value.length == 7) {
			$(obj).parents('.cloneTargetDivision').find('#univ_eyear').val(obj.value.substr(0, 4));
			$(obj).parents('.cloneTargetDivision').find('#univ_emonth').val(obj.value.substr(5, 2));
		} else {
			$(obj).parents('.cloneTargetDivision').find('#univ_eyear').val('');
			$(obj).parents('.cloneTargetDivision').find('#univ_emonth').val('');
		}
	}

	//추가전공 관련해서
	function fn_univ_minor(obj) {
		var bool = $('[name="div_univ_add_minor"]').is(':visible');

		if(bool) {
			$(obj).text('전공 추가');
			$(obj).parents('.cloneTargetDivision').find('#univ_minornm').val('');
			$(obj).parents('.cloneTargetDivision').find('#univ_minor').val('');
			$(obj).parents('.cloneTargetDivision').find('[name="select_univ_minor"]').initSelectbox();

			$('[name="div_univ_add_minor"]').attr('style','display:none;');
		}
		else {
			$(obj).text('추가전공 삭제');

			$('[name="div_univ_add_minor"]').attr('style','display:block;');
		}
	}
</script>

<!-- container -->
<div id="contents" class="sub_page">
	<div class="contents">
		<!-- 이력서등록수정관련:S -->
		<div class="mmResumeWrap">
			<div class="resumCreateWrap">
				<div class="innerWrap">

					<div class="mmResumeVarTable borderNone" name="div_school_univ">
						<div class="cloneTargetDivision MT30 fnCloneTargetDivision">
							<div class="mmRow border colaps">
								<input type="hidden" id="final_scholar" name="final_scholar" value="">

								<input type="hidden" id="univ_kind" name="univ_kind" value="<%=schoolGubun%>">
								<input type="hidden" id="sc_type" name="sc_type" value="2">
								<input type="hidden" id="univ_depth" name="univ_depth" value=""> <!-- 계열코드(X) -->
								<input type="hidden" id="univ_pointavg" name="univ_pointavg" value="<%=univ_pointavg%>"> <!-- 학점기준(X) -->
								<input type="hidden" id="univ_code" name="univ_code" value=""> <!-- 대학코드(X) -->
								<input type="hidden" id="univ_major_code" name="univ_major_code" value=""> <!-- 전공코드(X) -->
								<input type="hidden" id="univ_area" name="univ_area" value=""> <!-- 지역코드(X) -->
								<input type="hidden" id="univ_stype" name="univ_stype" value="1"> <!-- 입학코드(X) -->
								<input type="hidden" id="univ1_grd" name="univ1_grd" value="<%=univ_grd%>"> <!-- 학위구분코드(X) -->

								<input type="hidden" id="univ_syear" name="univ_syear" value="<%=univ_sYY%>">
								<input type="hidden" id="univ_smonth" name="univ_smonth" value="<%=univ_sMM%>">
								<input type="hidden" id="univ_eyear" name="univ_eyear" value="<%=univ_eYY%>">
								<input type="hidden" id="univ_emonth" name="univ_emonth" value="<%=univ_eMM%>">
								<input type="hidden" id="univ_etype" name="univ_etype" value="<%=univ_etype%>"> <!-- 졸업상태 -->
								<input type="hidden" id="univ_minor" name="univ_minor" value="<%=univ_minor%>"> <!-- 부전공 -->
								<input type="hidden" id="univ_mdepth" name="univ_mdepth" value=""> <!-- 부전공계열코드(X) -->
								<input type="hidden" id="univ_minor_code" name="univ_minor_code" value=""> <!-- 부전공코드(X) -->

								<input type="hidden" id="gde" name="gde" value=""> <!---대입검정고시-->

								<div class="mmCol12 ">
									<div class="mmCmmInput">
										<div class="ip">
											<input type="text" value="<%=univ_nm%>" id="univ_name" name="univ_name" placeholder="학교명을 입력해 주세요." onkeyup="fn_kwSearchItem(this, 'univ')" autocomplete="off" />
										</div>
										<!-- 검색결과 창 : S -->
										<!-- 상위 클래스 .mmCmmInput 안에 자식으로 있어야함 -->
										<div class="result_box" id="id_result_box">
										</div>
										<!-- 검색결과 창 : E -->
									</div>
								</div>
								<div class="mmCol12">
									<select class="fnCustomSelect" name="select_univ_etype" onchange="fn_sel_value_set(this, 'univ_etype');">
										<option value="">졸업구분</option>
										<option value="3">재학</option>
										<option value="4">휴학</option>
										<option value="5">중퇴</option>
										<option value="7">졸업(예)</option>
										<option value="8">졸업</option>
									</select>
								</div>
								<div class="mmCol6">
									<div class="mmCmmInput date fnDatePicker">
										<div class="ip">
											<input type="text" value="<%=univ_sDT%>" name="univ_sdate" placeholder="입학년월" onkeyup="numCheck(this, 'int'); changeDateType(this); fn_school_s_div(this);" onblur="chkDateType(this)" maxlength="6" />
										</div>
									</div>
								</div>
								<div class="mmCol6">
									<div class="mmCmmInput date fnDatePicker">
										<div class="ip">
											<input type="text" value="<%=univ_eDT%>" name="univ_edate" placeholder="졸업년월" onkeyup="numCheck(this, 'int'); changeDateType(this); fn_school_e_div(this);" onblur="chkDateType(this)" maxlength="6" />
										</div>
									</div>
								</div>
							</div>

							<% If schoolGubun = "6" Then %>
							<div class="mmTit MT55">학위</div>
							<div class="mmRow border colaps MT20">
								<div class="mmCol12">
									<select class="fnCustomSelect" name="select_univ1_grd" onchange="fn_sel_value_set(this, 'univ1_grd');">
										<option value="">학위구분</option>
										<option value="1">석사</option>
										<option value="2">박사</option>
										<option value="3">석박사</option>
									</select>
								</div>
							</div>
							<% End If %>

							<!-- 전공 : S-->
							<div class="mmTit MT55">전공</div>
							<div class="mmRow border colaps MT20">
								<!--
								<div class="mmCol12">
									<select class="fnCustomSelect">
										<option value="">전공을 선택해 주세요. </option>
									</select>
								</div>-->
								<div class="mmCol12 ">
									<div class="mmCmmInput">
										<div class="ip">
											<input type="text" value="<%=univ_major%>" id="univ_major" name="univ_major" placeholder="전공을 입력해 주세요." onkeyup="fn_kwSearchItem(this, 'major')" autocomplete="off" />
										</div>
										<!-- 검색결과 창 : S -->
										<!-- 상위 클래스 .mmCmmInput 안에 자식으로 있어야함 -->
										<div class="result_box" id="id_result_box">
										</div>
										<!-- 검색결과 창 : E -->
									</div>
								</div>
							</div>
							<!-- 전공 : E-->
							<!-- 학점 : S-->
							<div class="mmTit MT55">학점</div>
							<div class="mmRow border colaps MT20">
								<div class="mmCol8">
									<div class="mmCmmInput">
										<div class="ip">
											<input type="text" value="<%=univ_point%>" id="univ_point" name="univ_point" placeholder="학점을 입력해 주세요." maxlength="4" />
										</div>
									</div>
								</div>
								<div class="mmCol4 ">
									<select class="fnCustomSelect" name="select_univ_pointavg" onchange="fn_sel_value_set(this, 'univ_pointavg');">
										<option value="">총점</option>
										<option value="4.0">4.0</option>
										<option value="4.3">4.3</option>
										<option value="4.5">4.5</option>
										<option value="7.0">7.0</option>
										<option value="100">100</option>
									</select>
								</div>
							</div>
							<!-- 학점 : E-->
							<!-- 전공추가 : S-->
							<div name="div_univ_add_minor" style="display:none;">
								<div class="mmTit MT55">추가전공</div>
								<div class="mmRow border colaps MT20">
									<div class="mmCol8">
										<div class="mmCmmInput">
											<div class="ip">
												<input type="text" value="<%=univ_minornm%>" id="univ_minornm" name="univ_minornm" placeholder="전공을 입력해 주세요." onkeyup="fn_kwSearchItem(this, 'major')" autocomplete="off" />
											</div>
											<!-- 검색결과 창 : S -->
											<!-- 상위 클래스 .mmCmmInput 안에 자식으로 있어야함 -->
											<div class="result_box" id="id_result_box">
											</div>
											<!-- 검색결과 창 : E -->
										</div>
									</div>
									<div class="mmCol4 ">
										<select class="fnCustomSelect" name="select_univ_minor" onchange="fn_sel_value_set(this, 'univ_minor');">
											<option value="">전공선택</option>
											<option value="부">부전공</option>
											<option value="복수">복수전공</option>
										</select>
									</div>
								</div>
							</div>
							<!-- 전공추가 : E-->
							<div class="mmBtnsWrap TXTC MT25">
								<div class="mmRow">
									<div class="mmCol6"><a href="javascript:;" class="mmBtns blue FWB" onclick="fn_univ_minor(this);"><small class="MR10">+</small>전공 추가</a></div>
								</div>
							</div>


							<!-- 이수과목 및 연구내용 : S-->
							<div class="mmTit MT65">이수과목 및 연구내용</div>
							<div class="mmRow border colaps MT20">
								<div class="mmCol12">
									<div class="mmCmmInput">
										<div class="ip">
											<input type="text" value="<%=univ_research%>" id="univ_research" name="univ_research" placeholder="이수과목 및 연구내용을 입력해 주세요." />
										</div>
									</div>
								</div>
							</div>
							<!-- 이수과목 및 연구내용 : E-->
							<!--
							<div class="mmBtnsWrap MT30 TXTC">
								<div class="mmRow">
									<div class="mmCol6">
										<a href="javascript:;" class="mmBtns blue2 FWB" onclick="fn_append({code:'<%=rsubGubun%>',gubun:'<%=schoolGubun%>' }, this);"><small class="MR10">+</small>학력 추가하기</a>
									</div>
								</div>
							</div>
							-->
							<div class="mmHr MT35"></div>
						</div>
					</div><!-- mmResumeVarTable -->

					<div class="mmBtnsWrap MT70 TXTC">
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
