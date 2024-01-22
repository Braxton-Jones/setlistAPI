/*
  Warnings:

  - You are about to drop the column `associatedArtists` on the `Playlists` table. All the data in the column will be lost.
  - You are about to drop the column `associatedGenres` on the `Users` table. All the data in the column will be lost.
  - You are about to drop the column `followedArtists` on the `Users` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "Playlists" DROP COLUMN "associatedArtists";

-- AlterTable
ALTER TABLE "Users" DROP COLUMN "associatedGenres",
DROP COLUMN "followedArtists";

-- CreateTable
CREATE TABLE "Artists" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "photoURL" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),
    "genres" TEXT[],

    CONSTRAINT "Artists_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_ArtistsToPlaylists" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_ArtistsToPlaylists_AB_unique" ON "_ArtistsToPlaylists"("A", "B");

-- CreateIndex
CREATE INDEX "_ArtistsToPlaylists_B_index" ON "_ArtistsToPlaylists"("B");

-- AddForeignKey
ALTER TABLE "_ArtistsToPlaylists" ADD CONSTRAINT "_ArtistsToPlaylists_A_fkey" FOREIGN KEY ("A") REFERENCES "Artists"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ArtistsToPlaylists" ADD CONSTRAINT "_ArtistsToPlaylists_B_fkey" FOREIGN KEY ("B") REFERENCES "Playlists"("id") ON DELETE CASCADE ON UPDATE CASCADE;
