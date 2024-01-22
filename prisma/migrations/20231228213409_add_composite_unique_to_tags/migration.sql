/*
  Warnings:

  - Made the column `spotifyId` on table `Tags` required. This step will fail if there are existing NULL values in that column.

*/
-- DropIndex
DROP INDEX "Tags_name_key";

-- AlterTable
ALTER TABLE "Tags" ALTER COLUMN "spotifyId" SET NOT NULL;
