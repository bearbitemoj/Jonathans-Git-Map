import java.util.Iterator;

public class LevelorderIterator implements Iterator<Node> {
	protected Queue<Node> q;

	public LevelorderIterator(Node tree) {
		q = new Queue<Node>();
		if (tree != null){
			q.enqueue(tree);
		}
		// To be completed
	}

	public void remove() {
		// Leave empty
	}

	public Node next() {
		Node node = q.dequeue();
		if(node.left != null){
			q.enqueue(node.left);
		}
		if(node.right != null){
			q.enqueue(node.right);
		}
		return node;
		// To be completed
	}

	public boolean hasNext() {
		if(!q.isEmpty()){
			return true;
		}
		return false;
	}
}
