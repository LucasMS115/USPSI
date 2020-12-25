
public class InsertionSort implements StrategyOrdena{
	
	public boolean criterio(Produto x, Produto y) {
		return x.getDescricao().compareToIgnoreCase(y.getDescricao()) < 0;
	}

	public void ordena(Produto[] produtos) {
		
		int ini = 0;
		int fim = produtos.length - 1;
		
		for(int i = ini; i <= fim; i++){

			Produto x = produtos[i];				
			int j = (i - 1);

			while(j >= ini){

					if( criterio(x, produtos[j])){
		
						produtos[j + 1] = produtos[j];
						j--;
					}
					else break;

					produtos[j + 1] = x;
			}
		}

	}

}
