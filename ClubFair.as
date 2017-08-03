package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.Stage;
	import com.client.loading.*;
	import flash.net.SharedObject;
	import com.client.saving.SaveData;

	public class ClubFair extends MovieClip
	{
		private static var _display:MovieClip;
		private static var _stage:Stage;
		
		//locally saved variables using SharedObject
		public static var firstName:String = "";
		public static var lastName:String = "";
		public static var rememberDetails:Boolean = false;
		public static var clubName:String = "";
		public static var clubPassword:String = "";
		public static var subscribedClubs:Array = [];
		public static var closedTime:Number = new Date().time;
		public static var ClubFairData:SharedObject = SharedObject.getLocal("ClubFair");

		/* use getters instead of public static vars so they
		/ cannot be reset outside of ClubFair */
		public static function get display():MovieClip
		{
			return _display;
		}

		public static function get stage():Stage
		{
			return _stage;
		}
		public function ClubFair()
		{
		   	//now the ClubFair class is the stage and display (now we can access certain instance names in other classes)
			ClubFair._display = this;
			ClubFair._stage = stage;
			
			stage.addEventListener(Event.DEACTIVATE, onDeactivate);
		   
		   //load the mobile app. the moment we open it
		   new LoadGame();
		}
		public function onDeactivate(E:Event): void {
			//whenever the user exits the app
			closedTime = new Date().time;
			new SaveData();
			trace("[ClubFair] Deactivating ClubFair at time " + closedTime + ".");
		}
	}

}