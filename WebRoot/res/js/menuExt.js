


//初始化首节点
function initMenu(menus) {
    var $span = '<span class="layui-nav-more"></span>';
    for (var i = 0; i < menus.length; i++) {
        var menusi = menus[i];
        var $li = $('<li class="layui-nav-item">');
        var $a = $('<a data-url="'+menusi.url+'">');
        $a.text(menusi.name);
        if (menusi.hasChild) {
            $a.append($span);
        }

        $a.attr("onclick", "clickMenu(this)");
        $a.data("menuObj", menusi);

        $li.append($a);
        $("#menuLeft").append($li);
    }
}

//初始化叶子节点
function initChildMenu(childMenus, a) {
    //如何已经有数据可以直接显示不用生成html

    var $dl = $('<dl class="layui-nav-child">');
    for (var i = 0; i < childMenus.length; i++) {
        var menusi = childMenus[i];
        var $dd = $('<dd></dd>');
        var $a = $('<a data-url="'+menusi.url+'" onclick="clickMenu(this)">' + menusi.name + '</a>');
        var $span = '<span class="layui-nav-down"></span>';

        if (menusi.hasChild) {
            $a.append($span);
            $a.data("menuObj", menusi);
        }
        $dd.append($a);
        $dl.append($dd);
        $(a).parent().append($dl);
        $(a).parent().addClass("layui-nav-itemed");
    }

}

//单击事件
function clickMenu(a) {
	$(a).parent().addClass("active").siblings().removeClass("active");
	var url = $(a).attr("data-url");
	if(url != null && url != "null" && url != "undefined" && url != ""){
		$(".data-content").load(url);
	}else {
		$(a).parent().toggleClass("layui-nav-itemed");

	    if ($(a).next().length == 0) {//首次初始化
	        var childMenus = getMenus($(a).data("menuObj").menuId);
	        initChildMenu(childMenus, a);
	    } else {
	        if ($(a).parents(".layui-nav-child").length > 0) {
	            $(a).next().toggle();
	        }
	    }

	    $(a).children("span").toggleClass(function () {
	        if ($(this).hasClass("layui-nav-down")) {
	            return "layui-nav-more";
	        } else {
	            return "layui-nav-down";
	        }
	    });
	}
}

function intitLeftMenus(menus) {
    for (var i = 0; i < menus.length; i++) {
        var menusi = menus[i];
        var $li = $('<li class="layui-nav-item">');
        var childItem = getLeftChildMenu(menusi,'first-title',menusi.name);
       
        $li.html(childItem);
        $("#menuLeft").append($li);
    }
    layui.use(['element', 'layer'], function(){
		  var element = layui.element;
		  var layer = layui.layer;
		  element.init();
	});

}
function getLeftChildMenu(menusi,orderFlag) {
	var span = '<span class="layui-nav-more"></span>';
	var a = '<a class="urla" data-url="'+menusi.url+'" onclick="jumpPagee(\''+menusi.url+'\',\''+orderFlag+'\',\''+menusi.name+'\')">';
	a += '<i class="layui-icon '+menusi.icon+'"></i><cite>' + menusi.name + '</cite>';
	var dl = '<dl class="layui-nav-child">';
	var ddT = '<dd>';
	var dd = '';
    if (menusi.hasChild) {
        a += span;
        var childMenus = getMenus(menusi.menuId);
        if(childMenus){
            for (var i = 0; i < childMenus.length; i++) {
                var childHtml = getLeftChildMenu(childMenus[i],'second-title');
                dd += ddT;
                dd += childHtml;
                dd += "</dd>";
            }
            dl+=dd;
            dl+="</dl>";
        }
        a += "</a>";
        a+=dl;
    }else {
    	a += "</a>";
    }
    return a;
}

function jumpPagee (url,orderFlag,menuName) {
	if (orderFlag == 'first-title') {
		$(".bread-dis li:eq(1)").show();
		$(".bread-dis li:eq(1)").addClass("base-blue-01");
		$(".bread-dis li:eq(1) span").text(menuName);
		$(".bread-dis li:eq(2)").hide();
	} else if (orderFlag == 'second-title'){
		$(".bread-dis li:eq(1)").show();
		$(".bread-dis li:eq(1)").removeClass("base-blue-01");
		$(".bread-dis li:eq(2)").show();
		$(".bread-dis li:eq(2) span").text(menuName);
	}
	if(url) {
		$('.data-content').load(url);
	}
}
