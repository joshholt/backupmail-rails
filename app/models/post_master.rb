class PostMaster < ActionMailer::Base
  

  def your_download_is_ready(sent_at = Time.now)
    subject    'PostMaster#your_download_is_ready'
    recipients ''
    from       ''
    sent_on    sent_at
    
    body       :greeting => 'Hi,'
  end

end
