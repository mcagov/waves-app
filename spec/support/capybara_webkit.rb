Capybara.javascript_driver = :webkit

# rubocop:disable Style/SymbolProc
Capybara::Webkit.configure do |config|
  config.block_unknown_urls
end
# rubocop:enable Style/SymbolProc
