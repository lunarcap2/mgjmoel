<script type="text/javascript">
	function fn_set_area_change(obj, _i) {
		$('[name="area_ul_list1"]').attr('class', 'mmtpBtns'); //1차지역 class off
		$(obj).attr('class', 'mmtpBtns on'); //선택한 1차지역 class on

		$('[name="area_ul_list2"]').hide(); //2차지역 전체숨김
		$("#area_ul_list2_" + _i).show(); //선택한 1차지역의 2차지역 리스트 노출

		// 지역2차 체크박스(로드된 값 있을경우)
		if ($('[name="resume_area_sub"]').length > 0) {
			var resume_area_sub_val = "";

			$('[name="resume_area_sub"]').each(function(index, item) {
				resume_area_sub_val = this.value

				$('[name="area_check2_val"]').each(function() {
					if (this.value == resume_area_sub_val) {
						this.checked = true;
					}
				});
			});			
		}
	}

	// 2차지역 선택
	function fn_set_area2(obj, _area1_cd, _area1_nm) {
		var area2_cd, area2_nm, area2_checked
		area2_cd = $(obj).val();
		area2_nm = $(obj).next().html();
		area2_checked = $(obj).is(":checked");

		if (area2_checked) {
			var area_check2_cnt = $('input:checkbox[name="area_check2_val"]:checked').length;

			if (area_check2_cnt > 10) {
				alert("희망 근무지는 최대 10개까지 선택이 가능합니다.");
				fn_set_area2_del(area2_cd);
				return;
			}
			else {
				fn_area2_html(_area1_cd, _area1_nm, area2_cd, area2_nm);
			}
		}
		else {
			fn_set_area2_del(area2_cd);
		}
	}
	
	//선택값 하단에 셋팅
	function fn_area2_html(_area1_cd, _area1_nm, _area2_cd, _area2_nm) {
		var up_html = '';

		up_html += '<div class="tt">';
		up_html += '	<input type="hidden" name="view_resume_area" value="' + _area1_cd + '">'
		up_html += '	<input type="hidden" name="view_resume_area_nm" value="' + _area1_nm + '">'
		up_html += '	<input type="hidden" name="view_resume_area_sub" value="' + _area2_cd + '">'
		up_html += '	<input type="hidden" name="view_resume_area_sub_nm" value="' + _area2_nm + '">'
		up_html += 		_area1_nm
		up_html += '	<span class="mmColorBlue2">></span> ' + _area2_nm
		up_html += '	<a href="javascript:;" class="clBtn" title="삭제" onclick="fn_set_area2_del(\'' + _area2_cd + '\')"></a>';
		up_html += '</div>';

		$('#btm_item_list').append(up_html);
	}

	// 선택한 지역삭제, 체크해제
	function fn_set_area2_del(_val) {
		// 하단부 선택된 지역표기 삭제
		$('input[name="view_resume_area_sub"]').each(function() {
			if (this.value == _val) {
				$(this).parents(".tt").remove();
			}
		});

		// 지역2차 선택된 체크박스 해제
		$('input:checkbox[name="area_check2_val"]').each(function() {
			if (this.value == _val) {
				this.checked = false;
			}
		});
	}

	// 지역값 조건저장
	function fn_save_area() {
		var out_html = '';
		var set_area_cnt = $('[name="view_resume_area"]').length;
		
		for (i=0; i<set_area_cnt; i++) {
			var resume_area			= $('[name="view_resume_area"]').eq(i).val();
			var resume_area_nm		= $('[name="view_resume_area_nm"]').eq(i).val();
			var resume_area_sub		= $('[name="view_resume_area_sub"]').eq(i).val();
			var resume_area_sub_nm	= $('[name="view_resume_area_sub_nm"]').eq(i).val();

			out_html += '<input type="hidden" name="resume_area" value="'+ resume_area +'">';
			out_html += '<input type="hidden" name="resume_area_nm" value="'+ resume_area_nm +'">';
			out_html += '<input type="hidden" name="resume_area_sub" value="'+ resume_area_sub +'">';
			out_html += '<input type="hidden" name="resume_area_sub_nm" value="'+ resume_area_sub_nm +'">';
			out_html += '<input type="text" value="' + resume_area_nm + ' > ' + resume_area_sub_nm + '" readonly />';
		}

		$('#div_hope_area').html(out_html);
	}
