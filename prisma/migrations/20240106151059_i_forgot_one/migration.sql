-- AddForeignKey
ALTER TABLE "NestedComments" ADD CONSTRAINT "NestedComments_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "Users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
