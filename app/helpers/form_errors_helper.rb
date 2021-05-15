module FormErrorsHelper
  def errors_display(model, field)
    return '' unless model.errors.messages[field].any?

    result = ''
    model.errors.messages[field].each do |error|
      result += "<p>#{error}</p>"
    end
    "<div class='form-errors'>#{result}</div>".html_safe
  end
end
