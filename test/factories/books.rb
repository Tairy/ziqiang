FactoryGirl.define do
  factory :book do
    name 'Tairy is a great man!'
    author 'Tairy'
    donor 'Tairy'
    donate_time '2014-01-01 12:22:33'
    status 'CANBORROW'
    # should_restitution_time '2014-01-01 12:22:33'
    actual_restitution_time '2014-01-01 12:22:33'
    barcode '213111517'
    borrow_times 2
  end
end
