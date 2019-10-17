$(function () {
    setChartsVal("#charts1", 35);
    setChartsVal("#charts2", 56);
    setChartsVal("#charts3", 90);

    pageData();

    $("#searchProjectBtn").on('click',function () {
        pageData(1);
    })


    function pageData(pageIndex) {
        var pageDataUrl = "/projectInfo/projectPageInfo";
        //获取参数
        var formData = $("#searchProjectForm").serialize();
        formData['pageCurrent'] = pageIndex;
        $.post(pageDataUrl,formData,function (data) {
            if(data.success == '1'){
                data = data.data;
                var totalPages = data.totalPages;
                pushPageData(data.content)
                $("#page").Page({
                    totalPages: totalPages,//分页总数
                    liNums: 10,//分页的数字按钮数(建议取奇数)
                    activeClass: 'activP', //active 类样式定义
                    indexPage:pageIndex,
                    callBack: function (page) {
                        pageData(page)
                    }
                });
            }else{
                //弹出错误
            }
        })
    }
    function pushPageData(data) {
        var html = "";
        for (var index = 0; index < data.length; index++) {
            html += '<tr>\n' +
                '        <td>'+(index * 1 + 1)+'</td>\n' +
                '        <td>'+data[index].address+'</td>\n' +
                '        <td>'+data[index].projectName+'</td>\n' +
                '        <td>\n' ;
            if(data[index].projectStatus == 1){
                html+='<button type="button" style="width: 50%" class="m-btn m-btn-warning">'+data[index].stateStr+'</button> &nbsp;&nbsp;\n'
            }else {
                html+='<button type="button" style="width: 50%" class="m-btn m-btn-success">'+data[index].stateStr+'</button> &nbsp;&nbsp;\n'
            }

               html+= '          <button type="button" class="m-btn m-btn-primary">查看</button>\n' +
                '        </td>\n' +
                '    </tr>';
        }
        $(".J_table").html(html);
    }

    function setChartsVal(dom, val) {
        if (val > 0 && val < 50) {
            $(dom).parent("li").css("background-image", 'url("/res/ati_monitor/img/1.png")');
        }
        if (val >= 50 && val < 90) {
            $(dom).parent("li").css("background-image", 'url("/res/ati_monitor/img/2.png")');
        }
        if (val > 90) {
            $(dom).parent("li").css("background-image", 'url("/res/ati_monitor/img/3.png")');
        }
        val = val - 54;
        $(dom).css("transform", "rotate(" + val + "deg)");

    }
})




