$(document).ready(function() {
  browser_path = window.location.pathname
  var pagination_ready = true;
  var pagination_load_more = true;

  // Only after the user has asked for posts does pagination work
  var user_pagination_ready = false;

//allow user to press enter to submit new deed
  $('#confession_summary').keypress(function (e) {     
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

  // Show error messages accordingly to status of vote
  function showFlashMessage(message) {
    var messageBox = $("#vote-modal");
    messageBox.append("<p class=\"vote-message-log\">" + message + "</p>");
    console.log(messageBox.parents(".modal"));
    messageBox.parents(".modal").modal("show");
  }

  // Create a vote (praise)
  $('#deeds_container').on("click", ".praisebtn", function () {
      var deedId = this.dataset.deedId;
      var praisebtn = $(this);
      $.post("/deeds/" + deedId + "/praise", function(data) {
        data = data.split(",");
        var numPraises = data[0];
        var warning = data[1];
        if (warning == "Success") {
          praisebtn.siblings(".praisebadge").text(numPraises);
          praisebtn.addClass("praisebtn-color");
        } else {
          var warningBox = $('#vote-error');
          if (data[2] == "remove") praisebtn.removeClass("praisebtn-color");
          showFlashMessage(warning);
          praisebtn.siblings(".praisebadge").text(numPraises);
        }
      });
  }); 
 
  // Create a vote (shame)
  $('#deeds_container').on("click", ".shamebtn", function () {
      var deed_id = this.dataset.deedId;
      var shamebtn = $(this);
      $.post("/deeds/" + deed_id + "/shame", function(data) {
        data = data.split(",");
        var numShames = data[0];
        var warning = data[1];
        if (warning == "Success") {
          shamebtn.siblings(".shamebadge").text(numShames);
          shamebtn.addClass("shamebtn-color");
        } else {
          showFlashMessage(warning);
        }
      });
  }); 

  // Hide warning block after clicking in the close button
  $(function(){
    $("[data-dismiss]").on("click", function(){
      $(this).closest("." + $(this).attr("data-dismiss")).hide();
      $(".vote-message-log").remove();
    });
  });

  $("#users-profile-show-all").click(function() {
    user_pagination_ready = true;
    var server_path = "/users/next-deeds"
    var params = {"id":document.querySelector("#users-profile-show-all").dataset.userId}
    $(this).addClass("hidden")
    $("#user-loader-gif").removeClass("hidden")
    ajaxRequestPaginate(server_path, params, user_pagination_received)
  });

  function user_pagination_received(type, data) {
    // Upon successful user pagination
    if (type == "success") {
      var container = $("#user-deeds-container")
      container.removeClass("hidden")
      container.css("display", "block")
      container.append(data)
    }

    $("#user-loader-gif").addClass("hidden")
  }


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

 function isUserPath() {
  if (browser_path.startsWith("/users/")) {
    if (!isNaN(browser_path.split('/').pop())) {
      return true
    }
  }
  return false
 }

 function index_pagination_received(type, data) {
  if (type == "success") {
    container = $("#deeds_container")
    container.append(data)
  }
  $("#deeds-loading-gif").addClass("hidden")
 }

  function ajaxRequestPaginate(server_path, params, received_func) {
    pagination_ready = false
    $.get(server_path, params, function(data) {
      if (data == "end-pagination") {
        pagination_load_more = false;
        received_func("end", null)
      } else {
        received_func("success", data)
        pagination_ready = true;
      }
    }).fail(function() {
      received_func("fail", null)
      pagination_ready = true;
    });
  }

  if (pagination_load_more) {
    $(window).scroll(function () {
     if ($(window).scrollTop() >= $(document).height() - $(window).height() - 500) {
        if ( $('ol.astream > .loadCount:last > li').attr('id') == "noMoreActivities" ) {
          return false;
        }
        if (pagination_ready && browser_path == '/') {
          var server_path = "/deeds/next"
          $("#deeds-loading-gif").removeClass("hidden")
          ajaxRequestPaginate(server_path, {}, index_pagination_received);
        }
        else if (pagination_ready && isUserPath() && user_pagination_ready) {
          var server_path = "/users/next-deeds"
          var params = {"id":document.querySelector("#users-profile-show-all").dataset.userId}
          $("#user-loader-gif").removeClass("hidden")
          ajaxRequestPaginate(server_path, params, user_pagination_received)
        }
      }
    }); 
  }



  $("body").on("click", ".show-comments", function(event) {
    var deed_id = this.dataset.deedId;
    var comments_div = "#comments-"+String(deed_id)
      if ($(comments_div).html() == "") {
        $(comments_div).css("display", "block");
        $.get("/deeds/" + deed_id + "/comments", function(data) {
          $(comments_div).append(data);
        });
      } else { //if it has comments loaded
          if ($(comments_div).css('display') == 'block' ){
            $(comments_div).css('display', 'none');
          } else {
            $(comments_div).css('display', 'block');
          }
      } 
      event.preventDefault();
    });

  //make comment form showup when button pressed
  $("body").on("click", ".btn-link", function(event) {
    var deed_id = this.dataset.deedId;
    var selector = "#form-comment-"+String(deed_id)
    if ($(selector).css('display') == 'block' ){
      $(selector).css('display', 'none');
    } else {
      $(selector).css('display', 'block');
    }
  });

  //allow user to press enter to submit comment
  $('#deeds_container').on("keypress", ".form-control.comment", function (e) {     
    if (e.which == 13) {
      console.log("WE IN BOY");
      deed_id = event.target.dataset.deedId;
      console.log(deed_id);
      var text_area = $("#input-"+String(deed_id)).val().length
      var form_data = $("#form-comment-"+String(deed_id)).serialize()
      $("#input-"+String(deed_id)).val(""); 
      if (text_area == 0) {
        $(".comment_error").css("display","block");
      } else { 
          console.log(deed_id);
          console.log(form_data);
          $.post("/deeds/"+String(deed_id)+"/comments", form_data, function(data) {
            $(".comment_error").css("display", "none");
            console.log("WE MADE IT HAHAH")
            console.log(data);
            $("#comments-"+String(deed_id)).prepend(data);
          });
      }
      return false;
    }
  });

});
