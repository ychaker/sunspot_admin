function rotateFan() {
	var count = 0;
	$('still').toggle();
	$('spinning').toggle();
	function rotate() {
	  var elem2 = $('spinning');
	  elem2.style.MozTransform = 'scale(1) rotate('+count+'deg)';
	  elem2.style.WebkitTransform = 'scale(1) rotate('+count+'deg)';
	  if (count==360) { count = 0 }
	  count+=90;
	  window.setTimeout(rotate, 25);
	}
	window.setTimeout(rotate, 25);
}
