jQuery(document).ready(function($) {
  $('form').submit(function() {
    upload_interval = window.setInterval(function() {
      $.ajax({
        url: '/progress',
        beforeSend: function(req) {
          req.setRequestHeader("X-Progress-ID", upload_uuid);
        },
        success: function(data) {
          var upload = eval(data);

          if(upload.state == 'done') {
            $('#progress').html('Done');
            window.clearTimeout(upload_interval);
          } else if(upload.state == 'uploading') {
            $('#progress').html(Math.floor(100 * upload.received / upload.size) + '%');
          }
        }
      });
    }, 500);

    $(this).ajaxSubmit();
    return false;
  });
});
