var pathName = window.location.pathname.substring(1);
var webName = pathName == '' ? '' : pathName.substring(0, pathName.indexOf('/'));
webName = '/'+webName;

$(function()
{
	//点击其他收起菜单
	$(document).on("click",	function(e) {
		if (!$(e.target).hasClass("settingHandler")
				&& $(e.target).parents(".settingHandler").length == 0) {
			$(".topSub-nav", top.window.document).slideUp(300);
		}
	})
	// 操作框的点击效果
	$(".listHandler").on("click",function()
	{	
		$(".listHandler>ul").slideUp('fast',function(){
		});
		if($(this).find("ul").find("li").length>0)
		{
			$(this).find("ul").slideToggle(300);
		}		
	});
	
	//复选框的点击效果
	$(".list-table .check_btn").on("click",function()
	{
		if($(this).hasClass("active"))
		{
			$(this).next("input").removeAttr('checked');
		}
		else
		{
			$(this).next("input").attr('checked','checked');
		}
		$(this).toggleClass("active");
	});
	
	//列表全选操作
	$(".check_all").on("click",function()
	{
		if($(this).hasClass("active"))
		{
			$(".label").find(".check_btn").removeClass("active");
			$(".label").find("input").removeAttr('checked');
		}
		else
		{
			$(".label").find(".check_btn").addClass("active");
			$(".label").find("input").attr("checked","checked");		
		}	
	});
	//点击页面其它部分隐藏操作下拉层
	$(document).on("click",function(e)
	{
		if($(e.target).parents(".listHandler").length == 0)
		{
			$(".listHandler").find("ul").hide();
		}
	});
	//选择窗口方法
	$(".form-selectinput").on("click",function()
	{
		$(this).next("ul").slideToggle(200);
		$(this).find(".from-selecticon").toggleClass("active");
	});
	$(".select-radio ul li").on("click",function()
	{
		$(this).siblings("li").removeClass("active");
		$(this).addClass("active");
		$(this).parent("ul").slideUp(200);		
		var selectVal = $(this).text();
		$(this).parent("ul").next("select").val(selectVal);
		
		
		
		$(this).parent("ul").prev(".form-selectinput").find("span").text(selectVal);
		var id = $(this).attr("id");
		if(id == "system-manager" || id == "org-manager" || id == "file-manager" || id == "doc-manager") {
			$('#resIcon').val(id);
		} else {
			$('#parentId').val(id);
		}
	});
	
	//控制显示提示框
		var add ; 
		add = $("#alert");
		add.slideUp(1000);
		setTimeout(function(){add.slideUp(1000);},1300);
	    add.slideDown(1500);  
	    setTimeout(function(){add.slideUp(1000);},1300);
		//单选框的点击效果
	$(".radio_btn").on("click",function()
	{
		$(this).parents(".label").siblings().find(".radio_btn").removeClass("active");
		$(this).parents(".label").siblings().find(".check_btn").removeAttr("checked");
		$(this).addClass("active");
		$(this).parent().find("input").attr("checked","checked");
	});
	$(".label").click(function(){ 	return false;  });
	$(".form-tab li").on("click",function()
	{
		$(this).siblings("li").removeClass("active");
		$(this).addClass("active");	
	});
	
	
	/**单选影响全选**/	
	$("i.check_btn:not('.check_all')").click( function(){  if( $("i.check_btn:not('.check_all')").length >   $("i.check_btn.active:not('.check_all')").length ) { $(".check_all").removeClass("active");$(".check_all").parent().find("input").removeAttr("checked");  }else { $(".check_all").addClass("active");$(".check_all").parent().find("input").attr("checked","checked");  } ;  }  );
	//全局计算宽度
	$(".list-topBar").width($(".list-table").width()); 
	$(".list-title").width($(".list-table").width()-14);
});
/**批量删除**/	
function deleteData(url,parm){
	if($(".check_btn:checked").length!=0&&$('.list-table tbody input:checkbox:checked').length!=0){
		Dialog.confirm('您确认要删除吗？',function(){
			var ids = "";
			$('.list-table tbody input[type=checkbox]').each(function(i, o) {
				if($(o).attr('checked')) {
					ids += $(o).val() + ",";
				}
			});
			window.location.href=webName+'/'+url+"?"+parm+"="+ids.substring(0,ids.length-1);
		});
		
	}else{
		Dialog.alert('请您至少选择一条数据',function(){
			return null;
		});
	}
}

/**删除单条数据**/
function deleteSingle(url,parm,obj){
	var singleId=$(obj).parent().parent().parent().find('td:first').find('input').attr('id'); 
    	Dialog.confirm('您确认要删除吗？',function(){
    		window.location.href=webName+'/'+url+"?"+parm+"="+singleId;
	});	
}
/**进入新增或编辑页面，新增时不需要传后面两个参数**/
function add(url,parm,obj){
	var singleId=$(obj).parent().parent().parent().find('td:first').find('input').attr('id');
	var orderField=$("#orderField").val();
	var orderSort=$("#orderSort").val();
	if(orderField!=''&&orderSort!=''){
		window.location.href=webName+'/'+url+"?"+parm+"="+singleId+"&orderField="+orderField+"&orderSort="+orderSort;
	}else{
		window.location.href=webName+'/'+url+"?"+parm+"="+singleId;
	}
}

function switchSelect(selectValue,inputId){	
	$("#"+inputId).val(selectValue);
}

/**列表跳转指定页**/
function pageGoto(page,sortType,searchParams,totalPages,orderField,orderSort){
	page = page?page:$("#page").val();
	var re = /^[1-9]+[0-9]*]*$/;
	if(!re.test(page)){
		$("#page").addClass("erro");
		$("#page").val("");
	}else if(page<1){
		$("#page").addClass("erro");
		$("#page").val("");
	}else if(page>totalPages){
		$("#page").addClass("erro");
		$("#page").val("");
	}else{
		var data = {
				"page":page,
				"sortType":sortType,
				"searchParams":searchParams,
				"orderField":orderField,
				"orderSort":orderSort	
		};
		$("#main").load("/itws/sysUser1/getSysUserList",data,function(res,status,xhr){
			//layer.close(index);
			var v_title = ''
			if(status !=='success'){
				switch(status){
				case 'notmodified':
					v_title = 'not modified';
					break;
				case 'error':
					v_title = '网络异常';
					break;
				case 'timeout':
					v_title:'访问超时';
					break;
				case 'parsererror':
					v_title:'parser error'
					break;
				default:
					v_title:'系统错误'
				}
			}
		});
		
		//location.href="?page="+page+"&sortType="+sortType+"&"+searchParams+"&orderField="+orderField+"&orderSort="+orderSort;
	}
}

/*
用途：检查输入字符串是否只由汉字、字母、数字组成
输入：
value：字符串
返回：
如果通过验证返回true,否则返回false
*/
function isChinaOrNumbOrLett( s ){//判断是否是汉字、字母、数字组成
//var regu = "^[0-9a-zA-Z\u4e00-\u9fa5]+$";
var regu = /^(\w|[\u4E00-\u9FA5]|@)*$/;
var re = new RegExp(regu);
if (re.test(s)) {
return true;
}else{
return false;
}
}