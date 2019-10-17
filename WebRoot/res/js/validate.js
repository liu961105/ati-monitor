(function($){
	$.fn.extend({
		validateForm:function(opt){
			var temp = true;
				defaults = {
					msgPosition:'top',
					msgBg:'#f00',
				},
				options = $.extend(defaults,opt),
				$_cur = '';
			//input
			this.find('.validate').each(function(i,v){
				$_cur = $(v);
				if($_cur.parents('.base-table').length > 0){
					var _top = $_cur.offset().top;
					var winTop = $_cur.parents('.base-table').offset() ? $_cur.parents('.base-table').offset().top : 0;
					$_cur.parents('.layui-layer-content').eq(0).scrollTop(_top - winTop);
				}
				var val = $(v).val(),
				v_exp = $(v).data('exp');
				if(v_exp){
					var str = v_exp.indexOf("{"),
					end = v_exp.indexOf("}"),
					getStr = v_exp.substring(str+1,end),
					arry = getStr.split("-"),
					v_type = v_exp.substr(0,1);
				}
				if($(v).is(".require") && !val){
					options.msg = '必填项';
					temp = false;
					$(v).css("border","1px solid #f10f0f");
					return false; 
					
				} else if(val){
					if($(v).is(".vsjh")){
	                	if( !/^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/.test(val)){
							options.msg = '手机号码格式不正确';
							temp = false;
							return false;
						}
					}
					if($(v).is(".vsfz")){
	                	if( !/(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/.test(val)){
							options.msg = '身份证号格式不正确';
							temp = false;
							return false;
						}
					}
					if($(v).is(".vem")){
	                	if( !/^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/.test(val)){
							options.msg = '邮箱格式不正确';
							temp = false;
							return false;
						}
					}
					if(v_type =='c' && !/[\u4e00-\u9fa5]/.test(val)){
						options.msg = '只能是汉字';
						temp = false;
						return false;
					}else if(v_type =='n' && !/^[+-]?\d+(\.\d+)?$/.test(val)){
						options.msg = '只能是数字';
						temp = false;
						return false;
					}else if(arry && (val.length<arry[0] || val.length>arry[1])){
						options.msg ='长度必须是'+getStr+'位';
						temp = false;
						return false;
					}
				}
				temp = true;
				if($_cur.is(".login-vdt")) {
					$_cur.css("border","1px solid #2b2b36");
				} else {
					$_cur.css("border","1px solid #e3e3e3");
				}
				return true;
                
			})
			
			function getPosition(pos){
				var temp = 1;
				switch(pos){
					case 'top':
						temp = 1;
						break;
					case 'right':
						temp = 2;
						break;
					case 'buttom':
						temp = 3;
						break;
					case 'left':
						temp = 4;
						break;
				};
				return temp;
			}
			if(options.msg && options.msg !="normal"){
				$_cur.css("border","1px solid #f10f0f");
				$(".validate-tips").remove();
				$_cur.after("<div class='validate-tips'>"+options.msg+"</div");
			}else {
				$_cur.css("border","1px solid #e3e3e3");
			}
			return temp;
		}
		
	});
})(jQuery);