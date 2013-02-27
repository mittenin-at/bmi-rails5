module ApplicationHelper
  def admin?
    if session[:user_id]
      User.find_by_id(session[:user_id]).admin?
    end
  end

  def current_user
    if session[:user_id]
      User.find_by_id(session[:user_id])
    end
  end

  def bootstrap_error(instance, model_class)
    if instance && instance.errors.any?
      flash_messages = []
      flash_messages << content_tag(:h4, t("error"))
      flash_messages << content_tag(:p, pluralize(instance.errors.count, t("error")) + t("helpers.error_message", :model => model_class.model_name.human) )
      list_items = []
      instance.errors.full_messages.each do |message|
        list_items << content_tag(:li, message)
      end
      flash_messages << content_tag(:ul, list_items.join("\n").html_safe)
      complete_message = flash_messages.join("\n").html_safe
      content_tag(:div, link_to("x", "#", :class => "close", "data-dismiss" => "alert") + complete_message, :class => "alert alert-block fade in alert-error") if flash_messages
    end
  end
end