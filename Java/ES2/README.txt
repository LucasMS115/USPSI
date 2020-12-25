Exercício de Computação Orientada a Objetos

Questão 2
Implemente as classes MatrixInputStream e MatrixOutputStream que funcionem de modo similar às classes DataInputStream e DataOutputStream, mas capazes de ler/escrever uma instância de uma classe Matrix em uma única operação.



Questão 3
Proponha uma implementação para a classe Matrix que implemente a interface Serializable e que personalize o seu mecanismo de seriação (ou seja, que defina os métodos


private void writeObject(java.io.ObjectOutputStream out)
     throws IOException

e

 private void readObject(java.io.ObjectInputStream in)
     throws IOException, ClassNotFoundException.