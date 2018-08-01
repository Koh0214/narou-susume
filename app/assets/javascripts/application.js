// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

$(document).on('turbolinks:load',function(){

  // $("#get-novel-info-button").click(function(){
  $("#modal-novel-url").change(function(){
      if ($("#modal-novel-url").val() != "" ) {
        $.ajax({
            url: "get_novel_info",
            type: "GET",
            data: { url : $("#modal-novel-url").val() },
            dataType: "html",
            success: function(data) {
                console.log('success');
                console.log(data);
                // app/views/osusumes/scraping_novel.js.erb
                //上記ファイルの中身を文字列"delimiter"で分ける
                var split_datas = data.split("delimiter");
                $("#modal-novel-title").val(split_datas[0]);
                $("#modal-novel-description").val(split_datas[1]);
            },
            error: function(data) {
                console.log('error');
                alert("URLが不正、もしくはこのURLには対応していません。");
            }
        });
      }
  });
});


$(document).on('turbolinks:load',function(){
  $(".novel-card-like").click(function(){
    $(this).removeClass("fa-heart-o").addClass("fa-heart");
    //いいね数プラス1
    var old_like_count = parseInt($(this).find(".novel-like-count").text());
    $(this).find(".novel-like-count").text(old_like_count + 1);
    console.log("click");
    $.ajax({
        url: "like",
        data: { id : parseInt($(this).siblings(".novel-id").text()) },
        dataType: "html",
        success: (data) => {
          console.log("正常にいいね完了")
        },
        error: function(data) {
          console.log('いいねをつけるのに失敗しています');
        }
    });
  });
});


//upボタン押された時
$(document).on('turbolinks:load',function(){
  $(".comment-rating-button-up").click(function(){
    //upを押された時に、upとdownどちらも動かないようにクラスを付け替える  TODO セレクターがダサいから直す。
    $(this).removeClass("comment-rating-button-up").addClass("comment-rating-button-up-pushed");
    var down_button = $(this).parent().next().next().children(".comment-rating-button-down");
    down_button.removeClass("comment-rating-button-down").addClass("comment-rating-button-down-pushed");

    var old_up_count = parseInt($(this).siblings(".comment-count-up").text());
    $(this).siblings(".comment-count-up").text(old_up_count + 1);
    $.ajax({
        url: "comment_count_up",
        data: { id : parseInt($(this).parent().siblings(".comment-id").text()) },
        dataType: "html",
        success: (data) => {
          //TODO function get_up_down_rateに切り出ししたい
          var up_count   = parseInt($(this).parents(".comment-bottom-content").children(".up-contents").children(".comment-count-up").text());
          var down_count = parseInt($(this).parents(".comment-bottom-content").children(".down-contents").children(".comment-count-down").text());
          var sum_count = up_count + down_count
          var up_down_rate = ((up_count/sum_count)*100)
          $(this).parent().next().children(".comment-rating-bar-up").animate({width:up_down_rate + "%"},200);

          switch(true) {
              case 75 <= up_down_rate:
                  var comment_level = "comment-level-5";
                  break;
              case 60 <= up_down_rate && up_down_rate < 75 :
                  var comment_level = "comment-level-4";
                  break;
              case 25 <= up_down_rate && up_down_rate < 60 :
                  var comment_level = "comment-level-3";
                  break;
              case 10 <= up_down_rate && up_down_rate < 25 :
                  var comment_level = "comment-level-2";
                  break;
              case up_down_rate < 10 :
                  var comment_level = "comment-level-1";
                  break;
              default:
                  alert("0より小さいです");
          }
          //前方一致でクラスを削除  参考：jQueryの.removeClass()で「特定の文字列で始まるclass」をすべて削除する
          $(this).parents(".card").children(".comment").removeClass(function(index, className) {
              return (className.match(/\bcomment-level-\S+/g) || []).join(' ');
          }).addClass(comment_level);

          console.log("正常にup完了")
        },
        error: function(data) {
          console.log('upをつけるのに失敗しています');
        }
    });
  });
});

//downボタン押された時
$(document).on('turbolinks:load',function(){
  $(".comment-rating-button-down").click(function(){
    //downを押された時に、upとdownどちらも動かないようにクラスを付け替える  TODO セレクターがダサいから直す。
    $(this).removeClass("comment-rating-button-down").addClass("comment-rating-button-down-pushed");
    var up_button = $(this).parent().prev().prev().children(".comment-rating-button-up");
    up_button.removeClass("comment-rating-button-up").addClass("comment-rating-button-up-pushed");

    var old_down_count = parseInt($(this).siblings(".comment-count-down").text());
    $(this).siblings(".comment-count-down").text(old_down_count + 1);

    $.ajax({
        url: "comment_count_down",
        data: { id : parseInt($(this).parent().siblings(".comment-id").text()) },
        dataType: "html",
        success: (data) => {
          //TODO function get_up_down_rateに切り出ししたい
          var up_count   = parseInt($(this).parents(".comment-bottom-content").children(".up-contents").children(".comment-count-up").text());
          var down_count = parseInt($(this).parents(".comment-bottom-content").children(".down-contents").children(".comment-count-down").text());
          var sum_count = up_count + down_count
          var up_down_rate = ((up_count/sum_count)*100)
          $(this).parent().prev().children(".comment-rating-bar-up").animate({width:up_down_rate + "%"},200);

          switch(true) {
              case 75 <= up_down_rate:
                  var comment_level = "comment-level-5";
                  break;
              case 60 <= up_down_rate && up_down_rate < 75 :
                  var comment_level = "comment-level-4";
                  break;
              case 25 <= up_down_rate && up_down_rate < 60 :
                  var comment_level = "comment-level-3";
                  break;
              case 10 <= up_down_rate && up_down_rate < 25 :
                  var comment_level = "comment-level-2";
                  break;
              case up_down_rate < 10 :
                  var comment_level = "comment-level-1";
                  break;
              default:
                  alert("0より小さいです");
          }
          //前方一致でクラスを削除  参考：jQueryの.removeClass()で「特定の文字列で始まるclass」をすべて削除する
          $(this).parents(".card").children(".comment").removeClass(function(index, className) {
              return (className.match(/\bcomment-level-\S+/g) || []).join(' ');
          }).addClass(comment_level);

          console.log("正常にdown完了")
        },
        error: function(data) {
          console.log('downをつけるのに失敗しています');
        }
    });
  });
})

//あらすじの開閉 osusumes#show, _novel-card
$(document).on('turbolinks:load',function(){
  $(".novel-description").click(function(){
    //あらすじを一覧では50pxの高さ、小説個別画面では100pxの高さにした方が見やすいので以下のように実装
    // osusumes#show
    if ($(this).hasClass("novel-description-in-osusume")) {
      var description_height = "50";
    }
    // novel#show
    else {
      var description_height = "100";
    }

    //開く
    if ($(this).height() == description_height) {
      //heightをautoにする実装
      curHeight = $(this).height();
      autoHeight = $(this).css('height', 'auto').height();
      $(this).height(curHeight).animate({height: autoHeight}, 150);
      // $(this).siblings(".fa-angle-down").removeClass("fa-angle-down").addClass("fa-angle-up");
      $(this).siblings(".fa-angle-down").removeClass("fa-angle-down").addClass("fa-angle-up");
    }
    //閉じる
    else {
      $(this).animate({height: description_height + "px"}, 150);
      $(this).siblings(".fa-angle-up").removeClass("fa-angle-up").addClass("fa-angle-down");
    }
  })
});
