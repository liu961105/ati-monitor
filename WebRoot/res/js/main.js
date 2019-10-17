function alertOk(msg){
	var layerui=undefined;
	if(window.parent&&parent.layer){
		layerui=parent.layer;
	}else{
		layerui=layer;
	}
	
	if(!layerui){
		alert(msg);
	}else{
		layerui.alert(msg,{icon:6,title:'成功提示'});
	}
}

function alertYes(msg){
	var layerui=undefined;
	if(window.parent&&parent.layer){
		layerui=parent.layer;
	}else{
		layerui=layer;
	}
	
	if(!layerui){
		alert(msg);
	}else{
		layerui.alert(msg,{icon:6,title:'温馨提示'});
	}
}

function alertError(msg){
	var layerui=undefined;
	if(window.parent&&parent.layer){
		layerui=parent.layer;
	}else{
		layerui=layer;
	}
	
	if(!layerui){
		alert(msg);
	}else{
		layerui.alert(msg,{icon:5,title:'错误提示'});
	}
}

function alertWarn(msg){
	var layerui=undefined;
	if(window.parent&&parent.layer){
		layerui=parent.layer;
	}else{
		layerui=layer;
	}
	
	if(!layerui){
		alert(msg);
	}else{
		layerui.alert(msg,{icon:7,title:'错误提示'});
	}
}

function showInfo(msg){
	var layerui=undefined;
	if(window.parent&&parent.layer){
		layerui=parent.layer;
	}else{
		layerui=layer;
	}
	
	if(!layerui){
		alert(msg);
	}else{
		layerui.msg(msg);
	}
}

function showOkTip(msg){
	var layerui=undefined;
	if(window.parent&&parent.layer){
		layerui=parent.layer;
	}else{
		layerui=layer;
	}
	
	if(!layerui){
		alert(msg);
	}else{
		layerui.msg(msg,{icon:6});
	}
}

function showErrorTip(msg){
	var layerui=undefined;
	if(window.parent&&parent.layer){
		layerui=parent.layer;
	}else{
		layerui=layer;
	}
	
	if(!layerui){
		alert(msg);
	}else{
		layerui.msg(msg,{icon:5});
	}
}


function isOK(ret){
	if(ret&&ret.status=="0"&&ret.resultCode=="0"&&ret.logicCode=="0"){
		return true;
	}else{
		return false;
	}
}


function isBlank(value){
	if(value && value!=""){
		return false;
	}else{
		return true;
	}
	
}

function getTimeStamp() {
	return new Date().getTime();
}


function guid() {
    return 'xxxxxxxxxxxx8xxxyxxxxxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
        var r = Math.random()*16|0, v = c == 'x' ? r : (r&0x3|0x8);
        return v.toString(16);
    });
}


function parseIntNumber(str){
	var ret=0;
	if(!isNaN(str)){
		if( typeof str== "string"){
			ret=parseInt(str);
		}else{
			ret=str;
		}
	}
	return ret;
}



function parseUrl(url){
	var retUrl="";
	if(url){
		if(url.substr(0,1)=="/"){
			retUrl= GLOBAL_INFO.WEBURL_PREFIX+url.substr(1);
		}else{
			retUrl= GLOBAL_INFO.WEBURL_PREFIX+url;
		}
	}
	
	if(retUrl){
		if(retUrl.indexOf("?")<0){
			retUrl+="?t="+getTimeStamp();
		}else if(retUrl.indexOf("t=")<0){
			retUrl+="&t="+getTimeStamp();
		}
	}
	return retUrl;
}


function parseImageUrl(url,flag){
	var retUrl="";
	if(url){
		if(url.substr(0,1)=="/"){
			retUrl= GLOBAL_INFO.FILESERVER_URL +url.substr(1);
		}else{
			retUrl= GLOBAL_INFO.FILESERVER_URL +url;
		}
	}
	
	if(retUrl&&!flag){
		if(retUrl.indexOf("?")<0){
			retUrl+="?t="+getTimeStamp();
		}else if(retUrl.indexOf("t=")<0){
			retUrl+="&t="+getTimeStamp();
		}
	}
	return retUrl;
}


var idCard={
	getBorn:function(UUserCard){
		return UUserCard.substring(6, 10) + "-" + UUserCard.substring(10, 12) + "-" + UUserCard.substring(12, 14);
	},
	getSex:function(UUserCard){
		if (parseInt(UUserCard.substr(16, 1)) % 2 == 1) {
			return "1";
	    } else {
	    	return "0";
	    }
	},
	getSexL:function(UUserCard){
		if (parseInt(UUserCard.substr(16, 1)) % 2 == 1) {
			return "男";
	    } else {
	    	return "女";
	    }
	},
	getAge:function(UUserCard){
		var myDate = new Date();
        var month = myDate.getMonth() + 1;
        var day = myDate.getDate();
        var age = myDate.getFullYear() - UUserCard.substring(6, 10) - 1;
        if (UUserCard.substring(10, 12) < month || UUserCard.substring(10, 12) == month && UUserCard.substring(12, 14) <= day) {
            age++;
        }
        return age;
	}
};

