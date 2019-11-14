<?php
//matrix reccomendation system

function usersimilarity //user similarity function
($matrixRecommend,$user1,$user2) //checks the similarity between 2 users to reccomend based on user based collabrative filtering

{

	$equiv=array(); //equiv array
	
	$number=0; //number return
	
	$order=array(); //order array
	
		foreach
			($matrixRecommend[$user1] as $key=>$numbval) //number value user 1
		
		{
		
			if
				(array_key_exists($key,$matrixRecommend[$user1]))//if statement user 1
			
			{
			
			$equiv	[$key]=1; //equivilant
			
			}
		
		}
	
			if	
				($equiv==0)// if statement
			
			{
			
				return 0;//return
				
			}	
		
		foreach
			($matrixRecommend[$user1] as $key=>$numbval)// for each user 1
		
		{
			if
				(array_key_exists($key,$matrixRecommend[$user2]))// if statement for if key exists 
			
			{
			
				$number=$number+pow
					($number-$matrixRecommend[$user2][$key],2);//calculation to the power
				
			}
			
		}
			
		return 
			1/(1+sqrt($number));//number return

}

	function RecommendationRecieve
		($matrixRecommend,$user)// recieve reccomendation function
	
	{
		$final=array();// array for final result
		
		$similaritynumber=array();// array for similarity
	
		foreach
			($matrixRecommend as $compareuser=>$numbval)//for each comparison
		
			{
	
			if
				($compareuser!=$user)//if statement for comparison of selected user and other users
		
			{
		
		 	$calsim=usersimilarity
		 		($matrixRecommend,$user,$compareuser);//calculate similarity of 2 users and compares
		 
		 		foreach
		 			($matrixRecommend[$compareuser] as $key=>$numbval)//user comparison
		 		
		 		{
		 		
		 			if(!array_key_exists($key,$matrixRecommend[$user]))//if statement for user comparison
		 			
		 			{
		 			
		 				if(!array_key_exists($key,$final))//if statement or a specific key within an array 
		 			
		 			{
		 				$final[$key]=0;//final
		 			}
		 			
		 			$final[$key]+=$matrixRecommend[$compareuser][$key]*$calsim;//
		 			
		 				if
		 					(!array_key_exists($key,$similaritynumber))// checking for a specific key within an array (similarity number)
		 			
		 			{
		 				$similaritynumber[$key]=0;// 
		 			}
		 			
		 			$similaritynumber[$key]+=$calsim;//calculation
		 			
		 		}
		 	}
		 
		}
	
	}

		foreach
		($final as $key=>$numbval)//final calculation for similarity
	
		{
			$order[$key]=$numbval/$similaritynumber[$key];// calculates 
		
			array_multisort($order,SORT_DESC);// sorts in order to the most similar song
		
			return $order;//returns in order of most similar song
		}
}

?>