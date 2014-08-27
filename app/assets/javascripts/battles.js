String.prototype.contains = function(it) {
  return this.indexOf(it) != -1;
};

$(function() {

  $(".battle-form .battle-submit").on("click",function(e) {
    e.preventDefault();
    $(".spinner").fadeIn("slow");
    $(".loading-bg").fadeIn("slow");


     $.post( "/battles", $( "#new_battle" ).serialize() )
      .done(function( data ) {
        $(".spinner").fadeOut("slow");
        $(".loading-bg").fadeOut("slow");

      });

  });

  var source = new EventSource('/battles/events');
  source.addEventListener('battle.hashtag', function(e) {
    $(".battle").hide();

    result = $.parseJSON(e.data);
    totalHashtag = result.total_hashtag;

    $.each(result.keywords, function( index, value ) {
      var keywordTitle = $("#brand").find("h2#"+ value +"");
      if (keywordTitle.length > 0) {
        var count = parseInt(keywordTitle.find("span").text());
        count = count + 1
        keywordTitle.find("span").text(count);
        $("<p>"+ result.tweet +"</p>").insertAfter("#"+ value);
      } else {
        $("#brand").append("<h2 id="+ value +">#"+ value +" (<span>1</span>)</h2>");
        $("<p>"+ result.tweet +"</p>").insertAfter("#"+ value);
      }
      $(".spinner").hide();
      $(".loading-bg").hide();

    });

  }, false);
});

