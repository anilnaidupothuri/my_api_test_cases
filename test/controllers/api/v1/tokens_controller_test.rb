# frozen_string_literal: true

require 'test_helper'

module Api
  module V1
    class TokensControllerTest < ActionDispatch::IntegrationTest
      setup do
        @user = users(:one)
      end
      test 'should get jwt token' do
        post api_v1_tokens_url, params: { user: { email: @user.email, password: "one123" } }, as: :json
        assert_response :success
        json_response = json.parse(response.body)
        assert_not_nil json_response['token']
      end

      test 'should not get jwt token' do
        post api_v1_tokens_url, params: { user: { email: @user.email, password_digest: 'bad pass' } }, as: :json
        assert_response :unauthorized
      end
    end
  end
end
