module Api
  module V1
    class PeopleController < ApplicationController
      before_filter :restrict_access

      respond_to :json

      def index
        if !current_user.credits.first.nil?
            @people = []
          if params[:count].to_i <= 500
        params[:count].to_i.times do
          @people << People.new(
            name:     Faker::Name.name,
            age:      Faker::Number.number(2),
            city:     Faker::Address.city,
            state:    Faker::Address.state
          )
        end
        
        @numb = current_user.credits.first.value
        current_user.credits.first.update(value: (@numb-1))
        Get.create(call: "#{request.fullpath}", user_id: current_user.id)
        respond_with  @people
        else
          render :nothing => true, :status => 413
        end
      else
       render :nothing => true, :status => 401
       end
      end

       private
      def restrict_access
        api_key = params[:auth_token].presence && User.find_by_authentication_token(params[:auth_token].presence.to_s)
        head :unauthorized unless api_key
      end

    end
  end
end