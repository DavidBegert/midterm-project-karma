$(document).ready(function() {
  browser_path = window.location.pathname
  var pagination_ready = true;
  var pagination_load_more = true;

  // Only after the user has asked for posts does pagination work
  var user_pagination_ready = false;

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
          praisebtn.siblings(".praisebadge").text(numPraises);
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
    else {
      alert("Failed to load from server")
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
 }

  function ajaxRequestPaginate(server_path, params, received_func) {
    pagination_ready = false
    $.get(server_path, params, function(data) {
      if (data.length == 1) {
        pagination_load_more = false;
      }
      received_func("success", data)
      pagination_ready = true;
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
        console.log("Pag Ready: " + pagination_ready + "userpath: "+ isUserPath() + "userpagready: " + user_pagination_ready)
        if (pagination_ready && browser_path == '/') {
          var server_path = "/deeds/next"
          ajaxRequestPaginate(server_path, {}, index_pagination_received);
        }
        else if (pagination_ready && isUserPath() && user_pagination_ready) {
          var server_path = "/users/next-deeds"
          var params = {"id":document.querySelector("#users-profile-show-all").dataset.userId}
          ajaxRequestPaginate(server_path, params, user_pagination_received)
        }
      }
    }); 
  }
});
