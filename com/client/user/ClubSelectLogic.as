package com.client.user
{
	import flash.events.MouseEvent;
	import com.client.home.HomePageLogic;
	import flash.events.Event;
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	
	public class ClubSelectLogic
	{
		private var clubName:String = "";
		
		public function ClubSelectLogic(clubName)
		{
			//if we're in the 8th frame (clubs select page)
			if(ClubFair.display.currentFrame == 8) {
				this.clubName = clubName;
				loadClubInfo();
				loadPosts();
				ClubFair.display.backBTN.addEventListener(MouseEvent.CLICK, backBTNHome);
			}
		}
		function loadClubInfo() {
			ClubFair.display.clubNameInstance.clubNameTxT.text = clubName;
		}
		function loadPosts() {
			
		}
		function backBTNHome(E:MouseEvent): void {
			//go back to the home page and load the homepage code
			ClubFair.display.backBTN.removeEventListener(MouseEvent.CLICK, backBTNHome);
			ClubFair.display.gotoAndStop(7);
			new ClubsViewLogic();
		}
   }
}