public class QSort {

	/**
	 * Quicksort the array a[] using m as cutoff to insertion sort.
	 */
	public static void quicksort(int[] a, int m) {
		quicksort(a, 0, a.length - 1, m);
	}

	/**
	 * Quicksort the subarray a[low .. high]. Uses median-of-three partitioning
	 * and a cutoff to insertion sort of m.
	 */
	private static void quicksort(int[] a, int low, int high, int m) {
		if (high <= low + m) {
			insertionsort(a, low, high);
		} else {
			inPlaceQuicksort(a, low, high, m);
		}
	}

	private static int MedianIndex(int[] a, int lowIndex, int highIndex) {
		int firstIndex, middleIndex, lastIndex, differenceIndex, medianIndex;
		firstIndex = lowIndex;
		lastIndex = highIndex;
		differenceIndex = (highIndex - lowIndex);
		if ((differenceIndex + 1) % 2 == 0) {
			middleIndex = (differenceIndex) / 2;
		} else {
			middleIndex = (differenceIndex + 1) / 2;
		}

		medianIndex = compare(firstIndex, middleIndex, lastIndex, a);
		return medianIndex;
	}

	private static void inPlaceQuicksort(int[] a, int lowIndex, int highIndex,
			int cutPoint) {

		int medianIndex = MedianIndex(a, lowIndex, highIndex);
		int temp;
		temp = a[medianIndex];
		int median = a[medianIndex];
		a[medianIndex] = a[highIndex];
		a[highIndex] = temp;
		int leftInd = lowIndex;
		int rightInd = highIndex - 1;
		while (leftInd <= rightInd) {
			while ((leftInd <= rightInd) && a[leftInd] < median) {
				leftInd++;
			}
			while ((rightInd >= leftInd) && a[rightInd] > median) {
				rightInd--;
			}
			if (leftInd < rightInd) {
				temp = a[rightInd];
				a[rightInd] = a[leftInd];
				a[leftInd] = temp;
			}
		}
		temp = a[highIndex];
		a[highIndex] = a[leftInd];
		a[leftInd] = temp;
		
		if (leftInd - 1 <= lowIndex + cutPoint) {
			quicksort(a, lowIndex, leftInd - 1, cutPoint);
		}else if ((leftInd - 1 - lowIndex + cutPoint)>1){
			insertionsort(a, lowIndex, leftInd - 1);
		}
		if (highIndex <= leftInd + 1 + cutPoint) {
			quicksort(a, leftInd + 1, highIndex, cutPoint);
		}else if ((highIndex - leftInd + 1 + cutPoint)>1){
			insertionsort(a, leftInd + 1, highIndex);
		}
	}

	private static int compare(int a, int b, int c, int[] d) {
		if (d[a] > d[b] && d[a] < d[c] || d[a] < d[b] && d[a] > d[c]) {
			return a;
		} else if (d[b] > d[a] && d[b] < d[c] || d[b] < d[a] && d[b] > d[c]) {
			return b;
		} else {
			return c;
		}
	}

	/**
	 * Sort from a[low] to a[high] using insertion sort.
	 */
	private static void insertionsort(int[] a, int low, int high) {
		int temp = 0;
		int j = 0;
		for (int i = low; i <= high; i++) {
			j = i;
			temp = a[i];
			while (j >= low + 1 && a[j - 1] > temp) {
				a[j] = a[j - 1];
				j = j - 1;
			}
			a[j] = temp;
		}
	}
}