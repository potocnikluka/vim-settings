import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.StringTokenizer;

public class x {
	static class FastReader {                                                                        
		BufferedReader br;
		StringTokenizer st;

		public FastReader() {
			br = new BufferedReader(new InputStreamReader(System.in));
		}
		String next() throws IOException {
			while (st == null || !st.hasMoreElements()) {
				st = new StringTokenizer(br.readLine());
			}
			return st.nextToken();
		}
		int nextInt() throws IOException {
			return Integer.parseInt(next());
		}
		//String nextLine() throws IOException {
		//	return br.readLine();
		//}
		//int nextDouble() throws IOException {
		//	return Double.parseDouble(next());
		//}
		//int nextLong() throws IOException {
		//	return Long.parseLong(next());
		//}
		void close() throws IOException {
			this.br.close();
		}
	}

	public static void main (String[] args) throws IOException {
		FastReader fr = new FastReader();
		fr.close();
	}
}
