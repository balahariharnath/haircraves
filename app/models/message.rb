class Message < ApplicationRecord
  #================== Associations =================================
  belongs_to :conversation
  belongs_to :sender, :class_name => 'User'


  # after_create_commit { broadcast_append_to self.conversation }
end
