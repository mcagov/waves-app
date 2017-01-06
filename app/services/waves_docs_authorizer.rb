class WavesDocsAuthorizer < Documentation::Authorizer
  def can_use_ui?
    @controller.signed_in?
  end
end
