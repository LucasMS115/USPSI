public class Exp2 {

	public static void main(String[] args) {
		
		MyThread[] tr = new MyThread[10];
		
		for(int i=0; i<10; i++) {
			tr[i] = new MyThread(i, true);
		}
		
		try {
			tr[tr.length-1].join();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		
		System.out.println("Ending... \n------------------------------");

	}
	

}

class MyThread extends Thread{
	
	int id;
	
	MyThread(int id, boolean j){
		this.id = id;
		try {
			start();
			if(j)join(); //Tentando controlar as threads esperarem para executar ou nao
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}
	
	public void run() {
		System.out.println("Hello World " + id);
	}
	
}