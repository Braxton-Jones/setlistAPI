/*
  Warnings:

  - The primary key for the `Tags` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `Tags` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "_PostsToTags" DROP CONSTRAINT "_PostsToTags_B_fkey";

-- AlterTable
ALTER TABLE "Tags" DROP CONSTRAINT "Tags_pkey",
DROP COLUMN "id",
ADD CONSTRAINT "Tags_pkey" PRIMARY KEY ("spotifyId");

-- AlterTable
ALTER TABLE "_PostsToTags" ALTER COLUMN "B" SET DATA TYPE VARCHAR(255);

-- AddForeignKey
ALTER TABLE "_PostsToTags" ADD CONSTRAINT "_PostsToTags_B_fkey" FOREIGN KEY ("B") REFERENCES "Tags"("spotifyId") ON DELETE CASCADE ON UPDATE CASCADE;
