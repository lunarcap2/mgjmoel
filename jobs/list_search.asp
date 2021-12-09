<!--#include virtual = "/common/common.asp"-->
<!--#include virtual = "/wwwconf/function/db/DBConnection.asp"-->
<!--#include virtual = "/wwwconf/code/code_function_jc.asp"-->

<%

'직종코드 xml
Dim arrListJc1
arrListJc1 = getArrJcList1() '/wwwconf/code/code_function_jc.asp

ReDim arrListJc2(UBound(arrListJc1)) '2차
For i=0 To UBound(arrListJc1)
	arrListJc2(i) = getArrJcList2(arrListJc1(i,0))
Next

arrListJc1 = getArrJcList1() '/wwwconf/code/code_function_jc.asp

Dim jc,ec,sc,wc,ac,kw
If g_LoginChk = 1 Then
ConnectDB DBCon, Application("DBInfo_FAIR")

	Dim strQuery, arrRs, i
	strQuery = "select 직종, 경력, 학력, 직무형태, 지역, 키워드 from 개인_채용검색정보 WITH(NOLOCK) WHERE 개인아이디 = '"& user_id &"'"
	arrRs = arrGetRsSql(DBCon, strQuery, "", "")
	If isArray(arrRs) Then
		jc = arrRs(0, 0)
		ec = arrRs(1, 0)
		sc = arrRs(2, 0)
		wc = arrRs(3, 0)
		ac = arrRs(4, 0)
		kw = arrRs(5, 0)
	End If

DisconnectDB DBCon
End If


%>
<!--#include virtual = "/include/header/header.asp"-->
<script type="text/javascript">

	$(document).ready(function () {
		var loginChk = "<%=g_LoginChk%>";
		if (loginChk == "1") {
			var r_jc = "<%=jc%>";
			var r_ec = "<%=ec%>";
			var r_sc = "<%=sc%>";
			var r_wc = "<%=wc%>";
			var r_ac = "<%=ac%>";
			var r_kc = "<%=kw%>";

			r_jc = r_jc.split("|");
			r_ec = r_ec.split("|");
			r_sc = r_sc.split("|");
			r_wc = r_wc.split("|");
			r_ac = r_ac.split("|");

			$('[name="sch_jc_hk"]').each(function() {
				for (var i=0; i<r_jc.length; i++) {
					if (this.value == r_jc[i]) this.checked = true;
				}
			});
			$('[name="ec"]').each(function() {
				for (var i=0; i<r_ec.length; i++) {
					if (this.value == r_ec[i]) this.checked = true;
				}
			});
			$('[name="sc"]').each(function() {
				for (var i=0; i<r_sc.length; i++) {
					if (this.value == r_sc[i]) this.checked = true;
				}
			});
			$('[name="wc"]').each(function() {
				for (var i=0; i<r_wc.length; i++) {
					if (this.value == r_wc[i]) this.checked = true;
				}
			});
			$('[name="ac"]').each(function() {
				for (var i=0; i<r_ac.length; i++) {
					if (this.value == r_ac[i]) this.checked = true;
				}
			});


		}



	});


	function fn_search() {

		if (typeof($('#conditional_save')) != 'undefined' && $('#conditional_save').is(":checked") == true) {
			var jc_val = "";
			var ec_val = "";
			var sc_val = "";
			var wc_val = "";
			var ac_val = "";
			var kw_val = "";

			$('input[name="sch_jc_hk"]').each(function() {
				if(this.checked) {
					jc_val += "|" + this.value;
				}
			});
			$('input[name="ec"]').each(function() {
				if(this.checked) {
					ec_val += "|" + this.value;
				}
			});
			$('input[name="sc"]').each(function() {
				if(this.checked) {
					sc_val += "|" + this.value;
				}
			});
			$('input[name="wc"]').each(function() {
				if(this.checked) {
					wc_val += "|" + this.value;
				}
			});
			$('input[name="ac"]').each(function() {
				if(this.checked) {
					ac_val += "|" + this.value;
				}
			});
			kw_val = $('input[name="kw"]').val();

			if (jc_val != "") { jc_val = jc_val.substring(1); }
			if (ec_val != "") { ec_val = ec_val.substring(1); }
			if (sc_val != "") { sc_val = sc_val.substring(1); }
			if (wc_val != "") { wc_val = wc_val.substring(1); }
			if (ac_val != "") { ac_val = ac_val.substring(1); }

			$.ajax({
				url: "./proc_conditional_save.asp",
				type: "POST",
				dataType: "text",
				data: ({
					"jc_val": jc_val,
					"ec_val": ec_val,
					"sc_val": sc_val,
					"wc_val": wc_val,
					"ac_val": ac_val,
					"kw_val": kw_val,
				}),
				success: function (data) {
					document.frm.submit();
				},
				error: function (req, status, err) {
					alert("처리 도중 오류가 발생하였습니다.\n" + err);
				}
			});
		} else {
			document.frm.submit();
		}
	}
