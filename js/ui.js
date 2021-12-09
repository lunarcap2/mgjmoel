$(function() {

	$(document).ready(function() {
		tabFnc();//탭
		accordionFnc();//아코디언
		popUp();//팝업
        fileboxFnc();//파일박스
        selectboxFnc();//셀렉트박스
        checkboxFnc();//체크박스.
        radioboxFnc();//라디오박스
		disableFnc();//비활성시키기2019-10-10
		ckhAll();//체크박스 전체선택

		if ($('.datepicker').length > 0) useDatePicker();//달력
		(function(){
			if($('#header .gnb .tp.active').length && $('#header .gnb .tp.active .menu ').length){
				$('#header .gnb').addClass('open');
			}
		})();
	});

	tabFnc = function(){
		$(".tab_content").hide();
		$(".tabs li:first").addClass("on").show();
		$(".tab_content:first").show();

		$(".tabs li").click(function() {
			$(".tabs li").removeClass("on");
			$(this).addClass("on");
			$(".tab_content").hide();
			var activeTab = $(this).find("a").attr("href");
			$(activeTab).fadeIn();
			return false;
		});
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
			if($(this).is('.on')){
				$(this).removeClass('on');
				$(this).next().slideUp(300);
				return false;
			}
			$(this).addClass('on');
			$(this).next().slideToggle(300);
			$(".acco li a").not(this).next().slideUp(300);
			$(".acco li a").not(this).removeClass('on');
			return false;
		});
		//$("ul li a").eq(0).trigger("click");
	}

	popUp = function(){//레이어팝업*/
		$('.pop').click(function(){
			var activePop = $(this).attr("href");
			$(activePop).show().children('.popup, .popup_dim').show();
			$poHeight = $(activePop).children('.popup').outerHeight();
			winHeight = $(activePop).children('.popup_dim').height();
			if ($poHeight > winHeight) {
				$(activePop).children('.popup').css("top", Math.max(0, $(window).scrollTop()));
				$(activePop).children('.popup').css({
					marginTop:0});
				return this;
			}
			else{
				$(activePop).children('.popup').css("top", Math.max(0,  $(window).scrollTop() + winHeight / 2) + "px");
				$(activePop).children('.popup').css({
					marginTop: -$poHeight / 2});
			   return this;
			}

		});

		$('.popup_dim, .popup .close').click(function(){
			$(this).parents('.layer_popup').hide();
		});
	}//레이어팝업*/


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
	}//비활성

	ckhAll = function() {
		var $boxAll = $('.dd ul .checkbox.all');
		var $boxes = $('.dd ul');

		/* 전체선택 */
		$boxAll.change(function(){
			var $boxAllchk = $(this).is(":checked");
			if ( $boxAllchk == true ) {
				$(this).parents('dd').find('ul input').attr("checked", true)
				.parent().removeClass('off').addClass('on');
				$(this).parents('dd').find('ul input').prop("checked", true)
				.parent().removeClass('off').addClass('on');
			}else {
				$(this).parents('dd').find('ul input').attr("checked", false)
				.parent().removeClass('on').addClass('off');
				$(this).parents('dd').find('ul input').prop("checked", false)
				.parent().removeClass('on').addClass('off');
			}
		});


		/* 하위 전체 선택시 전체버튼 선택 */
		$boxes.change(function(){
			var bchk = $(this).find("input[type='checkbox'].chk");
			if(bchk.length == bchk.filter(":checked").length){
				$(this).parents('dd').find($boxAll).attr("checked", true)
				.parent().removeClass('off').addClass('on');
				$(this).parents('dd').find($boxAll).prop("checked", true)
				.parent().removeClass('off').addClass('on');
			}else {
				$(this).parents('dd').find($boxAll).attr("checked", false)
				.parent().removeClass('on').addClass('off');
				$(this).parents('dd').find($boxAll).prop("checked", false)
				.parent().removeClass('on').addClass('off');
			}
		});
	}//전체선택

	useDatePicker = function() {

		$(document).ready(function() {

			//datepicker 한국어로 사용하기 위한 언어설정
			$.datepicker.setDefaults($.datepicker.regional['ko']);

			// Datepicker
			$(".datepicker").datepicker({
				dateFormat: "yy-mm-dd",
				dayNamesMin: ["일", "월", "화", "수", "목", "금", "토"],
				monthNames: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
				monthNamesShort: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
				changeMonth: true,
				changeYear: true,
				yearRange: 'c-60:c+10',
				showButtonPanel: true,
				closeText: '닫기',
				currentText: '오늘',
				onClose : function ( selectedDate ) {
					var eleId = $(this).attr("id");
					var optionName = "";
					if(eleId.indexOf("StartDate") > 0) {
						eleId = eleId.replace("StartDate", "EndDate");
						optionName = "minDate";
					} else {
						eleId = eleId.replace("EndDate", "StartDate");
						optionName = "maxDate";
					}
					$("#"+eleId).datepicker( "option", optionName, selectedDate);
					$(".searchDate").find(".chkbox2").removeClass("on");


					var $dates = $('.start_date, .end_date').datepicker();
					$('.datePick .reset').on('click', function () {
						 $dates.val('').datepicker('option', {minDate: null, maxDate: null});
					});
				}

			});

			$.datepicker._gotoToday = function(id) {
				$(id).datepicker('setDate', new Date()).datepicker('hide').blur();
			};

			$(".dateclick").dateclick();    // DateClick
			$(".searchDate").schDate();        // searchDate

		});

		// Search Date
		jQuery.fn.schDate = function(){
			var $obj = $(this);
			var $chk = $obj.find("input[type=radio]");
			$chk.click(function(){
				$('input:not(:checked)').parent(".chkbox2").removeClass("on");
				$('input:checked').parent(".chkbox2").addClass("on");
			});
		};

		// DateClick
		jQuery.fn.dateclick = function(){
			var $obj = $(this);
			$obj.click(function(){
				$(this).parent().find("input").focus();
			});
		}
	}// 달력


	function fn_pop_show() {
		$('.popup, .pop_dim').show();
		$poHeight = $('.popup').outerHeight();
		docWidth = $(document).width(),
		winHeight = $(window).height();
		if ($poHeight > winHeight/*&& $poWidth < docWidth*/) {
			$('.popup').css("top", Math.max(0, $(window).scrollTop()));
			$('.popup').css({
				marginTop:0});
				//,marginLeft:-$poWidth / 2});
			return this;
		}
		else{
			$('.popup').css("top", Math.max(0,  $(window).scrollTop() + jQuery(window).height() / 2) + "px");
			$('.popup').css({
				marginTop: -$poHeight / 2});
				//,marginLeft: -$poWidth / 2});
		   return this;
		}
	}

	/* 2020.12.09 */
	view_layer = function (_val){
		var popUp = $("#pop_area_question_" + _val);
		popUp.show().find(".pop_dim").show();
	}

	view_layer_hide = function (_val) {
		var popUp = $("#pop_area_question_" + _val);
		popUp.show().hide(".pop_dim").hide();
	}



});




