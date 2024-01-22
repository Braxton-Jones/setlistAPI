require('dotenv').config();
const axios = require('axios');
const express = require('express');
const app = express();
const querystring = require('querystring');
const cors = require('cors');
const port = 3001;
const playlistRoutes = require('./routes/playlistRoutes.js');
const userRoutes = require('./routes/userRoutes.js');
const artistRoutes = require('./routes/artistsRoutes.js');


const SPOTIFY_CLIENT_ID = process.env.SPOTIFY_CLIENT_ID;
const SPOTIFY_CLIENT_SECRET = process.env.SPOTIFY_CLIENT_SECRET;
const SPOTIFY_REDIRECT_URI = process.env.SPOTIFY_REDIRECT_URI;
console.log(SPOTIFY_CLIENT_ID, SPOTIFY_CLIENT_SECRET, SPOTIFY_REDIRECT_URI);

const generateRandomString = length => {
    let text = '';
    const possible = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    for (let i = 0; i < length; i++) {
      text += possible.charAt(Math.floor(Math.random() * possible.length));
    }
    return text;
  };

  
const stateKey = 'spotify_auth_state';

app.use(cors())
app.use(express.json());

app.get('/login', (req, res) => {
    const state = generateRandomString(16);
    res.cookie(stateKey, state);

    const scope = `user-read-private user-read-email user-top-read playlist-modify-public playlist-modify-private playlist-read-private playlist-read-collaborative`

    const queryParams = querystring.stringify({
        response_type: 'code',
        client_id: SPOTIFY_CLIENT_ID,
        scope: scope,
        redirect_uri: SPOTIFY_REDIRECT_URI,
        state: state
    });

    res.redirect(`https://accounts.spotify.com/authorize?${queryParams}`);
    
})
app.get('/callback', (req, res) => {
    const code = req.query.code || null;

    axios({
        method: 'post',
        url: 'https://accounts.spotify.com/api/token',
        data: querystring.stringify({
            grant_type: 'authorization_code',
            code: code,
            redirect_uri: SPOTIFY_REDIRECT_URI
        }),
        headers: {
            'content-type': 'application/x-www-form-urlencoded',
            Authorization: `Basic ${Buffer.from(`${SPOTIFY_CLIENT_ID}:${SPOTIFY_CLIENT_SECRET}`).toString('base64')}`
        }
    }).then(response => {
        if (response.status === 200) {
            const access_token = response.data.access_token;
            const refresh_token = response.data.refresh_token;
            const expires_in = response.data.expires_in;

            const queryParams = querystring.stringify({
                access_token,
                refresh_token,
                expires_in
            });
            // Redirect to client with tokens
            res.redirect(`http://localhost:5173/?${queryParams}`);
        }else{
            res.redirect(`/?${querystring.stringify({ error: 'invalid_token' })}`);
        }
    }).catch(error => {
        res.send(error);
      });
});

app.get('/refresh_token', (req, res) => {
    const {refresh_token} = req.query;
    const params = querystring.stringify({
      grant_type: 'refresh_token',
      refresh_token: refresh_token
    })
  
    axios({
      method: 'post',
      url: 'https://accounts.spotify.com/api/token',
      data: params ,
      headers: {
        'content-type': 'application/x-www-form-urlencoded',
        Authorization: `Basic ${new Buffer.from(`${SPOTIFY_CLIENT_ID}:${SPOTIFY_CLIENT_SECRET}`).toString('base64')}`,
      },
    })
      .then(response => {
        res.send(response.data);
      })
      .catch(error => {
        console.log(error)
      });
  });

// app.use('/userActivity', userActivityRoutes);
app.use('/playlist', playlistRoutes);
app.use('/user', userRoutes);
app.use('/artist', artistRoutes);


app.listen(port, () => console.log(`Server is listening on port ${port}! <3`));
