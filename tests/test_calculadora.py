import pytest
from calculadora.calculadora import Calculadora


def test_soma():
    calc = Calculadora()
    assert calc.somar(2, 3) == 5


def test_subtracao():
    calc = Calculadora()
    assert calc.subtrair(5, 3) == 2


def test_multiplicacao():
    calc = Calculadora()
    assert calc.multiplicar(2, 4) == 8


def test_divisao():
    calc = Calculadora()
    assert calc.dividir(10, 2) == 5


def test_divisao_por_zero():
    calc = Calculadora()
    with pytest.raises(ValueError):
        calc.dividir(10, 0)
