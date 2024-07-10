const express=require('express')
const router=express.Router()
const {createOrganisation,login}=require('../controllers/organisationController')
router.post('/createorg',createOrganisation)
router.post('/login',login)
module.exports=router