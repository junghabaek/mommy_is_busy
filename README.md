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
5. 

## What I learend :
1. Using Obx requires extra attention as it's prone to make errors if not used properly.
2. Firebase as nosql. Collections, docs, and streams.
3. async - await to manage the timing of methods to be called.
4. stream to subscribe data changes.
