import 'dart:collection';

import 'area_event.dart';

/// One message as a room keeps it.
class AreaPost {
  AreaPost({
    required this.id,
    required this.pubkey,
    required this.createdAt,
    required this.text,
    this.name,
    this.cell,
    this.replyTo,
    this.flood = false,
    this.mine = false,
  });

  final String id;
  final String pubkey;

  /// Unix seconds.
  final int createdAt;
  final String text;
  final String? name;
  final String? cell;
  final String? replyTo;

  /// Its author sent more than [AreaRoom.floodPerMinute] in the minute up to
  /// it; the screen folds these behind "Flood · Show".
  final bool flood;
  final bool mine;
}

/// One note as a room keeps it.
class AreaNote {
  AreaNote({
    required this.id,
    required this.pubkey,
    required this.g,
    required this.createdAt,
    required this.expiration,
    required this.text,
    this.cell,
    this.mine = false,
  });

  final String id;
  final String pubkey;
  final String g;
  final int createdAt;
  final int expiration;
  final String text;

  /// The district its author pinned it to by hand, or null: then it hangs on
  /// the city.
  final String? cell;
  final bool mine;
}

/// What one level of the area chat holds — in memory only, never on disk
/// (spec, «Ограничения памяти»: a phone taken away does not keep who and
/// where its owner read).
///
/// Every structure is bounded, so a relay that streams ten thousand fresh
/// keys costs the same as one that streams fifty (bitchat's M12).
class AreaRoom {
  AreaRoom();

  static const int maxPosts = 300;
  static const int maxParticipants = 500;
  static const int maxNotes = 100;

  /// More than this many messages from one key in a minute is flood.
  static const int floodPerMinute = 10;

  /// A key counts towards "≈N here" for this long after its last sign.
  static const int presentSeconds = 5 * 60;

  /// The count is shown as "50+" above this.
  static const int countCap = 50;

  final List<AreaPost> _posts = [];
  final Set<String> _postIds = {};

  /// Last sign of life by key, least recently seen first.
  final LinkedHashMap<String, int> _seen = LinkedHashMap();

  /// Each key's last [floodPerMinute] + 1 message times, for the flood test.
  /// Bounded with [_seen]: a key that drops out of one drops out of both.
  final Map<String, List<int>> _recent = {};

  final LinkedHashMap<String, AreaNote> _notes = LinkedHashMap();

  /// Posts, oldest first.
  List<AreaPost> get posts => List.unmodifiable(_posts);

  /// Notes, oldest first, the expired ones left out.
  List<AreaNote> notesAt(int nowSeconds) => [
        for (final n in _notes.values)
          if (n.expiration > nowSeconds) n,
      ];

  int get participantCount => _seen.length;

  AreaPost? postById(String id) {
    for (final p in _posts) {
      if (p.id == id) return p;
    }
    return null;
  }

  /// Adds a message. False if it was here already.
  bool addPost(AreaInbound event, {bool mine = false}) {
    final content = event.content;
    if (content == null || _postIds.contains(event.id)) return false;
    _touch(event.pubkey, event.createdAt);
    final flood = _countRecent(event.pubkey, event.createdAt) > floodPerMinute;
    final post = AreaPost(
      id: event.id,
      pubkey: event.pubkey,
      createdAt: event.createdAt,
      text: content.text,
      name: content.name,
      cell: content.cell,
      replyTo: event.replyTo,
      flood: flood,
      mine: mine,
    );
    // In time order: a backlog arrives newest first, live ones at the end.
    var at = _posts.length;
    while (at > 0 && _posts[at - 1].createdAt > post.createdAt) {
      at--;
    }
    _posts.insert(at, post);
    _postIds.add(post.id);
    while (_posts.length > maxPosts) {
      _postIds.remove(_posts.removeAt(0).id);
    }
    return true;
  }

  void addPresence(AreaInbound event) => _touch(event.pubkey, event.createdAt);

  /// Adds a note, or replaces nothing if its id is here. False if it was.
  bool addNote(AreaInbound event, {bool mine = false}) {
    final content = event.content;
    final expiration = event.expiration;
    if (content == null || expiration == null) return false;
    if (_notes.containsKey(event.id)) return false;
    _notes[event.id] = AreaNote(
      id: event.id,
      pubkey: event.pubkey,
      g: event.g,
      createdAt: event.createdAt,
      expiration: expiration,
      text: content.text,
      cell: content.cell,
      mine: mine,
    );
    while (_notes.length > maxNotes) {
      _notes.remove(_notes.keys.first);
    }
    return true;
  }

  void removeNote(String id) => _notes.remove(id);

  /// Drops everything by [pubkey] — a block, or the ban list.
  void dropAuthor(String pubkey) {
    _posts.removeWhere((p) {
      if (p.pubkey != pubkey) return false;
      _postIds.remove(p.id);
      return true;
    });
    _notes.removeWhere((_, n) => n.pubkey == pubkey);
  }

  void dropEvent(String id) {
    _posts.removeWhere((p) => p.id == id);
    _postIds.remove(id);
    _notes.remove(id);
  }

  /// Keys with a sign of life — presence or a message — in the last
  /// [presentSeconds].
  int presentCount(int nowSeconds) {
    var n = 0;
    for (final at in _seen.values) {
      if (at > nowSeconds - presentSeconds) n++;
    }
    return n;
  }

  void clear() {
    _posts.clear();
    _postIds.clear();
    _seen.clear();
    _recent.clear();
    _notes.clear();
  }

  void _touch(String pubkey, int at) {
    final previous = _seen.remove(pubkey);
    _seen[pubkey] = previous == null || at > previous ? at : previous;
    while (_seen.length > maxParticipants) {
      final oldest = _seen.keys.first;
      _seen.remove(oldest);
      _recent.remove(oldest);
    }
  }

  int _countRecent(String pubkey, int at) {
    // Sorted, because a backlog arrives newest first; trimmed to the newest
    // few, which is all a minute's count can need.
    final times = _recent.putIfAbsent(pubkey, () => <int>[])
      ..add(at)
      ..sort();
    while (times.length > 2 * (floodPerMinute + 1)) {
      times.removeAt(0);
    }
    return times.where((t) => t > at - 60 && t <= at).length;
  }
}
