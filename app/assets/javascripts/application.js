// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require_tree ./mobile
//= require_self

var 
    
// Helper
$ = function(id){
  return document.getElementById(id);
},

// Instance
snapper = new Snap({
  element: document.getElementById('content')
}),

// 
UpdateDrawers = function(){
  var state = snapper.state(),
    towards = state.info.towards,
    opening = state.info.opening;
  if(opening=='right' && towards=='left'){
    // $('right-drawer').classList.add('active-drawer');
    $('left-drawer').classList.remove('active-drawer');
  } else if(opening=='left' && towards=='right') {
    // $('right-drawer').classList.remove('active-drawer');
    $('left-drawer').classList.add('active-drawer');
  }
};

snapper.on('drag', UpdateDrawers);
snapper.on('animating', UpdateDrawers);
snapper.on('animated', UpdateDrawers);

$('toggle-left').addEventListener('click', function(){
  snapper.open('left');
});