package com.client.home
{
	import flash.events.MouseEvent;
	import com.client.saving.SaveData;
	public class NewUserLogic
	{
		public function NewUserLogic()
		{
			//if we're in frame 2, then let's get the NewUserLogic code working!
			if(ClubFair.display.currentFrame == 2)
			{
				ClubFair.display.submitBTN.addEventListener(MouseEvent.CLICK, registerUserInformation);
			}
			function registerUserInformation(E:MouseEvent): void {
				//check if the first name or last name texts were blank
				if(ClubFair.display.firstNameTxT.text == "")
				{
					trace("Failed to input first name!");
					ClubFair.display.Warning.warningField.textInfo.text = "Please input your first name.";
					ClubFair.display.Warning.gotoAndPlay(2);
					trace(ClubFair.display.Warning.warningField.textInfo.text);
				} else if(ClubFair.display.lastNameTxT.text == "")
				{
					trace("Failed to input last name!");
					ClubFair.display.Warning.warningField.textInfo.text = "Please input your last name.";
					ClubFair.display.Warning.gotoAndPlay(2);
				} else
				{ //else, the player has correctly put in their register details and the info. will now be saved!
					ClubFair.firstName = ClubFair.display.firstNameTxT.text;
					ClubFair.lastName = ClubFair.display.lastNameTxT.text;
					ClubFair.display.submitBTN.removeEventListener(MouseEvent.CLICK, registerUserInformation);
					new SaveData();
					ClubFair.display.gotoAndStop(3);
					new HomePageLogic();
				}
			}
		}
	}

}