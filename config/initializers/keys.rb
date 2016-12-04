YOTPO_KEYS = {
  public:  File.read(Padrino.root('config/public.pem')),
  private: File.read(Padrino.root('config/private.pem'))
}

CLIENT_KEYS = {
  public: File.read(Padrino.root('config/client_public.pem')),
}
