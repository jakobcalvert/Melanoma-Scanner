import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:path_provider/path_provider.dart';

class ServerManager {
  static final ServerManager _instance = ServerManager._internal();
  static Db? _db;
  static DbCollection? _collection;

  factory ServerManager() {
    return _instance;
  }

  ServerManager._internal();

  static bool isConnected() {
    if (_db != null && _db!.state == State.OPEN) {
      return true;
    } else {
      return false;
    }
  }

  static Future<void> connectToMongoDB() async {

    final startTime = DateTime.now();
    try {
      var uri = 'mongodb://admin:admin@cluster0-shard-00-00.ehuu8.mongodb.net:27017,cluster0-shard-00-01.ehuu8.mongodb.net:27017,cluster0-shard-00-02.ehuu8.mongodb.net:27017/?ssl=true&replicaSet=atlas-ap5l5c-shard-0&authSource=admin&retryWrites=true&w=majority&appName=Cluster0';
      _db = Db(uri);

      await _db!.open();
      print("Connected to MongoDB");

      _collection = _db!.collection('MelanomaScans');
    } catch (e) {
      print('Failed to connect to MongoDB: $e');
    }
    final loadTime = DateTime.now().difference(startTime);
    print('Server loaded in: ${loadTime.inMilliseconds} ms');
  }

  static Future<void> saveToMongoDB(File image, double? output, int? confidence) async {
    final startTime = DateTime.now();
    try {
      final base64Image = encodeImageToBase64(image);
      var data = {
        'image': base64Image,
        'output': output,
        'confidence': confidence,
      };
      await _collection!.insert(data);
      print("Image and results saved to MongoDB");
    } catch (e) {
      print('Failed to save to MongoDB: $e');
    }
    final runTime = DateTime.now().difference(startTime);
    print('Image saved in: ${runTime.inMilliseconds} ms');
  }

  static Future<List<Map<String, dynamic>>> retrieveFromMongoDB() async {
    try {
      final results = await _collection!.find().toList();
      print('Retrieved ${results.length} documents from MongoDB');
      List<Map<String, dynamic>> originalResults = [];

      for (var result in results) {
        String base64Image = result['image'];
        String outputPath = await _getTempImagePath();
        File imageFile = await decodeBase64ToImage(base64Image, outputPath);
        double? output = result['output'];
        int? confidence = result['confidence'];

        originalResults.add({
          'image': imageFile,
          'output': output,
          'confidence': confidence,
        });
      }

      return originalResults;
    } catch (e) {
      print('Failed to retrieve and process data from MongoDB: $e');
      return [];
    }

  }

  static String encodeImageToBase64(File imageFile) {
    List<int> imageBytes = imageFile.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }

  static Future<File> decodeBase64ToImage(String base64String, String outputPath) async {
    try {
      Uint8List imageBytes = base64Decode(base64String);
      File imageFile = File(outputPath);
      await imageFile.writeAsBytes(imageBytes);
      print('Image saved to $outputPath');
      return imageFile;
    } catch (e) {
      print('Error converting Base64 to image: $e');
      throw e;
    }
  }

  static Future<String> _getTempImagePath() async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    String filePath = '$tempPath/temp_image_${DateTime.now().millisecondsSinceEpoch}.png';
    return filePath;
  }
}
