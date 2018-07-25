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
