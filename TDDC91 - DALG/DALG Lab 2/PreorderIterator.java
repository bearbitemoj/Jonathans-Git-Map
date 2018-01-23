import java.util.Iterator;

public class PreorderIterator implements Iterator<Node> {
	protected Stack<Node> s;

	public PreorderIterator(Node tree) {
		s = new Stack<Node>();
		if (tree != null)
			s.push(tree);
	}

	public void remove() {
		// Leave empty
	}

	public Node next() {
			Node node = s.pop();
			
			if(node.right != null){
				s.push(node.right);
			}
			if(node.left != null){
				s.push(node.left);
			}
			
		return node;
		// To be completed
	}

	public boolean hasNext() {
		if(!s.isEmpty()){
			return true;
		}
		return false;
		// To be completed
	}
}