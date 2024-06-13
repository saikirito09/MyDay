const express = require("express");
const { createEntry, getEntries } = require("../controllers/entryController");
const auth = require("../middleware/auth");
const router = express.Router();

router.post("/", auth, createEntry);
router.get("/:userId", auth, getEntries);

module.exports = router;
