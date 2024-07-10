-- CreateTable
CREATE TABLE "User" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT,
    "email" TEXT,
    "phoneNumber" TEXT,
    "password" TEXT,
    "role" TEXT,
    "branchId" INTEGER NOT NULL,
    "organisationName" TEXT NOT NULL,
    CONSTRAINT "User_branchId_fkey" FOREIGN KEY ("branchId") REFERENCES "Branch" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "User_organisationName_fkey" FOREIGN KEY ("organisationName") REFERENCES "Organisation" ("name") ON DELETE RESTRICT ON UPDATE CASCADE
);
