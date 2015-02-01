class Track < ActiveRecord::Base
  validates :title, :album_id, :kind, presence: true
  validates :kind, inclusion: { in: %w(regular bonus)}

  belongs_to :album

  has_many :notes

  has_one :band, through: :album, source: :band
end
