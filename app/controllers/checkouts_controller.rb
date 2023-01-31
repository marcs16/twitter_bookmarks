# frozen_string_literal: true

class CheckoutsController < ApplicationController
  before_action :require_user!
  def show; end

  def create
    # redirecto to checkout page
    if current_user.payment_processor.subscribed?
      redirect_to "/bookmarks"
    else
      @checkout_session = current_user.payment_processor.checkout(
        mode: 'subscription',
        line_items: ENV['ITEM_PRICE_ID'],
        allow_promotion_codes: true
      )
      redirect_to @checkout_session.url, allow_other_host: true, status: :see_other
    end
  end
end
