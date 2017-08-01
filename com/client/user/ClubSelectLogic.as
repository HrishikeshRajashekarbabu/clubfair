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
		private var contentPanes:Array = new Array();
		
		public function ClubSelectLogic(clubName)
		{
			//if we're in the 8th frame (clubs select page)
			if(ClubFair.display.currentFrame == 8) {
				this.clubName = clubName;
				ClubFair.display.clubNameInstance.clubNameTxT.text = clubName;
				ClubFair.display.backBTN.addEventListener(MouseEvent.CLICK, backClubsView);
				loadPosts();
			}
		}
		function loadPosts() {
				//POST variables
				var phpVars:URLVariables = new URLVariables();
				phpVars.club_name = clubName;
	
				//send the variables to php
				var urlRequest:URLRequest = new URLRequest("http://clubfair.000webhostapp.com/load_posts.php");
				urlRequest.method = URLRequestMethod.POST;
				urlRequest.data = phpVars;
				var urlLoader:URLLoader = new URLLoader();
				urlLoader.load(urlRequest);
				urlLoader.addEventListener(Event.COMPLETE, loadResults); //load the result from the php file
		}
		function backClubsView(E:MouseEvent): void {
			//go back to the home page and load the homepage code
			ClubFair.display.backBTN.removeEventListener(MouseEvent.CLICK, backClubsView);
			ClubFair.display.gotoAndStop(7);
			new ClubsViewLogic();
		}
		function loadResults(E:Event) {
			var resultData:Object = JSON.parse(E.target.data);
			//add new childs of the post content panes
			for (var i:Number=0; i < resultData.post_info.length; i++){
				contentPanes.push(new clubPostBox());
				contentPanes[i].x = 205.85;
				//if this is not the first contentPane, then increment the y by 250 from the previous contentpane
				if(i != 0) {
				contentPanes[i].y = contentPanes[i-1].y + 250;
				} else {
					contentPanes[i].y = 100;
				}
				contentPanes[i].postTitleTxT.text = String(resultData.post_info[i].post_title);
				contentPanes[i].postDateTxT.text = String(resultData.post_info[i].post_date);
				contentPanes[i].postContentTxT.text = String(resultData.post_info[i].post_content)
				
				ClubFair.display.scrollContent.contentPostsPane.addChild(contentPanes[i]);
			}
		}
   }
}