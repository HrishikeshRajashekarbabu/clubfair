package com.client.saving
{
	public class SaveData
	{
		public function SaveData()
		{
			//save the neccessary variables
			ClubFair.ClubFairData.data.firstName = ClubFair.firstName;
			ClubFair.ClubFairData.data.lastName = ClubFair.lastName;
			ClubFair.ClubFairData.flush();
		}
	}

}