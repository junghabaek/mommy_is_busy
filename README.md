# mommy_is_busy (Flutter)

# Project Description
## Objectives:
1. To make it easy to manage daily tasks by only using the deadline.
2. To make it easy to manage what's in the fridge and share it among family (or any other group) members.

## Technologies:
1. GetX - to manage the state and to implement the MVVM pattern.
2. Firebase - NoSQL database.
3. FireAuth - delegation of authentication.
4. Stream - update real-time data and share it with the group members.

## Challenges:
1. DateTime conversion - this was especially challenging without knowing what UTC time looks like (it has 'Z' at the end where localtime does not). In addition, when uploading to Firebase, the local datetime gets read as UTC time, resulting in an existing time difference of 9 hours. So I had to manually subtract 9 hours to resolve this.
2. GetX - `state()` or `markNeedsBuild()` called during build `Obx` error has occurred. With a deeper understanding of GetX, this was resolved by removing unnecessary `Obx` widget.
3. GetX - the use of `.value` when referencing `Rx` objects. I did not know this and spent a long time figuring out what was wrong.
4. StatefulBuilder - when prompting data from the user in `showDialog`, I didn't know I had to use `StatefulBuilder`.
5. Real-time update of TextFormField - this was resolved by using both stream and `Obx` in the same widget.

## What I learned:
1. Using `Obx` requires extra attention as it's prone to make errors if not used properly.
2. Firebase as NoSQL. Collections, docs, and streams.
3. `async` - `await` to manage the timing of methods to be called.
4. Stream to subscribe to data changes.

## Features to be added:
1. Household account feature

## Dependencies used from Flutter pub:
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

## Installation:
**This app was not tested on iOS.**
**AVD API34 was used.**

1. Download the project.
2. Build with Android Studio.
3. Run with your AVD.

# How to use
[Demo clip](https://www.youtube.com/watch?v=pxjz-g9Lcgk&ab_channel=JungHaBaek)  
The navigator has four icons: home, calendar, food bank, settings.
1. Home: It shows the deadlines of the selected day. When each deadline is clicked, the new page shows tasks to be finished. Users can swipe to the left to delete the task. An undo button will appear from the bottom.
2. Calendar: Users can select a day from the calendar. Clicking the add button on the bottom right will show a popup where users can type tasks and pick the time.
3. Food Bank: Users can use toggle buttons to save whether the user has food in the fridge. Users can take a short memo as well. This screen can be shared among the other users who acquired a connection code from a user.
4. Settings: Users can acquire a connection code so that they can share the fridge screen.
