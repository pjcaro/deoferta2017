// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.slick
//= require materialize
//= require materialize/extras/nouislider
//= require_tree .

$(document).ready(function(){

  var slider = document.getElementById('test-slider');
  noUiSlider.create(slider, {
   start: [0, 20000],
   connect: true,
   step: 100,
   margin: 1000,
   orientation: 'horizontal', // 'horizontal' or 'vertical'
   range: {
     'min': 0,
     'max': 20000
   },
   format: wNumb({
     decimals: 0
   })
  });

  slider.noUiSlider.on('change', function (values) {
    console.log('hola ', values);
    $("#rango_menor").val(values[0]);
    $("#rango_mayor").val(values[1]);
   });


   $('.slider-for').slick({
    slidesToShow: 1,
    slidesToScroll: 1,
    arrows: false,
    fade: true,
    asNavFor: '.slider-nav'
  });
  $('.slider-nav').slick({
    slidesToShow: 3,
    slidesToScroll: 1,
    asNavFor: '.slider-for',
    dots: true,
    centerMode: true,
    focusOnSelect: true
  });
  $('.button-collapse').sideNav({
      menuWidth: 250, // Default is 300
      closeOnClick: true, // Closes side-nav on <a> clicks, useful for Angular/Meteor
      draggable: true // Choose whether you can drag to open on touch screens
    }
  );
  $('.collapsible').collapsible();
  marketplaces();

});

function marketplaces(){
  $('.marketplaces').change(function(){
    if($('.marketplaces').is(':checked')){
      console.log(this.id);
    }
  });
}
