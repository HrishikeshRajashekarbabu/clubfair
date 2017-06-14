package com.client.loading
{
	import com.client.home.NewUserLogic;
	import com.client.home.HomePageLogic;

	public class LoadData
	{
		public function LoadData()
		{
			//check if the person ever registered a first name. if they never registered a first name, then they're a new user.
			if(ClubFair.ClubFairData.data.firstName == undefined) {
				trace("This is a new user - make the person go to the second page.");
				ClubFair.display.gotoAndStop(2);
				new NewUserLogic();
			} else {
				//else, the user has already registered their information and is ready to load the home page!
				ClubFair.firstName = ClubFair.ClubFairData.data.firstName;
				ClubFair.lastName = ClubFair.ClubFairData.data.lastName;
				ClubFair.display.gotoAndStop(3);
				new HomePageLogic();
			}
		}
	}

}