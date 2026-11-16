// What a peer is doing (typing, recording, sending) is a wire value the
// transport encodes and decodes, so it lives in core. Re-exported so the
// peers feature keeps reading it from here.
export '../../../core/models/peer_activity.dart';
