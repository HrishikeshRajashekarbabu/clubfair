package com.client.user
{
	import flash.events.MouseEvent;
	import com.client.home.HomePageLogic;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.events.Event;
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import com.client.saving.SaveData;
	
	public class ClubsViewLogic
	{
		private var contentPanes:Array = new Array();
		
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
				//load the load_clubs.php file
				var urlRequest:URLRequest = new URLRequest("http://clubfair.000webhostapp.com/load_clubs.php");
				var urlLoader:URLLoader = new URLLoader();
				urlLoader.load(urlRequest);
				urlLoader.addEventListener(Event.COMPLETE, loadClubResults); //load the result from the php file
		}
		function viewFeed(E:MouseEvent): void {
			
		}
		function backBTNHome(E:MouseEvent): void {
			//go back to the home page and load the homepage code
			ClubFair.display.viewFeedBTN.removeEventListener(MouseEvent.CLICK, viewFeed);
			ClubFair.display.backBTN.removeEventListener(MouseEvent.CLICK, backBTNHome);
			ClubFair.display.gotoAndStop(3);
			new HomePageLogic();
		}
		function clickedClub(E:TouchEvent): void {
			var clubTitle:String = E.target.parent.clubTitleTxT.text;
			var clubBio:String = E.target.parent.clubBioTxT.text;
			ClubFair.display.viewFeedBTN.removeEventListener(MouseEvent.CLICK, viewFeed);
			ClubFair.display.backBTN.removeEventListener(MouseEvent.CLICK, backBTNHome);
			ClubFair.display.gotoAndStop(8);
			new ClubSelectLogic(clubTitle, clubBio);
			trace("[ClubFair] Now viewing " + clubTitle);
		}
		function subscribe(E:TouchEvent): void {
			var clubContent:MovieClip = E.target.parent;
			//add or delete the club as subscribed
			if(clubContent.subscribeBTN.currentFrame == 1) {
				ClubFair.subscribedClubs.push(clubContent.clubTitleTxT.text);
				clubContent.subscribeBTN.gotoAndStop(2);
			} else if(clubContent.subscribeBTN.currentFrame == 2) {
				for (var i:Number=0; i < ClubFair.subscribedClubs.length; i++){
					//if we find the name of the club, then remove its index
					if(ClubFair.subscribedClubs[i] == clubContent.clubTitleTxT.text)
					ClubFair.subscribedClubs.removeAt(i);
					clubContent.subscribeBTN.gotoAndStop(1);
				}
			}
			new SaveData();
		}
		function loadClubResults(E:Event): void {
			var resultData:Object = JSON.parse(E.target.data);
			//add new childs of the club content panes
			for (var i:Number=0; i < resultData.club_info.length; i++){
				resultData.club_info[i].club_name
				contentPanes.push(new clubViewBox());
				contentPanes[i].x = 205.85;
				//if this is not the first contentPane, then increment the y by 220 from the previous contentpane
				if(i != 0) {
				contentPanes[i].y = contentPanes[i-1].y + 220;
				} else {
					contentPanes[i].y = 100;
				}
				contentPanes[i].clubTitleTxT.text = String(resultData.club_info[i].club_name);
				contentPanes[i].clubBioTxT.text = String(resultData.club_info[i].club_bio)
				
				//check if the club is subscribed, but first make sure we're not dealing with a null array
				if(ClubFair.subscribedClubs == null) {
					ClubFair.subscribedClubs = [];
					new SaveData();
				} else {
				for (var i2:Number=0; i2 < ClubFair.subscribedClubs.length; i2++){
					//if we find the name of the club, then count it as subscribed!
					if(ClubFair.subscribedClubs[i2] == contentPanes[i].clubTitleTxT.text) {
						contentPanes[i].subscribeBTN.gotoAndStop(2);
					}
				}
				}
				
				//touch event gestures are good to use when scrolling and hovering over buttons
				Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
				contentPanes[i].clickClubBTN.addEventListener(TouchEvent.TOUCH_TAP, clickedClub);
				contentPanes[i].subscribeBTN.addEventListener(TouchEvent.TOUCH_TAP, subscribe);
				
				ClubFair.display.scrollContent.contentPane.addChild(contentPanes[i]);
			}
		}
   }
}