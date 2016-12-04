module Reviews
  class ContentDecryptorService
    include Interactor

    def call
      context.decrypted_body = decrypted_body
    rescue OpenSSL::PKey::RSAError
      context.fail!
    end

    private

    def decrypted_body
      EncryptoSigno.decrypt(YOTPO_KEYS[:private], context.crypted_body)
    end
  end
end
