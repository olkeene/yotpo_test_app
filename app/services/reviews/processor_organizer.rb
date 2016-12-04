module Reviews
  class ProcessorOrganizer
    include Interactor::Organizer

    organize RawParamsExtractorService,
             ContentDecryptorService,
             RequestVerificationService,
             SaveService
  end
end
