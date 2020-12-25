
public class Filtro implements StrategyFiltro{

	Object argFiltro;
	Produto[] filtrados;
	
	public boolean criterio(Object argFiltro, Produto p) {
		return true;
	}

	public Filtro() {
		this.argFiltro = "Sem filtro";
	}
	
	@Override
	public Produto[] filtra(Produto[] produtos) {
		
		this.filtrados = new Produto[produtos.length];
		int count = 0;

		for(int i = 0; i < produtos.length; i++){

			Produto p = produtos[i];
			if(criterio(argFiltro, p)) {
				this.filtrados[count] = p;
				count++;
			} 
				
		}	
		
		return this.filtrados;
	}
}
