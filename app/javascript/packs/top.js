jQuery(function ($) {

    // 絞り込みボタン、絞り込み対象を宣言
    var filterButton = $('#js-filter-buttons').children('li');
    var filterContent = $('#js-filter-contents').children('div');


    filterButton.click(function () { // ボタンクリック時
        filterButton.removeClass('active'); // ボタンのactiveをリセット
        $(this).addClass('active'); // クリックしたボタンをactive化

        // クリックしたボタンのデータ属性を取得
        var targetData = $(this).data('flow');

        filterContent.removeClass('active'); // 対象のactiveをリセット
        filterContent.each(function () { // クリックしたボタンと同じデータ属性をもつ対象を表示
            if ($(this).data('flow') === targetData) {
                $(this).addClass('active');
            }
        })
    })

    // 質問サンプルに関するポップ
    $('a#popup-show').on('click',function(){
        $('#js-popup').addClass('show').fadeIn();
        return false;
    });
      
    $('a#popup-close, #js-popup-bg').on('click',function(){
        $('#js-popup').removeClass('show').fadeOut();
        return false;
    });
});