const { PrismaClient } = require('@prisma/client');
const bcrypt = require('bcrypt');
const prisma = new PrismaClient();
const createOrganisation = async (req, res) => {
  const {
    organisationName,
    founderFirstName,
    founderLastName,
    mobileNumber,
    email,
    address,
    city,
    state,
    pincode,
    mandal,
    village,
    founderEmail,
    founderPassword
  } = req.body;

  try {
    // Check if the organisation already exists
    const findOrganisation = await prisma.organisation.findFirst({
      where: {
       organisationName: organisationName
      }
    });

    if (findOrganisation) {
      return res.status(400).send('Please login, your organisation is already registered.');
    }

    // Hash the founder's password
    const hashedPassword = await bcrypt.hash(founderPassword, 10);

    // Create new organisation
    const newOrganisation = await prisma.organisation.create({
      data: {
        organisationName,
        founderFirstName,
        founderLastName,
        mobileNumber,
        email,
        address,
        city,
        state,
        pincode,
        mandal,
        village,
        founderEmail,
        founderPassword: hashedPassword
      }
    });

    // Create new user for the organisation's admin
    if (newOrganisation) {
      await prisma.user.create({
        data: {
          name: `${newOrganisation.founderFirstName} ${newOrganisation.founderLastName}`,
          email: newOrganisation.founderEmail,
          phoneNumber: newOrganisation.mobileNumber,
          password: hashedPassword,
          organisationName: newOrganisation.organisationName,
          role: 'Admin' // Assign 'Admin' role to the founder
        }
      });

      // Create a branch for the new organisation
      await prisma.branch.create({
        data: {
          name: `${city} Branch of ${organisationName}`,
          organisationId: newOrganisation.id,
          organisationName: newOrganisation.organisationName,
          founderName: `${newOrganisation.founderFirstName} ${newOrganisation.founderLastName}`,
          city,
          state,
          pincode
        }
      });
    }

    return res.status(200).send(newOrganisation);
  } catch (error) {
    console.error('Error creating organisation:', error);
    return res.status(500).send('Internal error: ' + error.message);
  }
};

const login = async (req, res) => {
  const { email, password } = req.body;
  try {
    // Find the user by email
    const user = await prisma.user.findFirst({
      where: { email }
    });

    if (!user) {
      return res.status(400).send('Invalid email or password.');
    }

    // Compare the provided password with the stored hashed password
    const isPasswordValid = await bcrypt.compare(password, user.password);

    if (!isPasswordValid) {
      return res.status(400).send('Invalid email or password.');
    }
    // Return user details upon successful login
    return res.status(200).json({
      message: 'Login successful',
      user: {
        id: user.id,
        name: user.name,
        email: user.email,
        phoneNumber: user.phoneNumber,
        role: user.role
      }
    });
  } catch (error) {
    console.error('Error logging in:', error);
    return res.status(500).send('Internal error: ' + error.message);
  }
};

module.exports = { createOrganisation, login };
