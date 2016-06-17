$(document).ready(function() {
  var im_not_ready;
  var load_more = true;
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
          warningBox.append("<p>" + warning + "</p>")
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
          warningBox.text(warning)
          warningBox.show();
        }
      });
  }); 

  $("#users-profile-show-all").click(function() {
    var user_id = this.dataset.userId
    $(this).css("display", "none")
    return $.get("/users/next-deeds", {"id":user_id}, function(data) {
        $("#user-deed-container").css("display", "block")
        $("#user-deed-container").append(data);
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
  if (load_more) {
    $(window).scroll(function () { 
     if ($(window).scrollTop() >= $(document).height() - $(window).height() - 500) {

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
  }
});
