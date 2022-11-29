# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      before_action :set_user, only: %i[show update destroy]

      def index 
        @users = User.all 
        render json:@users 
      end
      def show
        @user = User.find(params[:id])
        render json: @user
      end

      def create
        @user = User.create(user_params)
        if @user.save
          render json: @user, status: :created
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      def update
        if @user.update(user_params)
          render json: @user, status: :ok
        else
          render json: @errors, status: :unprocessable_entity
        end
      end

      def destroy
        @user.destroy
      end

      private

      def user_params
        params.require(:user).permit(:name, :email, :password_digest, :location)
      end

      def set_user
        @user = User.find(params[:id])
      end
    end
  end
end
