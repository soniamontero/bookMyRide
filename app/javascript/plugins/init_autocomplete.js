import places from 'places.js';

const initAutocomplete = () => {
  const addressInput = document.getElementById('ride_location');
  if (addressInput) {
    places({ container: addressInput });
  }
};

export { initAutocomplete };
