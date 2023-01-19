# frozen_string_literal: true

class User < ApplicationRecord
  pay_customer default_payment_processor: :stripe, stripe_attributes: :stripe_data
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def stripe_data(_user)
    {
      metadata: {
        twitter_id:,
        user_id: id,
        nickname: "@#{nickname}"
      }
    }
  end
end
