const express = require('express')
const app = express()
const dotenv=require("dotenv")
const organisationRouter=require('./public/routes/organisationRouter')
const branchRouter=require('./public/routes/branchRouter')
dotenv.config()
const port=process.env.PORT
const bodyparser=require('body-parser')

//@middlewares
app.use(bodyparser())
app.use(express.json())
//@routes 
app.use('/sms',organisationRouter)
app.use('/sms',branchRouter)


app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})