$(function(){
    function buildMESSAGE(message) {
        console.log("message=");
        console.log(message);
        console.log(message.id);
        var html = '<div class="message" data-id=' + message.id + '>' +
                        '<strong>' + message.content + '</strong>' +
                        '<hr>' +
                    '</div>';
        console.log(html);
        $('#messages').append(html);
    };

    $(function(){
        setInterval(update, 5000);
    });
    function update(){
        if($('.message')[0]){
            var message_id = $('.message:last').data('id');
        } else {
            var message_id = 0
        }
        console.log(message_id);
        console.log("hoge")
        $.ajax({
            url: location.href,
            type: 'GET',
            data: {
                message: { id: message_id }
            },
            dataType: 'json'
        }).always(function(data){
            $.each(data, function(i, data){
                buildMESSAGE(data);
            });
        });
    };
});