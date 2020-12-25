
public class ContatoNaoEncontradoException extends Exception{
	
	private String nomeContato;
	private int idContato;
	
	public ContatoNaoEncontradoException(int idContato) {
		this.idContato = idContato;
	}
	
	public ContatoNaoEncontradoException(String nomeContato) {
		this.nomeContato = nomeContato;
	}
	
	@Override
	public String getMessage() {
		if(nomeContato != null) {
			return "Contato" + nomeContato + " nao encontrado!";
		}else {
			return "Contato " + idContato + " nao encontrado!";
		}
	}
}
