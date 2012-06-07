// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require twitter/bootstrap
//= require wymeditor/jquery.wymeditor.js
//= require_tree .

$(document).ready(function() {
  $('.date_input').datepicker();	

	$('.draggable').draggable();
	$('.droppable').droppable();
	
	$('.sortable').sortable()	
				
  jQuery('.wymeditor').wymeditor({
    stylesheet: 'styles.css',
    skin: 'silver',
    postInit: function(wym) {
        wym.hovertools();
        wym.resizable();
    },
    boxHtml:  "<div class='wym_box'>"
            + "<div class='wym_area_top'>"
            + WYMeditor.TOOLS
            + "</div>"
            + "<div class='wym_area_main'>"
            + WYMeditor.HTML
            + WYMeditor.IFRAME
            + WYMeditor.STATUS
            + "</div>"
            + "</div>"
  });
});