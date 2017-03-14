module AssetHelper
  def azure_private_asset_url(asset)
    asset.file.expiring_url(30.minutes.since, :original)
  end
end
