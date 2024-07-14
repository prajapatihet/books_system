import 'package:appwrite/appwrite.dart';

Client client = Client()
    .setEndpoint('https://cloud.appwrite.io/v1')
    .setProject('669338de0016301b9306')
    .setSelfSigned(
        status: true); // For self signed certificates, only use for development