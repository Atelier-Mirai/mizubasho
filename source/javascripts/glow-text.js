// .glow.text に shineクラス名を付与する関数定義
const addShineClassName = () => {
  let element = $(".glow.text");
  element.each(() => {
    let elemPosition = element.offset().top - 50;
    let scroll       = $(window).scrollTop();
    let windowHeight = $(window).height();

    // .glow.text要素の位置までスクロールされたなら、shineクラスを付与する。
    if (scroll >= elemPosition - windowHeight) {
      element.addClass("shine");
    } else {
      element.removeClass("shine");
    }
  });
}

// 画面スクロール時に呼び出す関数を記述する
$(window).scroll(() => {
  addShineClassName();
});

$(window).on('load', () => {
  const DELAY_TIME = 0.25; // 一文字ずつの遅延時間

  $(".glow.text").each((index, element) => {
    let delay_initial_value = 0 + (index * text.length * DELAY_TIME);
    let text                = $(element).text();
    let textbox             = "";
    text.split('').forEach((t, i) => {
      let delay = delay_initial_value + i * DELAY_TIME;
      textbox += `<span style="animation-delay:${delay}s;">${t}</span>`;
    });
    $(element).html(textbox);
  });

  addShineClassName();
});
