
public class SymbolTable {
	private static final int INIT_CAPACITY = 7;

	/* Number of key-value pairs in the symbol table */
	private int N;
	/* Size of linear probing table */
	private int M;
	/* The keys */
	private String[] keys;
	/* The values */
	private Character[] vals;
	
	/**
	 * Create an empty hash table - use 7 as default size
	 */
	public SymbolTable() {
		this(INIT_CAPACITY);
	}

	/**
	 * Create linear probing hash table of given capacity
	 */
	public SymbolTable(int capacity) {
		N = 0;
		M = capacity;
		keys = new String[M];
		vals = new Character[M];
	}

	/**
	 * Return the number of key-value pairs in the symbol table
	 */
	public int size() {
		return N;
	}

	/**
	 * Is the symbol table empty?
	 */
	public boolean isEmpty() {
		return size() == 0;
	}

	/**
	 * Does a key-value pair with the given key exist in the symbol table?
	 */
	public boolean contains(String key) {
		return get(key) != null;
	}

	/**
	 * Hash function for keys - returns value between 0 and M-1
	 */
	public int hash(String key) {
		int i;
		int v = 0;

		for (i = 0; i < key.length(); i++) {
			v += key.charAt(i);
		}
		return v % M;
	}

	/**
	 * Insert the key-value pair into the symbol table
	 */
	public void put(String key, Character val) {
		int i=0;
		int h = hash(key);
		if(val == null || key == null){
			delete(key);
		}
		if(size()!=M || size()==M && contains(key)){
		while(keys[h+i] != key && val != null && key != null){
			if(keys[h+i] == null){
				N++;
			}
			if(keys[h+i] == null || key.equals(keys[h+i])){
				keys[h+i] = key;
				vals[h+i] = val;
			}
			else if(h+i<M-1){
				i++;
			}else{
				i=i-M+1;
			}
		}
		}
	} 

	/**
	 * Return the value associated with the given key, null if no such value
	 */
	public Character get(String key) {
		int i = lookup(key);
		if(i < M){
		return vals[i];
		}
		return null;
	}

	/**
	 * Delete the key (and associated value) from the symbol table
	 */
	public void delete(String key) {
		int i = lookup(key);
		if(i < M){
			keys[i] = null;
			vals[i] = null;
			N--;
		}
		check(i);
	}
	//The check method rehash the table
	private void check(int key){
		for(int i=0; i<M; i++){
			if(keys[(i+key)%M] != null){
			if(hash(keys[(i+key)%M])== key){
				String k = keys[(i+key)%M];
				char v = vals[(i+key)%M];
				delete(keys[(i+key)%M]);
				put(k, v);
			}
			}
		}
	}
	
	private int lookup(String key){
		int h = hash(key);
		for(int i=0; i<M; i++){
			if(keys[(i+h)%M] != null){
			if(key.equals(keys[(i+h)%M])){
				return (i+h)%M;
			}
		}
		}
		return M;
	}

	/**
	 * Print the contents of the symbol table
	 */
	public void dump() {
		String str = "";

		for (int i = 0; i < M; i++) {
			str = str + i + ". " + vals[i];
			if (keys[i] != null) {
				str = str + " " + keys[i] + " (";
				str = str + hash(keys[i]) + ")";
			} else {
				str = str + " -";
			}
			System.out.println(str);
			str = "";
		}
	}
}