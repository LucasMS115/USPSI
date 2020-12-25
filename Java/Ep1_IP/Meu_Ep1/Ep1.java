
/****************************************
nome: [Lucas Mendes Sales]
nusp: [11270736]
*****************************************/


import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.util.Scanner;

public class Ep1 {
    public static void main(String args[]) throws FileNotFoundException {
        
        
    	int n = 14; //numero de caracteristicas e pesos
		
		Scanner sc = new Scanner (new FileInputStream("exemplo1.txt"));
		Scanner sc2 = new Scanner (sc.nextLine());
		
		int nCargos = sc2.nextInt(); //numero de cargos no arquivo .txt
		
		String[] cargos = new String[nCargos]; //array com os nomes dos cargos
		String[] p = new String[nCargos]; //array com cada linha correspondendo aos pesos dos determinados cargos
		
		//o bloco abaixo adiciona os valores do arquivo .txt aos arrays
		
		for (int i = 0; i < nCargos; i++){
			cargos[i] = sc.nextLine();
			p[i] = sc.nextLine();
		}
		
		int nPessoas = sc.nextInt();
		String aux2 = sc.nextLine();
		
		String[] pessoas = new String[nPessoas];
		String[] pontos = new String[nPessoas];
		
		for (int i = 0; i < nPessoas; i++){
			
			pessoas[i] = sc.nextLine();
			pontos[i] = sc.nextLine();
					
		}
		
		double[][] pesos = new double[nCargos][n];
		
		
		//o bloco abaixo separa os itens do array que contem os pesos em colunas de uma matriz de tipo double
		
		for (int i = 0 ; i < nCargos; i++){
			Scanner sc3 = new Scanner(p[i]);
				for(int j = 0; j < n; j++){
				pesos[i][j] = Double.parseDouble(sc3.next()); 
			}
		}
		
		double[][] notas = new double[nPessoas][n];
		
		for (int i = 0 ; i < nPessoas; i++){
			Scanner sc3 = new Scanner(pontos[i]);
				for(int j = 0; j < n; j++){
				notas[i][j] = Double.parseDouble(sc3.next()); 
			}
		}
		
		double[][] notasFinal = new double [nCargos][nPessoas];	// matriz que recebera as notas apos as operacoes com os pesos 
		double soma = 0;
		double mpc = 0; //media pessoa-cargo
		
		for(int i = 0; i < nCargos; i++){
			for(int j = 0; j < nPessoas;){
				for(int l = 0; l < nPessoas;l++){
					for(int k = 0; k < n; k++){
						soma += notas[j][k] * pesos[i][k]; //variavel recebe a soma das notas multiplicadas pelos determinados pesos
					}
					
					mpc = soma/somaLinha(pesos,i,n); //calculo da media dividindo a soma das notas multiplicadas pelos pesos soma dos pesos 
					notasFinal[i][l] = mpc;

					soma = 0;
					j++;
					
				}

			}

		}

		
		double[] arrayNotasFinal = new double [nPessoas];
		
		for(int i = 0; i < nCargos; i++){
			
			String[] aux = new String[nPessoas];
				
				for(int j = 0; j < nPessoas; j++){ 
					arrayNotasFinal[j] = notasFinal[i][j]; // atribui os valores de uma linha da matriz a um array
					aux[j] = pessoas[j]; //recebe os valores do array pessoas para ser ordenado junto das array de notas
				}
				ordemDecrescenteA(arrayNotasFinal,aux);
				System.out.println(cargos[i]);
				printArrayS(aux);//candidatos ordenados pelas notas
				System.out.println("");
		}
	
		
    }
      

	public static void printArrayS (String[] array){
		
		for (int i = 0; i < array.length;i++){

			if(i != array.length - 1){
				System.out.println(array[i]);
			}else{
				System.out.println(array[i]);
			}
		} 
	}
	
	
	public static double somaLinha (double[][]matriz, int l, int n){ //(matriz, linha da matriz, numero de colunas da matriz)
		double soma = 0;
		for(int i = 0; i < n; i++){
			soma += matriz[l][i];
		}
	return soma;	
	}
	
	
	public static void maiorFrente (double[] array1, String[] array2 ){


		for(int i = array1.length - 2; i >= 0 ; i--){


			if(array1[i] < array1[i + 1]){
				troca(array1,array2,i);
			}else{}	
		
		}

	}
	

	public static void troca (double[] a, String[] b, int t){

		if (t > a.length - 2){

		}else{
		double x = a[t]; 		
		a[t] = a[t+1];
		a[t+1] = x;	
		String y = b[t];
		b[t] = b[t+1];
		b[t+1] = y;
		}			

	}
	
	public static void ordemDecrescenteA (double[] array1, String[] array2){

		int tamanho = array1.length - 2;
		int ate = 0;
		
		for(int i = tamanho; i >= 0; i--){
		
			for(int j = tamanho; j >= ate ; j--){
		
				maiorFrente(array1,array2);
			
			}
			
			ate++;
		}	
	}
	
	
}
