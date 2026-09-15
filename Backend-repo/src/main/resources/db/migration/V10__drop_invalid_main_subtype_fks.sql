-- The baseline schema declared "main" as having a FK to BOTH "ARTICLE" and "BOOK"
-- (MN_APP_NO -> ART_APP_NO and MN_APP_NO -> BK_APP_NO). Since a "main" row is a
-- discriminated union (an article OR a book OR a periodical/news item, never more than
-- one), requiring it to simultaneously exist in both subtype tables makes it impossible
-- to insert any "main" row at all -- every create() ends up violating one of the two
-- constraints. Neither ARTICLE nor BOOK carry the (correct) reverse FK back to "main",
-- so this direction was never load-bearing for referential integrity in the app; drop it.
ALTER TABLE "main" DROP CONSTRAINT "main_MN_APP_NO_fkey";
ALTER TABLE "main" DROP CONSTRAINT "main_MN_APP_NO_fkey1";
