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
		private var allowEditPost:Boolean = false;
		private var contentPane:MovieClip = null;
		private var contentPanes:Array = new Array();
		
		public function ClubSelectLogic(clubName, allowEditPost)
		{
			//if we're in the 8th frame (clubs select page)
			if(ClubFair.display.currentFrame == 8) {
				this.clubName = clubName;
				this.allowEditPost = allowEditPost;
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
				urlLoader.addEventListener(Event.COMPLETE, loadPostsResults); //load the result from the php file
		}
		function openEditPostPopUP(E:MouseEvent): void {
			contentPane = E.target.parent;
			ClubFair.display.EditPost.gotoAndPlay(2);
			ClubFair.display.EditPost.postField.editPostTitleTxT.text = contentPane.postTitleTxT.text;
			ClubFair.display.EditPost.postField.editPostContentTxT.text = contentPane.postContentTxT.text;
			
			ClubFair.display.EditPost.postField.closeEditPostBTN.addEventListener(MouseEvent.CLICK, closeEditPostPopUP);
			ClubFair.display.EditPost.postField.editPostBTN.addEventListener(MouseEvent.CLICK, editPost);
		}
		function closeEditPostPopUP(E:MouseEvent): void {
			ClubFair.display.EditPost.gotoAndPlay(ClubFair.display.EditPost.currentFrame + 1);
		}
		function editPost(E:MouseEvent): void {
				//POST variables
				var phpVars:URLVariables = new URLVariables();
				phpVars.club_name = clubName;
				phpVars.original_post_title = contentPane.postTitleTxT.text;
				phpVars.post_title = ClubFair.display.EditPost.postField.editPostTitleTxT.text;
				phpVars.post_content = ClubFair.display.EditPost.postField.editPostContentTxT.text;
	
				//send the variables to php
				var urlRequest:URLRequest = new URLRequest("http://clubfair.000webhostapp.com/edit_post.php");
				urlRequest.method = URLRequestMethod.POST;
				urlRequest.data = phpVars;
				var urlLoader:URLLoader = new URLLoader();
				urlLoader.dataFormat = URLLoaderDataFormat.VARIABLES;
				urlLoader.load(urlRequest);
				urlLoader.addEventListener(Event.COMPLETE, loadEditPostResults); //load the result from the php file
		}
		function openDeletePostPopUP(E:MouseEvent): void {
			contentPane = E.target.parent;
			ClubFair.display.DeletePost.gotoAndPlay(2);
			ClubFair.display.DeletePost.deleteField.postTitleTxT.text = contentPane.postTitleTxT.text;
			
			ClubFair.display.DeletePost.deleteField.noBTN.addEventListener(MouseEvent.CLICK, closeDeletePostPopUP);
			ClubFair.display.DeletePost.deleteField.yesBTN.addEventListener(MouseEvent.CLICK, deletePost);
		}
		function closeDeletePostPopUP(E:MouseEvent): void {
			ClubFair.display.DeletePost.gotoAndPlay(ClubFair.display.DeletePost.currentFrame + 1);
		}
		function deletePost(E:MouseEvent): void {
				//POST variables
				var phpVars:URLVariables = new URLVariables();
				phpVars.club_name = clubName;
				phpVars.post_title = contentPane.postTitleTxT.text;
				phpVars.post_content = contentPane.postContentTxT.text;
	
				//send the variables to php
				var urlRequest:URLRequest = new URLRequest("http://clubfair.000webhostapp.com/delete_post.php");
				urlRequest.method = URLRequestMethod.POST;
				urlRequest.data = phpVars;
				var urlLoader:URLLoader = new URLLoader();
				urlLoader.dataFormat = URLLoaderDataFormat.VARIABLES;
				urlLoader.load(urlRequest);
				urlLoader.addEventListener(Event.COMPLETE, loadDeletePostResults); //load the result from the php file
		}
		function backClubsView(E:MouseEvent): void {
			//go back to the home page and load the homepage code
			ClubFair.display.backBTN.removeEventListener(MouseEvent.CLICK, backClubsView);
			ClubFair.display.EditPost.postField.closeEditPostBTN.removeEventListener(MouseEvent.CLICK, closeEditPostPopUP);
			ClubFair.display.EditPost.postField.editPostBTN.removeEventListener(MouseEvent.CLICK, editPost);
			ClubFair.display.gotoAndStop(7);
			new ClubsViewLogic();
		}
		function loadPostsResults(E:Event) {
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
				
				//if we're not allowing the user to edit posts, then make the edit/delete post button false. if it is enabled, then allow us to edit/delete!
				if(allowEditPost == false) {
					contentPanes[i].editPostBTN.visible = false;
					contentPanes[i].deletePostBTN.visible = false;
				} else {
					contentPanes[i].editPostBTN.addEventListener(MouseEvent.CLICK, openEditPostPopUP);
					contentPanes[i].deletePostBTN.addEventListener(MouseEvent.CLICK, openDeletePostPopUP);
				}
				
				contentPanes[i].postTitleTxT.text = String(resultData.post_info[i].post_title);
				contentPanes[i].postDateTxT.text = String(resultData.post_info[i].post_date);
				contentPanes[i].postContentTxT.text = String(resultData.post_info[i].post_content)
				
				ClubFair.display.scrollContent.contentPostsPane.addChild(contentPanes[i]);
			}
		}
		function loadEditPostResults(E:Event): void {
			var resultMessage:String = String(E.target.data.result_message);
			trace("[ClubFair] " + resultMessage);
			ClubFair.display.Warning.warningField.textInfo.text = resultMessage;
			ClubFair.display.Warning.gotoAndPlay(2)
			
			//if the result message contains "successfully logged in", then edit the post text!
			if(resultMessage.indexOf("Successfully edited") == 0) {
				contentPane.postTitleTxT.text = ClubFair.display.EditPost.postField.editPostTitleTxT.text;
				contentPane.postContentTxT.text = ClubFair.display.EditPost.postField.editPostContentTxT.text;
			}
		}
		function loadDeletePostResults(E:Event): void {
			var resultMessage:String = String(E.target.data.result_message);
			trace("[ClubFair] " + resultMessage);
			ClubFair.display.Warning.warningField.textInfo.text = resultMessage;
			ClubFair.display.Warning.gotoAndPlay(2)
			
			//close the popup
			ClubFair.display.DeletePost.gotoAndPlay(ClubFair.display.DeletePost.currentFrame + 1);
			
			//if the result message contains "successfully logged in", then delete the post text!
			if(resultMessage.indexOf("Successfully deleted") == 0) {
			contentPane.visible = false;
			}
		}
   }
}