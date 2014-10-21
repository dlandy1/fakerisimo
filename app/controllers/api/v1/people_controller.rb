module Api
  module V1
    class PeopleController < ApplicationController
      before_filter :restrict_access
      respond_to :json

      def index
            @people = []
        params[:count].to_i.times do
          @people << People.new(
            name:     Faker::Name.name,
            age:      Faker::Number.number(2),
            city:     Faker::Address.city,
            state:    Faker::Address.state
          )
        end
        respond_with  @people
      end

       private
      def restrict_access
        api_key = params[:auth_token]
        head :unauthorized unless api_key
      end

    end
  end
end