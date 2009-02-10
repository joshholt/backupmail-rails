#!/usr/local/bin/ruby
#	mail_backup.rb
#       
#	@author Josh Holt
# @date		02.09.2009
#
#***************** USAGE *******************************************************
# bmm_process  = BackupMyMail.new({
#  :server   => "pop.gmail.com",
#  :email    => "joshholt.testaccount@gmail.com",
#  :username => "joshholt.testaccount@gmail.com",
#  :password => "I$tanB00L",
#  :port     => 995,
#  :ssl      => true
# })
#
# bmm_process.runBackup
#******************************************************************************
module MyBackupHelper
  class BackupMyMail
    attr_accessor :email, :username, :password, :port, :ssl, :server, :backup_dir
    
  	modules_path = File.join(File.dirname(__FILE__),'lib','modules')
  	module_files = Dir["#{modules_path}/*.bmm_mod.rb"]
  	module_files.each { |modFile| require modFile }

  	if module_files.size > 0
  		include Backup::Mail::Pop3
  		include Backup::Mail::ToMbox
  	end
  	
  	def initialize(options)
  	  begin
  	    @email      = options.email
  	    @username   = options.username
  	    @password   = options.password
  	    @port       = options.port
  	    @server     = options.server
  	    @ssl        = options.ssl
  	    @backup_dir = File.join(File.dirname(__FILE__),'backups',"#{Time.now.to_f}_#{@email}") if @email
  	  rescue => exception
  	    logger.info("An Exception Occured during initialization: #{exception.class}, #{exception}")
  	    raise "\r\nWe are not able to process your backup at this time.\r\n We apologize for the inconvenience."
      end
  	end
  	
  	def runBackup()
  	  begin
  	    Backup::Mail.fetch_and_store()
  		  squash_emails()
  	  rescue Exception => e
  	    logger.info("An Exception Occured while running the backup: #{e.class} => #{e}")
  	    false
  	  else
  	    true
  	  end
  	end
  	
  	def squash_emails
  		files = Dir["#{@backup_dir}/*.eml"]
  		files.each do |filename|
  			Backup::Mail::ToMbox.CurrentEmail.new(open(filename).readlines).write_archive(@backup_dir)
  	  end
  	end
  	
  end
end
