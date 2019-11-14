
<?php
include("db.php");

	$flag=0;

	if(isset($_POST['username']))
	{
		$sql = "INSERT INTO users (username) VALUES ( '".$_POST['username']."')";

if ($conn->query($sql) === TRUE) {
    echo "New record created successfully";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

//$conn->close();
	}

?>

<head>
  <title>website</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
  <link rel="stylesheet" type="text/css" href="MyWebsite.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
</head>
<body>

<div class="container">

<nav> 

<ul> 

  <li><a title="Welcome" href="Welcome.html">Welcome</a></li>  
  <li><a title="HomePage" href="HomePage.html">HomePage</a></li> 
  <li><a title="Recommendation"	href="user.php">insert user</a></li> 
  <li><a title="Contact" href="music.php">insert music</a></li> 
  <li><a title="Contact" href="recommendation.php">Recommendation</a></li> 
  
</ul>  
</nav> 

  <h2>Add User</h2>

  <div class="panel-group">

    <div class="panel panel-default">
      <div class="panel-heading"></div>
      

    <?php if($flag) { ?>
      <div class="alert alert-successful">You have been Added to personify database</div>

		<?php } ?>

      <div class="panel-body">
      		<form action="user.php" method="POST">
      	<div class="form-group">
      	<label for="username">User Name</label>
      	<input type="text" name="username" id="username" class="form-control" required>

      </div>

      <div class="form-group">
      <input type="submit"  value="submit" class="btn btn-primary" required>

    </div>
 </form>

  </div>
  
<?php
	$sql = "SELECT * FROM users";
	$result = $conn->query($sql);

	if ($result->num_rows > 0) {
	    // output data of each row
	    while($row = $result->fetch_assoc()) {
	        echo " Name: " . $row["username"]. "<br>";
	    }
	} else {
	    echo "0 results";
	}
	$conn->close();

	?>
	
</div>

<br>


<footer>Personify</footer> <!-- this is the footer at the end of the page -->

</body>
 