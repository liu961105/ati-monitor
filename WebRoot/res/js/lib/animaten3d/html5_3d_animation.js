
!function ($) {
    $.fn.lights = function (options) {
        var defaults = {};
        var settings = $.extend({}, defaults, options);
        //创建canvas对象
        var canvas = $(this).get(0);
        var ctx = canvas.getContext('2d');
        var x = canvas.width = window.innerWidth;
        var y = canvas.height = window.innerHeight;
        var imgs = new Image();
        imgs.src = '../../img/bg.png';
        if(imgs.border){
            ctx.drawImage(imgs,0,0,x,y);
        }else{
            imgs.onload = function(){
                ctx.drawImage(imgs,0,0,x,y);
            }
            imgs.onerror = function(){
                window.alert('背景图片加载失败，请重试');
            };
        }
    }
}(window.jQuery);
