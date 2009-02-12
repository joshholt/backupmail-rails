# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery #:secret => 'fb3f072ff68415c82d68fcb7dc725823'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  def thank_you_message
    text_to_process  = "h2. Thank you for backing up your mail!\n\n"
    text_to_process += "We feel better now, and surely you do right?\n"
    text_to_process += "You've heard talk about the difficulties of backig up your email.\n"
    text_to_process += "Now you have the right to argue until you run out of breath.\n\n"
    text_to_process += "bq. ***Disclaimer***\n"
    text_to_process += "__We are in no way suggesting that you try to turn blue...__\n"
    text_to_process += "__we really can't have that on our conscience...__\n\n"
    text_to_process += "__-- Whew! now that we have that out of the way,__ \"click here\":http://theholtsare.thruhere.net:9921/my_backup/download/%s to download your backup.\n\n"
    text_to_process += "--\nAgain thank you for choosing BackUpMyMail\n__The BackUpMyMail Team__\n__holt.josh@gmail.com__"
    return text_to_process
  end
  
  def thank_you_no_backup
    text_to_process  = "h2. Thank you for using BackUpMyMail!\n\n"
    text_to_process += "Unfortunately you did not have any new email to backup.\n"
    text_to_process += "Although this is unfortunate, you now know how easy it is to backup your email\n"
    text_to_process += "Please come back when you have new email to backup and we will take care of it.\n\n"
    text_to_process += "bq. ***Disclaimer***\n"
    text_to_process += "__If this message is making your blood pressure rise,__\n"
    text_to_process += "__turn off your monitor and take a few deep breaths...__\n"
    text_to_process += "__We really hope you aren't too disturbed, you can come back, we will be here to help you through it.__\n\n"
    text_to_process += "--\nAgain thank you for choosing BackUpMyMail\n__The BackUpMyMail Team__\n__holt.josh@gmail.com__"
    return text_to_process
  end
  
  def thank_you_async_backup
    text_to_process  = "h2. Thank you for using BackUpMyMail!\n\n"
    text_to_process += "Since you have chosen to run your backup Asynchronously you will only receive an email.\n"
    text_to_process += "Don't fret, the email will contain your download link if you have messages to backup.\n"
    text_to_process += "What if I don't have any messages to backup? Well you will receive a nice message too!\n"
    text_to_process += "That's great, but what if something goes wrong? Well you will receive a nice description of that exception!\n\n"
    text_to_process += "bq. ***Shameless Plug***\n"
    text_to_process += "__Now that you know how easy it is to backup your mail using BackUpMyMail,__\n"
    text_to_process += "__go tell your friends, they will thank you...__\n"
    text_to_process += "__Oh did I mention the source is on GitHub check it out \"here\":http://github.com/joshholt __\n\n"
    text_to_process += "--\nAgain thank you for choosing BackUpMyMail\n__The BackUpMyMail Team__\n__holt.josh@gmail.com__"
    return text_to_process
  end
end
