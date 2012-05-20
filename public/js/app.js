var eventsDomElem;

$(function() {
  eventsDomElem = $("#events");
  $('.list li').bind('click', function(evt) {
    var target = evt.currentTarget;
    var dataUrlKey = $(target).attr('data-url-key');
    $('.list li.current').removeClass('current');
    $(target).addClass('current');
    getEvents(dataUrlKey)
  });
});

function getEvents(dataUrlKey) {
  if (!eventsDomElem) return;
  var url = "/events/" + dataUrlKey;
  $.ajax({
    url: url,
    complete: function(jqXHR, textStatus) {
      eventsDomElem.html('');
      eventsDomElem.html(jqXHR.responseText);
    }
  });
}