</script>
</head>

<body>

<!-- header -->
<div  id="header">
	<div class="header-wrap detail">
		<div class="detail_box">
			<a href="<%=strRefer%>">이전</a>
			<p>검색</p>
		</div>
		</div>
	</div>
</div>
<!-- //header -->


<!-- container -->
<div id="contents" class="sub_page">
	<div class="contents detail">
		<!-- list_area -->
		<div class="sch_area">

			<form id="frm" name="frm" method="get" action="./list.asp">

			<div class="sch_box cust_sch_box">
				<div class="tit">
					<h3>직무선택</h3>
				</div>
				<ul>
					<%
						For i=0 To UBound(arrListJc1)
							If arrListJc1(i, 0) <> "O0" Then
					%>
					<li>
						<label class="checkbox" for="sc_1_<%=i%>">
							<input type="checkbox" class="chk" id="sc_1_<%=i%>" name="jc1" value="<%=arrListJc1(i, 0)%>" onclick="">
							<span><%=arrListJc1(i, 1)%></span>
						</label>
					</li>
					<%
							End If
						Next
					%>
				</ul>
			</div>

			<div class="sch_box cust_sch_box">
				<div class="tit">
					<h3>경력</h3>
				</div>
				<ul>
					<li>
						<label class="radiobox on" for="sc_2_1">
							<input type="radio" class="rdi" id="sc_2_1" name="ec" value="" onclick="">
							<span>전체</span>
						</label>
					</li>
					<li>
						<label class="radiobox on" for="sc_2_2">
							<input type="radio" class="rdi" id="sc_2_2" name="ec" value="1" onclick="">
							<span>신입</span>
						</label>
					</li>
					<li>
						<label class="radiobox on" for="sc_2_3">
							<input type="radio" class="rdi" id="sc_2_3" name="ec" value="8" onclick="">
							<span>경력</span>
						</label>
					</li>
				</ul>
				<label class="checkbox" for="chk_irr1">
					<input type="checkbox" class="chk" id="chk_irr1" name="ec" value="0" onclick="">
					<span>경력무관</span>
				</label>
			</div>

			<div class="sch_box cust_sch_box">
				<div class="tit">
					<h3>학력</h3>
				</div>
				<ul>
					<li>
						<label class="radiobox on" for="sc_3_1">
							<input type="radio" class="rdi" id="sc_3_1" name="sc" value="" onclick="">
							<span>전체</span>
						</label>
					</li>
					<li>
						<label class="radiobox on" for="sc_3_2">
							<input type="radio" class="rdi" id="sc_3_2" name="sc" value="5,4" onclick="">
							<span>대학원</span>
						</label>
					</li>
					<li>
						<label class="radiobox on" for="sc_3_3">
							<input type="radio" class="rdi" id="sc_3_3" name="sc" value="3" onclick="">
							<span>대학교(4년) 졸업</span>
						</label>
					</li>
					<li>
						<label class="radiobox on" for="sc_3_4">
							<input type="radio" class="rdi" id="sc_3_4" name="sc" value="2" onclick="">
							<span>대학(2~3년)졸업</span>
						</label>
					</li>
					<li>
						<label class="radiobox on" for="sc_3_5">
							<input type="radio" class="rdi" id="sc_3_5" name="sc" value="1" onclick="">
							<span>고등학교 졸업</span>
						</label>
					</li>
					<li>
						<label class="radiobox on" for="sc_3_6">
							<input type="radio" class="rdi" id="sc_3_6" name="sc" value="6" onclick="">
							<span>고등학교 이하</span>
						</label>
					</li>
				</ul>
				<label class="checkbox" for="chk_irr2">
					<input type="checkbox" class="chk" id="chk_irr2" name="sc" value="" onclick="">
					<span>학력무관</span>
				</label>
			</div>

			<div class="sch_box cust_sch_box">
				<div class="tit">
					<h3>직무형태</h3>
				</div>
				<ul>
					<li>
						<label class="checkbox all" for="sc_4_1">
							<input type="checkbox" class="chk" id="sc_4_1" name="wc" value="" onclick="">
							<span>전체</span>
						</label>
					</li>
					<li>
						<label class="checkbox" for="sc_4_2">
							<input type="checkbox" class="chk" id="sc_4_2" name="wc" value="1" onclick="">
							<span>정규직</span>
						</label>
					</li>
					<li>
						<label class="checkbox" for="sc_4_3">
							<input type="checkbox" class="chk" id="sc_4_3" name="wc" value="7" onclick="">
							<span>계약직</span>
						</label>
					</li>
					<li>
						<label class="checkbox" for="sc_4_4">
							<input type="checkbox" class="chk" id="sc_4_4" name="wc" value="6" onclick="">
							<span>인턴직</span>
						</label>
					</li>
					<li>
						<label class="checkbox" for="sc_4_5">
							<input type="checkbox" class="chk" id="sc_4_5" name="wc" value="5" onclick="">
							<span>병역특례</span>
						</label>
					</li>
					<li>
						<label class="checkbox" for="sc_4_6">
							<input type="checkbox" class="chk" id="sc_4_6" name="wc" value="10" onclick="">
							<span>위촉직</span>
						</label>
					</li>
					<li>
						<label class="checkbox" for="sc_4_7">
							<input type="checkbox" class="chk" id="sc_4_7" name="wc" value="2" onclick="">
							<span>해외취업</span>
						</label>
					</li>
					<li>
						<label class="checkbox" for="sc_4_8">
							<input type="checkbox" class="chk" id="sc_4_8" name="wc" value="11" onclick="">
							<span>프리랜서</span>
						</label>
					</li>
					<li>
						<label class="checkbox" for="sc_4_9">
							<input type="checkbox" class="chk" id="sc_4_9" name="wc" value="3" onclick="">
							<span>아르바이트</span>
						</label>
					</li>
					<li>
						<label class="checkbox" for="sc_4_10">
							<input type="checkbox" class="chk" id="sc_4_10" name="wc" value="14" onclick="">
							<span>시간선택제</span>
						</label>
					</li>
				</ul>
			</div>

			<div class="sch_box all cust_sch_box">
				<div class="tit">
					<h3>지역</h3>
				</div>
				<ul>
					<li>
						<label class="checkbox all" for="sc_5_1">
							<input type="checkbox" class="chk" id="sc_5_1" name="ac" value="" onclick="">
							<span>전체</span>
						</label>
					</li>
					<li>
						<label class="checkbox" for="sc_5_2">
							<input type="checkbox" class="chk" id="sc_5_2" name="ac" value="1,3,11" onclick="">
							<span>서울/인천/경기</span>
						</label>
					</li>
					<li>
						<label class="checkbox" for="sc_5_3">
							<input type="checkbox" class="chk" id="sc_5_3" name="ac" value="8,15,16" onclick="">
							<span>대전/충남/충북</span>
						</label>
					</li>
					<li>
						<label class="checkbox" for="sc_5_4">
							<input type="checkbox" class="chk" id="sc_5_4" name="ac" value="5,7" onclick="">
							<span>대구/경북</span>
						</label>
					</li>
					<li>
						<label class="checkbox" for="sc_5_5">
							<input type="checkbox" class="chk" id="sc_5_5" name="ac" value="6,12,13" onclick="">
							<span>광주/전남/전북</span>
						</label>
					</li>
					<li>
						<label class="checkbox" for="sc_5_6">
							<input type="checkbox" class="chk" id="sc_5_6" name="ac" value="2" onclick="">
							<span>강원</span>
						</label>
					</li>
					<li>
						<label class="checkbox" for="sc_5_7">
							<input type="checkbox" class="chk" id="sc_5_7" name="ac" value="4,9,10" onclick="">
							<span>부산/울산/경남</span>
						</label>
					</li>
				</ul>
			</div>

			<div class="key_box cust_sch_box">
				<div class="tit">
					<h3>키워드</h3>
				</div>
				<input type="text" class="txt" style="width:100%;" id="kw" name="kw" value="" placeholder="검색어를 입력해주세요.">

				<% If g_LoginChk = 1 Then %>
				<div class="right_sec">
					<label class="checkbox" for="conditional_save">
						<input type="checkbox" class="chk" id="conditional_save" name="conditional_save" value="1">
						<span>검색조건저장</span>
					</label>
				</div>
				<% End If %>

			</div>

			</form>

			<div class="btn_area">
				<a href="javascript:void(0)" class="btn blue" onclick="fn_search();">검색하기</a>
			</div>

			<script>
				var $boxAll = $('.sch_box.all ul li .checkbox.all input');
				var $boxInput = $('.sch_box.all ul li').not(':first-child').find('input');

				/* 전체선택 */
				$boxAll.change(function(){
					var $boxAllchk = $(this).is(":checked");
					if ( $boxAllchk == true ) {
						$(this).parents('.sch_box.all').find('ul li').not(':first-child').find('input').prop("checked", false)
						.parent().removeClass('on').addClass('off');
					}
				});

				$boxInput.change(function(){
					var $boxInput = $(this).is(":checked");
					if ( $boxInput == true ) {
						$(this).parents('.sch_box.all').find('ul li:first-child').find('input').prop("checked", false)
						.parent().removeClass('on').addClass('off');
					}
				});
			</script>

		</div><!-- sch_area -->
	</div>
</div>
<!-- //container -->


<!-- 하단 -->
<!--#include virtual = "/include/footer.asp"-->
<!-- 하단 -->

</body>
</html>
