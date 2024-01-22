/*
  Warnings:

  - You are about to drop the column `photoURL` on the `Artists` table. All the data in the column will be lost.
  - You are about to drop the column `spotifyArtistURI` on the `Artists` table. All the data in the column will be lost.
  - You are about to drop the column `associatedGenres` on the `Playlists` table. All the data in the column will be lost.
  - You are about to drop the column `photoURL` on the `Playlists` table. All the data in the column will be lost.
  - You are about to drop the column `spotifyPlaylistURI` on the `Playlists` table. All the data in the column will be lost.
  - You are about to drop the column `email` on the `Users` table. All the data in the column will be lost.
  - You are about to drop the `Comments` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `NestedComments` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Posts` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Comments" DROP CONSTRAINT "Comments_authorId_fkey";

-- DropForeignKey
ALTER TABLE "Comments" DROP CONSTRAINT "Comments_postId_fkey";

-- DropForeignKey
ALTER TABLE "NestedComments" DROP CONSTRAINT "NestedComments_authorId_fkey";

-- DropForeignKey
ALTER TABLE "NestedComments" DROP CONSTRAINT "NestedComments_commentId_fkey";

-- DropForeignKey
ALTER TABLE "Posts" DROP CONSTRAINT "Posts_authorId_fkey";

-- DropForeignKey
ALTER TABLE "Posts" DROP CONSTRAINT "Posts_playlistId_fkey";

-- DropIndex
DROP INDEX "Artists_spotifyArtistURI_key";

-- DropIndex
DROP INDEX "Playlists_spotifyPlaylistURI_key";

-- DropIndex
DROP INDEX "Users_email_key";

-- AlterTable
ALTER TABLE "Artists" DROP COLUMN "photoURL",
DROP COLUMN "spotifyArtistURI";

-- AlterTable
ALTER TABLE "Playlists" DROP COLUMN "associatedGenres",
DROP COLUMN "photoURL",
DROP COLUMN "spotifyPlaylistURI";

-- AlterTable
ALTER TABLE "Users" DROP COLUMN "email";

-- DropTable
DROP TABLE "Comments";

-- DropTable
DROP TABLE "NestedComments";

-- DropTable
DROP TABLE "Posts";

-- CreateTable
CREATE TABLE "Genre" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "Genre_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_GenreToPlaylists" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_GenreToPlaylists_AB_unique" ON "_GenreToPlaylists"("A", "B");

-- CreateIndex
CREATE INDEX "_GenreToPlaylists_B_index" ON "_GenreToPlaylists"("B");

-- AddForeignKey
ALTER TABLE "_GenreToPlaylists" ADD CONSTRAINT "_GenreToPlaylists_A_fkey" FOREIGN KEY ("A") REFERENCES "Genre"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_GenreToPlaylists" ADD CONSTRAINT "_GenreToPlaylists_B_fkey" FOREIGN KEY ("B") REFERENCES "Playlists"("id") ON DELETE CASCADE ON UPDATE CASCADE;
