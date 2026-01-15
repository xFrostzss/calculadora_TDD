# Calculadora TDD - Engenharia de Software III

> Projeto prático para demonstração da metodologia **Test Driven Development (TDD)** com automação do ciclo Red-Green-Refactor.

![Python](https://img.shields.io/badge/Python-3.13-blue?style=for-the-badge&logo=python)
![Pytest](https://img.shields.io/badge/Pytest-8.0+-green?style=for-the-badge&logo=pytest)
![Status](https://img.shields.io/badge/Status-Concluído-success?style=for-the-badge)

## Sobre o Projeto

Este projeto foi desenvolvido como requisito avaliativo da disciplina de **Engenharia de Software III** no **Instituto Federal do Piauí (IFPI)**.

O objetivo principal não é apenas criar uma calculadora, mas demonstrar na prática a aplicação rigorosa do ciclo **TDD**. Para isso, desenvolvemos um **Orquestrador de Testes** (`tdd_runner.py`) que simula a evolução do código em tempo real, alternando entre as versões do software enquanto executa a bateria de testes automatizados.

## Funcionalidades

O módulo `CalculadoraService` implementa:
* ➕ Soma
* ➖ Subtração
* ✖️ Multiplicação
* ➗ Divisão (com tratamento de exceção para zero)
* 🔢 Verificação de paridade (`isPar`)
* ✅ Validação de números positivos

## Tecnologias Utilizadas

* **Python 3.13+**
* **Pytest**: Framework para execução dos testes unitários.
* **Rich**: Biblioteca para criar a interface visual interativa no terminal.
* **Shutil/OS**: Para manipulação de arquivos e orquestração das versões.

## Estrutura de Arquivos

A arquitetura foi pensada para permitir a troca dinâmica de versões durante a apresentação:

```text
CALCULADORA_TDD/
├── calculadora/           # Pacote principal (o código "vivo")
│   ├── __init__.py
│   └── calculadora.py     # Este arquivo é sobrescrito pelo script
├── tests/                 # Suíte de testes unitários
│   ├── __init__.py
│   └── test_calculadora.py
├── versions/              # Snapshots das fases do TDD
│   ├── calculadora_red.py      # Versão vazia (gera erro)
│   ├── calculadora_green.py    # Implementação mínima
│   └── calculadora_refactor.py # Versão final tipada
├── tdd_runner.py          # Script de automação (Orquestrador)
├── requirements.txt       # Dependências do projeto
└── README.md
