addresses_data = [
  {
    d_no: '123',
    landmark: 'Near P---------ark',
    city: 'New York',
    zip_code: '10001',
    state: 'NY',
    country: 'USA',
    created_at: Time.zone.now,
    updated_at: Time.zone.now,
    is_active: true,
    is_permanent: true,
employee_id: 3
  }
]

# Create addresses records
addresses_data.each do |address_data|
  Address.create!(address_data)
end