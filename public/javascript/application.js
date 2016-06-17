$(document).ready(function() {
  browser_path = window.location.pathname
  var pagination_ready;
  var pagination_load_more = true;

  // Only after the user has asked for more posts does pagination work
  var user_paginate = false;

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

  // Create a vote (praise)
  $('#deeds_container').on("click", ".praisebtn", function () {
      var deedId = this.dataset.deedId
      var praisebtn = $(this)
      
      $.post("/deeds/" + deedId + "/praise", function(data) {
        data = data.split(",")
        var numPraises = data[0]
        var warning = data[1]
        if (warning == "success") {
          praisebtn.siblings(".praisebadge").text(numPraises);
        } else {
          var warningBox = $('#vote-error')
          warningBox.append("<p class=\"vote-error-log\">" + warning + "</p>")
          warningBox.show();
        }
      });
  }); 
 
  // Create a vote (shame)
  $('#deeds_container').on("click", ".shamebtn", function () {
      var deed_id = this.dataset.deedId
      var shamebtn = $(this)
      $.post("/deeds/" + deed_id + "/shame", function(data) {
        data = data.split(",")
        var numShames = data[0]
        var warning = data[1]
        if (warning == "success") {
          shamebtn.siblings(".shamebadge").text(numShames);
        } else {
          var warningBox = $('#vote-error')
          warningBox.append("<p class=\"vote-error-log\">" + warning + "</p>")
          warningBox.show();
        }
      });
  }); 

  // Hide warning block after clicking in the close button
  $(function(){
    $("[data-hide]").on("click", function(){
      $(this).closest("." + $(this).attr("data-hide")).hide();
      $(".vote-error-log").remove();
    });
  });

  $("#users-profile-show-all").click(function() {
    var user_id = this.dataset.userId
    $("#user-loader-gif").removeClass("hidden")
    $(this).css("display", "none")
    $.get("/users/next-deeds", {"id":user_id}, function(data) {
      $("#deeds-container").removeClass("hidden")
      $("#user-loader-gif").addClass("hidden")
      $("#deeds-container").css("display", "block")
      $("#deeds-container").append(data);
      user_paginate = true;
    });
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

 function userPath() {
  if (browser_path.startsWith("/users/")) {
    if (!isNaN(browser_path.split('/').pop())) {
      return true
    }
  }
  return false
 }

  function ajaxLoadActivity() {
    var server_path = user_paginate ? "/users/next-deeds" : "/deeds/next"
    $.get(server_path, function(data) {
      if (data.length == 1) {
        pagination_load_more = false;
      }
      $("#deeds_container").append(data);
      pagination_ready = false;
    });
  }

  if (pagination_load_more) {
    $(window).scroll(function () {
     if ($(window).scrollTop() >= $(document).height() - $(window).height() - 500) {

        if ( $('ol.astream > .loadCount:last > li').attr('id') == "noMoreActivities" ) {
          return false;
        }
        if (pagination_ready) {
          return false;
        }
        if (userPath() && !user_paginate) {
          return false
        }

        pagination_ready = true
        ajaxLoadActivity();
      }
    }); 
  }
});