function loadCss(css){
	$("<link>").attr({
		rel : "stylesheet",
		type : "text/css",
		href : parseUrl(css)
	}).appendTo("head");

}

function loadJs(js,pre){
	pre=pre||"";
	if(typeof js=="string"){
		$.getScript(parseUrl(pre+js));
	}
	if(typeof js =="object"){
		for(var j in js){
			$.getScript(parseUrl(pre+js));
		}
	}
}


function goUrl(url){
	window.location.href=parseUrl(url);
}

function loadViewJs(js){
	loadJs(js,"/viewjs/")
}

function showReadme(){
	var layerui=undefined;
	if(window.parent&&parent.layer){
		layerui=parent.layer;
	}else{
		layerui=layer;
	}
	
	layerui.open({
		  type: 2,
		  title:"服务协议",
		  area: ['60%', '550px'],
		  fixed: false, //不固定
		  maxmin: true,
		  content: parseUrl("/html/readme.html")
	});
}

/**
 * 普通请求，不加载蒙尘
 */
var __loading=undefined;
jQuery.extend({
    reqWeb : (function(){
        var default_options = {
            "type"        :    "post",
            "timeout"     :    "90000",
            "contentType" :    "application/x-www-form-urlencoded; charset=UTF-8",
			"dataType"    :    "json",
            "success"     :    function(data){
            },
            "error"       :    function(request, textStatus, errorThrown){
            },
            "complete"    :    function(){
            }
        };
        return function(user_options){
			var options = {};

			//统一处理弹出层
			if(!user_options['loading']||user_options['loading']==0){
				if(parent.layer){
		    		__loading=parent.layer.load(2,{shade: false});
		    	}else if(layer){
		    		__loading=layer.load(2,{shade: false});
		    	}
			}
			var new_options = {};
			
			if(!user_options["data"]){
				user_options["data"]={};
			}
			
			user_options["data"]["_is_ajax"] = "true";
			user_options["url"] = parseUrl(user_options["url"]);
			
			for ( var key in user_options) {
				if (key != 'success'  && key!='error') {
					new_options[key] = user_options[key];
				}
			}
			
			new_options['success'] = function(result) {
				if(parent.layer){
		    		__loading=parent.layer.close(__loading);
		    	}else if(layer){
		    		__loading=layer.close(__loading);
		    	}
				__loading=undefined;
				
				var dataType=new_options['dataType'];
				if(!result ||result=="null"){ //补丁后台空响应时异常处理
					if(dataType!="json"){
						result="系统繁忙,请稍后重试!";
					}else{
						result={"resultCode":"-1","logicCode":"-2","errorMsg":"NULL EXCEPTION"};
					}
				}
				if (result) {
					if(dataType!="json"){
						user_options['success'](result);
						return;
					}
					if (result && isOK(result)) {
						user_options['success'](result);
					} else {
						
						//未登录跳转
						if (result.systemCode == '-99') {
							goLogin();
							return;
						}
						
						//未登录跳转
						if (result.systemCode == '-888') {
							if(parent.layer){
								parent.layer.msg("系统繁忙，请稍后重试!",{icon:4});
							}else{
								layer.msg("系统繁忙，请稍后重试!",{icon:4});
							}
							return;
						}
						
						if(!isOK(result)){
							if(parent.layer){
					    		__loading=parent.layer.msg("系统开小差了，不能及时处理您的请求，请稍后重试!");
					    	}else if(layer){
					    		__loading=layer.msg("系统开小差了，不能及时处理您的请求，请稍后重试!");
					    	}
						}
						
						//使用公共结果组件，成功组件
						if (user_options['data'].resultCommon == "1"){
							//待实现公共处理
						} else {
							if(typeof user_options['success'] =="function"){
								user_options['success'](result);
							}
						}
					}
				}
			};
			
			new_options['error']=function(e){ //处理 apache 返回503错误 等非200的错误
				if(parent.layer){
		    		__loading=parent.layer.close(__loading);
		    	}else if(layer){
		    		__loading=layer.close(__loading);
		    	}
				__loading=undefined;
				
				if(parent.layer){
		    		__loading=parent.layer.msg("系统开小差了，不能及时处理您的请求，请稍后重试!");
		    	}else if(layer){
		    		__loading=layer.msg("系统开小差了，不能及时处理您的请求，请稍后重试!");
		    	}
				
				if(typeof user_options['error'] =="function"){
					user_options['error'](e);
				}else{
					__loading=layer.msg("系统开小差了，不能及时处理您的请求，请稍后重试!");
				}
			};
			
			$.extend(options, default_options, new_options);
			$.ajax(options);
        };
    })()
});

