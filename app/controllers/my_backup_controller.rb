class MyBackupController < ApplicationController

	def index
	  @account ||= EmailAccount.new
	end
	
	def doBackup
    begin
      @account = EmailAccount.new(params[:email_account])
      if @account.valid?
        # Great we're valid so let's go get the mail!!
	      @bmm_process = MyBackupHelper::BackupMyMail.new(@account)
	      if @bmm_process.authenticated?
	        flash[:notice] = "We were able successfully connect to your mailbox!"
	        if @bmm_process.runBackup()
	          @return_html = <<-RETVAL
	          \tThank you for backing up your mail! We feel better now, and surely you do right?\r\n
	          You know all this talk about backing up your data being hard, after this you have the\r\n
	          right to argue until you run out of breath.\r\n
	          
	          \t\t*** Disclamer ***\r\n
	          \t\t\tWe are in no way suggesting that you run yourself out of breath...\r\n
	          \t\t\twe really can't have that on our conscience...\r\n
	                  
	           \t\t--- Whew! now that we have that out of the way, feel free to run out of breath if that's your bag!
	                 
	          ---
	            Again thank you for backing up your Mail!
	          RETVAL
	        end
	      end
	      #redirect_to --> the thank you page with or w/o link...
	    else
	      # rendering the index action here will show validation messages in the text boxes
	      # b/c the information required for the account setup is missing or invalid.
	      render :action => :index
	    end
	  rescue Exception => e 
	    # uh oh, well at least we don't get some crazy blow up page!
	    flash[:error] = "An Execption has occured: #{e}" # --> this will show the end user an nice pretty message
	    redirect_to root_url # --> so we send them home to try again with the reason for the failure
	  end
	end
	
end
