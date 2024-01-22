/*
  Warnings:

  - A unique constraint covering the columns `[spotifyArtistId]` on the table `Artists` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[spotifyArtistURI]` on the table `Artists` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "Artists" ADD COLUMN     "spotifyArtistId" TEXT,
ADD COLUMN     "spotifyArtistURI" TEXT;

-- CreateIndex
CREATE UNIQUE INDEX "Artists_spotifyArtistId_key" ON "Artists"("spotifyArtistId");

-- CreateIndex
CREATE UNIQUE INDEX "Artists_spotifyArtistURI_key" ON "Artists"("spotifyArtistURI");
