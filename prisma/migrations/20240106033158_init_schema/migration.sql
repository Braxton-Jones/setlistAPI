/*
  Warnings:

  - You are about to drop the column `body` on the `Comments` table. All the data in the column will be lost.
  - You are about to drop the column `commentId` on the `Comments` table. All the data in the column will be lost.
  - You are about to drop the column `userId` on the `Comments` table. All the data in the column will be lost.
  - You are about to drop the column `username` on the `Comments` table. All the data in the column will be lost.
  - You are about to drop the column `commentId` on the `Likes` table. All the data in the column will be lost.
  - You are about to drop the column `username` on the `Likes` table. All the data in the column will be lost.
  - You are about to drop the column `audioTag` on the `Posts` table. All the data in the column will be lost.
  - You are about to drop the column `body` on the `Posts` table. All the data in the column will be lost.
  - You are about to drop the column `mediaLink` on the `Posts` table. All the data in the column will be lost.
  - You are about to drop the column `title` on the `Posts` table. All the data in the column will be lost.
  - You are about to drop the column `userId` on the `Posts` table. All the data in the column will be lost.
  - You are about to drop the column `username` on the `Posts` table. All the data in the column will be lost.
  - You are about to drop the column `bio` on the `Users` table. All the data in the column will be lost.
  - You are about to drop the column `displayPhoto` on the `Users` table. All the data in the column will be lost.
  - You are about to drop the column `topArtists` on the `Users` table. All the data in the column will be lost.
  - You are about to drop the column `username` on the `Users` table. All the data in the column will be lost.
  - You are about to drop the `Tags` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_PostsToTags` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[spotifyUserId]` on the table `Users` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[spotifyUserURI]` on the table `Users` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `authorId` to the `Comments` table without a default value. This is not possible if the table is not empty.
  - Added the required column `content` to the `Comments` table without a default value. This is not possible if the table is not empty.
  - Made the column `postId` on table `Comments` required. This step will fail if there are existing NULL values in that column.
  - Added the required column `userId` to the `Likes` table without a default value. This is not possible if the table is not empty.
  - Added the required column `authorId` to the `Posts` table without a default value. This is not possible if the table is not empty.
  - Added the required column `content` to the `Posts` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Comments" DROP CONSTRAINT "Comments_commentId_fkey";

-- DropForeignKey
ALTER TABLE "Comments" DROP CONSTRAINT "Comments_postId_fkey";

-- DropForeignKey
ALTER TABLE "Comments" DROP CONSTRAINT "Comments_userId_fkey";

-- DropForeignKey
ALTER TABLE "Likes" DROP CONSTRAINT "Likes_commentId_fkey";

-- DropForeignKey
ALTER TABLE "Likes" DROP CONSTRAINT "Likes_postId_fkey";

-- DropForeignKey
ALTER TABLE "Posts" DROP CONSTRAINT "Posts_userId_fkey";

-- DropForeignKey
ALTER TABLE "_PostsToTags" DROP CONSTRAINT "_PostsToTags_A_fkey";

-- DropForeignKey
ALTER TABLE "_PostsToTags" DROP CONSTRAINT "_PostsToTags_B_fkey";

-- DropIndex
DROP INDEX "Users_username_key";

-- AlterTable
ALTER TABLE "Comments" DROP COLUMN "body",
DROP COLUMN "commentId",
DROP COLUMN "userId",
DROP COLUMN "username",
ADD COLUMN     "authorId" INTEGER NOT NULL,
ADD COLUMN     "content" TEXT NOT NULL,
ADD COLUMN     "deletedAt" TIMESTAMP(3),
ALTER COLUMN "postId" SET NOT NULL;

-- AlterTable
ALTER TABLE "Likes" DROP COLUMN "commentId",
DROP COLUMN "username",
ADD COLUMN     "deletedAt" TIMESTAMP(3),
ADD COLUMN     "playlistId" INTEGER,
ADD COLUMN     "userId" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "Posts" DROP COLUMN "audioTag",
DROP COLUMN "body",
DROP COLUMN "mediaLink",
DROP COLUMN "title",
DROP COLUMN "userId",
DROP COLUMN "username",
ADD COLUMN     "associatedArtists" TEXT[],
ADD COLUMN     "associatedGenres" TEXT[],
ADD COLUMN     "authorId" INTEGER NOT NULL,
ADD COLUMN     "content" TEXT NOT NULL,
ADD COLUMN     "deletedAt" TIMESTAMP(3),
ADD COLUMN     "playlistId" INTEGER,
ADD COLUMN     "purpose" TEXT;

-- AlterTable
ALTER TABLE "Users" DROP COLUMN "bio",
DROP COLUMN "displayPhoto",
DROP COLUMN "topArtists",
DROP COLUMN "username",
ADD COLUMN     "associatedArtists" TEXT[],
ADD COLUMN     "associatedGenres" TEXT[],
ADD COLUMN     "deletedAt" TIMESTAMP(3),
ADD COLUMN     "isOnboarded" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "name" TEXT,
ADD COLUMN     "photoURL" TEXT,
ADD COLUMN     "spotifyUserId" TEXT,
ADD COLUMN     "spotifyUserURI" TEXT,
ALTER COLUMN "email" SET DATA TYPE TEXT;

-- DropTable
DROP TABLE "Tags";

-- DropTable
DROP TABLE "_PostsToTags";

-- CreateTable
CREATE TABLE "Playlists" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "photoURL" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),
    "spotifyPlaylistId" TEXT,
    "spotifyPlaylistURI" TEXT,
    "associatedGenres" TEXT[],
    "associatedArtists" TEXT[],
    "purpose" TEXT,

    CONSTRAINT "Playlists_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "NestedComments" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),
    "content" TEXT NOT NULL,
    "commentId" INTEGER NOT NULL,

    CONSTRAINT "NestedComments_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_PlaylistsToUsers" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "Playlists_spotifyPlaylistId_key" ON "Playlists"("spotifyPlaylistId");

-- CreateIndex
CREATE UNIQUE INDEX "Playlists_spotifyPlaylistURI_key" ON "Playlists"("spotifyPlaylistURI");

-- CreateIndex
CREATE UNIQUE INDEX "_PlaylistsToUsers_AB_unique" ON "_PlaylistsToUsers"("A", "B");

-- CreateIndex
CREATE INDEX "_PlaylistsToUsers_B_index" ON "_PlaylistsToUsers"("B");

-- CreateIndex
CREATE UNIQUE INDEX "Users_spotifyUserId_key" ON "Users"("spotifyUserId");

-- CreateIndex
CREATE UNIQUE INDEX "Users_spotifyUserURI_key" ON "Users"("spotifyUserURI");

-- AddForeignKey
ALTER TABLE "Posts" ADD CONSTRAINT "Posts_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "Users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Posts" ADD CONSTRAINT "Posts_playlistId_fkey" FOREIGN KEY ("playlistId") REFERENCES "Playlists"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Comments" ADD CONSTRAINT "Comments_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "Users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Comments" ADD CONSTRAINT "Comments_postId_fkey" FOREIGN KEY ("postId") REFERENCES "Posts"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "NestedComments" ADD CONSTRAINT "NestedComments_commentId_fkey" FOREIGN KEY ("commentId") REFERENCES "Comments"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Likes" ADD CONSTRAINT "Likes_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Likes" ADD CONSTRAINT "Likes_postId_fkey" FOREIGN KEY ("postId") REFERENCES "Posts"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Likes" ADD CONSTRAINT "Likes_playlistId_fkey" FOREIGN KEY ("playlistId") REFERENCES "Playlists"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_PlaylistsToUsers" ADD CONSTRAINT "_PlaylistsToUsers_A_fkey" FOREIGN KEY ("A") REFERENCES "Playlists"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_PlaylistsToUsers" ADD CONSTRAINT "_PlaylistsToUsers_B_fkey" FOREIGN KEY ("B") REFERENCES "Users"("id") ON DELETE CASCADE ON UPDATE CASCADE;
