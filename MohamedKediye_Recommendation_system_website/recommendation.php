<?php

include("db.php");//database



include("recommend.php");//recommend



	$matrixRecommend=array(); //array matrix reccomendation
	
	$music=mysqli_query
		($conn,"select * from userMusic"); //connection to database/selects userMusic table from the database




		while
		
		($musicc=mysqli_fetch_array
		
			($music)
		
		)//calls to fetch song name and song rating from the database

		{
	
			$users=mysqli_query
				($conn,"select username from users where id=$musicc[userID]"); //allows user to select a username from the database from the user table according to the user ID
	
			$username=mysqli_fetch_array //fetches a numeric array from users
			($users); //fetches a numeric array from users
	
			$matrixRecommend //username to song name to the rating the user gave the song
			[$username['username']][$musicc['SongName']]=$musicc['SongRating']; //username to song name to the rating the user gave the song 


		}
	var_dump//displays structured info from recommend
	
	(RecommendationRecieve($matrixRecommend,"Kediye")); //user will be able to select a user within the database and the recommendation will be shown based on collabrative filtering

?>