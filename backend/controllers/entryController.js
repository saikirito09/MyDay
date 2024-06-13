const Entry = require("../models/Entry");

exports.createEntry = async (req, res) => {
  const { userId, text, audio, mood, tags } = req.body;
  try {
    const entry = new Entry({ user: userId, text, audio, mood, tags });
    await entry.save();
    res.status(201).json({ message: "Entry created successfully" });
  } catch (error) {
    res.status(500).json({ error: "Error creating entry" });
  }
};

exports.getEntries = async (req, res) => {
  const { userId } = req.params;
  try {
    const entries = await Entry.find({ user: userId });
    res.status(200).json(entries);
  } catch (error) {
    res.status(500).json({ error: "Error fetching entries" });
  }
};
