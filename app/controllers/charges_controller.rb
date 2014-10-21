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

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to dashboards_path
  end
end