;
(function($) {
    //$.__CLSFORMAT('.asdf .asdf .asdf')
    //return asdf asdf asdf
    //$.__ARRAY_SHUFFLE([1, 2, 3, 4, 5, 6, 7, 8])
    //return 8
    //$.__ARRAY_SHUFFLE([1, 2, 3, 4, 5, 6, 7, 8])
    //$.__RANDOM(6,8)
    //6이상8미만의 실수;
    //$.__GETPARAMS('tnna')
    //url = absc.com?tnna=123 ==> return 123;
    var utills = '__';
    var utills_array = utills + 'ARRAY_';
    $[utills_array + 'SHUFFLE'] = function(a) {
        var va = a;
        var j, x, i;
        for(i = a.length - 1; i > 0; i--) {
            j = Math.floor(Math.random() * (i + 1));
            x = va[i];
            va[i] = va[j];
            va[j] = x;
        }
        return va;
    }
    $[utills + 'CLSFORMAT'] = function(s) {
        return s.replace(/\./g, '');
    };
    $[utills_array + 'LAST'] = function(a) {
        return a[a.length - 1];
    };
    $[utills_array + 'MAX'] = function(a) {
        return Math.max.apply(null, a);
    };
    $[utills_array + 'MIN'] = function(a) {
        return Math.min.apply(null, a);
    };
    $[utills + 'RANDOM'] = function(min, max) {
        return Math.random() * (max - min) + min;
    };
    $[utills + 'GETPARAMS'] = function(param, str, amp, url) {
        var url = url ? url : location.search;
        if(url) {
            var arry = url.split(str ? str : '?');
            var amp = amp ? amp : '&';
            var result = null;
            var arryDp = arry[1].split(amp);
            for(var i = 0; i < arryDp.length; i++) {
                var resArry = arryDp[i].split('=');
                for(var j = 0; j < resArry.length; j++) {
                    if(resArry[0] == param) {
                        result = resArry[1];
                    }
                }
            }
            return result;
        }
    };
    $[utills + 'SCROLL'] = function(b, t, fnc) {
        var t = t ? t : window;
        var events = 'scroll wheel mousemove touchmove';
        if(b) {
            $(t).on(events, function(e) {
                if(typeof fnc === 'function') fnc($(this));
                e.preventDefault();
                e.stopPropagation();
                return false;
            });
        } else {
            $(t).off(events);
        }
    };
    $[utills + 'GET_IP'] = null;
})(jQuery);

