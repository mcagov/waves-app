def select2(value, **options)
  first("#select2-#{options[:from]}-container").click
  find(".select2-results__option", text: value).click
end
