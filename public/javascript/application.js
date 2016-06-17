$(document).ready(function() {
  var ajax;
  var load_more = true;

  $("#users-profile-show-all").click(function() {
    var user_id = this.dataset.userId
    $(this).css("display", "none")
    return $.get("/users/next-deeds", {"id":user_id}, function(data) {
      console.log(data);
        $("#user-deed-container").append(data);
      });
  });

  $("#confession_submit").click(function(){ 
    var text_area = $("#confession_summary")
    if (text_area.val().length == 0) {
      $("#confession_error").css("display","block")
    } else {    
      $.post("/deeds", $("#confession_form").serialize(), function(data) {
          $("body").html(data)
      });
    }
  });




  function ajaxLoadActivity() {
    return $.get("/deeds/next", function(data) {
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
        ajax = ajaxLoadActivity();
      }

    });
  }
});