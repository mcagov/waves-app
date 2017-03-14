if Rails.env.test?
  Paperclip::Attachment.default_options[:storage] = :filesystem
else
  Paperclip::Attachment.default_options[:storage] = :azure
  Paperclip::Attachment.default_options[:url] = ":azure_path_url"

  Paperclip::Attachment.default_options[:path] =
    ":class/:attachment/:id/:style/:filename"

  Paperclip::Attachment.default_options[:azure_credentials] = {
    storage_account_name: ENV["AZURE_STORAGE_ACCOUNT"],
    access_key:           ENV["AZURE_ACCESS_KEY"],
    container:            ENV["AZURE_CONTAINER_NAME"],
  }
end
