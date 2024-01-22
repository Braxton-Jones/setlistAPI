const { PrismaClient } = require('@prisma/client');

const prisma = new PrismaClient()

exports.createPlaylist = async (req, res) => {
    const { 
        name,
        spotifyPlaylistId,
        associatedGenres, 
        featuredArtists, 
        purpose } = req.body;

        // check if playlist already exists
        const playlistExists = await prisma.playlists.findUnique({
            where: {
                spotifyPlaylistId: spotifyPlaylistId,
            },
        });
        if (playlistExists) {
            res.status(200).json({ message: "Playlist already exists" });
            return;
        }

        // check if artists already exist, if not, create them
        const createdArtists = await Promise.all(
            featuredArtists.map(async (artist) => {
              const artistExists = await prisma.artists.findUnique({
                where: {
                  spotifyArtistId: artist.id,
                },
              });
          
              if (!artistExists) {
                const newArtist = await prisma.artists.create({
                  data: {
                    name: artist.name,
                    genres: artist.genres,
                    spotifyArtistId: artist.id,
                  },
                });
                return newArtist;
              }
          
              return artistExists;
            })
          );
          
          

        // check if genres already exist, if not, create them
        const createdGenres = await Promise.all(
            associatedGenres.map(async (genre) => {
              const genreExists = await prisma.genre.findUnique({
                where: {
                  name: genre.name,
                },
              });
          
              if (!genreExists) {
                const newGenre = await prisma.genre.create({
                  data: {
                    name: genre.name,
                  },
                });
                return newGenre;
              }
          
              return genreExists;
            })
          );
          

    try {
        const playlist = await prisma.playlists.create({
        data: {
            name,
            spotifyPlaylistId,
            associatedGenres : {
                connect: associatedGenres.map((genre) => {
                    return {
                        name: genre.name,
                    };
                })
            },
            featuredArtists: {
                connect: featuredArtists.map((artist) => {
                    return {
                        spotifyArtistId: artist.id,
                    };
                }),
            },
            purpose,
            creator: {
                connect: {
                    spotifyUserId: req.params.userid,
                },
            },
            
        }
        });
    
        res.status(201).json({ message: "Playlist created"});
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: error.message });
    }
    finally {
        await prisma.$disconnect();
      }

}

// Get a single playlist by id
exports.getPlaylistById = async (req, res) => {
    try {
        const playlist = await prisma.playlists.findUnique({
            where: {
                spotifyPlaylistId: req.params.playlistId,
            },
            select:{
                id: true,
                name: true,
                spotifyPlaylistId: true,
                associatedGenres: true,
                featuredArtists: true,
                purpose: true,
            }
        });
        res.status(200).json(playlist);
    } catch (error) {
        console.error(error);
        res.status(404).json({ error: error.message });
    } finally {
        await prisma.$disconnect();
      }
}

// Delete a playlist from users profile
exports.deletePlaylist = async (req, res) => {
    try {
        const playlist = await prisma.playlists.delete({
            where: {
                id: parseInt(req.params.id),
            },
        });
        res.status(200).json({ playlist, message: "Playlist deleted" });
    } catch (error) {
        console.error(error);
        res.status(404).json({ error: error.message });
    } finally {
        await prisma.$disconnect();
    }
}


// Get all playlists
exports.getAllPlaylists = async (req, res) => {
    try {
        const playlists = await prisma.playlists.findMany({
            select:{
                id: true,
                name: true,
                spotifyPlaylistId: true,
                purpose: true,
                featuredArtists: true,
                creator: {
                    select: {
                        spotifyUserId: true,
                        name: true,
                    }
                }
            }
        });
        res.status(200).json(playlists);
    } catch (error) {
        console.error(error);
        res.status(404).json({ error: error.message });
    } finally {
        await prisma.$disconnect();
      }
}


exports.searchPlaylists = async (req, res) => {
    try {
        console.log(`Searching for playlists containing "${req.params.query}"...`);
        const playlists = await prisma.playlists.findMany({
            where: {
                OR: [
                    {
                        name: {
                            contains: req.params.query,
                            mode: "insensitive"
                        }
                    },
                    {
                        featuredArtists: {
                            some: {
                                name: {
                                    contains: req.params.query,
                                    mode: "insensitive"
                                }
                            }
                        }
                    },
                    {
                        creator: {
                            some: {
                                name: {
                                    contains: req.params.query,
                                    mode: "insensitive"
                                }
                            }
                        }
                    },
                    {
                        purpose: {
                            contains: req.params.query,
                            mode: "insensitive"
                        }
                    }
                ]
            },
            select:{
                id: true,
                name: true,
                spotifyPlaylistId: true,
                purpose: true,
                featuredArtists: {
                    select: {
                        name: true
                    }
                },
                creator: {
                    select: {
                        spotifyUserId: true,
                        name: true
                    }
                }
            }
        });
        

        if (playlists.length === 0) {
            console.log(`No playlists found for query: ${req.params.query}`);
        } else {
            console.log('Found playlists: ', playlists);
        }

        res.status(200).json(playlists);
    } catch (error) {
        console.error(error);
        res.status(404).json({ error: error.message });
    } finally {
        await prisma.$disconnect();
    }
}







module.exports = exports;