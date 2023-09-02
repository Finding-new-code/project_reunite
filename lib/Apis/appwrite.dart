

import 'package:appwrite/appwrite.dart';

class Appwrite {
  static const _endpoint = 'https://cloud.appwrite.io/v1';
  static const _projectId = '6441409b72e38d92a23d';


  admin () {
   Client client = Client();
   client..setEndpoint(_endpoint)
   ..setProject(_projectId);

  }

  Future<void> googleSignin () async {}
  
  Future<void> phoneAuuth () async {}

}

