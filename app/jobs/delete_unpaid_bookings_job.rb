class DeleteUnpaidBookingsJob < ApplicationJob
  queue_as :default

  def perform(booking_id)
    booking = Booking.find(booking_id)
    puts "Gonna work with booking ##{booking.id}."
    if booking.state != 'Confirmed'
      p 'Sate is not confirmed!'
      booking.destroy
      p "Booking with id #{booking.id} has been destroyed."
    else
      p "Booking state is: #{booking.state}. All good."
    end
  end
end
