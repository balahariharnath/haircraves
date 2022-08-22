class Conversation < ApplicationRecord
  #============== Associations =======================================
  has_many :messages, dependent: :destroy
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  has_one :recent_message, -> { order created_at: :desc}, class_name: 'Message'

  #================== Validation =====================================
  validates :sender_id, uniqueness: { scope: :receiver_id }

  scope :between, -> (sender_id, receiver_id) do
    where(sender_id: sender_id, receiver_id: receiver_id).or(
      where(sender_id: receiver_id, receiver_id: sender_id)
    )
  end

  def self.get(sender_id, receiver_id)
    conversation = between(sender_id, receiver_id).first
    return conversation if conversation.present?

    create(sender_id: sender_id, receiver_id: receiver_id)
  end

  def opposed_user(user)
    user == receiver ? sender : receiver
  end
end
