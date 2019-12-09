FactoryBot.define do
  factory :tracking_sleep do
    start_time {6.hours.ago}
    end_time {1.hour.ago}
    period nil
    user_id nil
  end
end
