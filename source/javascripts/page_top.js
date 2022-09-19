/* 動くWebデザインアイディア帳より 先頭へ戻るボタン
---------------------------------------------------------------------*/
const pageTop = () => {
  let scroll = $(window).scrollTop();

  // 200px スクロールで、ボタン表示
  if (scroll >= 200){
    $("#page_top").removeClass("disappear");
    $("#page_top").addClass("appear");
  } else if ($("#page_top").hasClass("appear")){
    $("#page_top").removeClass("appear");
    $("#page_top").addClass("disappear");
  }
}

$(window).scroll(() => { pageTop(); });
$(window).on("load", () => { pageTop(); });
