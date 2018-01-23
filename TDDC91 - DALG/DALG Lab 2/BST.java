public class BST {
	/* Root of BST */
	private Node root;
	/* Number of nodes in BST */
	private int size;
	
	private int children;

	public BST() {
		this.root = null;
		this.size = 0;
	}

	/**
	 * Is the BST empty?
	 */
	public boolean isEmpty() {
		return size() == 0;
	}

	/**
	 * Return root of BST
	 */
	public Node getRoot() {
		return root;
	}

	/**
	 * Return number of key-value pairs in BST
	 */
	public int size() {
		return size;
	}

	/**
	 * Does there exist a key-value pair with given key?
	 */
	public boolean contains(int key) {
		return find(key) != null;
	}

	/**
	 * Return value associated with the given key, or null if no such key exists
	 */
	public String find(int key) {
		return find(root, key);
	}

	/**
	 * Return value associated with the given key, or null if no such key exists
	 * in subtree rooted at x
	 */
	private String find(Node x, int key) {
		if (x == null) {
			return null;
		}
		if (key < x.key) {
			return find(x.left, key);
		} else if (key > x.key) {
			return find(x.right, key);
		} else {
			return x.val;
		}
	}

	/**
	 * Insert key-value pair into BST. If key already exists, update with new
	 * value
	 */
	public void insert(int key, String val) {
		if (val == null) {
			remove(key);
			return;
		}
		root = insert(root, key, val);
	}

	/**
	 * Insert key-value pair into subtree rooted at x. If key already exists,
	 * update with new value.
	 */
	private Node insert(Node x, int key, String val) {
		if (x == null) {
			size++;
			return new Node(key, val);
		}
		if (key < x.key) {
			x.left = insert(x.left, key, val);
		} else if (key > x.key) {
			x.right = insert(x.right, key, val);
		} else {
			x.val = val;
		}

		return x;
	}

	/**
	 * Remove node with given key from BST
	 */
	public void remove(int key) {
		String existKey = find(key);
		if (existKey != null) {
			Node node = root;
			if (node != null) {
				while (key != node.key && node != null) {
					if (key > node.key && node.right != null) {
						node = node.right;
					}
					if (key < node.key && node.left != null) {
						node = node.left;
					}
				}

				Node cNode = checkChildren(node);
				Node parent = getParent(node.key);
				if (cNode != null && children == 2) {
					size++;
					remove(cNode.key);
				}
				if (parent != null) {
					if (node == parent.left) {
						parent.left = null;
						parent.left = cNode;
					} else {
						parent.right = null;
						parent.right = cNode;
					}
					if (node.right != null && node.right != cNode) {
						if (checkChange(cNode.key, node.right)) {
							cNode.left = node.right;
						} else {
							cNode.right = node.right;
						}
					}
					if (node.left != null && node.left != cNode) {
						if (checkChange(cNode.key, node.left)) {
							cNode.left = node.left;
						} else {
							cNode.right = node.left;
						}
					}
				} else {
					root = null;
					root = cNode;

					if (node.right != null && node.right != cNode) {
						if (checkChange(cNode.key, node.right)) {
							cNode.left = node.right;
						} else {
							cNode.right = node.right;
						}
					}
					if (node.left != null && node.left != cNode) {
						if (checkChange(cNode.key, node.left)) {
							cNode.left = node.left;
						} else {
							cNode.right = node.left;
						}
					}
				}
			}
			size--;
		}
	}

	// dummy code

	private boolean checkChange(int N, Node n) {
		if (N > n.key ) {
			return true;
		}
		return false;
	}

	private Node checkChildren(Node n) {
		Node node = n;
		children = 0;
		int step = 0;
		if (node.left != null || node.right != null) {
				if (node.right != null && node.left == null) {
					node = node.right;
					children = 1;
					step++;
				}
				if (node.left != null && node.right == null && step<1) {
					node = node.left;
					children = 1;
					step++;
				}
				if (node.left != null && node.right != null && step<1) {
						node = node.left;
						children = 2;
					while (node.right != null) {
						node = node.right;
					}
				}
			return node;
		}
		return null;
	}

	private Node getParent(int key) {
		Node node = root;
		while (key != node.key) {
			if (key > node.key) {
				if (node.right != null && key == node.right.key) {
					return node;
				}
				node = node.right;
			}
			if (key < node.key) {
				if (node.left != null && key == node.left.key) {
					return node;
				}
				node = node.left;
			}
		}
		return null;
	}

	public PreorderIterator preorder() {
		return new PreorderIterator(root);
	}

	public LevelorderIterator levelorder() {
		return new LevelorderIterator(root);
	}
}