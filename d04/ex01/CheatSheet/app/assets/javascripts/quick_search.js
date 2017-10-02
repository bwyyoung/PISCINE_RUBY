

$('document').ready(function()
{
	$("#quick_search_table").dataTable();
});


document.addEventListener("turbolinks:load", function()
{
	$("#quick_search_table").dataTable();
});