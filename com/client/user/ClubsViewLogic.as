package com.client.user
{
	import flash.events.MouseEvent;
	import com.client.home.HomePageLogic;
	import flash.events.Event;
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	
	public class ClubsViewLogic
	{
		public function ClubsViewLogic()
		{
			//if we're in the 7th frame (clubs view page)
			if(ClubFair.display.currentFrame == 7) {
				ClubFair.display.chooseClub.visible = false;
				loadClubs();
				ClubFair.display.viewFeedBTN.addEventListener(MouseEvent.CLICK, viewFeed);
				ClubFair.display.backBTN.addEventListener(MouseEvent.CLICK, backBTNHome);
			}
		}
		function loadClubs() {
			
		}
		function viewFeed(E:MouseEvent): void {
			
		}
		function backBTNHome(E:MouseEvent): void {
			//go back to the home page and load the homepage code
			ClubFair.display.backBTN.removeEventListener(MouseEvent.CLICK, backBTNHome);
			ClubFair.display.gotoAndStop(3);
			new HomePageLogic();
		}
   }
}