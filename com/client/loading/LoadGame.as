package com.client.loading
{
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.Event;

	public class LoadGame
	{
		public function LoadGame()
		{
			//add an event listener
			ClubFair.display.addEventListener(Event.ENTER_FRAME, LoadGamePage);
		}
		
		public function LoadGamePage(E:Event):void
		{
			var total:Number = ClubFair.display.loaderInfo.bytesTotal;
			var loaded:Number = ClubFair.display.loaderInfo.bytesLoaded;
			
			//once the game has loaded the bytes
			if (total == loaded) {
				trace("[ClubFair] Loaded the mobile application!");
				ClubFair.display.removeEventListener(Event.ENTER_FRAME, LoadGamePage);
				
				//now load all the SharedObject data from the user
				new LoadData();
			}
		}
	}

}