jQuery(function ($) {

    $(".copyBtn").on("click", function () {
        // コピーする文章の取得
        let text = $(this).prev().text();
        navigator.clipboard.writeText(text);

        // Copyの文字を変更
        $(this).text("copied");
    });

    $(".copyBtn").on('click', function () {
        setTimeout(function () {
            $('.copyBtn').text("copy");
        }, 1000);
    });

});