class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, :user_id, :status, presence: true
  validates :status, inclusion: { in: %w(PENDING APPROVED DENIED) }
  validate :approved_requests_cannot_overlap

  after_initialize { self.status ||= "PENDING" }

  belongs_to(
    :cat,
    class_name: "Cat",
    foreign_key: :cat_id,
    primary_key: :id
  )

  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  def overlapping_requests
    self.cat.cat_rental_requests.where(<<-SQL, self.end_date, self.start_date, self.id, self.id)
      NOT (start_date > ? OR end_date < ? )
      AND (? IS NULL OR id != ?)
    SQL
  end

  def approved_requests_cannot_overlap
    if overlapping_approved_requests.exists? && self.status != "DENIED"
      errors[:base] << "Request overlaps with another rental"
    end
  end

  def overlapping_approved_requests
    overlapping_requests.where(status: "APPROVED")
  end

  def approve!
    CatRentalRequest.transaction do
      self.status = "APPROVED"
      self.save!
      overlapping_requests.each do |req|
        req.deny!
      end
    end
  end

  def deny!
    self.status = "DENIED"
    self.save!
  end

  def pending?
    self.status == "PENDING"
  end
end
