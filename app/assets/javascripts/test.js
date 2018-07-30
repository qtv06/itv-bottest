$(document).on("turbolinks:before-cache", function() {
  $('.select2_single').select2('destroy');
});

$(document).on('turbolinks:load', function() {
  $('#simple-example').select2({
    placeholder: "Select a city",
    allowClear: true,
    maximumSelectionLength: 2
  });

  // $('#ajax-example').select2({
  //   ajax: {
  //     url: '/users.json',
  //     type: 'GET',
  //     dataType: 'JSON',
  //     results: function(data, page){
  //       console.log(data);
  //       return {
  //         results: $.map(data, function(user,i){
  //           return {id: user.id, text: user.name}
  //         })
  //       }
  //     }
  //   }
  // });
  $('.select2_single').select2({
    maximumSelectionLength: 3
  });
});
