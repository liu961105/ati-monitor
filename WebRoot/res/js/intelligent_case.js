'use strict';

window.addEventListener('load', function () {
    var carousels = document.querySelectorAll('.carousel');

    for (var i = 0; i < carousels.length; i++) {
        carousel(carousels[i]);
    }
});

function carousel(root) {
    var figure = root.querySelector('figure'),
    	customer = root.querySelector('customer'),
        nav = root.querySelector('.btn'),
        images = figure.children,
        custominfo = customer.children,
        n = images.length,
       
        gap = root.dataset.gap || 0,
        bfc = 'bfc' in root.dataset,
        theta = 2 * Math.PI / n,
        currImage = 0;
        
	    setupCarousel(n, parseFloat(getComputedStyle(images[0]).width));
	    window.addEventListener('resize', function () {
	        setupCarousel(n, parseFloat(getComputedStyle(images[0]).width));
	    });

    setupNavigation();

    function setupCarousel(n, s) {
        var apothem = s / (2 * Math.tan(Math.PI / n));

        figure.style.transformOrigin = '50% 50% ' + -apothem + 'px';
		customer.style.transformOrigin = '50% 50% ' + -apothem + 'px';
		
        for (var i = 0; i < n; i++) {
            images[i].style.padding = gap + 'px';
            custominfo[i].style.padding = gap + 'px';
        }for (i = 1; i < n; i++) {
            images[i].style.transformOrigin = '50% 50% ' + -apothem + 'px';
            images[i].style.transform = 'rotateY(' + i * theta + 'rad)';
            //
            custominfo[i].style.transformOrigin = '50% 50% ' + -apothem + 'px';
            custominfo[i].style.transform = 'rotateY(' + i * theta + 'rad)';
            }
        if (bfc) for (i = 0; i < n; i++) {
            images[i].style.backfaceVisibility = 'hidden';
            custominfo[i].style.backfaceVisibility = 'hidden';
        }rotateCarousel(currImage);
    }

    function setupNavigation() {
        nav.addEventListener('click', onClick, true);

        function onClick(e) {
        	var _this = this;
            e.stopPropagation();
            var t = e.target;
            if (t.tagName.toUpperCase() != 'DIV') return;
            if (t.classList.contains('btn-l')) {
                currImage++;
                rotateCarousel(currImage);
            }else if (t.classList.contains('btn-r')) {
                currImage--;
                rotateCarousel(currImage);
            }
        }
    }

    function rotateCarousel(imageIndex) {
        figure.style.transform = 'rotateY(' + imageIndex * -theta + 'rad)';
        customer.style.transform = 'rotateY(' + imageIndex * -theta + 'rad)';
    }
}

function transTimer(){
	
}
