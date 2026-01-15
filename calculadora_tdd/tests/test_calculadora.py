import pytest
from calculadora.calculadora import Calculadora

def test_soma():
    assert Calculadora().somar(2, 3) == 5

def test_subtracao():
    assert Calculadora().subtrair(5, 3) == 2

def test_multiplicacao():
    assert Calculadora().multiplicar(2, 4) == 8

def test_divisao():
    assert Calculadora().dividir(10, 2) == 5

def test_divisao_por_zero():
    with pytest.raises(ValueError):
        Calculadora().dividir(10, 0)
