/*
  Warnings:

  - You are about to drop the column `name` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `name` on the `Branch` table. All the data in the column will be lost.
  - You are about to drop the column `founderName` on the `Organisation` table. All the data in the column will be lost.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_User" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "firstName" TEXT,
    "lastName" TEXT,
    "email" TEXT,
    "phoneNumber" TEXT,
    "password" TEXT,
    "role" TEXT,
    "branchId" INTEGER,
    "organisationName" TEXT NOT NULL,
    "branchName" TEXT,
    CONSTRAINT "User_branchId_fkey" FOREIGN KEY ("branchId") REFERENCES "Branch" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "User_organisationName_fkey" FOREIGN KEY ("organisationName") REFERENCES "Organisation" ("name") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_User" ("branchId", "branchName", "email", "id", "organisationName", "password", "phoneNumber", "role") SELECT "branchId", "branchName", "email", "id", "organisationName", "password", "phoneNumber", "role" FROM "User";
DROP TABLE "User";
ALTER TABLE "new_User" RENAME TO "User";
CREATE TABLE "new_Branch" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "organisationId" INTEGER,
    "organisationName" TEXT NOT NULL,
    "founderName" TEXT,
    "village" TEXT,
    "mandal" TEXT,
    "city" TEXT,
    "state" TEXT,
    "pincode" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "Branch_organisationName_fkey" FOREIGN KEY ("organisationName") REFERENCES "Organisation" ("name") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Branch" ("city", "createdAt", "founderName", "id", "mandal", "organisationId", "organisationName", "pincode", "state", "updatedAt", "village") SELECT "city", "createdAt", "founderName", "id", "mandal", "organisationId", "organisationName", "pincode", "state", "updatedAt", "village" FROM "Branch";
DROP TABLE "Branch";
ALTER TABLE "new_Branch" RENAME TO "Branch";
CREATE TABLE "new_Organisation" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "founderFirstName" TEXT,
    "founderLastName" TEXT,
    "founderPassword" TEXT,
    "founderEmail" TEXT,
    "founderPhoneNumber" TEXT,
    "schoolEmail" TEXT NOT NULL,
    "address" TEXT,
    "city" TEXT,
    "state" TEXT,
    "pincode" TEXT,
    "phoneNumber" TEXT
);
INSERT INTO "new_Organisation" ("address", "city", "founderEmail", "founderPassword", "founderPhoneNumber", "id", "name", "phoneNumber", "pincode", "schoolEmail", "state") SELECT "address", "city", "founderEmail", "founderPassword", "founderPhoneNumber", "id", "name", "phoneNumber", "pincode", "schoolEmail", "state" FROM "Organisation";
DROP TABLE "Organisation";
ALTER TABLE "new_Organisation" RENAME TO "Organisation";
CREATE UNIQUE INDEX "Organisation_name_key" ON "Organisation"("name");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
