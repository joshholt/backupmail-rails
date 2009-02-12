class MailBackup < ActiveRecord::Base
  require 'sha1'
  before_save :encrypt_link

  private
    def encrypt_link
      self.obsfucated_link = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{self.file_path}--")
    end
end
