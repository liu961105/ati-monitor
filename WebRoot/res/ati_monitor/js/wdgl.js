$(function(){
    init();
    $(".J_checkout").find("li").find("span").click(function(){
        alert(this);
        $(this).addClass("on").siblings("span").removeClass("on");
    })
})
function init(){
    var html="";
    for (let index = 0; index < 20; index++) {
        html+=`<tr>
        <td>${index+=1}</td>
        <td>傳感器 拉线式位移1＃</td>
        <td>Excel</td>
        <td>133523k</td>
        <td>2017-12-13 22:00:55</td>
        <td><button type="button" class="m-btn m-btn-error">下载</button></td>
    </tr>`; 
    }
    $(".J_table").html(html);
}