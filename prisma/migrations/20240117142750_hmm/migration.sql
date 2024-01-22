/*
  Warnings:

  - You are about to drop the `Genre` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_GenreToPlaylists` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "_GenreToPlaylists" DROP CONSTRAINT "_GenreToPlaylists_A_fkey";

-- DropForeignKey
ALTER TABLE "_GenreToPlaylists" DROP CONSTRAINT "_GenreToPlaylists_B_fkey";

-- DropTable
DROP TABLE "Genre";

-- DropTable
DROP TABLE "_GenreToPlaylists";
