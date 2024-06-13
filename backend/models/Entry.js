const mongoose = require("mongoose");

const EntrySchema = new mongoose.Schema({
  user: { type: mongoose.Schema.Types.ObjectId, ref: "User", required: true },
  text: { type: String, maxlength: 100 },
  audio: { type: String },
  mood: { type: String },
  tags: { type: [String] },
  createdAt: { type: Date, default: Date.now },
});

module.exports = mongoose.model("Entry", EntrySchema);
