class LongestChain {
	private Queue q; // kÃ¶ som anvÃ¤nds i breddenfÃ¶rstsÃ¶kningen
	private String goalWord; // slutord i breddenfÃ¶rstsÃ¶kningen
	int wordLength;
	final char[] alphabet = { 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j',
			'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w',
			'x', 'y', 'z', 'å', 'ä', 'ö', 'é' };
	int alphabetLength = alphabet.length;
	char[] res = new char[4];

	protected WordRec wr = null;

	public LongestChain(int wordLength) {
		this.wordLength = wordLength;
		q = new Queue();
	}

	// IsGoal kollar om w Ã¤r slutordet.
	private boolean IsGoal(String w) {
		return w.equals(goalWord);
	}

	private void makeWord(String word) {
		for(int i = 0; i<word.length(); i++){
			res[i] = word.charAt(i);
		}
	}

	// MakeSons skapar alla ord som skiljer pÃ¥ en bokstav frÃ¥n x.
	// Om det Ã¤r fÃ¶rsta gÃ¥ngen i sÃ¶kningen som ordet skapas sÃ¥ lÃ¤ggs det
	// in i kÃ¶n q.
	private WordRec MakeSons(WordRec x) {
		makeWord(x.word);
		for (int i = 0; i < wordLength; i++) {
			for (int c = 0; c < alphabetLength; c++) {
				if (alphabet[c] != x.word.charAt(i)) {
					res[i] = alphabet[c];
					String newWord = WordList.Contains(String.valueOf(res));
					if (newWord != null) {
						wr = new WordRec(newWord, x);
						if (IsGoal(newWord))
							return wr;
						q.Put(wr);
					}
				}
				if(c+1 == alphabetLength){
					res[i] = x.word.charAt(i);
				}
			}
		}
		return null;
	}

	// BreadthFirst utfÃ¶r en breddenfÃ¶rstsÃ¶kning frÃ¥n startWord fÃ¶r att
	// hitta kortaste vÃ¤gen till endWord. Den kortaste vÃ¤gen returneras
	// som en kedja av ordposter (WordRec).
	// Om det inte finns nÃ¥got sÃ¤tt att komma till endWord returneras null.
	public WordRec BreadthFirst(String startWord, String endWord) {
		WordList.Restore();
		WordRec start = new WordRec(startWord, null);
		WordList.MarkAsUsed(startWord);
		goalWord = endWord;
		q.Empty();
		q.Put(start);
		try {
			while (true) {
				WordRec wr = MakeSons((WordRec) q.Get());
				if (wr != null)
					return wr;
			}
		} catch (Exception e) {
			return null;
		}
	}

	public WordRec BreadthFirst(String endWord) {
		WordList.Restore();
		WordRec prevWr = null;
		WordRec start = new WordRec(endWord, null);
		WordList.MarkAsUsed(endWord);
		goalWord = endWord;
		q.Empty();
		q.Put(start);
		try {
			while (true) {
				WordRec test = (WordRec) q.Get();
				MakeSons(test);
				if (wr != null) {
					prevWr = wr;
				}
			}
		} catch (Exception e) {
		}
		return prevWr;
	}

	// CheckAllStartWords hittar den lÃ¤ngsta kortaste vÃ¤gen frÃ¥n nÃ¥got ord
	// till endWord. Den lÃ¤ngsta vÃ¤gen skrivs ut.
	public void CheckAllStartWords(String endWord) {
		int maxChainLength = 0;
		WordRec maxChainRec = null;
		WordRec x = BreadthFirst(endWord);
		if (x != null) {
			int len = x.ChainLength();
			maxChainLength = len;
			maxChainRec = x;
		}
		System.out.println(endWord + ": " + maxChainLength + " ord");
		if (maxChainRec != null) {
			maxChainRec.PrintReversedChain();
		}
		System.out.println();
	}
}