</script>

<div class="contents" style="padding-bottom: 0;">
	<!-- 이력서등록수정관련:S -->
	<div class="mmResumeWrap">
		<div class="resumCreateWrap">
			<div class="mmScrArea">
				<!--
				<style>
					html,body,#contents,.contents,.mmResumeWrap,.resumCreateWrap,.mmScrArea{height: 100%;}
					html,body,#contents{height: 100%; height: calc(100% - (4.2rem + 0.6111rem + 0.6111rem));}
					.mmScrArea .mmScrRow{height: 100vh; height: calc(100% - (0.6111rem + 0.6111rem + 16.4444rem));}
				</style>
				-->
				<div class="mmHr"></div>
				<div class="mmScrRow">
					<div class="mmScrCol6">
						<ul class="mmScrLst">
							<!-- 희망근무지역(시) 리스트 forEach : S-->
							<% For i=0 To UBound(arrListArea1) %>
							<li class="mmtp">
								<button class="mmtpBtns" name="area_ul_list1" onclick="fn_set_area_change(this, '<%=i%>')"><%=arrListArea1(i, 1)%></button>
							</li>
							<% Next %>
							<!-- 희망근무지역(시) 리스트 forEach : E-->
						</ul>
					</div>
					<div class="mmScrCol6">
						<% For i=0 To UBound(arrListArea1) %>
						<ul class="mmScrLst" id="area_ul_list2_<%=i%>" name="area_ul_list2" style="display:none;">
							<!-- 희망근무지역(구) 리스트 forEach : S-->
							<% For ii=0 To UBound(arrListArea2(i)) %>
							<li class="mmtp">
								<input type="checkbox" class="chkrdo" name="area_check2_val" value="<%=arrListArea2(i)(ii, 0)%>" id="CR<%=arrListArea2(i)(ii, 0)%>" onclick="fn_set_area2(this, '<%=arrListArea1(i, 0)%>', '<%=arrListArea1(i, 1)%>')" />
								<label class="lb" for="CR<%=arrListArea2(i)(ii, 0)%>"><%=arrListArea2(i)(ii, 1)%></label>
							</li>
							<% Next %>
							<!-- 희망근무지역(구) 리스트 forEach : E-->
						</ul>
						<% Next %>
					</div>
				</div>
				<div class="mmHr"></div>
				<div class="mmScrBottom">
					<div class="innerWrap">
						<div class="mmBreadCom ">
							<div class="tp ">
								<span class="lb">지역</span>
								<div id="btm_item_list" class="txts">
									<%
									If isArray(arrArea) Then
										For i=0 To UBound(arrArea, 2)
									%>
									<div class="tt">
										<input type="hidden" name="view_resume_area" value="<%=arrArea(0, i)%>">
										<input type="hidden" name="view_resume_area_nm" value="<%=getAcName(arrArea(0, i))%>">
										<input type="hidden" name="view_resume_area_sub" value="<%=arrArea(1, i)%>">
										<input type="hidden" name="view_resume_area_sub_nm" value="<%=getAcName(arrArea(1, i))%>">
										<%=getAcName(arrArea(0, i))%><span class="mmColorBlue2">></span> <%=getAcName(arrArea(1, i))%>
										<a href="javascript:;" class="clBtn" title="삭제" onclick="fn_set_area2_del('<%=arrArea(1, i)%>')"></a>
									</div>
									<%
										Next
									End If
									%>
								</div>
							</div>
						</div>
						<div class="mmBtnsWrap TXTC MT35">
							<a href="javascript:;" class="mmBtns navy bold" onclick="fn_hope(''); fn_save_area();"><small class="MR10">+</small>지역 선택완료</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 이력서등록수정관련:S -->
</div>