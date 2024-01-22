/*
  Warnings:

  - You are about to drop the column `photoURL` on the `Users` table. All the data in the column will be lost.
  - You are about to drop the column `spotifyUserURI` on the `Users` table. All the data in the column will be lost.

*/
-- DropIndex
DROP INDEX "Users_spotifyUserURI_key";

-- AlterTable
ALTER TABLE "Users" DROP COLUMN "photoURL",
DROP COLUMN "spotifyUserURI";
