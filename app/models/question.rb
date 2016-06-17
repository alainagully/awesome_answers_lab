class Question < ActiveRecord::Base
  # has_many helps us set up the association between question model and the
  # answer model. In this case `has_many` assumes that the answers table contain
  # a field named `question_id` that is an integer (this is a Rails convention).
  # the dependent option takes valus like `destroy` and `nullify`
  #'destroy' will make rails automatically delete associates answers before deleting the question
  # `nullify` will make Rails turn `question_id` values of associated records
# to `NULL` before deleting the question.

  has_many :answers, dependent: :destroy
  belongs_to :category
  belongs_to :user

  
  validates(:title, {presence: {message: "must be present!"}, uniqueness: true})

  # by having the option: uniqueness: {scope :title} it ensures that the body must be unique in combination with the title

  validates :body, presence: true,
                   length: {minimum: 7},
                   uniqueness: {scope: :title}

  validates :view_count, numericality: {greater_than_or_equal_to: 0}


  # VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  #

  validate :no_monkey
  validate :body_no_title

  after_initialize :set_defaults
  before_validation      :cap_title
  before_validation      :squeeze_space



  scope :recent, lambda {|count| where("created_at > ?", 3.day.ago).limit(count)}
  # def self.recent(count)
  #   where ("created at > ?", 3.day.ago).limit(count)
  # end

  scope :created_after, lambda {|date| where "created_at > ?", date}


  # scope :search, lambda {|word| where("title ILIKE ? OR body ILIKE ?", "%#{word}%", "%#{word}%")}
  def self.search(word)
    where("title ILIKE :word OR body ILIKE :word", {word: "%#{word}%"})
  end

  def new_first_answers
    answers.order(created_at: :desc)
  end





  private

  def squeeze_space
      self.title = title.squeeze(" ")
      self.body = body.squeeze(" ")
  end

  def cap_title
    self.title = title.capitalize
  end

  def set_defaults
    puts title
    self.view_count ||= 0
  end

  def no_monkey
    if title && title.downcase.include?("monkey")
      errors.add(:title, "No monkey please")
    end
  end

  def body_no_title
    if body.include?(title)
      errors.add(:body, "No title in body")
    end
  end

end
