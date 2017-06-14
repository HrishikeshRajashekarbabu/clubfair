package com.client.home
{
	public class HomePageLogic
	{
		public function HomePageLogic()
		{
			//if we're in frame 3, then let's get the HomePageLogic code working!
			if(ClubFair.display.currentFrame == 3)
			{
				//GUI interfaces for the home page
				ClubFair.display.welcomeTxT.text = "Welcome " + ClubFair.firstName + "!"
			}
		}
	}

}