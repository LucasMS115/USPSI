import java.awt.Color;
import java.util.*;

public class Categorizer {
	
	public static HashSet<ArrayList<FormaGeometrica>> byColor(ArrayList<FormaGeometrica> c){
		
		HashSet<ArrayList<FormaGeometrica>> categorized = new HashSet<>();
		boolean exists = false;
		
		//Percorre a lista c observando as cores dos elementos
		for (Iterator<FormaGeometrica> it = c.iterator(); it.hasNext();) {
    		FormaGeometrica f = it.next();
			Color a = f.getCor();
    		
			//Percorre o set categorized comparando a cor da forma atual com a cor do primeiro elemento de cada lista
    		for (Iterator<ArrayList<FormaGeometrica>> iter = categorized.iterator(); iter.hasNext();) {
        		ArrayList<FormaGeometrica> nextList = iter.next();
        		Color b = nextList.get(0).getCor();
        		
        		//se as cores forem iguais, adiciona a forma a lista atual e sai laço
        		if(a == b) {
        			nextList.add(f);
        			exists = true;
        			break;
        		}
        	};
        	
        	//se a cor da forma atual não tem nenhuma lista relacionada a ela, cria uma nova e adiciona a forma na nova lista
        	if(!exists) {
        		ArrayList<FormaGeometrica> n = new ArrayList<>();
        		n.add(f);
        		categorized.add(n);
        	}
        	
    	};
		
		return categorized;
	} 
	
}