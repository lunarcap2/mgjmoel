$(function() {

	$(document).ready(function() {
		tabFnc();//탭
		accordionFnc();//아코디언
		chkFnc();//라디오,체크 여부
		btntogFnc();//버튼토글
        fileboxFnc();//파일박스
        inputFnc();//인풋박스
		inevtFnc();//인풋텍스트 리셋
        selectboxFnc();//셀렉트박스
        checkboxFnc();//체크박스.
		chk_selFnc();
		chkpassFnc();//체크박스 비밀번호 보이기/감추기
        radioboxFnc();//라디오박스
		disableFnc();//비활성시키기2019-10-10
		inexFnc();//ex9 플레이스홀드 포커스
		popFnc();//팝업
		popFnc2();//팝업
		popFnc3();//팝업
		popFnc4();//팝업
		menuboxFnc();//메뉴박스
		

        if($('input.value, textarea.value').length > 0) $('input.value, textarea.value').check();//인풋텍스트 체크
		if($('#calendarBox').length > 0) calendarBoxFnc.init();//달력


		$(window).load(function() {
			if($("#table-id-1").length > 0) calMoreShow();//캘린더 레이어 위치값 가져오기
		});

		//희망서비스 등록팝업
		$(".applicantBtn").click(function(){
			location.href="applicant.asp";
			$(".applicantPop").hide();
		});

	});

	tabFnc = function(){
		$("ul.sel_ul li, .contents .menu_slide a").click(function () {
			$("ul.sel_ul li, .contents .menu_slide a").removeClass("on");
			$(this).addClass("on");
		});//메뉴 지정

		$(".cal td a").click(function () {
			$(".cal td").removeClass("active");
			$(this).parents('td').addClass("active");
		});//달력 날짜 지정
	}

	tabDiv = function (obj, obj1, obj2) { //탭메뉴 ex) tabDiv(this,'.result','.tab1');
		var _this = $(obj);
		var _tab = _this.parent('li')
		var _index = _tab.index()
		var _areaN = $(obj1)
		var _area = $(obj2)

		_tab.addClass('on').siblings("li").removeClass("on")
		_areaN.css("display","block");
		_area.css("display","none");
	}//채용공고 탭

	accordionFnc = function(){
		$(".acco li a").click(function(){
			$(this).addClass('on');
			$(this).next().slideToggle(300);
			// $(this).next().slideDown(300);
			$(".acco li a").not(this).next().slideUp(300);
			$(".acco li a").not(this).removeClass('on');
			return false;
		});
		//$("ul li a").eq(0).trigger("click");
	}

	chkFnc = function (){
		$(".sel_box input").click(function(){
			if($(".sel_box .radiobox").hasClass("on") === true) {
				$(this).parents('.sel_box').prev().addClass('sel');
			}else{
				$(this).parents('.sel_box').prev().removeClass('sel');
			}
		});
	}

	btntogFnc = function(){
		$('.btn_heart').toggle(function() {
			$(this).css('background', 'url("http://image.career.co.kr/career_new/event/2019/landing/wish/heart_on.png")');
		}, function() {
			$(this).css('background', 'url("http://image.career.co.kr/career_new/event/2019/landing/wish/heart.png")');
		});
	}

    function fileboxFnc() {//찾아보기
        $('.filebox input:file').each(function (index, value) {
            $(this).prev().val($(this).val());
        }).bind('click change', function () {
            $(this).prev().val($(this).val());
        }).bind('focus', function () {
            $(this).prev().addClass('on');
        }).bind('blur', function () {
            $(this).prev().removeClass('on');
        });
    }//찾아보기
    inputFnc = function (obj) {//인풋박스
        var _obj = $('.contentWrap');
        var _input = _obj.find('input.pwd');
        var _this, _tmp, _bg = null;
        if (!obj)
            _this = $('input.txt, textarea.area');
        else
            _this = $(obj).find('input.txt, textarea.area');
        _this.unbind('focus blur').bind('focus', function () {
            _bg = ($(this).attr('class').indexOf('bg') > -1) ? true : false;
            $(this).addClass('on');//클래스 방식
            if(_bg) $(this).removeClass('bg');
        }).bind('blur', function () {
            $(this).removeClass('on');//클래스 방식
            if (_bg && $(this).val() == '') $(this).addClass('bg');
        });

        _input.bind('focus', function() {//인풋배경
            if (!$(this).val() || $(this).val()) $(this).addClass('bgnone');
        }).bind('blur', function() {
            if ($(this).val()) $(this).addClass('bgnone');
            else $(this).removeClass('bgnone');
        });
    }//인풋박스

    $.fn.check = function(index) {//인풋텍스트 체크
        return this.each(function(index, value) {
            var _default = $(this).attr('default');
            if(this.value == '' || this.value == _default) {
                $(this).attr('value', _default);
            } else {
                $(this).removeClass('value');
            }
            $(this).bind('focus', function() {
                if(this.value == _default) {
                    this.value = '';
                }
                $(this).removeClass('value');
					
            }).bind('blur', function() {
                if(this.value == '' || this.value == _default) {
                    this.value = _default;
                    $(this).addClass('value');
					$(this).siblings('.in_txt .txt_reset').hide();
                }else {
					$(this).addClass('on');
				}
            });
        });
    };//인풋텍스트 체크

	inevtFnc = function(){ //인풋 포커스, 클릭, val 효과 
		var _re = $('.in_txt .txt_reset');
		var _inTxt = $('.in_txt .txt');
		var _inPass = $('.in_txt .pass');

		$(_inTxt).keydown(function() {
			$(this).siblings(_re).show();
		});

		$(_re).click(function () {
			$(this).hide();
			$(this).siblings(_inTxt).removeClass('on');
			$(this).parents('.in_txt').css('border','2px solid #d0d0d0');
			$(this).parents('.in_txt').css('z-index','0');
		});

		$('.in_txt .txt, .in_txt .pass').focus(function() {
			$(this).parents('.in_txt').css('border','2px solid #333');
			$(this).parents('.in_txt').css('z-index','50');
		});
		$('.in_txt .txt, .in_txt .pass').blur(function() {
			if($(this).val() !== '') {
				$(this).parents('.in_txt').css('border','2px solid #333');
				$(this).parents('.in_txt').css('z-index','50');
			}else {
				$(this).parents('.in_txt').css('border','2px solid #d0d0d0');
				$(this).parents('.in_txt').css('z-index','0');
			}
		});
	} //인풋 텍스트 리셋 버튼

	inexFnc = function(){ //인풋 포커스, 클릭, val 효과 
		$('input, textarea').placeholder();
	} //placeholder 버전 9 구동


    $.fn.inputnumFnc = function(index) {//인풋전화번호 체크
        if (!$("#hd_pop").children().hasClass('hd_pops')) {
			$("#dim_pop_bg").css("display", "none");
		}
    };
    function numeric(value) {//문자제거
        return value.toString().replace(/[^\d$]/gi, "");
    }//인풋전화번호 체크    
    
    selectboxFnc = function (obj) {//셀렉트박스
        var _select = null
        if (!obj)
            _select = $('.selectbox select');
        else
            _select = ($(obj).find('.selectbox select').length > 0) ? $(obj).find('.selectbox select') : $(obj);
        _select.unbind().each(function (index, value) {
            $(this).prev().html($(this).children('option:selected').text());
            if ($(this).val() == 'direct') {//직접입력
                $(this).parent().prev().css('display', 'inline');
            }
        }).bind('change keyup', function (evt) {
            $(this).prev().html($(this).children('option:selected').text());
            if ($(this).prev().is('.ellipsis')) $(this).prev().ellipsis();//글줄임 설정
            if ($(this).find("option[value='direct']").length == 1) {//직접입력 설정
                if ($(this).val() == 'direct') {
                    $(this).parent().prev().css('display', 'inline');
                    if (evt.type == 'change') $(this).parent().prev().focus();//직접입력 포커스 이동
                } else {
                    $(this).parent().prev().css('display', 'none');
                }
            }
        }).bind('focus', function () {
			$(this).parents('.selectbox').addClass('on');

        }).bind('blur change', function () {
			if ($(this).val() != "" ) {
				$(this).parents('.selectbox').addClass('on');
			} else {
				$(this).parents('.selectbox').removeClass('on');
			}
			//$(this).prev().removeClass('on');
        });


    }//셀렉트박스

    checkallFnc = function (obj, name) {//전체선택
        var _this = $(obj);
        var _chk = $('input[name='+name+']');
        if(_this.is(':checked')) {
            _chk.each(function(index, value) {
                $(this).attr('checked', true).parent().removeClass('off').addClass('on');
            });
        } else {
            _chk.each(function(index, value) {
                $(this).attr('checked', false).parent().removeClass('on').addClass('off');
            });
        }
    }//전체선택

    checkboxFnc = function () {//체크박스
        var _chk = $('.chk').parent();
        _chk.each(function() {
            if ($(this).find('input').is(':checked')) {
                $(this).removeClass('off').addClass('on');

            } else {
                $(this).removeClass('on').addClass('off');
            }
        }).click(function() {
            if ($(this).find('input').is(':checked')) {
                $(this).removeClass('off').addClass('on');
            } else {
                $(this).removeClass('on').addClass('off');
            }
        });
    }//체크박스


	chk_selFnc = function () {//체크박스
        var chk_sch = $('.chk_sch').parent('.checkbox');
		var cs_prnt = $('.chk_selbox');

        chk_sch.click(function() {
            if ($(this).find('input').is(':checked')) {
                $(this).removeClass('off').addClass('on').parent(cs_prnt).addClass('on');
				$(this).parent(cs_prnt).find('.work_sel').removeAttr('disabled');
				
            } else {
                $(this).removeClass('on').addClass('off').parent(cs_prnt).removeClass('on');
				$(this).parent(cs_prnt).find('.work_sel').attr('disabled', 'true').parent('.selectbox').removeClass('on');
				$(this).parent(cs_prnt).find('.work_sel option:eq(0)').prop("selected", true);
				$(this).parent(cs_prnt).find('.selectbox span').html($(this).parent(cs_prnt).find('.work_sel').children('option:selected').text());
            }
        });
    }//체크박스
	

	
	chkpassFnc = function () { //패스워드 보이기/감추기
		$("#passChk").change(function(){
			// Check the checkbox state
			if($(this).is(':checked')){
				// Changing type attribute
				$("#inPass").attr("type","text");

				// Change the Text
				//$(".pass_txt").text("비밀번호 보이기");
			}else{
				// Changing type attribute
				$("#inPass").attr("type","password");

				// Change the Text
				//$(".pass_txt").text("비밀번호 감추기");
			}
		});
	} //패스워드 보이기/감추기

    radioboxFnc = function () {//라디오박스

		//비활성화 클래스명
		$(".disable").attr("readonly",true);
		$(".disable").attr("disabled",true);

        var _rdi = $('.rdi').parent();
        _rdi.unbind().each(function() {
            if ($(this).find('input').is(':checked')) {
                $(this).removeClass('off').addClass('on');
            }else if ($(this).find('input').is('[disabled=disabled]'))//비활성화시킬때
			{
				$(this).find("span").css({'color':'#a8a8a8','cursor':'default'});
				$(this).find('input').attr('name','disable')
			} else {
                $(this).removeClass('on').addClass('off');
            }
        }).bind('click', function() {
            var _name = $(this).find('input').attr('name');
            var _radio = $('label input[name$='+_name+']');
            var _index = _radio.parent().index(this);
            _radio.each(function(index, value) {
                if (_index == index) {
                    $(this).checked = true;
                    $(this).parent().removeClass('off').addClass('on');
					if ($(this).is('[disabled=disabled]'))
					{
						$(this).parent().removeClass('on');
					}
                } else {
                    $(this).checked = false;
                    $(this).parent().removeClass('on').addClass('off');
                }
            });
        });
        
        $('input:radio').click(function() {
            $('input:radio[name='+$(this).attr('name')+']').parent().removeClass('on');
            $(this).parent().addClass('on');
        });
		
    }//라디오박스

	
	moreFnc = function() {//주간 더보기
		var _obj = $('.weekly-area .more a');
		_obj.bind('click', function() {
			var _more = $(this).parent();
			_more.prev().css('max-height','none');
			_more.find('a:first-child').hide();
			_more.append('<a class="close" href="#">접기</a>').bind('click', function() {
				_more.prev().removeAttr('style');
				_more.find('a:first-child').show();
				_more.find('a.close').remove();
				return false;
			});
			return false;
		});
	}//주간 더보기
	
	showLayerFnc = function(obj) {//캘린더 레이어 v1 2016-06-21 skydown@career.co.kr
		var _table = $('#table-id');
		var _tr = _table.find('tbody tr');
		var _more = _table.find('tbody td').not('td.none, td.nodata').find('.more a');
		var _layer = $('#layer-id');
		var _inner = _layer.find('.inner');
		var _close = _layer.find('.close');
		if(!obj) {
			_more.unbind('click').bind('click', function() {
				var _td = $(this).parents('td');
				var _width = parseInt(_td.outerWidth()) + ((_td.next().length > 0) ? parseInt(_td.next().outerWidth()) : parseInt(_td.prev().outerWidth())) - 1;
				var _x = _td.offset().left - 1;
				var _y = _td.offset().top - 1;
				_layer.css({'width':_width + 'px','left':_x, 'top':_y}).show(200);
				return false;
			});
		} else {
			var _td = $(obj).parents('td');
			var _width = parseInt(_td.outerWidth()) + ((_td.next().length > 0) ? parseInt(_td.next().outerWidth()) : parseInt(_td.prev().outerWidth())) - 1;
			var _x = _td.offset().left - 1;
			var _y = _td.offset().top - 1;
			_layer.css({'width':_width + 'px','left':_x, 'top':_y}).show(200);
			return false;
		}
		$('#layer-id .close').unbind('click').bind('click', function () {
			_more.unbind('click');
			$('#layer-id').hide(200, function() {
				$(this).removeAttr('style');
				showLayerFnc();
			});
			return false;
		});
	}//캘린더 레이어

	hideLayerFnc = function() {//캘린더 레이어 감추기
		$('#layer-id').hide(200, function() {
			$(this).removeAttr('style');
		});
	}//캘린더 레이어 감추기

	/* 달력 2014-09-17 skydown@career.co.kr */
	_calArray = {
		Box: null,
		Month: null,
		Body: null,
		Prev: null,
		Next: null,
		Input: null,
		calClose: null,
		calButton: null,
		calToday: null,
		calDate: null,
		calMonth: null,
		calNow: null,
		calYear: null,
		Weekday: null,
		MonthA: null,
		Mdays: null
	};
	calendarBoxFnc = {
		init: function() {
			_calArray.Box = $('#calendarBox');
			_calArray.Month = $('#calendarMonth');
			_calArray.Body = $('#calendarBody');
			_calArray.Prev = _calArray.Box.find('.calHead .prev');
			_calArray.Next = _calArray.Box.find('.calHead .next');
			_calArray.calClose = _calArray.Box.find('.calClose');
			_calArray.calButton = _calArray.Box.find('td > button');
			_calArray.calClose.click(function() {
				_calArray.Box.hide();
				_calArray.Input.focus();
				calendarBoxFnc.set();
			});
			_calArray.Prev.click(function() {
				_calArray.calToday.setMonth( _calArray.calToday.getMonth() - 1 );
				calendarBoxFnc.set();
			});
			_calArray.Next.click(function() {
				_calArray.calToday.setMonth( _calArray.calToday.getMonth() + 1 );
				calendarBoxFnc.set();
			});
			calendarBoxFnc.set();
		},
		input: function(d) {
			var month = _calArray.MonthA[_calArray.calMonth];
			var day = d;
			(month < 10) ? month = '0' + month : month;
			(day < 10) ? day = '0' + day : day;

			_calArray.calDate = d;
			_calArray.Input.val(_calArray.calYear + '-' + month + '-' + day).focus();
			_calArray.Box.hide();
		},
		show: function(p, obj) {
			_calArray.Input = $('#' + p);
			var _pos = _calArray.Input.position();
			calendarBoxFnc.set(obj.value);
			_calArray.Box.show().css({
				'left': _pos.left,
				'top': _pos.top
			}).find('#calendarBody button.on').focus();
		},
		set: function(v) {
		// this array gives the weekday names
			_calArray.Weekday = new Array();
			_calArray.Weekday[0] = "Sunday";
			_calArray.Weekday[1] = "Monday";
			_calArray.Weekday[2] = "Tuesday";
			_calArray.Weekday[3] = "Wednesday";
			_calArray.Weekday[4] = "Thursday";
			_calArray.Weekday[5] = "Friday";
			_calArray.Weekday[6] = "Saturday";
		// this array gives month names
			_calArray.MonthA = new Array();
			_calArray.MonthA[0] = "1" //January";
			_calArray.MonthA[1] = "2" //February";
			_calArray.MonthA[2] = "3" //March";
			_calArray.MonthA[3] = "4" //April";
			_calArray.MonthA[4] = "5" //May";
			_calArray.MonthA[5] = "6" //June";
			_calArray.MonthA[6] = "7" //July";
			_calArray.MonthA[7] = "8" //August";
			_calArray.MonthA[8] = "9" //September";
			_calArray.MonthA[9] = "10" //October";
			_calArray.MonthA[10] = "11" //November";
			_calArray.MonthA[11] = "12" //December";
		// this array gives the number of days in each month
			_calArray.Mdays = new Array();
			_calArray.Mdays[0] = 31;
			_calArray.Mdays[1] = 28;
			_calArray.Mdays[2] = 31;
			_calArray.Mdays[3] = 30;
			_calArray.Mdays[4] = 31;
			_calArray.Mdays[5] = 30;
			_calArray.Mdays[6] = 31;
			_calArray.Mdays[7] = 31;
			_calArray.Mdays[8] = 30;
			_calArray.Mdays[9] = 31;
			_calArray.Mdays[10] = 30;
			_calArray.Mdays[11] = 31;
		// this code gets current date information
			if (_calArray.calToday == null) {
				_calArray.calToday = new Date();
				_calArray.calNow = _calArray.calToday.getDate();
			}
			if (v == undefined || v == '') {
				_calArray.calYear = _calArray.calToday.getYear();
				_calArray.calMonth = _calArray.calToday.getMonth();
				_calArray.calDate = _calArray.calToday.getDate();
			} else {
				var _v = v.split('-');
				var _vyear = _v[0];
				var _vmonth = (_v[1] < 10) ? _v[1].split('0')[1] : _v[1];
				var _vdate = (_v[2] < 10) ? _v[2].split('0')[1] : _v[2];
				_calArray.calYear = _vyear;
				_calArray.calMonth = _vmonth - 1;
				_calArray.calDate = _vdate;
				_calArray.calNow = _vdate;
			}
		// these are variables for 
			var day = 1;
			var i, j;
		// adjust year for browser differences
			if (_calArray.calYear < 2000) {
				_calArray.calYear += 1900;
			}
		// account for leap year
			if ((_calArray.calYear % 400 == 0) || ((_calArray.calYear % 4 == 0) && (_calArray.calYear % 100 !=0)))
				_calArray.Mdays[1] = 29;
		// determine day of week for first day of the month
			var Mfirst = _calArray.calToday;
			Mfirst.setDate(1);
			var dow1 = Mfirst.getDay();
		// write out current date
			var _month = _calArray.calYear + "." + _calArray.MonthA[_calArray.calMonth];
			_calArray.Month.html(_month);

		// construct calendar for current month
			var _tbody = "";
			for (i = 0; i < 6; i++) {
		// this loop writes one row of days Sun-Sat
				_tbody += ("<tr>");
				for (j = 0; j < 7; j++) {
		// this loop determines which dates to display and in which column
					if ((i == 0 && j < dow1) || (day > _calArray.Mdays[_calArray.calMonth])) {
		// this puts in blank cells at the beginning an end of the month
						_tbody += ("<td>&nbsp;</td>");
					} else {
						if (day == _calArray.calNow) {
		// highlight the current day and display the date for this cell
							_tbody += ("<td><button class='on' type='button' value='"+ day +"' onclick='calendarBoxFnc.input(this.value);'>" + day + "</button></td>");
						} else {
		// display the date for this cell
							_tbody += ("<td><button type='button' value='"+ day +"' onclick='calendarBoxFnc.input(this.value);'>" + day + "</button></td>");
						}
		// increment day counter
						day++;
					}
				}
		// end of row; determine if more rows needed
				_tbody += ("</tr>");
				if (day > _calArray.Mdays[_month]) {
					i = 6;
				}
			}
		// end of table
			_calArray.Body.html(_tbody);

		}
	};/* //달력 */

	//캘린더 레이어 위치값 가져오기
	calMoreShow = function(){
		$(".plusIcon").click(function(){

			$(".openPop").hide();//클릭시 해당 팝업 제외 히든처리

			$(this).next("div").show(0,function(){
				$(this).css({
					"left": "-1px",
					"top" : "-7px"
				});
			});
		});
	}
	disableFnc = function (obj, param) {//비활성
		var _obj = $(obj);
		var _input = _obj.find('input.txt, input.rdi, input.chk, textarea.area');
		switch(param) {
			case 'disable':
				_obj.addClass('disable');
				if (_input.length > 0) _input.attr('readonly','readonly');
				if (_input.length > 0) _input.attr('disabled','disabled');
				selectboxFnc();
				break;
			case 'active':
				_obj.removeClass('disable');
				if (_input.length > 0) _input.removeAttr('readonly');
				break;
			case 'check'://체크박스
				if ((_obj.attr('class')) ? (_obj.attr('class') == 'disable') : false) {
					_obj.removeClass('disable');
					if (_input.length > 0) _input.removeAttr('readonly');
				} else {
					_obj.addClass('disable');
					if (_input.length > 0) _input.attr('readonly','readonly');
				}
				break;
			default:
				return false;
		}
	};//비활성

	popFnc = function () {//팝업
		$('.pop').click(function(){ 
			$('.popup, #dim').show(); 
			$poHeight = $('.popup').outerHeight();
			//$poWidth = $('.popup').outerWidth();
			docWidth = $(document).width(),
			winHeight = $(window).height();
			var intFrameHeight = window.innerHeight;

			if ($poHeight > intFrameHeight/*&& $poWidth < docWidth*/) {
				$('.popup').css("top", Math.max(0, $(window).scrollTop()));
				$('.popup').css({
					marginTop:0});
					//,marginLeft:-$poWidth / 2});
				return this;
			}
			else if ($poHeight < intFrameHeight) {
				$('.popup').css("top", Math.max(0,  $(window).scrollTop() +intFrameHeight / 2) + "px"); 
				$('.popup').css({
					marginTop: -$poHeight / 2});
					//,marginLeft: -$poWidth / 2});
			   return this;
			}
			
		}); 

		$('.layer_close, #dim').click(function(e){ 
			e.preventDefault(); 
			$('.popup, #dim').hide(); 
		}); 

		$('.btn.check').click(function(){ 
			$('.popup, #dim').hide(); 
		}); 

    }//팝업

	popFnc2 = function () {//팝업
		$('.pop2').click(function(){ 
			$('.popup2, #dim').show(); 
			$poHeight = $('.popup2').outerHeight();
			//$poWidth = $('.popup').outerWidth();
			docWidth = $(document).width(),
			winHeight = $(window).height();
			if ($poHeight > winHeight/*&& $poWidth < docWidth*/) {
				$('.popup2').css("top", Math.max(0, $(window).scrollTop()));
				$('.popup2').css({
					marginTop:0});
					//,marginLeft:-$poWidth / 2});
				return this;
			}
			else{
				$('.popup2').css("top", Math.max(0,  $(window).scrollTop() + jQuery(window).height() / 2) + "px"); 
				$('.popup2').css({
					marginTop: -$poHeight / 2});
					//,marginLeft: -$poWidth / 2});
			   return this;
			}
			
		}); 

		$('.layer_close, #dim').click(function(e){ 
			e.preventDefault(); 
			$('.popup2, #dim').hide(); 
		}); 

		$('.btn.check').click(function(){ 
			$('.popup2, #dim').hide(); 
		}); 

    }//팝업

	popFnc3 = function () {//팝업
		$('.pop3').click(function(){ 
			$('.popup3, #dim').show(); 
			$poHeight = $('.popup3').outerHeight();
			//$poWidth = $('.popup').outerWidth();
			docWidth = $(document).width(),
			winHeight = $(window).height();
			if ($poHeight > winHeight/*&& $poWidth < docWidth*/) {
				$('.popup3').css("top", Math.max(0, $(window).scrollTop()));
				$('.popup3').css({
					marginTop:0});
					//,marginLeft:-$poWidth / 2});
				return this;
			}
			else{
				$('.popup3').css("top", Math.max(0,  $(window).scrollTop() + jQuery(window).height() / 2) + "px"); 
				$('.popup3').css({
					marginTop: -$poHeight / 2});
					//,marginLeft: -$poWidth / 2});
			   return this;
			}
			
		}); 

		$('.layer_close, #dim').click(function(e){ 
			e.preventDefault(); 
			$('.popup3, #dim').hide(); 
		}); 

		$('.btn.check').click(function(){ 
			$('.popup3, #dim').hide(); 
		}); 

    }//팝업

	popFnc4 = function () {//팝업
		$('.pop4').click(function(){ 
			$('.popup4, #dim').show(); 
			$poHeight = $('.popup4').outerHeight();
			//$poWidth = $('.popup').outerWidth();
			docWidth = $(document).width(),
			winHeight = $(window).height();
			if ($poHeight > winHeight/*&& $poWidth < docWidth*/) {
				$('.popup4').css("top", Math.max(0, $(window).scrollTop()));
				$('.popup4').css({
					marginTop:0});
					//,marginLeft:-$poWidth / 2});
				return this;
			}
			else{
				$('.popup4').css("top", Math.max(0,  $(window).scrollTop() + jQuery(window).height() / 2) + "px"); 
				$('.popup4').css({
					marginTop: -$poHeight / 2});
					//,marginLeft: -$poWidth / 2});
			   return this;
			}
			
		}); 

		$('.layer_close, #dim').click(function(e){ 
			e.preventDefault(); 
			$('.popup4, #dim').hide(); 
		}); 

		$('.btn.check').click(function(){ 
			$('.popup4, #dim').hide(); 
		}); 

    }//팝업

	menuboxFnc = function () {
	
		var mbOpen = $('.btn_menu .open');
		var mbClose = $('.btn_menu .close');
		var container = $(".mb_menu");

		$(mbOpen).click(function () {
			$(this).hide();
			$(this).siblings('.close').show();
			$(this).parent().next(container).show();
		});
		$(mbClose).click(function () {
			$(this).hide();
			$(this).siblings('.open').show();
			$(this).parent().next(container).hide();
		});
		$(document).mouseup(function (e) {

			if ($(container).is(':visible'))
			{
				if (!container.is(e.target) && container.has(e.target).length === 0){
				container.css("display","none");
				}	
				$(mbClose).hide();
				$(mbOpen).show();
			}
			
		});
	}

	

});
	
