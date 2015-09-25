$(document).ready(function() {
  var smoothScroll;
  $('body').flowtype({
    minimun: 500,
    maximum: 1000,
    minFont: 12,
    maxFont: 40,
    fontRatio: 40
  });

  /*
   $('.main').onepage_scroll
    sectionContainer: 'section'
    easing: 'ease'
    animationTime: 1000
    pagination: false
    updateURL: false
    beforeMove: (index) -> {}
    afterMove: (index) -> {}
    loop: true
    keyboard: true
    responsiveFallback: false
    direction: 'vertical'
   */
  smoothScroll = function(duration) {
    $('a[href^="#"]').on('click', function(event) {
      var target;
      target = $($(this).attr('href'));
      if (target.length) {
        event.preventDefault();
        $('html, body').animate({
          scrollTop: target.offset().top
        }, duration);
      }
    });
  };
  smoothScroll(1500);
});
