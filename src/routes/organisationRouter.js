const express = require('express');
const router = express.Router();
const { createOrganisation, login } = require('../controllers/organisationController');

// routes/product.js
/**
 * @swagger
 * tags:
 *   name: organisations
 *   description: Organisation management
 */

/**
 * @swagger
 * /sms/organisations:
 *   post:
 *     summary: Create a new organisation
 *     tags: [organisations]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               name:
 *                 type: string
 *               email:
 *                 type: string
 *               password:
 *                 type: string
 *     responses:
 *       '200':
 *         description: Successfully created organisation
 *       '400':
 *         description: Bad request
 */
router.post('/organisations', createOrganisation);

/**
 * @swagger
 * /sms/login:
 *   post:
 *     summary: Login to the application
 *     tags: [organisations]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               email:
 *                 type: string
 *               password:
 *                 type: string
 *     responses:
 *       '200':
 *         description: Successfully logged in
 *       '401':
 *         description: Unauthorized
 */
router.post('/login', login);

module.exports = router;
