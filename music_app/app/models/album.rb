class Album < ActiveRecord::Base
  validates :title, :band_id, :kind, presence: true
  validates :kind, inclusion: { in: %w(studio live) }

  belongs_to :band

  has_many :tracks, dependent: :destroy
end
