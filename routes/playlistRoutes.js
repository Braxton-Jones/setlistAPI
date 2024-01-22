const express = require('express');
const router = express.Router();
const playlistController = require('../controllers/playlists.js');

// Create a new Playlist
router.post('/create/:userid', playlistController.createPlaylist);

// Get a Playlist
router.get('/:playlistId', playlistController.getPlaylistById);

// Delete a Playlist by its ID
router.delete('/:id', playlistController.deletePlaylist);

// Get all Playlists
router.get('/', playlistController.getAllPlaylists);

// Search for a Playlist
router.get('/search/:query', playlistController.searchPlaylists);



module.exports = router;