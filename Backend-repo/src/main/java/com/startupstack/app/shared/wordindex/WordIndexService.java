package com.startupstack.app.shared.wordindex;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Set;

@Service
public class WordIndexService {

    private static final Set<String> ARABIC_STOP_WORDS = Set.of(
            "من", "في", "على", "إلى", "عن", "مع", "هذا", "هذه", "التي", "الذي",
            "الذين", "اللواتي", "هو", "هي", "هم", "هن", "أنا", "أنت", "أنتم",
            "نحن", "كان", "كانت", "يكون", "تكون", "و", "أو", "ثم", "لكن",
            "إن", "أن", "لا", "ما", "لم", "لن", "قد", "كل", "بعض", "أي",
            "ذلك", "تلك", "هنا", "هناك", "بعد", "قبل", "بين", "حول", "عند",
            "حتى", "إذا", "لأن", "منذ", "غير", "أكثر", "أقل"
    );

    private final WordRepository wordRepository;

    public WordIndexService(WordRepository wordRepository) {
        this.wordRepository = wordRepository;
    }

    /**
     * (Re-)indexes the words in {@code arabicText} for {@code appNo} under {@code wordType}.
     * Existing entries for the same (appNo, wordType) pair are removed first so that
     * updates produce a fresh index without stale tokens.
     *
     * @param wordType single-char type identifier: 'T' = catalogue title, 'N' = news, 'B' = book
     */
    @Transactional
    public void indexText(String appNo, String arabicText, String wordType) {
        if (appNo == null || arabicText == null || arabicText.isBlank()) return;

        wordRepository.deleteByAppNoAndWordType(appNo, wordType);

        // Split on whitespace and common Arabic punctuation
        String[] tokens = arabicText.split("[\\s،؛؟!,;?!.\\-–]+");

        for (String token : tokens) {
            String word = token.trim();
            if (word.isEmpty() || ARABIC_STOP_WORDS.contains(word)) continue;
            if (word.length() > 12) word = word.substring(0, 12);

            WordId id = new WordId();
            id.setSubCode6(appNo.length() > 10 ? appNo.substring(0, 10) : appNo);
            id.setSubDesc6(word);
            id.setSubTyp6(wordType);

            if (!wordRepository.existsById(id)) {
                WordEntity entity = new WordEntity();
                entity.setId(id);
                wordRepository.save(entity);
            }
        }
    }
}
