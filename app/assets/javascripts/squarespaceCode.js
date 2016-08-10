/*<!DOCTYPE html>
<html>
<head> 
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
$( document ).ready( function() {
	function generate_table() 
	{
		//This is what you will need to change
		var skus = "978-0802412706,978-0842360241,978-0986366703,978-0986366710,978-0990351405,978-1400324347,978-1414398044,978-1433548406,978-1433679599,978-1481866880,978-1490907550,978-1490925387,978-1589975385,978-1594153204,978-1594631870";
		
		//Don't mess with any of this
		var proxy_url = "http://localhost:3000/api/sku/?skus=" + skus;
		$.ajax( {
			type: "GET",
			url : proxy_url,
			dataType: 'jsonp',
			success: function(json) {
				console.log('success');
				console.log(json);
				for(var i = 0; i < json.title.length; i++){
					var newRowContent = "<tr><td>" + (i+1) + "</td><td>"+ json.title[i] + "</td><td>" + json.skus[i] + "</td><td>" + json.onhand[i] + "</td><td>" + json.pending[i] + "</td><td>" + json.available[i] + "</td></tr>";
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
	
	generate_table();
}); //close document ready
</script>
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
    #background-color: #dddddd;
}
</style>  
</head>


<body>
	<table id="myTable">
	<tbody>
	  <tr>
		<th>No.</th>
		<th>Title</th>
		<th>SKU</th>
		<th>Quantity On Hand</th>
		<th>Quantity Pending</th>
		<th>Quantity Available</th>
	  </tr>
	</tbody>
	</table>
</body>
</html>*/
