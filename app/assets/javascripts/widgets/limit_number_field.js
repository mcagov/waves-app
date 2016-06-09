var LimitNumberField = function (numberField, characterLimit) {
  $(numberField).on("keyup keypress blur change", function (event) {
    if (event.target.value.length > characterLimit)
      event.target.value = event.target.value.slice(0, characterLimit);
  });
};
