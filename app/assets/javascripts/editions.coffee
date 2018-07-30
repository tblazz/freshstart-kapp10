$ ->
  $('#s3_uploader').S3Uploader
    remove_completed_progress_bar: false
    progress_bar_target: $('#uploads_container')
  $('#s3_uploader').on 's3_upload_failed', (e, content) ->
    console.error e, content
    alert content.filename + ' failed to upload'
