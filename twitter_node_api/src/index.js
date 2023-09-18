require('./db/mongoose');
const express = require('express');
const app = express();

const userRouter = require('./routes/user')
const tweetRouter = require('./routes/tweet')
const notificationRouter = require('./routes/notification');


const port = process.env.PORT || 3000;

app.use(express.json())
app.use(userRouter)
app.use(tweetRouter)
app.use(notificationRouter)

app.listen(port, ()=> {
    console.log('listening on port 3000 \n connect to http://localhost:3000');
})

