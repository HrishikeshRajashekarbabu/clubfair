package com.client.club
{
	import flash.events.MouseEvent;
	import com.client.home.HomePageLogic;
	import flash.events.Event;
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import com.client.saving.SaveData;
	
	public class ClubPageLogic
	{
		public static var clubName:String = "";
		public static var clubPassword:String = "";
		public static var clubBio:String = "";
		
		public function ClubPageLogic()
		{
			//if we're in the 6th frame (club page)
			if(ClubFair.display.currentFrame == 6) {
				loadClubInfo();
				ClubFair.display.addEventListener(Event.ENTER_FRAME, updatePlaceHolderText);
				ClubFair.display.backBTN.addEventListener(MouseEvent.CLICK, backBTNHome);
				ClubFair.display.updateBTN.addEventListener(MouseEvent.CLICK, updateClub);
			}
		}
		function loadClubInfo() {
			ClubFair.display.clubNameTxT.text = clubName;
			ClubFair.display.clubPasswordTxT.text = clubPassword;
			ClubFair.display.clubNameInstance.clubNameTxT.text = clubName;
			ClubFair.display.clubBioTxT.text = clubBio;
		}
		function updatePlaceHolderText(E:Event): void {
				//whenever the text is not blank in the text boxes, then don't show the placeholder text
				if(ClubFair.display.clubNameTxT.text != "") {
					ClubFair.display.clubNamePlaceHolder.visible = false;
				} else {
					ClubFair.display.clubNamePlaceHolder.visible = true;
				}
				if(ClubFair.display.clubPasswordTxT.text != "") {
					ClubFair.display.clubPasswordPlaceHolder.visible = false;
				} else {
					ClubFair.display.clubPasswordPlaceHolder.visible = true;
				}
				if(ClubFair.display.clubBioTxT.text != "") {
					ClubFair.display.clubDescPlaceHolder.visible = false;
				} else {
					ClubFair.display.clubDescPlaceHolder.visible = true;
				}
		}
		function backBTNHome(E:MouseEvent): void {
			//go back to the home page and load the homepage code
			ClubFair.display.removeEventListener(Event.ENTER_FRAME, updatePlaceHolderText);
			ClubFair.display.backBTN.removeEventListener(MouseEvent.CLICK, backBTNHome);
			ClubFair.display.gotoAndStop(3);
			new HomePageLogic();
		}
		function updateClub(E:MouseEvent) { 
				if(ClubFair.display.clubNameTxT.text != "" && ClubFair.display.clubPasswordTxT.text != "" && ClubFair.display.clubBioTxT.text != "") {
				//POST variables
				var phpVars:URLVariables = new URLVariables();
				phpVars.original_club_name = clubName;
				phpVars.club_name = ClubFair.display.clubNameTxT.text;
				phpVars.club_password = ClubFair.display.clubPasswordTxT.text;
				phpVars.club_bio = ClubFair.display.clubBioTxT.text;
	
				//send the variables to php
				var urlRequest:URLRequest = new URLRequest("http://clubfair.000webhostapp.com/update_club.php");
				urlRequest.method = URLRequestMethod.POST;
				urlRequest.data = phpVars;
				var urlLoader:URLLoader = new URLLoader();
				urlLoader.dataFormat = URLLoaderDataFormat.VARIABLES;
				urlLoader.load(urlRequest);
				urlLoader.addEventListener(Event.COMPLETE, loadResults); //load the result from the php file
			} else {
				trace("[ClubFair] Failed to fill out all fields!");
				ClubFair.display.Warning.warningField.textInfo.text = "Please fill out all fields!";
				ClubFair.display.Warning.gotoAndPlay(2);
			}
		}
		function loadResults(E:Event) {
			var resultMessage = "" + E.target.data.result_message;
			trace("[ClubFair] " + resultMessage);
			ClubFair.display.Warning.warningField.textInfo.text = resultMessage;
			ClubFair.display.Warning.gotoAndPlay(2);
			
			//if the result message contains "successfully updated", then update the user's information!
			if(resultMessage.indexOf("Successfully updated") == 0) {
				clubName = ClubFair.display.clubNameTxT.text;
				clubPassword = ClubFair.display.clubPasswordTxT.text;
				clubBio = ClubFair.display.clubBioTxT.text;
				ClubFair.display.clubNameInstance.clubNameTxT.text = clubName;
				//if we decided to "remember details", then update it for the next login!
				if(ClubFair.rememberDetails) {
					ClubFair.clubName = ClubFair.display.clubNameTxT.text;
					ClubFair.clubPassword = ClubFair.display.clubPasswordTxT.text;
					new SaveData();
				}
			}
		}
   }
}