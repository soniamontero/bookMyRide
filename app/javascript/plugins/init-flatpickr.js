const startDateInput = document.getElementById('booking_date_begin');
const endDateInput = document.getElementById('booking_date_end');
const unavailableDates = JSON.parse(document.querySelector('#ride-booking-dates').dataset.unavailable)

endDateInput.disabled = true

flatpickr("#booking_date_begin", {
  minDate: "today",
  disable: unavailableDates,
  dateFormat: "Y-m-d",
});

startDateInput.addEventListener("change", (e) => {
  if (startDateInput != "") {
    endDateInput.disabled = false
  }
  flatpickr("#booking_date_end", {
  minDate: e.target.value,
  disable: unavailableDates,
  dateFormat: "Y-m-d",
  });
})


