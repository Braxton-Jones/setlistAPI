const express = require('express');
const router = express.Router();
const artistController = require('../controllers/artists.js');

// Create a new artist
router.post('/create', artistController.createArtist);

// Get an artist by id (checking if it exists honestly)
router.get('/:spotifyid', artistController.getArtistById);

// Delete an artist
router.delete('/:spotifyid', artistController.deleteArtist);

module.exports = router;