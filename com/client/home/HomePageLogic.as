package com.client.home
{
	import flash.events.MouseEvent;
	import com.client.club.ClubLogin;
	import com.client.club.ClubRegistration;
	
	public class HomePageLogic
	{
		public function HomePageLogic()
		{
			//if we're in frame 3, then let's get the HomePageLogic code working!
			if(ClubFair.display.currentFrame == 3)
			{
				ClubFair.display.loginBTN.addEventListener(MouseEvent.CLICK, gotoAdminLoginClub);
				ClubFair.display.registerBTN.addEventListener(MouseEvent.CLICK, registerClub);
				ClubFair.display.clubsBTN.addEventListener(MouseEvent.CLICK, seeClubs);
			}
		}
		public function gotoAdminLoginClub(E:MouseEvent): void {
			ClubFair.display.gotoAndStop(4);
			new ClubLogin();
		}
		public function registerClub(E:MouseEvent): void {
			ClubFair.display.gotoAndStop(5);
			new ClubRegistration();
		}
		public function seeClubs(E:MouseEvent): void {
			
		}
	}

}