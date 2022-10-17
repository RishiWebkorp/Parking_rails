FactoryBot.define do
  factory(:slot) do
    slot {1}
    car_no{"MP09fz1221"}
    name {"john"}
    status {"booked"}
    intime {Time.now}
    # user_id {current_user.id}
    floor {create(:floor)}
  end
end

FactoryBot.define do
  factory(:floor) do
    floor {1}
  end
end
