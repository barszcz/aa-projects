class Cat < ActiveRecord::Base

  belongs_to(
    :owner,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  COLORS = %w(red orange yellow green blue indigo violet black white plaid calico tartan paisley gray brown invisible)
  validates :birth_date, :color, :name, :sex, :user_id, presence: true
  validates :color, inclusion: { in: COLORS,
                                  message: "%{value} is not a valid color"}
  validates :sex, inclusion: { in: %w(M F), message: "Sorry, we're required to be gender binary-normative for this project."}

  has_many(
    :cat_rental_requests,
    dependent: :destroy,
    class_name: "CatRentalRequest",
    foreign_key: :cat_id,
    primary_key: :id
  )

  def age
    Time.now.year - birth_date.year
  end
end
