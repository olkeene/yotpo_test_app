require File.dirname(__FILE__) + '/../spec_helper.rb'
require 'json'

describe 'POST /reviews' do
  describe 'status 401' do
    let(:params) { {} }

    subject do
      post '/reviews', params
      last_response.status
    end

    context 'with invalid params' do
      context 'when no params' do
        it { is_expected.to eq(401) }
      end

      context 'when no signature' do
        let(:params) { { signature: '' } }

        it { is_expected.to eq(401) }
      end

      context 'when signature and no crypted_body' do
        let(:params) { { signature: 'xxx', crypted_body: '' } }

        it { is_expected.to eq(401) }
      end
    end

    context 'with all params presence' do
      context 'when signature is invalid' do
        let(:params) { { signature: 'xxx', crypted_body: 'sacsacasc' } }

        it { is_expected.to eq(401) }
      end

      context 'when params are valid' do
        let(:params_for_crypting) do
          {
            user_id: 'user_id', user_email: 'user_email', user_type: 'user_type'
          }
        end

        let(:review_params) do
          {
            review_content: 'review_content', review_score: 'review_score'
          }
        end

        let(:params) do
          json_params = params_for_crypting.to_json

          {
            signature:    EncryptoSigno.sign(File.read(Padrino.root('spec/client_private.pem')), json_params),
            crypted_body: EncryptoSigno.encrypt(YOTPO_KEYS[:public], json_params)
          }.merge(review_params)
        end

        it { is_expected.to eq(200) }

        it 'saves with right params' do
          right_params = params_for_crypting.merge(review_params)
          expect(Review).to receive(:create!).with(right_params)

          subject
        end
      end
    end
  end
end
