;
(function(win, $, l) {
    var BASE = {
        redirect_url: function(obj) {
            var index = BASE._dialog({
                type: 'load'
            });
            if(obj.isIframe && obj.isIframe!=='undefined'){
//            	$("body").getNiceScrolls({selected:[{".data-content":130}]});
            	layer.close(index);
            	$(obj.cont).empty().append("<iframe src="+obj.url+" width='100%' frameborder='0' height='100%'></iframe>");
            }else{
            	$(obj.cont).empty().load(obj.url, obj.data, function(res, status, xhr) {
                    layer.close(index);
                    if (status !== 'success') {
                        BASE._dialog({
                            msg: BASE.getStatus(status),
                            type: 'alert',
                        });
                    } else {
                        var o = obj.data;
                        for (var key in o) {
                            $('input[name=' + key + ']').val(o[key])
                        }
                    }
                });
            }
        },
        _dialog: function(obj) {
            var src = {
                button: [],
                title: '提示',
                msg: '操作成功',
                type: 'load', //tip:捕获页
                icon: 1
            };
            $.extend(src, obj);
            switch (src.type) {
                case 'load':
                    return l.load(0, { shade: [0.3,'#fff'] });
                case 'alert':
                    l.alert(src.msg, { icon: '&#xe69c;' });
                    break;
                default:
                    l.open({
                        title: src.title,
                        type: src.type,
                        content: src.msg
                    });
            }
        },
        getStatus: function(status) {
            switch (status) {
                case 'notmodified':
                    return '304 not modified';
                case 'error':
                    return '网络异常';
                case 'timeout':
                    return '访问超时';
                case 'parsererror':
                    return 'parser error'
                default:
                    return '系统错误'
            }
        }
    };
    //jquery初始化插件
    $.fn.extend({
        //初始化菜单
        initMenu: function(obj) {
//        	$("body").getNiceScrolls();
        	$(this).find("li").eq(0).find("dl").slideDown().siblings("a").addClass("base-active");
        	var _init =$(this).find("li").eq(0).find("dl").find("dt").eq(0).find("a");
        	var v_url = $(this).find("li").eq(0).find("dl").find("dt").eq(0).find("a").data("url");
        	var o = {
                    'cont':'.data-content',
                    'url': v_url,
                    'data': '',
                    'isIframe':_init.data("isiframe")
                };
                //设置二级导航
            //_init.data("url") ?(BASE.redirect_url(o),$(".bread-dis li:eq(1) span").text($("#menuTop").find("li.layui-this>a").text())) : '';
            
            var src = {
                content: '.data-content'
            }
            var defaults = $.extend(src, obj);
            var $_this = this;
            var $a = $_this.find('a');
            $_this.on('click', 'a', function(e) {
                e.preventDefault();
                var $_this = $(this);
                var o = {
                    'cont': defaults.content,
                    'url': $_this.data('url'),
                    'data': '',
                    'isIframe':$_this.data("isiframe")
                };
                //设置二级导航
                //$_this.data("url") ?(BASE.redirect_url(o),$(".bread-dis li:eq(1) span").text($("#menuTop").find("li.layui-this>a").text())) : '';
            });
        },
        gotoNewLink: function(obj) {
            obj.cont = this;
            if (obj instanceof Object) BASE.redirect_url(obj);
        },
        /**
         * HandBar模板生成
         */
        parseTemplate: function(templateId, data) {
            var myTemplate = Handlebars.compile($("#" + templateId).html());
            // 索引
            Handlebars.registerHelper("addOne", function(index, options) {
                return (index*1) + 1;
            });
            Handlebars.registerHelper('isNull',function(param, options){
                var v_p= '';
                if(!param){
                	v_p = '无';
                }else{
                	v_p = param;
                }
            	return v_p;
            })
            Handlebars.registerHelper('getSex',function(param, options){
                var v_p= '';
                if(param=='1'){
                	v_p = '男';
                }else{
                	v_p = '女';
                }
            	return v_p;
            })
            Handlebars.registerHelper('getType',function(param, options){
                var v_p= '';
                if(param=='1'){
                	v_p = '菜单';
                }else{
                	v_p = '按钮';
                }
            	return v_p;
            })
            
            Handlebars.registerHelper('getStatus',function(param, options){
                var v_p= '';
                if(param=='1'){
                	v_p = '<span class="base-green">有效</span>';
                }else{
                	v_p = '<span class="base-red">无效</span>';
                }
            	return new Handlebars.SafeString(v_p);
            });
            
            Handlebars.registerHelper('isNot',function(param, options){
            	var html_string = (param==true?"<span class='base-red'>已锁定</span>":"<span class='base-green'>未锁定</span>");
                return new Handlebars.SafeString(html_string);
            })
            this.html(myTemplate(data));
        },
        getNiceScrolls:function(obj){
        	var defaults = {
        			selected:[{"#menu":80}],
        			bgcolor:"#3B99FC"
            }
        	$.extend(defaults, obj);
        	defaults.selected.forEach(function(v,i){
        		for(var key in v){
        			$(key).height(
        					(document.documentElement.clientHeight
        							|| window.innerHeight || window.screen.height)
        							- v[key] + "px");
            		$(key).niceScroll({
        				cursorcolor : defaults.bgcolor,
        				cursoropacitymax : 1,
        				touchbehavior : false,
        				cursorwidth : "5px",
        				cursorborder : "0",
        				autohidemode : false,
        				cursorborderradius : "1px"
        			});
        		}
        	});
    		
    	}
    });
    $.extend({
    	initThirdTitle:function(){
    		/*$(".bread-dis li:eq(1)").show();
        	$(".bread-dis li:eq(2)").show();
            $(".bread-dis li:eq(2) span").text($(".banner:eq(0) span").data('title'));*/
    	}
    });
    
    $.fn.extend({
    	pageInit:function(obj){
    		var pagebetween;
    		var pageCount = obj.pageCount;
    		var pageCurrent = obj.pageCurrent+1;
    		if(obj.pageCurrent<5){
    			if(pageCount<10){
    				pagebetween = pageCount;
    			}else if(pageCount){
    				pagebetween = 10;
    			}
    			pageCurrent = 1;
    		}else if(obj.pageCurrent>=5 && obj.pageCurrent<=pageCount){
    			if(pageCount-obj.pageCurrent<10){
    				pagebetween = pageCount;
    				pageCurrent = (pageCount-9)<0?1:pageCount-9;
    			}else{
    				pagebetween = obj.pageCurrent + 10;
    				pageCurrent = obj.pageCurrent;
    			}
    		} 
    		//给分页加载事件
        	$(this).off("click").on('click','li',function(){
        		var pageCurrent = $(this).data('pcurrent');
        		var params = obj.params;
        		params.pageCurrent = pageCurrent;
             	$("#"+obj.selector).gotoNewLink({
                    url: obj.jumpUrl,
                    data:params
                });
            });
    		var page_html = "<ul><li class='pre' data-pcurrent='1'><i class='iconfont icon-shouye base-blue'></i>";
    		for(var i = 1;i<pagebetween+1;i++){
    			if(i === obj.pageCurrent+1){
    				page_html += "<li class='pageActive' data-pcurrent="+i+">"+i+"</li>";
    			}else{
    				page_html += "<li data-pcurrent="+i+">"+i+"</li>";
    			}
    			
    		}
    		page_html += "<li class='next' data-pcurrent="+pageCount+"><i class='iconfont icon-shouye base-blue'></i></li><li>共"+pageCount+"页/当前第"+pageCurrent+"页</li><li>共"+obj.elementSize+"条</li></ul>"	;
    		$(this).html(page_html);
    	}
    });
    
    $.extend({
        baseEvent: function(obj) {
            //设置导航三级标题
        	/*$(".bread-dis li:eq(1)").show();
        	$(".bread-dis li:eq(2)").show();
            $(".bread-dis li:eq(2) span").text($(".banner:eq(0) span").data('title'));*/
            //返回
            $('#btn_back,#btn_cancel').on('click', function() {
                $(".data-content").gotoNewLink({
                    url: obj.data_list,
                });
            });
            
          //返回
            $('#btn_back,#btn_cancel1').on('click', function() {
                $(".data-content").gotoNewLink({
                    url: obj.data_list,
                });
            });
            //新增页面
            $("#btn_add").on('click', function() {
            	$.clear();
            	if(obj.add_is_dialog){
            		//添加技能复选框
            		 var myaddcheckbox = {
                         url: obj.ctx+'/sysParam/findChildParam',
                         para: {
                             "ID": "40289f5b6671550b0166715980190001"
                         },
                         callback: function(res) {
                        	if(res.success=="1") {
                        	 var html="";
                        	 for(i=0;i<res.data.length;i++){
                        		 html+='<span>'+res.data[i].paramName+'</span><input type="checkbox" name="skill"  value="'+res.data[i].paramName+'"  title="'+res.data[i].paramName+'" style="width: 14px;margin-right: 25px;"> '
                        	 }
                        	 $('#skill-checkbox').append(html);
                         }}
                     } 
                     $._NormalRequest(myaddcheckbox);
            		 
            		/*  */
            		layer.open({
              		  type: 1,
              		  shade: false,
              		  title: "<span class='dialog_title base-zb-info'>"+$("#data-form").data("title")+"</span>",
              		  area: ['60%', '70%'],
              		  content: $('#data-form'),
	          		  end : function() {
	          			$("#data-form").hide();
	          		  }
            		});
            	}else{
            		$("#btn_save").show();
                	$("#data-list").hide().siblings("#data-form").show();
            	}
            	//TODO:因改行会导致公共层 选中的结构  项目id清空 所以 注释改行代码
            	//$("input,select,textarea").val("");
            	$("#btn_save").show();
            	$("#btn_save1").show();
            	$('input,select,textarea').removeClass('oper-no');
    			$('input,select,textarea').removeAttr('readonly');
    			$('select,input[type=checkbox]').removeAttr('disabled');
    			$(".form-checkbox").removeClass('oper-no');
    			
            })
            //编辑/详情界面
            $('#datalist').on('click', '.detail,.update', function() {
                var $_this = $(this);
                var my = {
                    url: obj.findBy_url?obj.ctx+obj.findBy_url:obj.ctx+"/com/query",
                    para: {
                        "ID": $(this).data('pkid'),
                        "sid": obj.sid
                    },
                    callback: function(res) {
                    	if(obj.add_is_dialog){
                    		layer.open({
                      		  type: 1,
                      		  shade: false,
                      		  title: "<span class='dialog_title base-zb-info'>"+$_this.attr("title")+"</span>",
                      		  area: ['60%', '58%'],
                      		  content: $('#data-form'),
	                      	  end : function() {
	                      		$(".data-content").gotoNewLink({
	                                url: obj.data_list,
	                            });
	                      	  }
                    		});
                    	}else{
                    		$("#btn_save").show();
                        	$("#data-list").hide().siblings("#data-form").show();
                    	}
                    	
                    	//图片回显
                    	$.setValue(res.data);
                    	if(res.data.userImg){$("#userImgUrl").attrdetail('src',obj.ctx+'/res/img/userImg/'+res.data.userImg);}
                    	if(res.data.userImg){$("#userImgNotChangePath").attr('value',res.data.userImg);} 
                    	
                    	
                    	//部门回显 
                    	if(res.data.sysDept){
                    		var deptId=res.data.sysDept.deptId;
                        	var deptName=res.data.sysDept.name;
                        	$("#sysDeptIds").val(deptId);
                    	}
                    	
                    	
                    	//单角色回显 
                    	if(res.data.roles && res.data.roles[0]){
                    		var roleId=res.data.roles[0].roleId;
                        	var roleName=res.data.roles[0].name;
                        	$("#roleIds").val(roleId);
                    	}
                    	
                    	if(res.data.parentProfession){
                    		var professionId=res.data.parentProfession.professionId;
                        	var professionName=res.data.parentProfession.name;
                        	$("#parentProfessionId").val(professionId);
                    	}
                    	
                    	//结构类型回显(监测类型管理)
                    	if(res.data.atiProjectStructure){
                    		var structId = res.data.atiProjectStructure.id;
                        	$("#atiProjectStructureId").val(structId);

                    	}
                    	//监测类型回显(监测项管理)
                    	if(res.data.atiMonitorType){
                    		var structId = res.data.atiMonitorType.atiProjectStructure.id;
                    		$("#projectStructId").val(structId);
                    		var typeId = res.data.atiMonitorType.id;
                    		var typeReq = {
                                url: obj.ctx+'/monitorType/getTypeList',
                                para: {
                                    "structId": structId
                                },
                                callback: function(result) {
                               	if(result.success=="1") {
                               		var html='<option value="">请选择监测类型</option>';
                               		for(i=0;i<result.data.length;i++){
                               			html+='<option value="'+result.data[i].id+'">'+result.data[i].name + '</option>';
                               		}
                               		$('#monitorTypeId').html(html);
                                	$("#monitorTypeId").val(typeId);
                                }}
                            } 
                            $._NormalRequest(typeReq);
                    	}
                    	
                    	//监测项回显(监测参数管理)
                    	if(res.data.atiMonitorItem){
                    		var typeId = res.data.atiMonitorItem.atiMonitorType.id;
                    		var itemId = res.data.atiMonitorItem.id;
                    		$("#monitorTypeId").val(typeId);
                    		var itemReqAjax = {
                				url : obj.ctx+'/monitorItem/getItemListByType',
                				para : {'monitorTypeId' : typeId},
                				callback : function (res) {
                					if (res.data) {
                						var html = '请选择监测项';
                						for (var i=0; i<res.data.length; i++) {
                							 html += '<option value="'+res.data[i].id+'">'+res.data[i].name + '</option>';
                						}
                						$("#monitorItemId").html(html);
                						$("#monitorItemId").val(itemId);
                					}
                				}
                    		}
                    		$._MultAjax(itemReqAjax);
                    	}

                        /**
                         * 监测参数回显
                         */
                        if(res.data.atiMonitorParam){
                            var paramId = res.data.atiMonitorParam.id;
                            var structId = res.data.atiMonitorParam.atiMonitorItem.atiMonitorType.atiProjectStructure.id;
                            var typeId = res.data.atiMonitorParam.atiMonitorItem.atiMonitorType.id;
                            var itemId = res.data.atiMonitorParam.atiMonitorItem.id;
                            var typeReq = {
                                url: obj.ctx+'/device/getDeviceByParamItem',
                                para: {
                                    "structId": structId,
                                    "typeId":typeId
                                },
                                callback: function(result) {
                                    if(result.success=="1") {
                                        //监测类型回显
                                        if(result.data.typeList.length>0) {
                                            var html='<option value="">请选择监测类型</option>';
                                            for(i=0;i<result.data.typeList.length;i++){
                                                html+='<option value="'+result.data.typeList[i].id+'">'+result.data.typeList[i].name + '</option>';
                                            }
                                            $('#monitorTypeId').html(html);
                                            $("#monitorTypeId").val(typeId);
                                        }
                                        //监测项回显
                                        if(result.data.itemList.length>0) {
                                            var html='<option value="">请选择监测项</option>';
                                            for(i=0;i<result.data.itemList.length;i++){
                                                html+='<option value="'+result.data.itemList[i].id+'">'+result.data.itemList[i].name + '</option>';
                                            }
                                            $('#monitorItemId').html(html);
                                            $("#monitorItemId").val(itemId);
                                        }

                                        if(result.data.paramList.length > 0){
                                            for(var i = 0;i < result.data.paramList.length;i++){
                                                var option = $("<option></option>");
                                                option.val(result.data.paramList[i].id);
                                                option.text(result.data.paramList[i].name);
                                                $("#monitorParamId").append(option);
                                            }
                                            $("#monitorParamId").val(paramId);
                                        }

                                    }}
                            }
                            $._NormalRequest(typeReq);

                        }
                    	
                    	
                    	//项目回显
                    	if(res.data.monitorProject){
                    		var projectId = res.data.monitorProject.id;
                        	var projectName = res.data.monitorProject.name;
                        	$("#monitorProjectId").val(projectId);
                    	}
                    	
                    	 //技能回显 
                     /*	if(skills){
                     		//动态添加技能复选框
                    	var skills="";
                        if(res.data.skill){skills=res.data.skill}
                        	var mycheckbox = {
                                url: obj.ctx+'/sysParam/findChildParam',
                                para: {
                                    "ID": "40289f5b6671550b0166715980190001"
                                },
                                callback: function(res) {
                                	if(res.success=="1"){
                                   	 var html="";
                                   	 for(i=0;i<res.data.length;i++){
                                   		 html+='<span>'+res.data[i].paramName+'</span><input type="checkbox" name="skill"  value="'+res.data[i].paramName+'"  title="'+res.data[i].paramName+'" style="width: 14px;margin-right: 25px;"> '
                                   	 }
                                   	 $('#skill-checkbox').append(html);
	                             		//获得所要回显的值
	                                     var checkeds = skills;
	                                     //拆分为字符串数组
	                                     var checkArray =checkeds.split(",");
	                                     //获得所有的复选框对象
	                                     var checkBoxAll = $("input[name='skill']");
	                                     //获得所有复选框的value值，然后，用checkArray中的值和他们比较，如果有，则说明该复选框被选中
	                                           for(var i=0;i<checkArray.length;i++){
	                                                //获取所有复选框对象的value属性，然后，用checkArray[i]和他们匹配，如果有，则说明他应被选中
	                                                $.each(checkBoxAll,function(j,checkbox){
	                                                    //获取复选框的value属性
	                                                    var checkValue=$(checkbox).val();
	                                                    if(checkArray[i]==checkValue){
	                                                        $(checkbox).attr("checked",true);
	                                                    }
	                                                })
	                                         }     
                                    }}
                            }
                            $._NormalRequest(mycheckbox);
                     	}*/
                        	
                    	if($_this.is(".detail")){
                        	$("#btn_save").hide();
                        	$("#btn_save1").hide();
                        	$('input,select,textarea').addClass('oper-no');
                			$('input,select,textarea').attr('readonly','readonly');
                			$('select').attr('disabled',"true");
                        }
                    	if($_this.is(".update")){
                        	$("#btn_save").show();
                        	$("#btn_save1").show();
                        	$('input,select,textarea').removeClass('oper-no');
                			$('input,select,textarea').removeAttr('readonly');
                			$('select').removeAttr('disabled');
                        }
                    }
                }
                $._NormalRequest(my);
            })
            
            //删除方法
            $('#datalist').on('click', '.delete', function() {
            	var $_this = $(this);
            	layer.confirm('你确定要删除吗？', {
            		  btn: ['确定','取消']//按钮
            		}, function(){
                        var $_id = $_this.data("pkid");
                        if ($_id) {
                            var my = {
                                url: obj.del_url?obj.ctx+obj.del_url:obj.ctx+"/com/delete",
                                para: {
                                    ID: $_id,
                                    sid: obj.sid
                                },
                                callback: function(res) {
                                    if (res.success == '1') {
                                    	$(".data-content").gotoNewLink({
                                            url: obj.data_list,
                                        });
                                    }
                                    layer.msg(res.message);
                                }
                            }
                            $._NormalRequest(my);
                        } else {
                            layer.msg('没有发现主键或该数据为最高级，无法删除。');
                        }
            		});
                
            });
            //查询
            $("#btn_search").on('click', function() {
                $.conditionqueryList(obj);
            })
            
            //保存方法
			$('#btn_save').on('click', function() {
				//表单校验
				var isTemp = $(obj.formSelect?"#"+obj.formSelect:"#form").validateForm({
					msgPosition : 'right'
				});
				//分类处理
				if (isTemp) {
					var my = {
							form : obj.formSelect?obj.formSelect:"form",
							para : {
								"sid" :obj.sid
							},
							url : obj.form_url?obj.ctx+obj.form_url:obj.ctx+"/com/add",
							callback : function(res) {
								layer.msg(res.message);
								if(res.success == '1'){
									$(".data-content").gotoNewLink({url:obj.data_list})
								}
							}
						}
						$._FormRequest(my);
				}
			});
            //初始化列表页面
            $.queryList(obj);
        },
        _NormalRequest: function(who) {
            var index = BASE._dialog({
                type: 'load'
            });
            if (who.para) {
                who.para.ts = Math.random();
            }
            $.ajax({
                type: (who.type == undefined || who.type == null) ? "POST" : who.type,
                cache: false,
                url: who.url,
                data: (who.para == undefined || who.para == null) ? {} : who.para,
                dataType: "json",
                async: (who.async == undefined || who.async == null) ? true : false,
                timeout: 30000,
                success: function(res) {
                    layer.close(index);
                    if (who.callback) {
                        who.callback(res);
                    } else {
                        console.log(res.message);
                    }
                },
                error: function(XMLHttpRequest, textStatus, errorThrown) {
                    BASE._dialog({
                        msg: BASE.getStatus(textStatus),
                        type: 'alert',
                    });
                }
            });
        },
        _MultAjax: function(who) {
            var index = BASE._dialog({
                type: 'load'
            });
            if (who.para) {
                who.para.ts = Math.random();
            }
            $.ajax({
                type: (who.type == undefined || who.type == null) ? "POST" : who.type,
                cache: false,
                url: who.url,
                data: (who.para == undefined || who.para == null) ? {} : who.para,
                dataType: "json",
                async: (who.async == undefined || who.async == null) ? true : false,
                timeout: 30000,
                success: function(res) {
                    layer.close(index);
                    if (who.callback) {
                        who.callback(res);
                    } else {
                        console.log(res.message);
                    }
                },
                error: function(XMLHttpRequest, textStatus, errorThrown) {
                	layer.msg("网络异常",{icon:7},function(){
                		layer.close(index);
                	});
                }
            });
        },
        /**
         * form表单提交数据
         * @param who 请求对象
         */
        _FormRequest: function(who) {
            var index = BASE._dialog({
                type: 'load'
            });
            $("#" + who.form).ajaxSubmit({
                type: "POST",
                url: who.url,
                data: (who.para == undefined || who.para == null) ? {} : who.para,
                dataType: "json",
                success: function(res) {
                    layer.close(index);
                    if (who.callback) {
                        who.callback(res);
                    } else {
                        console.log(res.message);
                    }
                },
                error: function(XMLHttpRequest, textStatus, errorThrown) {
                    BASE._dialog({
                        msg: BASE.getStatus(textStatus),
                        type: 'alert',
                    });
                }
            });
        },
        /*
         * 获得URL参数
         */
        getUrlPara: function(paras, isde) {
            if (!isde) {
                isde = "";
            }
            var url = location.href;
            var paraString = url.substring(url.indexOf("?") + 1, url.length).split("&");
            var paraObj = {}
            for (i = 0; j = paraString[i]; i++) {
                paraObj[j.substring(0, j.indexOf("=")).toLowerCase()] = j.substring(j.indexOf("=") + 1, j.length);
            }
            var returnValue = paraObj[paras.toLowerCase()];
            if (typeof(returnValue) == "undefined") {
                return "";
            } else {
                if (isde == "1") {
                    return decodeURI(returnValue); // 返回解码的数据
                } else {
                    return returnValue; // 返回参数中的原始数据
                }
            }
        },
        conditionqueryList : function(obj) {
        	$("#data-list").siblings("#data-form").hide();
            var v_obj = {};
            v_obj.sid = obj.sid;
            //处理参数(除去当前页)
            if(obj.param){
               	var v_p = obj.param;
   	            for(var i = 0,l = v_p.length;i<l;i++){
   	            	v_obj[v_p[i]] = $("#"+v_p[i]).val();
   	            }
            };
            var requestAjax = {};
            //分类处理，如果带分页
            if(obj.isPage){
            	requestAjax = {
                        url: obj.ctx+obj.pageList_url,
                        para: v_obj,
                        callback: function(res) {
                            $(".base-message").remove();
                            var code = res.success;
                            if(code == '1') {
                            	var data = res.data;
                        		var pageCount = data.totalPages;
                        		var pageCurrent = data.number+1;
                        		if(data.number<5){
                        			if(pageCount<10){
                        				pagebetween = data.totalPages;
                        			}else if(pageCount){
                        				pagebetween = 10;
                        			}
                        			pageCurrent = 1;
                        		}else if(data.number>=5 && data.number<=pageCount){
                        			if(pageCount-data.number<10){
                        				pagebetween = pageCount;
                        				pageCurrent = (pageCount-9)<0?1:pageCount-9;
                        			}else{
                        				pagebetween = data.number + 10;
                        				pageCurrent = data.number;
                        			}
                        		}  
                        		$('#datalist').parseTemplate('tradecent-template',data.content);
                        		var page_html = "<div class='list-page' id='page_list'><ul><li class='pre' data-pcurrent='1'><i class='iconfont icon-shouye base-blue'></i></li>";
                            		for(var i = pageCurrent;i<pagebetween+1;i++){
                            			if(i === data.number+1){
                            				page_html += "<li class='pageActive' data-pcurrent="+i+">"+i+"</li>";
                            			}else{
                            				page_html += "<li data-pcurrent="+i+">"+i+"</li>";
                            			}
                            			
                            		}
                        		page_html += "<li class='next' data-pcurrent="+data.totalPages+"><i class='iconfont icon-shouye base-blue'></i></li><li>共"+data.totalPages+"页/当前第"+(data.number+1)+"页</li><li>共"+data.totalElements+"条</li></ul></div>"	;
                        		if($("#list").has('.list-page')){
                        			$("#list").find('.list-page').remove();
                        			$("#list").append(page_html);
                        		}else{
                        			$("#list").append(page_html);
                        		}	
                            	//给分页加载事件
                            	$("#page_list").on('click','li',function(){
                                 	var pageCurrent = $(this).data('pcurrent');
                                 	obj.pageCurrent = pageCurrent;
                                 	$.queryList(obj)
                                });
                            	//ban全选
                            	$('.check_item').on('click',function(){
                        			var _this = $(this);
                        			if(!_this.prop('chekced')){
                        				$('#checkAll').prop('checked',false);
                        			}
                        		});
                            	
                            } else if (code == '2') {
                                $("#list").find('tbody').empty();
                                $("#page_list").remove();
                                $("#list").append("<div class='base-gray center base-message'>" + res.message + "</div>")
                            } else if (code == '0') {
                                layer.msg(res.message);
                            }
                        }
                    }
            	 $._NormalRequest(requestAjax);
            }else{
            	if(!obj.data_list || !obj.sid){
               	 BASE._dialog({
                        msg:'请检查你的配置项是否正确',
                        type: 'alert',
                 });
               }else{
            	   v_obj.sid = obj.sid;
            	   requestAjax = {
                       url: obj.ctx+"/com/conditionqueryList",
                       para: v_obj,
                       callback: function(res) {
                           $(".base-message").remove();
                           $("#list").find('tbody').empty();
                           var code = res.success;
                           if(code == '1') {
                        	   $('#datalist').parseTemplate('tradecent-template', res.data);
                           }else if (code == '2') {
                               $("#list").append("<div class='base-gray center base-message'>" + res.message + "</div>")
                           }else if (code == '0') {
                               layer.msg(res.message);
                           }
                       }
                   }
            	   $._NormalRequest(requestAjax);
               }
            }
        },
        
        //获得数据列表
        queryList: function(obj) {
        	//滚动条
//        	$("body").getNiceScrolls({selected:[{"#list":260}]});
        	
        	//隐藏表单
            $("#data-list").siblings("#data-form").hide();
            var v_obj = {};
            v_obj.sid = obj.sid;
            //处理参数(除去当前页)
            if(obj.param){
               	var v_p = obj.param;
   	            for(var i = 0,l = v_p.length;i<l;i++){
   	            	v_obj[v_p[i]] = $("#"+v_p[i]).val();
   	            }
            };
            var requestAjax = {};
            //分类处理，如果带分页
            if(obj.isPage){
            	v_obj.pageCurrent = obj.pageCurrent;
            	requestAjax = {
                        url: obj.ctx+obj.pageList_url,
                        para: v_obj,
                        callback: function(res) {
                            $(".base-message").remove();
                            var code = res.success;
                            if(code == '1') {
                            	var data = res.data;
                        		var pageCount = data.totalPages;
                        		var pageCurrent = data.number+1;
                        		if(data.number<5){
                        			if(pageCount<10){
                        				pagebetween = data.totalPages;
                        			}else if(pageCount){
                        				pagebetween = 10;
                        			}
                        			pageCurrent = 1;
                        		}else if(data.number>=5 && data.number<=pageCount){
                        			if(pageCount-data.number<10){
                        				pagebetween = pageCount;
                        				pageCurrent = (pageCount-9)<0?1:pageCount-9;
                        			}else{
                        				pagebetween = data.number + 10;
                        				pageCurrent = data.number;
                        			}
                        		}  
                        		$('#datalist').parseTemplate('tradecent-template',data.content);
                        		var page_html = "<div class='list-page' id='page_list'><ul><li class='pre' data-pcurrent='1'><i class='iconfont icon-shouye base-blue'></i></li>";
                            		for(var i = pageCurrent;i<pagebetween+1;i++){
                            			if(i === data.number+1){
                            				page_html += "<li class='pageActive' data-pcurrent="+i+">"+i+"</li>";
                            			}else{
                            				page_html += "<li data-pcurrent="+i+">"+i+"</li>";
                            			}
                            			
                            		}
                        		page_html += "<li class='next' data-pcurrent="+data.totalPages+"><i class='iconfont icon-shouye base-blue'></i></li><li>共"+data.totalPages+"页/当前第"+(data.number+1)+"页</li><li>共"+data.totalElements+"条</li></ul></div>"	;
                        		if($("#list").has('.list-page')){
                        			$("#list").find('.list-page').remove();
                        			$("#list").append(page_html);
                        		}else{
                        			$("#list").append(page_html);
                        		}	
                            	//给分页加载事件
                            	$("#page_list").on('click','li',function(){
                                 	var pageCurrent = $(this).data('pcurrent');
                                 	obj.pageCurrent = pageCurrent;
                                 	$.queryList(obj)
                                });
                            	//ban全选
                            	$('.check_item').on('click',function(){
                        			var _this = $(this);
                        			if(!_this.prop('chekced')){
                        				$('#checkAll').prop('checked',false);
                        			}
                        		});
                            	
                            } else if (code == '2') {
                                $("#list").find('tbody').empty();
                                $("#page_list").remove();
                                $("#list").append("<div class='base-gray center base-message'>" + res.message + "</div>")
                            } else if (code == '0') {
                                layer.msg(res.message);
                            }
                        }
                    }
            	 $._NormalRequest(requestAjax);
            }else{
            	if(!obj.data_list || !obj.sid){
               	 BASE._dialog({
                        msg:'请检查你的配置项是否正确',
                        type: 'alert',
                 });
               }else{
            	   v_obj.sid = obj.sid;
            	   requestAjax = {
                       url: obj.ctx+"/com/queryList",
                       para: v_obj,
                       callback: function(res) {
                           $(".base-message").remove();
                           $("#list").find('tbody').empty();
                           var code = res.success;
                           if(code == '1') {
                        	   $('#datalist').parseTemplate('tradecent-template', res.data);
                           }else if (code == '2') {
                               $("#list").append("<div class='base-gray center base-message'>" + res.message + "</div>")
                           }else if (code == '0') {
                               layer.msg(res.message);
                           }
                       }
                   }
            	   $._NormalRequest(requestAjax);
               }
            }
        }
    });
})(window, jQuery, layer)
