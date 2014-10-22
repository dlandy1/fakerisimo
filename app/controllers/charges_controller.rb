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
    @user = current_user.id
    Credit.create(value: @amount, user_id:@user)
     redirect_to root_path
     flash[:notice] = "Credit charge success"

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to root_path
  end
end
