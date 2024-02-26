# Nourish Ninja

Nourish Ninja is the first AI powered nutrition app which is your personal nutrition coach and personal dietician!

This was made for GDSC Solution Challenge!!!

Video: https://youtu.be/x2Q5wAbd_ng

## Installation


```bash
flutter create .
```

Replace the android/app/build.gradle with the build.gradle replacement_files/build.gradle

Replace the android/build.gradle with the android.gradle in replacement_files/android.gradle

Replace the android/app/main/src/main/AndroidManifest.xml with the AndroidManifest.xml replacement_files/AndroidManifest.xml

Add a ".env" file in the directory of the folder in the format:

```dart
API_KEY="INSERT_GEMINI_PRO_API_KEY"
SPOONACULAR="INSERT_SPOONACULAR_API_KEY"
```

## Usage

```bash
flutter run
```

While running make sure you have google health connect installed on your device and make sure you request for permissions before clicking "Get Records" to move to the main feature of the app!

Make sure that you press the apple icon to take images of the reciept and click on the plus icon to take the images of the food to add to your database on firebase!

# Technical Architechture

<img src="https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white"> <img src="https://img.shields.io/badge/firebase-%23039BE5.svg?style=for-the-badge&logo=firebase"> <img src="https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white"> <img src="https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white">



# Future Plans

Adding Notifications to remind user what to eat throughut the day. 

Fixing some of the bugs which are present along with the colour scheme.

Making the app a lot smoother by moving a lot more processes on the cloud.

Changing my file structure to make it easier to read!


## Contributing

Pull requests are welcome. For major changes, please open an issue first
to discuss what you would like to change.

Please make sure to update tests as appropriate.
