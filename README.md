<h1 align="center">Mediminder</h1>

<div align="center">
  <strong>An Offline Medicine Reminder</strong>
</div>
<div align="center">
  Built with Flutter, Provider and BLoC pattern
</div>

## Key Features
* __Homepage medicine list__ 
  * Homepage containing all the registered Mediminders
* __Shared preference data storage__ 
  * Storing medicine objects in shared preference
  * Medicine list retrieval upon application launch
  * JSON encoding and decoding
* __Adding new Mediminder, details include:__ 
  * Medicine name
  * Dosage in milligrams
  * Medicine icon selection (Optional)
  * Reminder interval selection
  * Starting time using Time Picker
* __Notification reminding__
  * Usage of Local Notifications to display Mediminders
  * Randomly-generated IDs for each notification
  * Daily reminders with set intervals, based on user preference
* __Registeration error checking__ 
  * Name duplication check
  * Empty/not specified fields check
  * Medicine type is optional
* __Individual medicine detail page__ 
  * In-depth details about each Mediminder upon tapping
* __Delete a Mediminder:__ 
  * Erase the specified medicine object from shared preference and list
  * Erase corresponding scheduled notifications 


# Screenshots
<pre>
<img src="screenshots/Mediminder_Home Screen.jpg" width="250"> <img src="screenshots/Mediminder_Register Screen.jpg" width="250"> <img src="screenshots/Mediminder_ Register Error.jpg" width="250"> <img src="screenshots/Mediminder_Time Picker.jpg" width="250"> <img src="screenshots/Mediminder_Data Filled.jpg" width="250"> <img src="screenshots/Mediminder_Register Success.jpg" width="250"> <img src="screenshots/Mediminder_Home Screen with Medicine.jpg" width="250"> <img src="screenshots/Mediminder_Details Screen.jpg" width="250">  

</pre>

