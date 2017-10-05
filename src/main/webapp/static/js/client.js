$('a.disabled').click(function (e) {
    e.preventDefault();
});

$('.client-driver-left a.list-group-item:not(.disabled)').click(function (e) {
    var selector = $(this).attr('href');
    $('.driver-task').prop('hidden', true);
    $(selector).prop('hidden', false);
    setTimeout(function() {
        window.scrollTo(0, 0);
    }, 1);
});

var clickable =  function () {
    if ($('.client-license-checkbox:checked').length === 0) {
        $('.client-license-send').prop('disabled', true);
    } else {
        $('.client-license-send').prop('disabled', false);
    }
}

$('.client-license-checkbox').change(clickable);

$('.client-license-select').click(function () {
    $('.client-license-checkbox').prop('checked', true);
    clickable();
});

$('.client-license-deselect').click(function () {
    $('.client-license-checkbox').prop('checked', false);
    clickable();
});

$('#client-renewal-select').change(function () {
    var filterValue = $(this).val();
    console.log(filterValue);
    var table = $('#client-renewal-table');
    var filteredSelector = '.badge[data-value="' +  filterValue + '"]';
    if (filterValue < 0) {
        $('.badge', table).closest('tr').prop('hidden', false);
    } else {
        console.log(filteredSelector);
        $('.badge', table).closest('tr').prop('hidden', true);
        $(filteredSelector, table).closest('tr').prop('hidden', false);
    }
});
