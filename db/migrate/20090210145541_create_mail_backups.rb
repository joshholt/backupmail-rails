class CreateMailBackups < ActiveRecord::Migration
  def self.up
    create_table :mail_backups do |t|
      t.string :obsfucated_link
      t.string :file_path
      t.timestamps
    end
  end

  def self.down
    drop_table :mail_backups
  end
end
