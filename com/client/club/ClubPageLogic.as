package com.client.club
{
	import flash.events.MouseEvent;
	import com.client.home.HomePageLogic;
	import flash.events.Event;
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	
	public class ClubPageLogic
	{
		public static var clubName:String;
		public static var clubPassword:String;
		public static var clubBio:String;
		
		public function ClubPageLogic()
		{
			//if we're in the 6th frame (club page)
			if(ClubFair.display.currentFrame == 6) {
				ClubFair.display.clubNameInstance.clubNameTxT.text = clubName;
			}
		}
   }
}