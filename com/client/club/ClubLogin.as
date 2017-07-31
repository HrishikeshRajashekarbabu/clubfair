package com.client.club
{
	import flash.events.MouseEvent;
	import com.client.home.HomePageLogic;
	import flash.events.Event;
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import com.client.saving.SaveData;
	
	public class ClubLogin
	{
		public function ClubLogin()
		{
			//if we're in the 4th frame (login page)
			if(ClubFair.display.currentFrame == 4) {
				//make sure the text boxes are blank when first loading the page
				ClubFair.display.clubNameTxT.text = "";
				ClubFair.display.clubPasswordTxT.text = "";
				
				//if the user decided to "remember login details"
				if(ClubFair.rememberDetails && (ClubFair.clubName != null && ClubFair.clubName != "") && (ClubFair.clubPassword != null && ClubFair.clubName != "")) {
					trace("[ClubFair] Loading saved club name and password.");
					ClubFair.display.rememberLoginBTN.gotoAndStop(2);
					ClubFair.display.clubNameTxT.text = ClubFair.clubName;
					ClubFair.display.clubPasswordTxT.text = ClubFair.clubPassword;
				} else {
					ClubFair.display.rememberLoginBTN.gotoAndStop(1);
					trace("[ClubFair] User did not remember the club name and password.");
					ClubFair.display.clubNameTxT.text = "";
					ClubFair.display.clubPasswordTxT.text = "";
				}
				
				ClubFair.display.addEventListener(Event.ENTER_FRAME, updatePlaceHolderText);
				ClubFair.display.rememberLoginBTN.addEventListener(MouseEvent.CLICK, rememberDetails);
				ClubFair.display.backBTN.addEventListener(MouseEvent.CLICK, backBTNHome);
				ClubFair.display.loginBTN.addEventListener(MouseEvent.CLICK, loginClub);
			}
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
		}
		function rememberDetails(E:MouseEvent): void {
			if(ClubFair.display.rememberLoginBTN.currentFrame == 1) {
				//enable the remember login details
				ClubFair.display.rememberLoginBTN.gotoAndStop(2);
				ClubFair.rememberDetails = true;
				ClubFair.clubName = ClubFair.display.clubNameTxT.text;
				ClubFair.clubPassword = ClubFair.display.clubPasswordTxT.text;
				new SaveData();
			} else if(ClubFair.display.rememberLoginBTN.currentFrame == 2) {
				//disable the remember login details
				ClubFair.display.rememberLoginBTN.gotoAndStop(1);
				ClubFair.rememberDetails = false;
				ClubFair.clubName = "";
				ClubFair.clubPassword = "";
				new SaveData()
			}
		}
		function backBTNHome(E:MouseEvent): void {
			//go back to the home page and load the homepage code
			ClubFair.display.removeEventListener(Event.ENTER_FRAME, updatePlaceHolderText);
			ClubFair.display.rememberLoginBTN.removeEventListener(MouseEvent.CLICK, rememberDetails);
			ClubFair.display.backBTN.removeEventListener(MouseEvent.CLICK, backBTNHome);
			ClubFair.display.loginBTN.removeEventListener(MouseEvent.CLICK, loginClub);
			ClubFair.display.gotoAndStop(3);
			new HomePageLogic();
		}
		function loginClub(E:MouseEvent): void {
			if(ClubFair.display.clubNameTxT.text != "" && ClubFair.display.clubPasswordTxT.text != "") {
				//POST variables
				var phpVars:URLVariables = new URLVariables();
				phpVars.club_name = ClubFair.display.clubNameTxT.text;
				phpVars.club_password = ClubFair.display.clubPasswordTxT.text;
	
				//send the variables to php
				var urlRequest:URLRequest = new URLRequest("http://clubfair.000webhostapp.com/login_club.php");
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
			var resultMessage:String = String(E.target.data.result_message);
			trace("[ClubFair] " + resultMessage);
			ClubFair.display.Warning.warningField.textInfo.text = resultMessage;
			ClubFair.display.Warning.gotoAndPlay(2);
			
			//if the result message contains "successfully logged in", then login the user!
			if(resultMessage.indexOf("Successfully logged in") == 0) {
				//if we chose to remember the details, then let's remember the login details for next time!
				if(ClubFair.rememberDetails) {
					trace("[ClubFair] Saving details for next login session.");
					ClubFair.clubName = ClubFair.display.clubNameTxT.text;
					ClubFair.clubPassword = ClubFair.display.clubPasswordTxT.text;
					new SaveData();
				}
				
				ClubFair.display.removeEventListener(Event.ENTER_FRAME, updatePlaceHolderText);
				ClubFair.display.backBTN.removeEventListener(MouseEvent.CLICK, backBTNHome);
				ClubFair.display.loginBTN.removeEventListener(MouseEvent.CLICK, loginClub);
				ClubPageLogic.clubName = ClubFair.display.clubNameTxT.text; //set the clubname in the logic class
				ClubPageLogic.clubPassword = ClubFair.display.clubPasswordTxT.text; //set the clubpassword in the logic class
				ClubPageLogic.clubBio = String(E.target.data.club_bio); //set the clubbio in the logic class
				ClubFair.display.gotoAndStop(6);
				new ClubPageLogic();
			}
		}
   }
}