class NoteModel {
  int id;
  String title;
  String notes;

  NoteModel(this.id, this.title, this.notes);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{'id': id, 'title': title, 'notes': notes};
    return map;
  }

  NoteModel.fromMap(Map<String, dynamic> map){
    id = map['id'];
    title = map['title'];
    notes = map['notes'];
  }
}
