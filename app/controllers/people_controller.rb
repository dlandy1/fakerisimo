class PeopleController < ApplicationController
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
    @people
  end
end
