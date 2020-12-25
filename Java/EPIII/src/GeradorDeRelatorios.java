import java.io.PrintWriter;
import java.awt.Color;
import java.io.IOException;

public class GeradorDeRelatorios {

	private Produto [] produtos;
	private StrategyFiltro f;
	private StrategyOrdena ord;

	public GeradorDeRelatorios(Produto [] produtos, StrategyOrdena ord, StrategyFiltro f){

		this.produtos = new Produto[produtos.length];
		
		for(int i = 0; i < produtos.length; i++){
		
			this.produtos[i] = produtos[i];
		}

		this.ord = ord;
		this.f = f;
	}

	
	
	public void geraRelatorio(String arquivoSaida) throws IOException {

		ord.ordena(this.produtos); //Oredenacao dos produtos 

		PrintWriter out = new PrintWriter(arquivoSaida);
		
		out.println("<!DOCTYPE html><html>");
		out.println("<head><title>Relatorio de produtos</title></head>");
		out.println("<body>");
		out.println("Relatorio de Produtos:");
		out.println("<ul>");

		Produto[] filtrados = f.filtra(produtos); //Filtragem dos produtos
		
		//Escrevendo os produtos que passaram no filtro no arquivo de saida
		int count = 0;
		Produto atual = filtrados[count];
		
		while(atual != null) {
			
				out.print("<li>");
			
				out.print(atual.formataParaImpressao());

				out.println("</li>");
				
				count++;
				
				if(count < filtrados.length) {
					atual = filtrados[count];
				}else {
					atual = null; //Break
				}
				
				
		}
		
		out.println("</ul>");
		out.println(count + " produtos listados, de um total de " + produtos.length + ".");
		out.println("</body>");
		out.println("</html>");

		out.close();
	}

	public static Produto [] carregaProdutos(){

		return new Produto [] { 

			new ProdutoItalico(new ProdutoNegrito(new ProdutoPadrao( 1, "O Hobbit", "Livros", 2, 34.90))),
			new ProdutoPadrao( 2, "Notebook Core i7", "Informatica", 5, 1999.90),
			new ProdutoPadrao( 3, "Resident Evil 4", "Games", 7, 79.90),
			new ProdutoPadrao( 4, "iPhone", "Telefonia", 8, 4999.90),
			new ProdutoItalico(new ProdutoNegrito(new ProdutoColorido(new ProdutoPadrao( 5, "Calculo I", "Livros", 20, 55.00), Color.orange))),
			new ProdutoPadrao( 6, "Power Glove", "Games", 3, 499.90),
			new ProdutoPadrao( 7, "Microsoft HoloLens", "Informatica", 1, 19900.00),
			new ProdutoPadrao( 8, "OpenGL Programming Guide", "Livros", 4, 89.90),
			new ProdutoPadrao( 9, "Vectrex", "Games", 1, 799.90),
			new ProdutoPadrao(10, "Carregador iPhone", "Telefonia", 15, 499.90),
			new ProdutoPadrao(11, "Introduction to Algorithms", "Livros", 7, 315.00),
			new ProdutoPadrao(12, "Daytona USA (Arcade)", "Games", 1, 12000.00),
			new ProdutoColorido(new ProdutoPadrao(13, "Neuromancer", "Livros", 5, 45.00), Color.blue),
			new ProdutoPadrao(14, "Nokia 3100", "Telefonia", 4, 249.99),
			new ProdutoPadrao(15, "Oculus Rift", "Games", 1, 3600.00),
			new ProdutoPadrao(16, "Trackball Logitech", "Informatica", 1, 250.00),
			new ProdutoPadrao(17, "After Burner II (Arcade)", "Games", 2, 8900.0),
			new ProdutoPadrao(18, "Assembly for Dummies", "Livros", 30, 129.90),
			new ProdutoPadrao(19, "iPhone (usado)", "Telefonia", 3, 3999.90),
			new ProdutoPadrao(20, "Game Programming Patterns", "Livros", 1, 299.90),
			new ProdutoPadrao(21, "Playstation 2", "Games", 10, 499.90),
			new ProdutoPadrao(22, "Carregador Nokia", "Telefonia", 14, 89.00),
			new ProdutoPadrao(23, "Placa Aceleradora Voodoo 2", "Informatica", 4, 189.00),
			new ProdutoPadrao(24, "Stunts", "Games", 3, 19.90),
			new ProdutoPadrao(25, "Carregador Generico", "Telefonia", 9, 30.00),
			new ProdutoPadrao(26, "Monitor VGA 14 polegadas", "Informatica", 2, 199.90),
			new ProdutoPadrao(27, "Nokia N-Gage", "Telefonia", 9, 699.00),
			new ProdutoPadrao(28, "Disquetes Maxell 5.25 polegadas (caixa com 10 unidades)", "Informatica", 23, 49.00),
			new ProdutoPadrao(29, "Alone in The Dark", "Games", 11, 59.00),
			new ProdutoColorido(new ProdutoPadrao(30, "The Art of Computer Programming Vol. 1", "Livros", 3, 240.00), Color.pink),
			new ProdutoItalico(new ProdutoPadrao(31, "The Art of Computer Programming Vol. 2", "Livros", 2, 200.00)),
			new ProdutoColorido(new ProdutoNegrito(new ProdutoPadrao(32, "The Art of Computer Programming Vol. 3", "Livros", 4, 270.00)), Color.red)
		};
	} 

	public static void main(String [] args) {
	
		Produto [] produtos = carregaProdutos();
		
		//Exemplos para filtro e aloritimo de ordenacao
		StrategyOrdena ord1 = new InsertionSort(); //Ordem alfabetica
		StrategyOrdena ord2 = new InsertionEstCresc(); //Qtd no estoque
		StrategyOrdena ord3 = new InsertionPrecoCresc(); //Preço
		StrategyOrdena ord4 = new InsertionSortDec();
		StrategyOrdena ord5 = new InsertionEstDec();
		StrategyOrdena ord6 = new InsertionPrecoDec();
		
		StrategyOrdena ord7 = new QuickSort(); //Ordem alfabetica
		StrategyOrdena ord8 = new QuickEstCresc(); //Qtd no estoque
		StrategyOrdena ord9 = new QuickPrecoCresc(); //Preço
		StrategyOrdena ord10 = new QuickSortDec();
		StrategyOrdena ord11 = new QuickEstDec();
		StrategyOrdena ord12 = new QuickPrecoDec();
		
		StrategyFiltro f1 = new Filtro(); //Todos os itens
		StrategyFiltro f2 = new FiltroCategoria("Livros");
		StrategyFiltro f3 = new FiltroQtdEst(10); // quantidade no estoque menor igual a
		double[] inter = {100, 300};
		StrategyFiltro f4 = new FiltroIntervalo(inter); // intervalo de preco
		StrategyFiltro f5 = new FiltroContem("carregador"); //descricao contem a string 
		
		GeradorDeRelatorios gdr;

		gdr = new GeradorDeRelatorios(produtos, ord3,f5);
		
		try{
			gdr.geraRelatorio("saida.html");
		}
		catch(IOException e){
			
			e.printStackTrace();
		}
	}
}
