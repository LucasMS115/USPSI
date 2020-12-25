
import java.util.Scanner;

public class Teste {
	
	public static void main (String[] args) {
		
		Scanner scan = new Scanner(System.in);
		
		Agenda minhaAgenda = new Agenda();
		
		boolean loop = false;
		int opcaoLoop;
		
		while(!loop) {
		
			int opcaoMenu = obterOpcaoMenu();
			int opcaoConsulta;
			int opcaoTipo;
			
			//--------------------------------------------------------------
			
			if (opcaoMenu == 1) {
				
				opcaoTipo = obterOpcaoTipo();
				
				switch(opcaoTipo) {
				
				case 1: Trabalho t = new Trabalho();
					minhaAgenda.Salva(t, minhaAgenda);
					break;
				case 2: Familia f = new Familia();	
					minhaAgenda.Salva(f, minhaAgenda);
					break;
				case 3: Contatos a = new Amigos();	
					minhaAgenda.Salva(a, minhaAgenda);
					break;	
				case 4: Contatos c = new Contatos();	
					minhaAgenda.Salva(c, minhaAgenda);
					break;	
		}
				
			}
			
			//-----------------------------------------------------------------
			
			if (opcaoMenu == 2) {
				
				opcaoConsulta = obterOpcaoConsulta();
				
				if(opcaoConsulta == 1) {
					System.out.println("Digite o ID do contato desejado: ");
					try {
						System.out.println(minhaAgenda.consulta(scan.nextInt()));
					} catch (ContatoNaoEncontradoException e) {
						System.out.println(e.getMessage());
					}
				}
				
				if (opcaoConsulta == 2) {
					System.out.println("Digite o NOME do contato desejado: ");
					try {
						System.out.println(minhaAgenda.consulta(scan.nextLine()));
					} catch (ContatoNaoEncontradoException e) {
						System.out.println(e.getMessage());
					}
				}
			}
			
			//----------------------------------------------------------------
			
			if (opcaoMenu == 3) {
				
				boolean fail = true;
				
				//while(!fail) {
				
					System.out.println("Insira o ID do contato a ser deletado!");
					
					try {
						minhaAgenda.Deletar(scan.nextInt());
						fail = false;
					}catch(Exception e) {
						System.out.println("Entrada invalida!");
					}
				//}
			}
			
			//----------------------------------------------------------------
			
			if (opcaoMenu == 4) {		
				System.out.println(minhaAgenda);
			}
			
			//----------------------------------------------------------------
			
			if (opcaoMenu == 5) {		
				System.out.println("Ate a proxima!! :)");
				System.exit(0);
			}
			
			//----------------------------------------------------------------
			
			opcaoLoop = obterOpcaoLoop();
			if(opcaoLoop == 1) {
			}else {
				System.out.println("Ate a proxima!");
				loop = true;
			}
			
			
		}	
	}
	
	public static int obterOpcaoMenu() {
		
		Scanner scan = new Scanner(System.in);
		
		int o = 0;
		boolean entradaValida = false;
		
		while(!entradaValida) {
			System.out.println("Insira o numero da opção desejada: ");
			System.out.println("1 - Adicionar um contato na agenda.");
			System.out.println("2 - Consultar um contato da da agenda.");
			System.out.println("3 - Deletar um contato");
			System.out.println("4 - Mostrar toda a agenda");
			System.out.println("5 - Sair.");
			
			try {
				o = Integer.parseInt(scan.nextLine());
			}catch(Exception e) {
				System.out.println("Entrada invalida! Tente novamente:");
			}
			
			if (o == 1 || o == 2 || o == 3 || o == 4 || o == 5) {
				entradaValida = true; 
			}else {
				System.out.println("Entrada invalida! Tente outra vez:");
			}
			
		}
		
		return o;
	}
	
	public static int obterOpcaoTipo() {
		
		Scanner scan = new Scanner(System.in);
		
		int o = 0;
		boolean entradaValida = false;
		
		while(!entradaValida) {
			System.out.println("Insira o numero correspondente ao tipo do contato: ");
			System.out.println("1 - Trabalho.");
			System.out.println("2 - Familia.");
			System.out.println("3 - Amigos.");
			System.out.println("4 - Nenhum.");
			
			try {
				o = Integer.parseInt(scan.nextLine());
			}catch(Exception e) {
				System.out.println("Entrada invalida! Tente novamente:");
			}
			
			if (o == 1 || o == 2 || o == 3 || o == 4) {
				entradaValida = true; 
			}else {
				System.out.println("Entrada invalida! Tente outra vez:");
			}
			
		}
		return o;
	}
	
	public static int obterOpcaoConsulta() {
		
		Scanner scan = new Scanner(System.in);
		
		int o = 0;
		boolean entradaValida = false;
		
		while(!entradaValida) {
			
			System.out.println("Digite 1 para pesquisar por ID e 2 para pesquisar por NOME:");
			
			try {
				o = Integer.parseInt(scan.nextLine());
				
				if (o != 1 && o != 2) {
					throw new Exception("Entrada invalida");
				}else {
					entradaValida = true;
				}
				
			}catch(Exception e) {
				System.out.println("Entrada invalida! Tente novamente:");
			}	
		}
		
		return o;
	}
	
	public static int obterOpcaoLoop() {
		
		Scanner scan = new Scanner(System.in);
		
		int o = 0;
		boolean entradaValida = false;
		
		while(!entradaValida) {
			
			System.out.println("Digite 1 para realizar uma nova operacao ou 2 para sair:");
			
			try {
				o = Integer.parseInt(scan.nextLine());
				
				if (o != 1 && o != 2) {
					throw new Exception("Entrada invalida");
				}else {
					entradaValida = true;
				}
				
			}catch(Exception e) {
				System.out.println("Entrada invalida! Tente novamente:");
			}	
		}
		
		return o;
	}
	
	public static String leInfos( String msg) {
		Scanner scan = new Scanner(System.in);
		System.out.println(msg);
		String entrada = scan.nextLine();
		return entrada;
	}
	
	
}
