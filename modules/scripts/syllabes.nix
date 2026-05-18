{
  pkgs,
  python3Packages,
  ...
}:
pkgs.writers.writePython3Bin "custom-syllabes" {
  libraries = [
    python3Packages.pyphen
  ];
} ''
  import sys
  import pyphen

  dic = pyphen.Pyphen(lang="fr")

  text = sys.stdin.read().strip()

  chunks = []
  total = 0

  for w in text.split():
      hyphenated = dic.inserted(w)
      parts = hyphenated.split("-")
      chunks.append("/".join(parts))
      total += len(parts)

  print(f"{total} ({'/'.join(chunks)})")
''
/*
   used IPA but had a deprecated dependency
{ pkgs, python3Packages, ... }:

pkgs.writers.writePython3Bin "custom-syllabes" {
  libraries = [
    python3Packages.epitran
    python3Packages.setuptools
  ];
} ''
import sys
import epitran
import re

epi = epitran.Epitran("fra-Latn")


def count_syllables_ipa(ipa):
    return len(re.findall(r"[aeiouyɑɛœɔ̃ɑ̃ɛ̃œ̃]", ipa))


text = sys.stdin.read().strip()

total = 0
chunks = []

for word in text.split():
    ipa = epi.transliterate(word)
    syllables = count_syllables_ipa(ipa)

    total += syllables
    chunks.append(f"{word}/{ipa}")

print(f"{total} ({' | '.join(chunks)})")
''
*/
/*
  { pkgs, ... }:

let
  lexique = pkgs.fetchurl {
    url = "http://www.lexique.org/databases/Lexique383/Lexique383.tsv";
    sha256 = "sha256-Y3ujenZ6ZmecSDcdZz7OUMv1QbSaTkDlmJY9Tz+85Ss=";
  };

in
pkgs.writers.writePython3Bin "custom-syllabes" {
  libraries = [ pkgs.python3Packages.pandas ];
} ''
import os
import sys
import pandas as pd
import re

# ----------------------------
# Load Lexique383
# ----------------------------
LEX_PATH = os.environ.get(
  "LEXIQUE_PATH",
  "${lexique}"
)

df = pd.read_csv(LEX_PATH, sep="\t", low_memory=False)

lex = dict(zip(df["ortho"].str.lower(), df["phon"]))


# ----------------------------
# phoneme-based syllabification
# ----------------------------

VOWELS = set([
    "a", "e", "ɛ", "ə", "i", "o", "ɔ", "u", "y",
    "ɑ̃", "ɛ̃", "ɔ̃", "œ̃"
])


def is_vowel(ph):
    return any(v in ph for v in VOWELS)


def syllabify_phonemes(phonemes):
    syllables = []
    cur = ""

    for p in phonemes:
        cur += p

        if is_vowel(p):
            syllables.append(cur)
            cur = ""

    if cur and syllables:
        syllables[-1] += cur
    elif cur:
        syllables.append(cur)

    return syllables


# ----------------------------
# poetic adjustment (basic)
# ----------------------------

def apply_rules(word, phon, syllables):
    # e muet at end (very rough heuristic)
    if phon.endswith("ə") or phon.endswith("e"):
        if len(syllables) > 1:
            syllables = syllables[:-1]
    return syllables


# ----------------------------
# main counter
# ----------------------------

def count_word(word):
    w = re.sub(r"[^a-zàâçéèêëîïôûùœæ']", "", word.lower())
    if not w:
        return 0, []

    phon = lex.get(w)
    if not phon:
        # fallback heuristic
        syls = re.findall(r"[aeiouyàâéèêëîïôûùœæ]+", w)
        return len(syls), syls

    phonemes = phon.split()
    syls = syllabify_phonemes(phonemes)
    syls = apply_rules(w, phon, syls)

    return len(syls), syls


def main():
    text = sys.stdin.read().strip()
    total = 0
    out = []

    for w in text.split():
        c, syls = count_word(w)
        total += c
        if syls:
            out.append("/".join(syls))

    print(f"{total} ({' '.join(out)})")


if __name__ == "__main__":
    main()
''
*/

