

$(document).on("pageinit","#indexpage",function(){
    
    for ( var i = 0; i < gon.numWords; i++) {
	$("#w" + i).on("tap",function(){
	    if (  $(this).data('word-highlighted') ) {
		$(this).data('word-selected','false');
		$(this).css('background-color', '#FFFFFF');
	    } else {
		$(this).data('word-highlighted','true');
		$(this).css('background-color', '#FFFFD9');
	    };
	});
    };                       
});
