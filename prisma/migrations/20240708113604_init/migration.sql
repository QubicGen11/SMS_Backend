-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_User" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT,
    "email" TEXT,
    "phoneNumber" TEXT,
    "password" TEXT,
    "role" TEXT,
    "branchId" INTEGER,
    "organisationName" TEXT NOT NULL,
    CONSTRAINT "User_branchId_fkey" FOREIGN KEY ("branchId") REFERENCES "Branch" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "User_organisationName_fkey" FOREIGN KEY ("organisationName") REFERENCES "Organisation" ("name") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_User" ("branchId", "email", "id", "name", "organisationName", "password", "phoneNumber", "role") SELECT "branchId", "email", "id", "name", "organisationName", "password", "phoneNumber", "role" FROM "User";
DROP TABLE "User";
ALTER TABLE "new_User" RENAME TO "User";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
