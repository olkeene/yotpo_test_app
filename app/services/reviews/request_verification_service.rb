class RequestVerificationService
  include Interactor

  before do
    @signature      = context.signature
    @decrypted_body = context.decrypted_body
  end

  def call
    context.fail! unless EncryptoSigno.verify(CLIENT_KEYS[:public], signature, decrypted_body)
  end

  private

  attr_reader :signature, :decrypted_body
end
