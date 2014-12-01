class Response < ActiveRecord::Base
  validates :user_id, :answer_choice_id, presence: true
  validate :respondent_has_not_already_answered_question

  belongs_to :respondent,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id

  belongs_to :answer_choice,
    class_name: "AnswerChoice",
    foreign_key: :answer_choice_id,
    primary_key: :id

  has_one :question, through: :answer_choice, source: :question

  def sibling_responses
    self.question.responses.where("responses.id != ?", self.id)
  end

#  private
  def respondent_has_not_already_answered_question
    if sibling_responses.exists?(user_id: self.user_id)
      errors[:user_id] << "this user already responded to this question"
    end
  end

  def author_cannot_respond_to_own_poll

    if question.poll.author_id == self.user_id
      errors[:user_id] << "A poll's author cannot respond to their own poll"
    end
  end
end
