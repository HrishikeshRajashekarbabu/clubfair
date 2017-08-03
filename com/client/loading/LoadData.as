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
				trace("[ClubFair] This is a new user - make the person go to the register page.");
				ClubFair.display.gotoAndStop(2);
				new NewUserLogic();
			} else {
				//else, the user has already registered their information and is ready to load the home page!
				ClubFair.firstName = ClubFair.ClubFairData.data.firstName;
				ClubFair.lastName = ClubFair.ClubFairData.data.lastName;
				ClubFair.rememberDetails = ClubFair.ClubFairData.data.rememberDetails;
				ClubFair.clubName = ClubFair.ClubFairData.data.clubName;
				ClubFair.clubPassword = ClubFair.ClubFairData.data.clubPassword;
				ClubFair.subscribedClubs = ClubFair.ClubFairData.data.subscribedClubs;
				ClubFair.closedTime = ClubFair.ClubFairData.data.closedTime;
				ClubFair.display.gotoAndStop(3);
				new HomePageLogic();
				trace("[ClubFair] Logging in as " + ClubFair.firstName + " " + ClubFair.lastName + "!");
			}
		}
	}

}