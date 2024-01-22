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
CREATE UNIQUE INDEX "Genre_name_key" ON "Genre"("name");

-- CreateIndex
CREATE UNIQUE INDEX "_GenreToPlaylists_AB_unique" ON "_GenreToPlaylists"("A", "B");

-- CreateIndex
CREATE INDEX "_GenreToPlaylists_B_index" ON "_GenreToPlaylists"("B");

-- AddForeignKey
ALTER TABLE "_GenreToPlaylists" ADD CONSTRAINT "_GenreToPlaylists_A_fkey" FOREIGN KEY ("A") REFERENCES "Genre"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_GenreToPlaylists" ADD CONSTRAINT "_GenreToPlaylists_B_fkey" FOREIGN KEY ("B") REFERENCES "Playlists"("id") ON DELETE CASCADE ON UPDATE CASCADE;
