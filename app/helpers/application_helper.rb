# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def has_errors?(object, attribute)
    if object.errors.on(attribute)
      error_messages_for_attribute(object,attribute)
    else
      html = <<-TAG
      <input id="email_account_#{attribute}" name="email_account[#{attribute}]" size="30" type="#{attribute.to_s == "password" ? "password" : "text"}" value="#{object.send(attribute)}"/>
      TAG
    end
  end
  
  def error_messages_for_attribute(object, attribute)
      messages = object.errors.on(attribute).collect
      messages = messages.size > 1 ? messages.join(' and ') : messages
      html = <<-TAG
      <input id="email_account_#{attribute}" class="errors" name="email_account[#{attribute}]" size="30" type="#{attribute.to_s == "password" ? "password" : "text"}" title="#{messages}"/>
      TAG
  end
  
end
