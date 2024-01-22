/*
  Warnings:

  - You are about to drop the column `associatedArtists` on the `Users` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[authorId]` on the table `Posts` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "Users" DROP COLUMN "associatedArtists",
ADD COLUMN     "followedArtists" TEXT[];

-- CreateIndex
CREATE UNIQUE INDEX "Posts_authorId_key" ON "Posts"("authorId");
