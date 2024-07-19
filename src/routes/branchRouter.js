const express = require('express');
const router = express.Router();
const {
  createBranch,
  getAllBranches,
  updateBranch,
  deleteBranch,
  getBranchByOrganisation
} = require('../controllers/branchController');

/**
 * @swagger
 * tags:
 *   name: branches
 *   description: Branch management
 */

/**
 * @swagger
 * /sms/branches/createbranch:
 *   post:
 *     summary: Create a new branch
 *     tags: [branches]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               name:
 *                 type: string
 *               city:
 *                 type: string
 *               state:
 *                 type: string
 *               pincode:
 *                 type: string
 *               organisationId:
 *                 type: integer
 *     responses:
 *       '200':
 *         description: Successfully created branch
 *       '400':
 *         description: Bad request
 */
router.post('/createbranch', createBranch);

/**
 * @swagger
 * /sms/branches/editbranch/{id}:
 *   put:
 *     summary: Update a branch by ID
 *     tags: [branches]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID of the branch to update
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               name:
 *                 type: string
 *               city:
 *                 type: string
 *               state:
 *                 type: string
 *               pincode:
 *                 type: string
 *     responses:
 *       '200':
 *         description: Successfully updated branch
 *       '404':
 *         description: Branch not found
 */
router.put('/editbranch/:id', updateBranch);

/**
 * @swagger
 * /sms/branches/deletebranch/{id}:
 *   delete:
 *     summary: Delete a branch by ID
 *     tags: [branches]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID of the branch to delete
 *     responses:
 *       '200':
 *         description: Successfully deleted branch
 *       '404':
 *         description: Branch not found
 */
router.delete('/deletebranch/:id', deleteBranch);

/**
 * @swagger
 * /sms/branches/allbranches:
 *   get:
 *     summary: Get all branches
 *     tags: [branches]
 *     responses:
 *       '200':
 *         description: Successfully retrieved branches
 *       '404':
 *         description: No branches found
 */
router.get('/allbranches', getAllBranches);

/**
 * @swagger
 * /sms/branches/{orgname}/allbranches:
 *   get:
 *     summary: Get all branches for a specific organisation
 *     tags: [branches]
 *     parameters:
 *       - in: path
 *         name: orgname
 *         required: true
 *         schema:
 *           type: string
 *         description: Name of the organisation to fetch branches for
 *     responses:
 *       '200':
 *         description: Successfully retrieved branches for the organisation
 *       '404':
 *         description: Organisation not found or no branches found
 */
router.get('/:orgname/allbranches', getBranchByOrganisation);

module.exports = router;
