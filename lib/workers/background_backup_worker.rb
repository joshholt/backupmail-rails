class BackgroundBackupWorker < BackgrounDRb::MetaWorker
  set_worker_name :background_backup_worker
  def create(args = nil)

  end
  
  def run_bg_backup(process = nil)
    begin
      result_of_backup = process.runBackup()
      logger.info("BACKGROUND_BACKUP => #{result_of_backup}")  
      case result_of_backup
        when /^Successfully/
          thankYouText = ApplicationController.new.thank_you_message()
          backup_link = MailBackup.create({:file_path => process.backup_dir})
          thankYouText = thankYouText % backup_link.obsfucated_link
          PostMaster.deliver_your_download_is_ready(process.email, RedCloth.new(thankYouText).to_html().to_s)
        when /^There are no new emails in your inbox/
          thankYouText = ApplicationController.new.thank_you_no_backup
          PostMaster.deliver_no_download(process.email, RedCloth.new(thankYouText).to_html().to_s)
      end
    rescue Exception => e
      PostMaster.deliver_async_exception(process.email, e)
      logger.info("BACKGROUND_BACKUP => #{e.class}: #{e}")
    end
  end
end

