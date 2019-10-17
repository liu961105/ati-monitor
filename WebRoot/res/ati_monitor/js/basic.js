
window.alert=function(v){
    console.log(v);
}
var menu = [
    { title: "首页", url: "index.html", sub: [] },
    { title: "工程信息", url: "gcxx.html", sub: [] },
    { title: "监测内容", url: "kzmb.html", sub: [] },
    { title: "安全预警", url: "sjgj.html", sub: [] },
    { title: "数据比较", url: "sjbj.html", sub: [] },
    { title: "数据处理", url: "sjcl.html", sub: [] },
    { title: "文档管理", url: "wdgl.html", sub: [] },
    { title: "工程相册", url: "gcxc.html", sub: [] },
    { title: "数据管理", url: "javascript:return;", 
    	sub: [
    		{ title: "工程信息维护", url: "gcxxwh.html",active:true },
	        { title: "现场照片", url: "xczp.html" },
	        { title: "数据生成", url: "javascript:return;" },
	        { title: "地图管理", url: "javascript:return;" }
	    ]
    }
]

$(function () {
    initMenu();
	$(".m-header-title").click(function(){
		window.location.href = "nav.html";
	})
});


function initMenu() {
    var html = '';
    menu.forEach((v) => {
        var subHtml = '';
        if (v.sub.length > 0) {
            subHtml = '<ul>';
            v.sub.forEach(sv => {
                if(sv.active){
                    subHtml += `<li class="on"><a href="${sv.url}">${sv.title}</a></li>`;
                }else{
                    subHtml += `<li><a href="${sv.url}">${sv.title}</a></li>`;
                }
            })
            subHtml += '</ul>';
        }
        html += `<li class="nav-ul-li" onclick="showSub(this)">
        <a href="${v.url}">${v.title}</a><i class="iconfont icon-xiangyou"></i>
         ${subHtml}
    </li>`;
    });
    $(".J_menu").html(html);
}

function showSub(e){
    if($(e).hasClass("show")){
        $(e).removeClass("show");
    }else{
        $(e).addClass("show").siblings("li").removeClass("show");
    }
}
