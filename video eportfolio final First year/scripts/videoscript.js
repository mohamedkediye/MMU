document.addEventListener("DOMContentLoaded", handleDocumentLoad)

function handleDocumentLoad ()  
{
	var video = document.getElementById ( "video" );// this is the variable for 
	var playButton = document.getElementById ( "playPause" );// this is the variable to play/pause the video
	var muteUnmuteButton = document.getElementById ("mute");// variable to mute the video
	var scrubSlider = document.getElementById ( "seekBar");// variable for scrubSlider
	var durationDisplay = document.getElementById ( "durationField");// duration display variable 
	var currentTime = document.getElementById ( "currentTime");// duration display variable 
	var volumeSlider= document.getElementById("volumeBar");// variable for the volume bar to change the volume of the video
	
	playButton.addEventListener ( "click", playPauseVideo ) ;
	video.addEventListener ("timeupdate", movePlaySlider);
	scrubSlider.addEventListener("mousedown", pauseSlider);
	scrubSlider.addEventListener("mouseup", resumeSlider);
	volumeSlider.addEventListener("change", volumeUpDownBar);
	video.addEventListener("timeupdate", PlayBackTime);
	durationDisplay.value= video.duration;
	
	
	function playPauseVideo()
	{
		if ( video.paused === true)
		{
			video.play();
			//toggle button caption
			playButton.innerHTML = "pause";
		}
		else
		{
			video.pause();
			// toggles the button caption
			playButton.innerHTML = "play";	
		} // ends Else
	}// ends playVideo function
	
	muteUnmuteButton.addEventListener ("click", muteUnmuteVideo);
	function muteUnmuteVideo()
	{
		if (video.muted == false)
		{
			video.muted = true;
			muteUnmuteButton.innerHTML = "mute"
		}
		
		else 
		{		
			video.muted = false;
		}	//ends  mute/unmute function 
		
	}
	scrubSlider.addEventListener ("change", scrubVideo);
	function scrubVideo()
	{
		 var scrubTime = video.duration * (scrubSlider.value /100);
		 var currentTime = document.getElementById ( "currentTime");
		 video.currentTime = scrubTime;
		 
	}
	function movePlaySlider()
	{
		var playbackPoint = (100/video.duration)* video.currentTime;
		scrubSlider.value = playbackPoint;
	}
	
	
	scrubSlider.addEventListener("mousedown", pauseSlider);
	scrubSlider.addEventListener("mouseup", resumeSlider);
	function pauseSlider()
	{
		video.pause();
	}
	function resumeSlider()
	{
		video.play();
	}
	
	function volumeUpDownBar()
	{
		video.volume= volumeBar.value/100;
	}
	
	video.addEventListener("durationchange", getDuration);
	function getDuration()
	{
		var durationDisplay = document.getElementById ("durationField");
		var videoDuration = video.duration ;
		
		var minutes = Math.floor(videoDuration / 60);
		var seconds = Math.floor(videoDuration % 60);
		
		if(minutes<10) minutes = "0" + minutes;
		if (seconds <10) seconds = "0" + seconds;
		durationDisplay.value = minutes + ":" + seconds;
	}
	
	video.addEventListener("currentTime", PlayBackTime);
	function currentTime()
	{
		var playbackPoint = (100/video.duration)* video.currentTime;
		
	}
	
	
	
	
}
