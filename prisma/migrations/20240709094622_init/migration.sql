-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Branch" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "organisationId" INTEGER,
    "organisationName" TEXT NOT NULL,
    "founderName" TEXT,
    "city" TEXT,
    "state" TEXT,
    "pincode" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "Branch_organisationName_fkey" FOREIGN KEY ("organisationName") REFERENCES "Organisation" ("name") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Branch" ("city", "createdAt", "founderName", "id", "name", "organisationId", "organisationName", "pincode", "state", "updatedAt") SELECT "city", "createdAt", "founderName", "id", "name", "organisationId", "organisationName", "pincode", "state", "updatedAt" FROM "Branch";
DROP TABLE "Branch";
ALTER TABLE "new_Branch" RENAME TO "Branch";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
