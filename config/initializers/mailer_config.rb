#------------ Initializer for ActionMailer -- GMAIL

#------------ Load up the Yaml File
mailer_config = File.open("#{RAILS_ROOT}/config/mailer.yml") 
mailer_options = YAML.load(mailer_config)
ActionMailer::Base.smtp_settings = mailer_options 

#------------ Allowing Haml to be used for the template
ActionMailer::Base.register_template_extension('haml')
