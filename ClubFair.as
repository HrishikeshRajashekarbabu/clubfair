package 
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import com.client.loading.*;
	import flash.net.SharedObject;

	public class ClubFair extends MovieClip
	{
		private static var _display:MovieClip;
		private static var _stage:Stage;
		
		public static var firstName:String = "";
		public static var lastName:String = "";
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
		   
		   //load the mobile app. the moment we open it
		   new LoadGame();
		}
	}

}