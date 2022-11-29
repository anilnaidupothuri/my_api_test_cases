# frozen_string_literal: true

require 'test_helper'

module Api
  module V1
    module Api
      module V1
        class UsersControllerTest < ActionDispatch::IntegrationTest
          setup do
            @user = users(:one)
          end

          test 'should show user' do
            get api_v1_user_url(@user), as: :json
            assert_response :success

            json_response = JSON.parse(response.body)

            assert_equal @user.email, json_response['email']
          end
          test 'should create user' do
            assert_difference('User.count') do
              post api_v1_users_url, params: { user: { name: 'test', email:
              'test@test.org', password: '123456', location: 'hyd' } }, as: :json
            end
            assert_response :created
          end
          test 'should not create user with taken email' do
            assert_no_difference('User.count') do
              post api_v1_users_url, params: { user: { name: 'test', email: @user
                .email, password: '123456', location: 'hyd' } }, as: :json
            end
            assert_response :unprocessable_entity
          end

          test 'should be update user' do
            patch api_v1_user_url(@user), params: { user: { name: 'test1', email: @user.email, location: 'Ap' } },
                                          as: :json
            assert_response :success
          end

          test 'shoud be delete user' do
            assert_difference('User.count', -1) do
              delete api_v1_user_url(@user), as: :json
            end
            assert_response :no_content
          end
        end
      end
    end
  end
end
