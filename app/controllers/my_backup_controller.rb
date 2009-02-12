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
	        flash_message = "We were able to successfully connect to your mailbox!\n"
	        logger.info("#{@account.async}")
	        if @account.async
	          MiddleMan.worker(:background_backup_worker).async_run_bg_backup(:arg => @bmm_process)
	          result_of_backup = "Running Background Backup..."
	        else
	          result_of_backup = @bmm_process.runBackup()
          end
	        flash_message += result_of_backup
	        flash.now[:notice] = flash_message
	        case result_of_backup
	          when /^Successfully/
	            thankYouText = thank_you_message()
	            # obsfucated_Link will be generated with SHA1::Hash
	            backup_link = MailBackup.create({:file_path => @bmm_process.backup_dir})
	            thankYouText = thankYouText % backup_link.obsfucated_link
	            PostMaster.deliver_your_download_is_ready(@bmm_process.email,RedCloth.new(thankYouText).to_html().to_s)
	          when /^There are no new emails in your inbox/
	            thankYouText = thank_you_no_backup
	            PostMaster.deliver_no_download(@bmm_process.email,RedCloth.new(thankYouText).to_html().to_s)
	          when /^Running Background/
	            thankYouText = thank_you_async_backup
	        end
	        @return_html = RedCloth.new(thankYouText).to_html()
	      end
	    else
	      # rendering the index action here will show validation messages in the text boxes
	      # b/c the information required for the account setup is missing or invalid.
	      render :action => :index
	    end
	  rescue Exception => e 
	    # uh oh, well at least we don't get some crazy blow up page!
	    #flash[:notice] = nil 
	    flash[:error]  = "An Execption has occured: #{e}" # --> this will show the end user an nice pretty message
	    redirect_to root_url # --> so we send them home to try again with the reason for the failure
	  end
	end
	
	def download
	  begin
	    @customers_backup = MailBackup.find_by_obsfucated_link(params[:id])
	    folder = @customers_backup.file_path.split('/')[-1]
	    send_file("#{@customers_backup.file_path}/#{folder}-backup.zip")
	  rescue Exception => e
	    flash[:error]  = "An Execption has occured: #{e}"
	    render :text => "#{e}"
	  end
	end
end
