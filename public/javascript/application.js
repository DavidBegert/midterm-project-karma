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
      $.post("/deeds/<%= deed.id %>/praise" );
  }); 
 
  $('.praisebtn').click(function () {
      $.post("/deeds//praise" );
  }); 
});
