import 'package:cloud_firestore/cloud_firestore.dart'; // WAJIB IMPORT INI

class Note {
  final String? id;
  final String title;
  final String description;
  final String? imageBase64;
  final DateTime createdAt; // Tipenya tetap DateTime untuk UI

  Note({
    this.id,
    required this.title,
    required this.description,
    this.imageBase64,
    required this.createdAt,
  });

  /// Map untuk dikirim KELUAR (ke Firestore)
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'imageBase64': imageBase64,
      // Saat menyimpan, Anda bisa kirim DateTime atau Timestamp bebas
      'createdAt': createdAt,
    };
  }

  /// Factory untuk menerima data MASUK (dari Firestore) -> DISINI REVISINYA
  factory Note.fromMap(String id, Map<String, dynamic> map) {
    return Note(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      imageBase64: map['imageBase64'],
      // Perbaikan error ada di baris ini:
      createdAt: map['createdAt'] is Timestamp
          ? (map['createdAt'] as Timestamp)
                .toDate() // Jika Timestamp, ubah ke DateTime
          : DateTime.parse(
              map['createdAt'].toString(),
            ), // Fallback jika berupa String ISO
    );
  }
}
