class PostMaster < ActionMailer::Base
  

  def your_download_is_ready(email, message, sent_at = Time.now)
    subject       'Your download is ready at BackUpMyMail'
    recipients    email
    from          'joshholt.testaccount@gmail.com'
    sent_on       sent_at
    content_type  'text/html'
    body          :message_text => message
  end
  
  def no_download(email, message, sent_at = Time.now)
    subject       'Thank you for using BackUpMyMail'
    recipients    email
    from          'joshholt.testaccount@gmail.com'
    sent_on       sent_at
    content_type  'text/html'
    body          :message_text => message
  end
  
  def async_exception(email, message, sent_at = Time.now)
    subject       'BackUpMyMail, an error occured during your backup'
    recipients    email
    from          'joshholt.testaccount@gmail.com'
    sent_on       sent_at
    content_type  'text/html'
    body          :message_text => message
  end
end
