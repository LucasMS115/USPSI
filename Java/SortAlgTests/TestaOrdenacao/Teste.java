

import java.io.FileNotFoundException;
import java.nio.file.Path;
import java.nio.file.Paths;

public class Teste extends Algoritmos{
	
	public static void main (String[] args) throws FileNotFoundException{
		
		Path caminhoM = Paths.get("C:/Users/adm/Desktop/saidaMerge.txt");
		Path caminhoI = Paths.get("C:/Users/adm/Desktop/saidaInsertion.txt");

		testaMerge();		
		gravaTxt(caminhoM);
		
		testaInsertion();
		gravaTxt(caminhoI);
		
		System.out.println("The End");
		
	}

}