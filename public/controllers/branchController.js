const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

const createBranch = async (req, res) => {
  const { name, organisationName, founderName, city, state, pincode } = req.body;
  try {
    const existingBranch = await prisma.branch.findFirst({
      where: {
        name: name
      }
    });

    if (existingBranch) {
      return res.status(400).send('Branch already exists. Please login instead.');
    }
    const newBranch = await prisma.branch.create({
      data: {
        name: name,
        organisationName: organisationName,
        founderName: founderName,
        city: city,
        state: state,
        pincode: pincode
      }
    });

    return res.status(200).send(newBranch);
  } catch (error) {
    return res.status(500).send('Internal error: ' + error.message);
  }
};

const getAllBranches = async (req, res) => {
  try {
    const allBranches = await prisma.branch.findMany({});
    return res.status(200).send(allBranches);
  } catch (error) {
    return res.status(500).send('Internal error: ' + error.message);
  }
};

const updateBranch = async (req, res) => {
  const { id } = req.params;
  const { organisationName, founderName, city, state, pincode } = req.body;
  try {
    const existingBranch = await prisma.branch.findFirst({
      where: {
        id: parseInt(id)
      }
    });

    if (!existingBranch) {
      return res.status(400).send('Branch does not exist.');
    }
    const updatedBranch = await prisma.branch.update({
      where: {
        id: parseInt(id)
      },
      data: {
        organisationName: organisationName,
        founderName: founderName,
        city: city,
        state: state,
        pincode: pincode
      }
    });

    return res.status(200).send(updatedBranch);
  } catch (error) {
    return res.status(500).send('Internal error: ' + error.message);
  }
};

const deleteBranch = async (req, res) => {
  const { id } = req.params;
  try {
    const existingBranch = await prisma.branch.findFirst({
      where: {
        id:  id
      }
    });

    if (!existingBranch) {
      return res.status(400).send('Branch does not exist.');
    }
    await prisma.branch.delete({
      where: {
        id: parseInt(id)
      }
    });

    return res.status(200).send('Branch deleted successfully.');
  } catch (error) {
    return res.status(500).send('Internal error: ' + error.message);
  }
};

module.exports = { createBranch, getAllBranches, updateBranch, deleteBranch };
