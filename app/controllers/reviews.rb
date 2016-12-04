Yotpo::App.controllers :reviews do
  post :create, map: '/reviews' do
    if Reviews::ProcessorOrganizer.call(params: params).success?
      status 200
    else
      status 401
    end
  end
end
