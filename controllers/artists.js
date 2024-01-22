const { PrismaClient } = require('@prisma/client');

const prisma = new PrismaClient()

// Create a new artist
exports.createArtist = async (req, res) => {
    const { 
        name,
        photoURL,
        genres,
        spotifyArtistId,
     } = req.body;
     try {
        const artist = await prisma.artists.create({
            data: {
                name,
                photoURL,
                genres,
                spotifyArtistId
            }
        });
        res.status(201).json(artist);}
    catch (error) {
        console.error(error);
        res.status(500).json({ error: error.message });
    }
    finally {
        await prisma.$disconnect();
      }
}

// Get artist by ID
exports.getArtistById = async (req, res) => {
    try {
        const spotifyArtistId = req.params.spotifyid;
        if (!spotifyArtistId){
            throw new Error('No artist ID provided');
        }
        const artist = await prisma.artists.findUnique({
            where: {
                spotifyArtistId: spotifyArtistId,
            },
            include:{
                playlists: true,
            }
        });
        res.status(200).json(artist);}
    catch (error) {
        console.error(error);
        res.status(500).json({ error: error.message });
    }
    finally {
        await prisma.$disconnect();
      }
}

// Edit an artist
exports.editArtist = async (req, res) => {
    const { 
        name,
        photoURL,
        genres,
        spotifyArtistId,
        spotifyArtistURI,
     } = req.body;
     try {
        const artist = await prisma.artists.update({
            where: {
                id: parseInt(req.params.id),
            },
            data: {
                name,
                photoURL,
                genres,
                spotifyArtistId,
                spotifyArtistURI,
            }
        });
        res.status(201).json(artist);}
    catch (error) {
        console.error(error);
        res.status(500).json({ error: error.message });
    }
    finally {
        await prisma.$disconnect();
      }
}

// Delete an artist
exports.deleteArtist = async (req, res) => {
    try {
        const artist = await prisma.artists.delete({
            where: {
                spotifyArtistId: req.params.spotifyid,
            },
        });
        res.status(201).json(artist);}
    catch (error) {
        console.error(error);
        res.status(500).json({ error: error.message });
    }
    finally {
        await prisma.$disconnect();
      }
}


module.exports = exports;