const express = require('express');
const router = express.Router();
const userController = require('../controllers/users.js');

// Create a new User (from the onboarding process) **
router.post('/', userController.createUser);

// Get a User by their Spotify ID
router.get('/:spotifyuserid', userController.getUserBySpotifyId);

// Delete a User by their ID
router.delete('/:id', userController.deleteUserById);

// Check if a User exists by their Spotify ID
router.get('/onboarding/:spotifyuserid', userController.checkUserExistsBySpotifyId);


module.exports = router;
