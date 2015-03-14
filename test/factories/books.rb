FactoryGirl.define do
  factory :book do
    name 'Tairy is a great man!'
    author 'Tairy'
    tag 'Success'
    donor 'Tairy'
    donate_time '2014-01-01 12:22:33'
    status 'can'
    should_restitution_time '2014-01-01 12:22:33'
    actual_restitution_time '2014-01-01 12:22:33'
    barcode '213111517'
    borrow_times 2
  end
end
