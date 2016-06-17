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

  // Create a vote (praise)
  $('.praisebtn').on("click", function () {
    alert("hi there");
      var deed_id = this.dataset.deedId
      var praisebtn = $(this)
      $.post("/deeds/" + deed_id + "/praise", function(data) {
        console.log(praisebtn)
        console.log(praisebtn.siblings(".praisebadge"))
        console.log(data)
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

 $("#confession_submit").click(function(){ 
    var text_area = $("#confession_summary").val().length;
    var form_data = $("#confession_form").serialize()
    $("#confession_summary").val(""); 
    if (text_area == 0) {
        $("#confession_error").css("display","block")
    } else { 
          alert("in the submit button");
          $.post("/deeds", form_data, function(data) {
            $("#confession_error").css("display", "none")
            $("#deeds_container").prepend(data)
          });
      //register the event on that button
  //      $('.praisebtn').on("click", function () {
  //     var deed_id = this.dataset.deedId
  //     var praisebtn = $(this)
  //     $.post("/deeds/" + deed_id + "/praise", function(data) {
  //       console.log(praisebtn)
  //       console.log(praisebtn.siblings(".praisebadge"))
  //       console.log(data)
  //       praisebtn.siblings(".praisebadge").text(data);
  //     });
  // }); 
  
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
