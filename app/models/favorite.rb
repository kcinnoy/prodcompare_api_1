class Favorite < ApplicationRecord
  belongs_to :user

  validates :title, :num_favorers, :url, :ref_id, :price, :image,  presence: true
  # validates :ref_id, uniqueness: true
end
