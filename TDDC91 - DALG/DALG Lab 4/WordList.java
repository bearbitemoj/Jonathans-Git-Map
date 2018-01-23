import java.util.HashSet;
import java.io.*;

// Klassen WordList innehåller en ordlista och en datastruktur som håller
// reda på använda ord.

class WordList {
	static private HashSet<String> list; // ordlista
	static private HashSet<String> list2; // databas med använda ord
	static int wordLength;
	static int size; // antal ord i ordlistan

	// Read läser in en ordlista från strömmen input. Alla ord ska ha
	// wordLength bokstäver.
	static public void Read(int wordLength_, BufferedReader input)
			throws IOException {
		wordLength = wordLength_;
		list = new HashSet<String>();
		list2 = new HashSet<String>();
		while (true) {
			String s = input.readLine();
			if (s.equals("#"))
				break;
			if (s.length() != wordLength)
				System.out.println("Rad " + size + " i filen innehåller inte "
						+ wordLength + " tecken.");
			list.add(s);
		}
		list2 = (HashSet<String>) list.clone();
		size++;
	}

	// Contains slår upp w i ordlistan och returnerar ordet om det finns med.
	// Annars returneras null.
	static public String Contains(String w) {
		if (list2.contains(w)) {
			list2.remove(w);
			return w;
		} else {
			return null;
		}
	}

	// MarkAsUsed markerar w som använt genom att ta bort det från listan.
	static public void MarkAsUsed(String w) {
		list2.remove(w);
	}

	static public void Restore() {
		list2 = (HashSet<String>) list.clone();
	}
}