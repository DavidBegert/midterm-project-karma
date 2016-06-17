$(document).ready(function() {

  $('input').keypress(function (e) {     //theres gotta be a way to connect this and the one below it
    if (e.which == 13) {
      var text_area = $("#confession_summary").val().length
      var form_data = $("#confession_form").serialize()
      $("#confession_summary").val(""); 
      if (text_area == 0) {
        $("#confession_error").css("display","block")
      } else { 
          $.post("/deeds", form_data, function(data) {
            $("#confession_error").css("display", "none")
            $("#deeds_container").prepend(data)
          });
      }
      return false;
    }
  });


 $("#confession_submit").click(function(){ 
    var text_area = $("#confession_summary").val().length
    var form_data = $("#confession_form").serialize()
    $("#confession_summary").val(""); 
    if (text_area == 0) {
        $("#confession_error").css("display","block")
    } else { 
          $.post("/deeds", form_data, function(data) {
            $("#confession_error").css("display", "none")
            $("#deeds_container").prepend(data)
          });
    }
  });


 var im_not_ready;
 var load_more = true;

 function ajaxLoadActivity() {

      $.get("/deeds/next", function(data) {
      console.log(data)
      if (data.length == 1) {
        load_more = false;
      }
      $("#deeds_container").append(data);
      im_not_ready = false;
    });
  }
  // if (load_more) {
    $(window).scroll(function () { 
     if ($(window).scrollTop() >= $(document).height() - $(window).height() - 10) {

        if ( $('ol.astream > .loadCount:last > li').attr('id') == "noMoreActivities" ) {
          return false;
        }
        if (im_not_ready) {
          return false;
        }
        im_not_ready = true
        ajaxLoadActivity();
      }

    }); 
  // }

});