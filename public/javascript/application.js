$(document).ready(function() {
 //$("#confession_error").css("display","block")

  $("#confession_submit").click(function(){ 
    var text_area = $("#confession_summary")
    if (text_area.val().length == 0) {
      $("#confession_error").css("display","block")
    } else {    
      $.post("/deeds", $("#confession_form").serialize(), function(data) {
      });
    }
  });

  // Create a vote (praise)
  $('.praisebtn').click(function () {
      var deed_id = this.dataset.deedId
      var praisebtn = $(this)
      $.post("/deeds/" + deed_id + "/praise", function(data) {
        praisebtn.siblings(".praisebadge").text(data);
      });
  }); 
 
  $('.shamebtn').click(function () {
      var deed_id = this.dataset.deedId
      var shamebtn = $(this)
      $.post("/deeds/" + deed_id + "/shame", function(data) {
        shamebtn.siblings(".shamebadge").text(data);
      });
  }); 

 var ajax;
 var load_more = true;


 function ajaxLoadActivity(one, two) {
    return $.get("/deeds/next", function(data) {
      console.log(data)
      if (data.length == 1) {
        load_more = false;
      }
      $("#deeds_container").append(data);
    });
  }

  if (load_more) {
    $(window).scroll(function () { 
     if ($(window).scrollTop() >= $(document).height() - $(window).height() - 10) {

        if ( $('ol.astream > .loadCount:last > li').attr('id') == "noMoreActivities" ) {
          return false;
        }
        if (ajax) {
          return false;
        }
        ajax = ajaxLoadActivity('bottom', true);
      }
    }); 
  }
});
