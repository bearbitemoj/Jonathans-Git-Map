import java.util.Random;

public class QSortMain {

	private static int N = 50000;
	private static int n = 30;
	private static int m = 20;

	public static void main(String[] args) throws Exception {
		int[] a = new int[N];
		int value;
		Random test;
		for (int i = 0; i < N; i++) {
			test = new Random();
			value = test.nextInt(50000000);
			a[i] = value;
		}
		QSort.quicksort(a, m);
		if (checkOrder(a)) {
			System.out.println("KLAR");
			writeOutOrderOf(n, a);
		}
	}

	private static boolean checkOrder(int[] a) {
		boolean res = true;
		for (int i = 1; i < a.length; i++) {
			if (a[i] < a[i - 1]) {
				System.out.println("Order violated at index " + i
						+ " with value " + a[i]);
				res = false;
			}
		}
		return res;
	}

	private static void writeOutOrderOf(int n, int [] a) {
		for (int i = 1; i < n; i++) {
			System.out.println(a[i]);
		}
	}

}
