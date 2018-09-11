$(function() {
	$.ajaxSetup({
  headers: { 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content') }
  });

	$("body").on("change", ".select-action", function() {
		
		var action = $(this).val();
		var test_suite_id = $(this).parent().find('.test_suit_id').val();
		var test_case_id = $(this).parent().find('.test_case_id').val()
		var id_row_step = $(this).parent().parent().parent().attr("id");
		var data = {
			action_select: action,
			test_suit_id: test_suite_id,
			test_case_id: test_case_id,
			id_row_step: id_row_step
		}

		$.ajax({
		  type: "POST",
		  url: "/edit/render_row_step",
		  data: data,
		  dataType: "script",
		  success: function() {
		  	console.log("success")
		  }
		});
	});

	$("body").on("click", ".btn-add-step", function() {
		var data = {
			row_count: $('.list-step li').length
		}
		$.ajax({
		  type: "POST",
		  url: "/edit/add_row_step",
		  data: data,
		  dataType: "script",
		  success: function() {
		  	console.log("success")
		  }
		});
	});
});