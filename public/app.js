jQuery(document).ready(function($) {
  var ready = false;

  $('#title_form').submit(function() {
    if(!ready) return false;
  });

  $('#file_form').submit(function() {
    upload_interval = window.setInterval(function() {
      $.ajax({
        url: '/progress',
        beforeSend: function(req) {
          req.setRequestHeader("X-Progress-ID", upload_uuid);
        },
        success: function(data) {
          var upload = eval(data);

          if(upload.state == 'done') {
            window.clearTimeout(upload_interval);
          } else if(upload.state == 'uploading') {
            $('#progress').html(Math.floor(100 * upload.received / upload.size) + '%');
          }
        }
      });
    }, 500);

    $(this).ajaxSubmit({success: function(url) {
      url = /<body>(.*)<.body>/.exec(url)[1];
      $('#progress').html('Completed. Your file is available under: ' + url);
      ready = true;
      $('#filepath').val(url);
      $('#title_form').submit();
    }});
    return false;
  });
});
