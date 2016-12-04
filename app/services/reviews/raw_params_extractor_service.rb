class RawParamsExtractorService < BaseInteractor
  include Interactor

  before do
    @params = context.params || fail_with_argument_error!
  end

  def call
    context.signature     = params[:signature].presence    || fail_with_argument_error!
    context.crypted_body  = params[:crypted_body].presence || fail_with_argument_error!
    context.review_params = {
      review_content: params[:review_content],
      review_score:   params[:review_score]
    }
  end

  private

  attr_reader :params
end
