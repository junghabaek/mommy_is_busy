# mommy_is_busy (flutter)

# Project Description
## Objectives :
1. to make it easy to manage daily task by only using the deadline.
2. to make it easy to manage what's in the fridge and share among family (or any other group) members.

## Technologies :
1. GetX - to manage the state and to implement the MVVM pattern.
2. Firebase - nosql database.
3. FireAuth - delegation of authentication.
4. stream - update real-time data and share with the group members.

## Challenges :
1. DateTime conversion - this was especially challenging without knowing what utc time look like (it has z at the end where localtime does not). In addition, when uploading firebase, the local datetime gets read as utc time and therefore existed time difference of 9 hours. So I had to manually subtract 9 hours to resolve this.
2. GetX - state() or markneedsbuild() called during build obx error has occured. With deeper understanding about GetX, this was resolved.
3. GetX - the use of .value when refreencing to Rx objects. I did not know this and spent a long time to figure out what was wrong.
4. StatefulBuilder - when prompting data from user in showdialog, I didn't know I had to use StatefulBuilder.
5. real-time update of TextFormField - this was resolved by using both stream and Obx at the same widget.

## What I learend :
1. Using Obx requires extra attention as it's prone to make errors if not used properly.
2. Firebase as nosql. Collections, docs, and streams.
3. async - await to manage the timing of methods to be called.
4. stream to subscribe data changes.

## Features to be added :
1. household account feature

## dependencies used from flutter pub :
cupertino_icons: ^1.0.2  
intl: ^0.18.1  
http: ^1.0.0  
timer_builder: ^2.0.0  
table_calendar: ^3.0.9  
interval_time_picker: ^2.0.0+5  
get:  
firebase_auth: ^4.6.3  
firebase_core: ^2.14.0  
cloud_firestore: ^4.8.2  
fluttertoast: ^8.2.2  
timezone: any  
shared_preferences: ^2.2.0  

## Installation :
** this app was not tested on iOS
** AVD API34 was used.

1. download the project.
2. build with android studio.
3. run with your avd.

# How to use
[Demo clip](https://www.youtube.com/watch?v=pxjz-g9Lcgk&ab_channel=JungHaBaek)
the navigator as four icons : home, calendar, foodbank, settings
1. Home : it shows the deadlines of selected day. When each deadline is clicked, the new page shows tasks to be finished. Users can swipe to the left to delete the task. An undo button will appear from the bottom.
2. Calendar : users can select a day from the calendar. Clicking add button on the right bottom will show a popup where users can type tasks and pick time.
3. foodbank : users can use toggle buttons to save whether the user has food in the fridge. Users can take a short memo as well. This screen can be shared among the other users who acquired connection code from a user.
4. settings : users can acquire connection code so that they can share the fridge screen.

