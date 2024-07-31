class DocumentUtils {
  static String getDocumentIcon(String fileName) {
    Map<String, String> extensionToImagePath = {
      'pdf': 'lib/assets/images/pdf_icon.png',
      'xls': 'lib/assets/images/google_sheet_icon.png',
      'xlsx': 'lib/assets/images/google_sheet_icon.png',
      'doc': 'lib/assets/images/google_sheet_icon.png',
      'docx': 'lib/assets/images/google_sheet_icon.png',
    };

    String extension = fileName.split('.').last.toLowerCase();

    return extensionToImagePath[extension] ?? 'lib/assets/images/pdf_icon.png';
  }
}
