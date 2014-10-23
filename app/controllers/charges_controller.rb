class ChargesController < ApplicationController
  def new
  end

  def create
    # Amount in cents
    @amount = 100

      customer = Stripe::Customer.create(
        :email => 'example@stripe.com',
        :card  => params[:stripeToken]
      )
        charge = Stripe::Charge.create(
          :customer    => customer.id,
          :amount      => @amount,
          :description => 'Rails Stripe customer',
          :currency    => 'usd'
        )
        if current_user.credits.first.nil?
        @user = current_user.id
        Credit.create(value: @amount, user_id:@user)
         redirect_to root_path
         flash[:notice] = "Credit charge success"
    else
      @value = current_user.credits.first.value
      @user = current_user
      number = (@value + 100)
      current_user.credits.first.update(value: number)
    redirect_to root_path
         flash[:notice] = "Credit charge success"
    end
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to root_path
  end
end
