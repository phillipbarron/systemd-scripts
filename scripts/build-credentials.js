const secretWriter = require('@bbc/cps-secret-writer');

secretWriter.writeSecretToFileSystem(
  'google-credentials.json',
  'translate_api_credentials',
  'GOOGLE_APPLICATION_CREDENTIALS',
);
