module Reviews
  class SaveService
    include Interactor

    before do
      @review_params = context.review_params
    end

    def call
      Review.create!(params)
    end

    private

    attr_reader :review_params

    def params
      review_params.merge(
        JSON.parse(context.decrypted_body).symbolize_keys
      )
    end
  end
end
