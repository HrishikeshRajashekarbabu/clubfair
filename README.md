![Alt text](/rsrc/icon72x72.png)
# About
ClubFair is a mobile application created by
- Pravat Bhusal(Server-side and Client-side Developer)
- Rohith Rajashekarbabu(Server-side Developer)
- Hrishikesh Rajashekarbabu (Client-side Developer)
- Mustafa Amir(Graphic Designer)

Its purpose is to help students organize their club activities at Uplift North Hills Preperatory.

# Technologies
- Actionscript: Client and Front-end language
- PHP: Back-end language
- MySQL: Database

# Setting-up The Database
- First, go to the com folder and find the database.sql file
- Second, import the database.sql file into SQL and it should import the neccessary tables and columns in a new SQL database
- Third, go to the com/server folder and then open the dbconnection.php
- Fourth, Configure the host, sqluser, sqlpassword, and dbusername variables then save and exit the dbconnection.php file
- Fifth, Now put all the files inside com/server into your Apache web-server
- Sixth, now go to the  com/client folder (this folder contains all the Actionscript files)
- Seventh, edit all the URLRequest URLs within the Actionscript files to the php URLs of your web-server
- Finally, open the ClubFair.fla file in Adobe Flash or Animate and test the application.
