class User < ActiveRecord::Base
  has_many :microposts
  validates :name, presence: true
  validates :emai, presence: true
end
