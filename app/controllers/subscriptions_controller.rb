class SubscriptionsController < ApplicationController

  before_filter :scope_subscription

  def index
    @unsaved = true
  end

  def create
    @subscription.save && @subscription.valid? && @subscription.register_with_mailchimp && @unsaved = false
    @subscription.reset unless @subscription.valid?
    @unsaved = true unless @subscription.valid?
    render :index
  end

  private

  def scope_subscription
    @subscription = Subscription.new({:message => 'Your email address'}.merge(params[:subscription] || {}))
  end

  def thank_you_text
    "Thanks for signing up! Check your email for a message confirming your subscription."
  end

end
