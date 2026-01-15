class Calculadora:
    """
    Classe responsável por operações matemáticas básicas.
    Implementada seguindo TDD (Test Driven Development).
    """

    def somar(self, a, b):
        return a + b

    def subtrair(self, a, b):
        return a - b

    def multiplicar(self, a, b):
        return a * b

    def dividir(self, a, b):
        if b == 0:
            raise ValueError("Divisão por zero não é permitida")
        return a / b
