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

    var denominator = $("#denominator").text();
    var answers = $("#total_answers").text();
    var votes = $("#total_votes").text();
    var jsCount = $("#js-count");
    if(denominator == answers || denominator == votes ) {
        jsCount.addClass("ready");
    }
});