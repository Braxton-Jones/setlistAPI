/*
  Warnings:

  - Added the required column `authorId` to the `NestedComments` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "NestedComments" ADD COLUMN     "authorId" INTEGER NOT NULL;
