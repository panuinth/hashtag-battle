String.prototype.contains = function(it) {
  return this.indexOf(it) != -1;
};

//Define color of wall container
var colour = [
      "rgb(26, 188, 156)",
      "rgb(22, 160, 133)",
      "rgb(46, 204, 113)",
      "rgb(39, 174, 96)",
      "rgb(52, 152, 219)",
      "rgb(155, 89, 182)",
      "rgb(142, 68, 173)",
      "rgb(241, 196, 15)",
      "rgb(243, 156, 18)",
      "rgb(230, 126, 34)",
      "rgb(211, 84, 0)",
      "rgb(231, 76, 60)",
      "rgb(192, 57, 43)",
      "rgb(189, 195, 199)",
      "rgb(149, 165, 166)",
      "rgb(127, 140, 141)"
			];

			$(".brick").each(function() {
				this.style.backgroundColor =  colour[colour.length * Math.random() << 0];
			});

$(function() {

  //Initialize new wall
  var wall = new freewall("#freewall");
  wall.reset({
    selector: '.brick',
    animate: true,
    cellW: 160,
    cellH: 100,
    delay: 50,
    onResize: function() {
      wall.fitWidth();
    }
  });

  //Add loading icon after submit
  $(".battle-form .battle-submit").on("click",function(e) {
    e.preventDefault();

    var errorMessage = "";

    if ($("#battle_name").val() == ""){
      errorMessage += "Battle name cannot be blank.\n";
    }

    if ($("#battle_hashtags").val() == ""){
      errorMessage += "Please put at least 1 hashtag.\n";
    }

    if (errorMessage != ""){
      alert(errorMessage);
    } else {

    $(".spinner").fadeIn("slow");
    $(".loading-bg").fadeIn("slow");

     $.post( "/battles", $( "#new_battle" ).serialize() )
      .done(function( data ) {
        console.debug(data);
        $(".spinner").fadeOut("slow");
        $(".loading-bg").fadeOut("slow");
      });
    }

  });

  //Streaming data from twitter api
  var source = new EventSource('/battles/events');
  var battleId = $("#battle-id").val();
  source.addEventListener("battle:hashtag:"+ battleId, function(e) {
    $(".battle").hide();
    $(".container").width("auto");

    result = $.parseJSON(e.data);
    totalHashtag = result.total_hashtag;

    $.each(result.keywords, function( index, value ) {
      var keywordTitle = $("#freewall").find("div#"+ value +"");
      if (keywordTitle.length > 0) {
        keywordTitle.parent().css({ opacity: 0.1 });
        var count = parseInt(keywordTitle.find("p").text());
        count = count + 1
        keywordTitle.find("p").text(count);
      } else {

        var temp = '<div class="brick {size}" style="background-color: {color}"><div class="cover" id='+ value +'><h2 style="text-align:center;color:#fff;margin-top:15px;">#'+ value +'</h2><p class="counter" style="font-size:50px;text-align:center;color:#fff;">1</p></div></div>';
        var size = "size23 size22 size21 size13 size12 size11".split(" ");
        var	html = temp.replace('{size}', size[size.length * Math.random() << 0])
                  .replace('{color}', colour[colour.length * Math.random() << 0]);
          wall.prepend(html);
      }
      $(".spinner").hide();
      $(".loading-bg").hide();

      wall.fitWidth();

    });

  }, false);
});

