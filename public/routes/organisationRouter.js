const express=require('express')
const router=express.Router()
const {createOrganisation,login}=require('../controllers/organisationController')
router.post('/organisations',createOrganisation)
router.post('/login',login)
module.exports=router