var MainDigCusFun = function () {};;
(function ($) {
	MainDigCusFun = function (_this, idx, params) {
		this.el = _this;
		this.obj = $.extend(true, {
			style: {
				'z-index': 100,
			},
			start: 0,
			end: 0,
			drag: false,
		}, params);
		this.cookieNm = 'close' + idx;
		this.closeBtn = '.fnDayPopCloseBtn';
		this.chkbox = '.fnDayPopCheckbox';

	};
	MainDigCusFun.prototype = {
		init: function () {
			var _this = this;
			this.set();
			this.bind();
			return {
				show: function () {
					$(_this.el).show();
				},
				hide: function () {
					$(_this.el).hide();
				}
			}
		},
		set: function () {
			var server_today = window.SERVER_TODAY || serverToday();
			if ($.ui) {
				if (this.obj.drag && $.ui.draggable) {
					$(this.el).draggable();
				}
			}
			$(this.el).css($.extend(true, {
				'position': 'absolute',
			}, this.obj.style));
			if (this.obj.start && this.obj.end && (this.obj.start < this.obj.end)) {
				var st = server_today;
				if (st >= this.obj.start && st < this.obj.end) {
					this.get();
				} else {
					$(this.el).hide();
				}
			} else {
				this.get();
			}
		},
		get: function () {
			if (this.getCookie(this.cookieNm) != "done") {
				$(this.el).show();
			} else {
				$(this.el).hide();
			}
		},
		setCookie: function (name, value, expiredays) {
			var todayDate = new Date();
			todayDate.setDate(todayDate.getDate() + expiredays);
			document.cookie = name + "=" + escape(value) + "; path=/; expires=" + todayDate.toGMTString() + ";"
		},
		getCookie: function (name) {
			var nameOfCookie = name + "=";
			var x = 0;
			while (x <= document.cookie.length) {
				var y = (x + nameOfCookie.length);
				if (document.cookie.substring(x, y) == nameOfCookie) {
					if ((endOfCookie = document.cookie.indexOf(";", y)) == -1) endOfCookie = document.cookie.length;
					return unescape(document.cookie.substring(y, endOfCookie));
				}
				x = document.cookie.indexOf(" ", x) + 1;
				if (x == 0) {
					break;
				}
			}
			return "";
		},
		bind: function () {
			var _this = this;
			$(this.el).find(this.closeBtn).on({
				'click': function () {
					_this.show();
				},
			});
			$(this.el).find(this.chkbox).on({
				'click': function () {
					_this.show();
				},
			});
		},
		show: function () {
			if ($(this.el).find(this.chkbox).is(":checked") == true) {
				this.setCookie(this.cookieNm, "done", 1);
			}
			$(this.el).hide();
		},
	};
})(jQuery);



function serverToday(year, month, day, hours, minutes) {
	var curDate = new Date();
	var curDateFmt;
	var year = year || curDate.getFullYear();
	var month = month || curDate.getMonth() + 1;
	var day = day || curDate.getDate();
	var hours = hours || curDate.getHours();
	var minutes = minutes || curDate.getMinutes();
	if (parseInt(month) < 10) {
		month = 0 + "" + month;
	}
	if (parseInt(day) < 10) {
		day = 0 + "" + day;
	}
	if (parseInt(hours) < 10) {
		hours = 0 + "" + hours;
	}
	if (parseInt(minutes) < 10) {
		minutes = 0 + "" + minutes;
	}
	curDateFmt = parseInt(year + "" + month + "" + day + "" + hours + "" + minutes);
	//	curDateFmt = "201910021919";
	//	alert(curDateFmt);

	return curDateFmt;
}
