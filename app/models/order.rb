class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :service

  validates :quantity, presence: true 
  validates :price, presence: true
  validates :total_price, presence: true
  validates :service_id, presence:true 

  before_save :set_order_price

  private
  	def set_order_price
  		self.total_price = self.quantity * self.price
  end
end
