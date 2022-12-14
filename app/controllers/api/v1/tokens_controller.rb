# frozen_string_literal: true

module Api
  module V1
    class TokensController < ApplicationController
      def create
        @user = User.find_by_email(params[:email])
        if @user&.authenticate(params[:password_digest])
          render json: {
            token: JsonWebToken.encode(user_id: @user.id),
            email: @user.email
          }
        else

          render json: {errors:"email/password is wrong"}, status: :unprocessable_entity
          #
        end
      end
    end
  end
end
