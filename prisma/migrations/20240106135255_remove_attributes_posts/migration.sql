/*
  Warnings:

  - You are about to drop the column `associatedArtists` on the `Posts` table. All the data in the column will be lost.
  - You are about to drop the column `associatedGenres` on the `Posts` table. All the data in the column will be lost.
  - You are about to drop the column `purpose` on the `Posts` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "Posts" DROP COLUMN "associatedArtists",
DROP COLUMN "associatedGenres",
DROP COLUMN "purpose";
