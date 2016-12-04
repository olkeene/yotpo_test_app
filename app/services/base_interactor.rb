class BaseInteractor
  private

  def fail_with_argument_error!
    context.fail!(error: 'ArgumentError')
  end
end
