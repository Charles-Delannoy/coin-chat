module FormErrorsHelper
  def errors_display(model, field)
    render 'shared/form_errors', model: model, field: field if model.errors.messages[field].any?
  end
end
