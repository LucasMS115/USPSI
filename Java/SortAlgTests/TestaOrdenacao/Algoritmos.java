	
	import java.io.FileInputStream;
	import java.io.FileNotFoundException;
	import java.nio.file.Files;
	import java.nio.file.Path;
	import java.util.Scanner;

	public class Algoritmos {
		
		static long inicioAlg;
		static long fimAlg;
		static long inicioLeit;
		static long fimLeit;
		static String nomeTxt;
		static int nroElem;
		static int[] array;
		static int nArrays = 1;
		static String karr = "K";
		
		static String saidaFinal = "";
		
	    private static void merge(int[] A, int left, int mid, int right) {
	        int[] aux = new int[right - left + 1];
	        int a = left;
	        int b = mid + 1;
	        int c = 0;
	        while (a <= mid && b <= right) {
	            if (A[a] < A[b]) {
	                aux[c++] = A[a++];
	            } else {
	                aux[c++] = A[b++];
	            }
	        }
	        while (a <= mid) {
	            aux[c++] = A[a++];
	        }
	        while (b <= right) {
	            aux[c++] = A[b++];
	        }
	        for (c = 0; c < aux.length; c++) {
	            A[left++] = aux[c];
	        }
	    }

	    static void mergeSort(int[] A, int esq, int dir) {
	        int meio = (esq + dir) / 2;
	        if (esq < dir) {
	            mergeSort(A, esq, meio);
	            mergeSort(A, meio + 1, dir);
	            merge(A, esq, meio, dir);
	        }
	    }
	    
	    static void insertionSort(int[] vetor) {
	        int j;
	        int key;
	        int i;
	        
	        for (j = 1; j < vetor.length; j++)
	        {
	          key = vetor[j];
	          for (i = j - 1; (i >= 0) && (vetor[i] > key); i--)
	          {
	             vetor[i + 1] = vetor[i];
	           }
	            vetor[i + 1] = key;
	        }
	    }
	    
	    static void imprimir(int[] array){
	    	System.out.println();
	    	for(int i = 0; i < array.length; i++){
	    		System.out.println(array[i] + " ");
	    	}
	    	System.out.println();
	    }
	    
	    static void testaMerge() throws FileNotFoundException {
	    	
			for(int k = 0; k <= 3; k++) {
				
				if(k == 3) {
					karr = "M";
					nArrays = 1;
				}
			
				for(int i = 1; i <= 250; i++){
					
					array = leTxt(nArrays, karr, i);
					
					inicioAlg = System.nanoTime();
					
					mergeSort(array, 0, nroElem - 1);
					
					fimAlg = System.nanoTime();
					
					System.out.println(nomeTxt);
					
					saidaFinal += nomeTxt + " " + nroElem + " " + (fimLeit - inicioLeit)
							+ " " + (fimAlg - inicioAlg) + " Dell_Vostro_i5-3230M_2.60GHz" + " MergeSort "
							+ "Java1.8.0_221 " + "Windows10 " + "64 " + "N/A " + "11270736\n";
					
				}
				
				nArrays = nArrays*10;
			
			}
	    	
	    }
	    

	    static void testaInsertion() throws FileNotFoundException {
	    	
			for(int k = 0; k <= 3; k++) {
				
				if(k == 3) {
					karr = "M";
					nArrays = 1;
				}
			
				for(int i = 1; i <= 250; i++){
					
					array = leTxt(nArrays, karr, i);
					
					inicioAlg = System.nanoTime();
					
					insertionSort(array);
					
					fimAlg = System.nanoTime();
					
					System.out.println(nomeTxt);
					
					saidaFinal += nomeTxt + " " + nroElem + " " + (fimLeit - inicioLeit)
							+ " " + (fimAlg - inicioAlg) + " Dell_Vostro_i5-3230M_2.60GHz" + " InsertionSort "
							+ "Java1.8.0_221 " + "Windows10 " + "64 " + "N/A " + "11270736\n";
					
				}
				
				nArrays = nArrays*10;
			
			}
	    }
	    
	    static int[] leTxt(int nArrays, String karr, int i) throws FileNotFoundException {
			
			nomeTxt =nArrays + karr +"_Array_" + i +".txt";
			
			Scanner sc = new Scanner (new FileInputStream(nomeTxt));
			
			nroElem = Integer.parseInt(sc.nextLine());
			
			int[] array = new int[nroElem];	
			String aux[] = new String[nroElem];
			
			inicioLeit = System.nanoTime();
		
			for(int j = 0; j < array.length; j++){
				aux[j] = sc.nextLine();
			}

			fimLeit = System.nanoTime();
			
			for(int j = 0; j < array.length; j++){
				array[j] = Integer.parseInt(aux[j]);
			}	
			
			sc.close();
			
			return array;
			
		}		
	    
	    static void gravaTxt(Path caminho) {
	    	
			byte[] textoEmByte = saidaFinal.getBytes();
			try {
				Files.write(caminho, textoEmByte);
			}catch(Exception e){}
			
			saidaFinal = "";
	    }
	    
	}



