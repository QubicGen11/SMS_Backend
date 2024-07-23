const express = require('express');
const app = express();
 
const dotenv = require('dotenv');
const organisationRouter = require('./src/routes/organisationRouter');
const branchRouter = require('./src/routes/branchRouter');
const swaggerDocs = require('./src/config/swaggerConfig'); 
const cors=require('cors')
const morgan=require('morgan')
dotenv.config();
const port = process.env.PORT || 3000;

app.use(express.json());
app.use(cors());
app.use(morgan('dev'));

// @routes
app.use('/sms', organisationRouter);
app.use('/sms', branchRouter);

// @swagger config
swaggerDocs(app, port);

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});
