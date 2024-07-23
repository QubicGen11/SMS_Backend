/*
  Warnings:

  - You are about to drop the column `mandal` on the `Branch` table. All the data in the column will be lost.
  - You are about to drop the column `village` on the `Branch` table. All the data in the column will be lost.
  - You are about to drop the column `address` on the `Organisation` table. All the data in the column will be lost.
  - You are about to drop the column `founderPhoneNumber` on the `Organisation` table. All the data in the column will be lost.
  - You are about to drop the column `name` on the `Organisation` table. All the data in the column will be lost.
  - You are about to drop the column `phoneNumber` on the `Organisation` table. All the data in the column will be lost.
  - You are about to drop the column `schoolEmail` on the `Organisation` table. All the data in the column will be lost.
  - You are about to drop the column `firstName` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `lastName` on the `User` table. All the data in the column will be lost.
  - Added the required column `name` to the `Branch` table without a default value. This is not possible if the table is not empty.
  - Added the required column `organisationName` to the `Organisation` table without a default value. This is not possible if the table is not empty.

*/
-- CreateTable
CREATE TABLE "Student" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "loginId" INTEGER,
    "firstName" TEXT,
    "lastName" TEXT,
    "dob" DATETIME,
    "gender" TEXT,
    "fatherName" TEXT,
    "motherName" TEXT,
    "fatherOccupation" TEXT,
    "motherOccupation" TEXT,
    "email" TEXT,
    "mobileNumber" INTEGER,
    "religion" TEXT,
    "nationality" TEXT,
    "address" TEXT,
    "userName" TEXT,
    "password" TEXT
);

-- CreateTable
CREATE TABLE "academicDetails" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "class" TEXT,
    "modeOfTransportation" TEXT,
    "IdentificationMarks" TEXT,
    "studyConductCertificate" TEXT,
    "transferCertificate" TEXT,
    "dateOfJoining" DATETIME,
    "student" INTEGER NOT NULL,
    CONSTRAINT "academicDetails_student_fkey" FOREIGN KEY ("student") REFERENCES "Student" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Teachers" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "loginId" INTEGER,
    "firstName" TEXT,
    "lastName" TEXT,
    "dob" DATETIME,
    "dateOfJoining" DATETIME,
    "gender" TEXT,
    "fatherName" TEXT,
    "motherName" TEXT,
    "fatherOccupation" TEXT,
    "motherOccupation" TEXT,
    "email" TEXT,
    "mobileNumber" INTEGER,
    "religion" TEXT,
    "nationality" TEXT,
    "address" TEXT,
    "userName" TEXT,
    "password" TEXT
);

-- CreateTable
CREATE TABLE "nonTeachingStaff" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "loginId" INTEGER,
    "firstName" TEXT,
    "lastName" TEXT,
    "dob" DATETIME,
    "dateOfJoining" DATETIME,
    "gender" TEXT,
    "fatherName" TEXT,
    "motherName" TEXT,
    "fatherOccupation" TEXT,
    "motherOccupation" TEXT,
    "email" TEXT,
    "mobileNumber" INTEGER,
    "religion" TEXT,
    "nationality" TEXT,
    "address" TEXT,
    "userName" TEXT,
    "password" TEXT
);

-- CreateTable
CREATE TABLE "management" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "loginId" INTEGER,
    "firstName" TEXT,
    "lastName" TEXT,
    "dob" DATETIME,
    "dateOfJoining" DATETIME,
    "gender" TEXT,
    "fatherName" TEXT,
    "motherName" TEXT,
    "fatherOccupation" TEXT,
    "motherOccupation" TEXT,
    "email" TEXT,
    "mobileNumber" INTEGER,
    "religion" TEXT,
    "nationality" TEXT,
    "address" TEXT,
    "userName" TEXT,
    "password" TEXT
);

-- CreateTable
CREATE TABLE "employeeInformation" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "subject" TEXT,
    "qualification" TEXT,
    "experience" TEXT,
    "dateOfGraduation" DATETIME,
    "dateOfJoining" DATETIME,
    "class" TEXT,
    "teacher" INTEGER NOT NULL,
    "nonTeachingStaff" INTEGER NOT NULL,
    "management" INTEGER NOT NULL,
    CONSTRAINT "employeeInformation_teacher_fkey" FOREIGN KEY ("teacher") REFERENCES "Teachers" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "employeeInformation_nonTeachingStaff_fkey" FOREIGN KEY ("nonTeachingStaff") REFERENCES "nonTeachingStaff" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "employeeInformation_management_fkey" FOREIGN KEY ("management") REFERENCES "management" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Branch" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "organisationId" INTEGER,
    "organisationName" TEXT NOT NULL,
    "mobileNumber" TEXT,
    "founderName" TEXT,
    "mainBranch" BOOLEAN NOT NULL DEFAULT false,
    "city" TEXT,
    "state" TEXT,
    "pincode" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "Branch_organisationName_fkey" FOREIGN KEY ("organisationName") REFERENCES "Organisation" ("organisationName") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Branch" ("city", "createdAt", "founderName", "id", "organisationId", "organisationName", "pincode", "state", "updatedAt") SELECT "city", "createdAt", "founderName", "id", "organisationId", "organisationName", "pincode", "state", "updatedAt" FROM "Branch";
DROP TABLE "Branch";
ALTER TABLE "new_Branch" RENAME TO "Branch";
CREATE TABLE "new_Organisation" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "organisationName" TEXT NOT NULL,
    "registerPersonName" TEXT,
    "founderFirstName" TEXT,
    "founderLastName" TEXT,
    "mobileNumber" TEXT,
    "typeOfSchool" TEXT,
    "syllubusType" TEXT,
    "addressLine1" TEXT,
    "addressLine2" TEXT,
    "email" TEXT,
    "city" TEXT,
    "state" TEXT,
    "pincode" TEXT,
    "mandal" TEXT,
    "village" TEXT,
    "founderEmail" TEXT,
    "founderPassword" TEXT
);
INSERT INTO "new_Organisation" ("city", "founderEmail", "founderFirstName", "founderLastName", "founderPassword", "id", "pincode", "state") SELECT "city", "founderEmail", "founderFirstName", "founderLastName", "founderPassword", "id", "pincode", "state" FROM "Organisation";
DROP TABLE "Organisation";
ALTER TABLE "new_Organisation" RENAME TO "Organisation";
CREATE UNIQUE INDEX "Organisation_organisationName_key" ON "Organisation"("organisationName");
CREATE TABLE "new_User" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT,
    "email" TEXT,
    "phoneNumber" TEXT,
    "password" TEXT,
    "role" TEXT,
    "branchId" INTEGER,
    "organisationName" TEXT NOT NULL,
    "branchName" TEXT,
    CONSTRAINT "User_branchId_fkey" FOREIGN KEY ("branchId") REFERENCES "Branch" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "User_organisationName_fkey" FOREIGN KEY ("organisationName") REFERENCES "Organisation" ("organisationName") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_User" ("branchId", "branchName", "email", "id", "organisationName", "password", "phoneNumber", "role") SELECT "branchId", "branchName", "email", "id", "organisationName", "password", "phoneNumber", "role" FROM "User";
DROP TABLE "User";
ALTER TABLE "new_User" RENAME TO "User";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
