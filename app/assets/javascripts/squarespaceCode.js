/*<!DOCTYPE html>
<html>
<head> 

<style>
table {
	font-family: arial, sans-serif;
	border-collapse: collapse;
	width: 80%;
	margin: 20px auto;
}

td, th {
    border: 1px solid #dddddd;
    text-align: left;
    padding: 8px;
}

tr:nth-child(even) {
    background-color: #dddddd;
}
</style>

<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
$( document ).ready( function() {
	function get_watched_repos() 
	{
		//This is what you will need to change
		var skus = "";
		
		//Don't mess with any of this
		var proxy_url = "http://ec2-52-42-210-119.us-west-2.compute.amazonaws.com/api/sku/?skus=" + skus;
		$.ajax( {
			type: "GET",
			url : proxy_url,
			dataType: 'jsonp',
			success: function(json) {
				console.log('success');
				console.log(json);
				for(var i = 0; i < json.title.length; i++){
					var newRowContent = "<tr><td>" + (i+1) + "</td><td>"+ json.title[i] + "</td><td>" + json.skus[i] + "</td><td>" + json.onhand[i] + "</td><td>" + json.pending[i] + "</td></tr>";
					$(newRowContent).appendTo($("#myTable"));
				}
			},
			error: function(x,y,z) {
				// x.responseText should have what's wrong
				console.log(x)
				console.log(y)
				console.log(z)
			}
		 });
	}
	
	get_watched_repos();
}); //close document ready
</script>
</head>


<body>
	<table id="myTable">
	<tbody>
	  <tr>
		<th>No.</th>
		<th>Title</th>
		<th>Sku</th>
		<th>Quantity On Hand</th>
		<th>Quantity Pending</th>
	  </tr>
	</tbody>
	</table>
</body>
</html>*/
