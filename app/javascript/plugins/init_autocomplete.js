import places from 'places.js';

const initAutocomplete = () => {

  const rideAddressInput = document.getElementById('ride_location');
  const userAddressInput = document.getElementById('user_location');
  const homeAddressInput = document.getElementById('home-query');

  if (rideAddressInput ) {
    places({
      language: 'us',
      container: rideAddressInput
    });
  }
  if (userAddressInput) {
    places({
      language: 'us',
      container: userAddressInput
    });
  }
  if (homeAddressInput) {
    places({
      language: 'us',
      container: homeAddressInput
    });
  }
};

export { initAutocomplete };
