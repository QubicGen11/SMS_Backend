const express=require('express')
const router=express.Router()
const {createBranch,getAllBranches,updateBranch,deleteBranch}=require('../controllers/branchController')
router.post('/createbranch',createBranch)
router.put('/editbranch/:name',updateBranch)
router.delete('/deletebranch/:name',deleteBranch)
router.get('/allbranches',getAllBranches)

module.exports=router