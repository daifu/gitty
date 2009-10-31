$("#toggle2").hide();

$("#toggle1").toggle(function(){
	$(this).html("Cancel adding");
}, function() {
	$(this).html("Add another collaborator");
});

$("#toggle1").click(function(){
	$(this).next("#toggle2").slideToggle("fast");
});
