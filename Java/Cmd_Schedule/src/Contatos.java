
public class Contatos {
	
	//private static int contador = 0;
	
	private int id;
	private String nome;
	private String telefone;
	private String eMail;
	public String tipo;
	
	public Contatos() {
		//contador++;
		//id = contador;
	}
	
	public Contatos(int id, String nome, String telefone, String eMail) {
		//contador++;
		//id = contador;
		this.id = id;
		this.nome = nome;
		this.telefone = telefone;
		this.eMail = eMail;
	}
	
	public Contatos( String nome, String telefone, String eMail) {
		this.nome = nome;
		this.telefone = telefone;
		this.eMail = eMail;
	}
	
	/*public int getContador() {
		return contador;
	}
	
	public void setContador(int contador) {
		this.contador = contador;
	}*/
	
	public int getId() {
		return this.id;
	}
	
	public void setId(int id) {// nao eh interessante dar este poder para o usuario
		this.id = id;
	}
	
	public String getNome() {
		return this.nome;
	}
	
	public void setNome(String nome) {
		this.nome = nome;
	}
	
	public String getTelefone() {
		return this.telefone;
	}
	
	public void setTelefone(String telefone) {
		this.telefone = telefone;
	}
	
	public String getEMail() {
		return this.eMail;
	}
	
	public void setEMail(String eMail) {
		this.eMail = eMail;
	}
	
	public String getTipo() {
		return tipo;
	} 
	
	public void setTipo(String tipo) {
		this.tipo = tipo;
	}
	
	public String toString() {
		
		String s = "[";
		s+= "Id = " + id;
		s+="; Nome = " + nome ;
		s+="; Telefone = " + telefone ;
		s+= "; E-Mail = " + eMail;
		s+= "]";
		
		return s;
	}
}
