Exercício de Computação orientada a Objetos

Questão 3
Considere o seguinte cenário: você está trabalhando em projeto no qual é definida a classe FormaGeométrica que possui,
 entre outros, um atributo privado chamado cor, do tipo Cor, acessível através de um getter. A classe Cor, por sua vez,
 possui três atributos privados r, g e b, definidos através do construtor da classe, que representam, respectivamente,
 as componentes vermelha, verde e azul de uma determinada cor (os três atributos são do tipo inteiro, 
podendo assumir valores entre 0 e 255). A partir deste cenário, escreva um método que recebe uma Collection de objetos
 do tipo FormaGeométrica e os categorizem de acordo com suas cores, ou seja, devolva uma coleção composta por sub
 coleções, onde cada sub coleção contém objetos de mesma cor (isto é, com os mesmos valores para as componentes r, g e b).
 Escreva seu método de modo a tirar o máximo proveito da API de coleções do Java, tanto em relação à facilidade de
 codificação, quanto em relação ao eficiência do método.