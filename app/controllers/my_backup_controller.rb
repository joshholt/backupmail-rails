class MyBackupController < ApplicationController

	def index
	  @account = EmailAccount.new
	end
	
	def doBackup
    begin
      @account = EmailAccount.new(params[:email_account])
      if @account.valid?
	      @bmm_process = MyBackupHelper::BackupMyMail.new(@account)
	    else
	      redirect_to root_url
	    end
	  rescue Exception => e
	    flash[:error] = "An Execption has occured: #{e}"
	    redirect_to root_url
	  end
	end
	
end
