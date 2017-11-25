function Zamboni() {
  this.$zamb = $('<img id="zamb" src="/assets/zamboni.png">');
  this.$zamb.css('position', 'absolute');
  this.$zamb.css('top', 10);

  width = $(window).width();
  this.$zamb.css('left', width);

  this.$zamb.css('height', 55);
  this.$zamb.css('width', 55);
  this.$zamb.css('margin', 5);

  $('.nav-wrapper').append(this.$zamb);
};

$(document).ready(function() {
  resurface = function() {
    zamb = new Zamboni();
    position = zamb.$zamb[0].x;

    var velocity = setInterval(function() {
      if (position >= -50) {
        position--;
        zamb.$zamb.css('left', position);
      } else {
        clearInterval(velocity);
        $('#zamb').remove();

        setTimeout(function() {
          resurface();
        }, 2000);
      };
    }, 10);
  };

  setTimeout(function() {
    resurface();
  }, 1000);
});
