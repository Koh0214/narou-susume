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
          var up_count = parseInt($(this).siblings(".comment-count-up").text());
          var down_count = parseInt($(this).parent().next().next().children(".comment-count-down").text());
          var sum_count = up_count + down_count
          var up_down_rate = ((up_count/sum_count)*100) + "%"
          $(this).parent().next().children(".comment-rating-bar-up").animate({width:up_down_rate},200);
          console.log("正常にplus完了")
        },
        error: function(data) {
          console.log('plusをつけるのに失敗しています');
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
          var up_count = parseInt($(this).parent().prev().prev().children(".comment-count-up").text());
          var down_count = parseInt($(this).siblings(".comment-count-down").text());
          var sum_count = up_count + down_count
          var up_down_rate = ((up_count/sum_count)*100) + "%"
          $(this).parent().prev().children(".comment-rating-bar-up").animate({width:up_down_rate},200);
          console.log("正常にいいね完了")
        },
        error: function(data) {
          console.log('いいねをつけるのに失敗しています');
        }
    });
  });
})
