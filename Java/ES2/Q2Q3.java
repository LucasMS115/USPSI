import java.io.*;

class Matrix implements Serializable{

	private static final long serialVersionUID = 1L;
	private int x;
	private int y;
	private int[][] m; 

	
	public Matrix(){
			
	}
	
	public Matrix(int x, int y){
		this.x = x;
		this.y = y;
		this.m = new int [x][y];	
	}
	
	private void readObject(java.io.ObjectInputStream in) throws IOException{
		for(int i = 0; i < this.x; i++) {
			for(int j = 0; j < this.y; j++) {	
				this.m[i][j] = (int) in.readInt();
			}
		}
		in.close();
	}
	
	private void writeObject(java.io.ObjectOutputStream out) throws IOException{
		for(int i = 0; i < this.x; i++) {
			for(int j = 0; j < this.y; j++) {	
				out.writeInt(this.m[i][j]);
			}
		}
		out.close();
	}
	
	public int getX() {
		return this.x;
	}
	
	public int getY() {
		return this.y;
	}
	
	public int getValue(int x, int y) {
		if(x < 0 || x >= this.x || y < 0 || y >= this.y) return 000; 
		return this.m[x][y];
	}
	
	public boolean setValue(int x, int y, int value) {
		if(x < 0 || x >= this.x || y < 0 || y >= this.y) return false;
		this.m[x][y] = value;
		return true;
	}
	
	public void printMatrix() {

		for(int i = 0; i < this.x; i++) {
			for(int j = 0; j < this.y; j++) {
				System.out.print(this.m[i][j] + " ");
			}
			System.out.println();
		}
	}
}

class MatrixOutputStream {
	DataOutputStream out;
	String file;
	
	MatrixOutputStream(String file) throws FileNotFoundException, IOException{
		this.file = file;
		out = new DataOutputStream(new BufferedOutputStream(new FileOutputStream(file)));
	}
	
	public boolean writeMatrix(Matrix m) throws IOException {
		
		if(m == null) return false;	
		
		for(int i = 0; i < m.getX(); i++) {
			for(int j = 0; j < m.getY(); j++) {
				out.writeInt(m.getValue(i, j));
			}
		}
			
		return true;
	}
	
	public void close() throws IOException {
		out.close();
	}
}

class MatrixInputStream {
	DataInputStream in;
	String file;
	
	MatrixInputStream(String file) throws FileNotFoundException, IOException{
		this.file = file;
		in = new DataInputStream(new BufferedInputStream(new FileInputStream(file)));
	}
	
	public void readMatrix(Matrix m) throws IOException {
		
		for(int i = 0; i < m.getX(); i++) {
			for(int j = 0; j < m.getY(); j++) {	
				m.setValue(i, j,(int) in.readInt());
			}
		}		
		
	}
	
	public void close() throws IOException {
		in.close();
	}
}



