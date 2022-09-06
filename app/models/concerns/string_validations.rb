module StringValidations
  extend ActiveSupport::Concern

  def regex_valid_name
    /^[0-9a-zA-Z√ë√±√°√©√≠√≥√∫√º√Å√â√ç√ì√ö&-_ ]+$/
  end

  def regex_insecure_string
    /[<>\$]/
  end
end
