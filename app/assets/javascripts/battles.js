String.prototype.contains = function(it) {
  return this.indexOf(it) != -1;
};

$(function() {
  var source = new EventSource('/battles/events');
  source.addEventListener('battle.hashtag', function(e) {
    $("#new_battle").hide();
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
    });

  }, false);
});

