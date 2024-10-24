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
