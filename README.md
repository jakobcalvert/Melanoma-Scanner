# MelanomaScannerApp
 
The application developed is able to scan images of suspicious skin regions taken from the camera or photo library on android and ios devices and analyse the image detecting likelihood of melanoma. It grades it in three risk categories with a traffic light system Low, Medium and High risk. Once diagnosed the user has the ability to save the results to a mongo db server and view all previous saved diagnoses.

Features Developed:
- Image Selection and Capture:
Implemented an image selection tool in Flutter that allows users to take or select an image on any platform.
- MobileNetV2 Model:
Trained a MobileNetV2 model on 10,000 existing skin images with known diagnoses, achieving over _____ accuracy.
- Real-Time Model Execution and Results:
Executing the model in the app in under ___ ms, implemented through the use of TensorFlow.
- Diagnosis Output and Results:
Classifies the results into 3 different risk grades, recommending further action for high and medium-risk spots.
- Basic saving and Retrieving Previous Diagnoses:
Saves previous diagnoses to a MongoDB server for later retrieval and outputs all previous results onto a results screen.


Steps for installing and running code 

To run application flutter must already be installed on device instructions can be found here https://docs.flutter.dev/get-started/install

Steps:
1. Clone github repo on device and navigate to Repo
2. Ensure flutter is installed and set up properly - run command “flutter doctor” to ensure setup is correct
3. Ensure a working android or iphone emulator is installed - run command “flutter devices” to make sure the device is showing up correctly. Using android studio or Xcode for emulation is recommended.
4. Use the command “flutter run” to finally run the program. In the case of dependency issues run commands “flutter clean” then “flutter pub get” to ensure correct dependencies are installed and working.

MongoDB server may not work due to hosting restrictions and IP blocks. Application will work without but will not have the ability to save and access previously saved images unless the server URI is swapped in the lib/model/server.dart file.
