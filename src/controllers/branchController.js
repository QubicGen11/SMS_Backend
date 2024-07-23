const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const createBranch = async (req, res) => {
  const { name, organisationName, founderName, mobileNumber, city, state, pincode, mainBranch } = req.body;

  try {
    // Check if the branch already exists by its name
    const existingBranch = await prisma.branch.findFirst({
      where: {
        name: name,
        organisationName: organisationName
      }
    });

    if (existingBranch) {
      return res.status(400).send('Branch already exists.');
    }

    // Create a new branch
    const newBranch = await prisma.branch.create({
      data: {
        name: name,
        organisationName: organisationName,
        founderName: founderName,
        mobileNumber: mobileNumber,
        city: city,
        state: state,
        pincode: pincode,
        mainBranch: mainBranch || false // Default to false if not provided
      }
    });

    return res.status(201).json(newBranch);
  } catch (error) {
    console.error('Error creating branch:', error);
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

const getBranchByOrganisation = async (req, res) => {
  const orgname = req.params.orgname; 
  try {
    const isOrg = await prisma.organisation.findUnique({
      where: { organisationName: orgname }  
    });
    if (!isOrg) {
      return res.status(400).send('Organisation does not exist');
    }
    const getbranchbyorg = await prisma.branch.findMany({
      where: { organisationName: orgname }  
    });
    if (!getbranchbyorg.length) {
      return res.status(400).send('No branches for this organisation');
    }
    return res.status(200).send(getbranchbyorg);
  } catch (error) {
    return res.status(500).send('Internal error: ' + error.message);
  }
}
module.exports = { createBranch , updateBranch, deleteBranch,getBranchByOrganisation };
