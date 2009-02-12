class PmBackupObserver < ActiveRecord::Observer
  require 'zip/zip'
  require 'zip/zipfilesystem'
  
  observe :mail_backup
  
  def after_save(mail_backup)
    folder        = mail_backup.file_path.split('/')[-1]
    download_link = mail_backup.obsfucated_link
    archive_for_download(folder,download_link)
  end
  
  private
    def archive_for_download(folder, download_link)
      path_to_files    = File.join(RAILS_ROOT,"public","backups","#{folder}")
      archive_filename = File.join(path_to_files,"/#{folder}-backup.zip")
    
      Zip::ZipFile.open(archive_filename, Zip::ZipFile::CREATE) do |archive|
        individual_emails = Dir["#{path_to_files}/*.eml"]
        mbox_file         = Dir["#{path_to_files}/inbox.mbox"]
      
        # First we'll add the individual emails to the archive in their own folder
        if individual_emails.size != 0
          individual_emails.each do |filename|
            archive.add("individual_emails/#{filename.split('/')[-1]}", "#{filename}")
          end
        end
      
        # Second we'll add the mbox file to the archive in it's own folder
        if mbox_file != 0
          archive.add("mbox/inbox.mbox","#{mbox_file[0]}")
        end
      
        # Third we'll create a README file and add it to the archive
        archive.file.open("README", "w") { |f| f.puts readme_for_zip(folder,download_link) }
      end
      File.chmod(0644, archive_filename)
    end
  
    def readme_for_zip(folder, download_link)
      readme = <<-EOF
        ===============================================================================
                  This is the arcive of your email from BackUpMyMail
                  Backup created: #{Time.now}
        ================================================================================
        The layout of your archive is as follows:
      
        #{folder}-backup.zip
        |
        |_________individual_emails/ ( This directory contains each plain text email )
        |
        |_________mbox/ ( This directory contains the mbox file )
        |
        |_README ( The file you are reading now )
      
        This archive can be downloaded again at the following address:
      
        http://theholtsare.thruhere.net:9921/my_backup/download/#{download_link}
      
        ===== Side Note =====
        The mbox file/files can be imported into your mail client (i.e. Thunderbird etc...)
      
        We will keep the archive for you at the link above for 1 month then it will get
        hammered with the red stapler and filed with the TPS reports.
      
        ========== Thank you for using BackUpMyMail
        ---------- Sincerely, The BackUpMyMail Team 
        holt.josh@gmail.com
      EOF
      return readme
    end
end
