Rails.application.config.assets.version = (ENV["ASSETS_VERSION"] || "1.0")
Rails.application.config.assets.precompile += %w(
  gov.uk_logotype_crown.svg govuk.scss internal.scss
)
