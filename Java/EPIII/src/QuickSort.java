
public class QuickSort implements StrategyOrdena{
	
	public boolean criterio1(Produto w, Produto x) {
		return w.getDescricao().compareToIgnoreCase(x.getDescricao()) > 0;
	}
	
	public boolean criterio2(Produto w, Produto x) {
		return w.getDescricao().compareToIgnoreCase(x.getDescricao()) < 0;
	}
		
	public int particiona(int ini, int fim, Produto[] produtos){

		Produto x = produtos[ini];
		int i = (ini - 1);
		int j = (fim + 1);
		
		while(true){
			
			do{ 
				j--;
				
			} while(criterio1(produtos[j], x));
		
			do{
				i++;

			} while(criterio2(produtos[i], x));

			if(i < j){
				Produto temp = produtos[i];
				produtos[i] = produtos[j]; 				
				produtos[j] = temp;
			}
			else return j;
		}
		
	}

	public void quickSort(int ini, int fim, Produto[] produtos) {
		
		if(ini < fim) {

			int q = particiona(ini, fim, produtos);
			
			quickSort(ini, q, produtos);
			quickSort(q + 1, fim, produtos);
		}	
	}

	@Override
	public void ordena(Produto[] produtos) {
		quickSort(0, produtos.length - 1, produtos);		
	}
}
