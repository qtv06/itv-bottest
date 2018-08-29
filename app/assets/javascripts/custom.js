$(document).on("turbolinks:before-cache", function() {
  $('.select2_single').select2('destroy');
});

$(document).on('turbolinks:load', function() {
  $('#simple-example').select2({
    placeholder: "Select a city",
    allowClear: true,
    maximumSelectionLength: 2
  });
  $('.col-md-2 .select2_single').select2({});
});