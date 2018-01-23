
public class test {
	final static SymbolTable st = new SymbolTable(733);
	final static int nums = 730;
	final static int gap = 37;
	final static char[] tests = new char[nums];
	private static int i;
	
	public static void main(final String[] args){

	// Associate i (as a string) with a random printable character
	for (i = gap; i != 0; i = (i + gap) % nums) {
	final char ch = (char) (32 + (int) (Math.random() * ((127 - 32) + 1)));

	st.put(Integer.toString(i), ch);
	tests[i] = ch;
	}

	// Check that size() is correct
	if (st.size() != nums - 1) {
	System.out.println("size was() " + st.size()
	+ ", should have been " + (nums - 1));
	}

	// Delete some entries
	for (i = 1; i < nums; i += 2) {
	st.delete(Integer.toString(i));
	}

	// Check that size is correct
	if (st.size() != ((nums / 2) - 1)) {
	System.out.println("size was() " + st.size()
	+ ", should have been " + ((nums / 2) - 1));
	}

	// Delete same entries again
	for (i = 1; i < nums; i += 2) {
	st.delete(Integer.toString(i));
	}

	// Check that size is correct
	if (st.size() != ((nums / 2) - 1)) {
	System.out.println("size was() " + st.size()
	+ ", should have been " + ((nums / 2) - 1));
	}

	// Check that correct entries are still in table
	for (i = 2; i < nums; i += 2) {
	if (st.get(Integer.toString(i)) == null
	|| st.get(Integer.toString(i)) != tests[i]) {
	System.out.println("get(" + i + ") was "
	+ st.get(Integer.toString(i))
	+ ", should have been " + tests[i]);
	}
	}

	// Check that deleted entries really were deleted
	for (i = 1; i < nums; i += 2) {
	if (st.get(Integer.toString(i)) != null) {
	System.out.println("get(" + i + ") was "
	+ st.get(Integer.toString(i))
	+ ", should have been null");
	}
	}
	}
}
