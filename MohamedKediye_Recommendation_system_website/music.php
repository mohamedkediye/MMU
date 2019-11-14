
<?php
	include("db.php");
	
	session_start();
	if(isset($_GET['id'])){
			$_SESSION['ID'] = $_GET['id'];
			echo $_GET['id'];
	}
	
	


	$flag=0;

	if(isset($_POST['songname']))
	
	{
		$sql = "INSERT INTO userMusic (userID,SongName,Genre,SongRating) VALUES ( $_SESSION[ID],'$_POST[songname]','$_POST[genre]',$_POST[songrating])";

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

  <h2>Songs</h2>

  <div class="panel-group">

    <div class="panel panel-default">
      <div class="panel-heading"></div>

    <?php if($flag) { ?>
      <div class="btn btn-successful">Music has been added</div>

		<?php } ?>

      <div class="panel-body">
<form action="music.php" method="POST">
	<input type="text" name="id" class="form-control" value="<?php echo $_SESSION['ID']?>" required>
      	<div class="form-group">
      	<label for="username">Song Name</label>
      	<input type="text" name="songname" id="songname" class="form-control" required>

      </div>
      
      	 <div class="form-group">
      	<label for="username">Genre</label>
      	<input type="text" name="genre" id="genre" class="form-control" required>

      </div>
      
      	<div class="form-group">
      	<label for="username">Song Rating</label>
      	<input type="number" name="songrating" id="songrating" class="form-control" required>

      </div>

      <div class="form-group">
      <input type="submit"  value="submit" class="btn btn-primary" required>

    </div>
 </form>

  </div>
</div>

<br>


<footer>Personify</footer> <!-- this is the footer at the end of the page -->

</body>