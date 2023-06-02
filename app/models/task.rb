class Task < ApplicationRecord
    belongs_to :user
    validates :title, presence: true, length: {minimum: 6, maximum: 100}
    validates :description, presence: true, length: {minimum: 10, maximum: 300}
    validate :end_time_after_start_time

    def end_time_after_start_time
      if task_start_time.present? && task_end_time.present? && task_start_time >= task_end_time
        errors.add(:task_end_time, "must be greater than task start time ")
      end
    end
end
