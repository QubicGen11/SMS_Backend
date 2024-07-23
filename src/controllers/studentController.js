const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const bcrypt=require('bcrypt')

const createNewSudent=async(req,res)=>{
    const {firstName,lastName,dob,gender,fatherName,motherName,fatherOcupation,motherOcupation,email,mobileNumber,religion,nationality,address,userName,password}=req.body
    try {
        
    } catch (error) {
        
    }
}