module ApplicationHelper
  def full_title page_title = ""
    base_title = t "static_page.app_name"
    page_title.empty? ? base_title : page_title << " | " << base_title
  end

  def flash_class level
    case level
    when :notice then "alert-info"
    when :error then "alert-error"
    when :warning then "alert-warning"
    when :success then "alert-success"
    end
  end

  def i18n_enum model_name, enum
    enum = enum.to_s.pluralize
    model_name = model_name.to_s
    model_name.classify.constantize.public_send(enum).keys.map do |key|
      OpenStruct.new key: key, value: t("#{model_name.pluralize}.#{enum}.#{key}")
    end.flatten
  end
end
