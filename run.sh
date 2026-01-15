#!/bin/bash
set -e

# ==============================================================
# CONFIGURAÇÕES
# ==============================================================
PROJECT="calculadora_tdd"
VENV="venv"

# Cores
RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
RESET="\033[0m"

type_text() {
    text="$1"
    for ((i=0; i<${#text}; i++)); do
        printf "%s" "${text:$i:1}"
        sleep 0.01
    done
    echo
}

clear
echo -e "${BLUE}==============================================================${RESET}"
type_text " EXECUÇÃO DO PROJETO — TDD REAL COM PYTEST"
echo -e "${BLUE}==============================================================${RESET}"
echo

# ==============================================================
# DETECTAR SISTEMA
# ==============================================================
type_text "🔍 Detectando sistema operacional..."

if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
    type_text "✔ Sistema detectado: $PRETTY_NAME"
else
    echo -e "${RED}❌ Não foi possível detectar o sistema${RESET}"
    exit 1
fi
echo

# ==============================================================
# INSTALAR PYTHON
# ==============================================================
type_text "📦 Verificando Python..."

install_arch() {
    sudo pacman -Sy --noconfirm python python-pip
    PYTHON=python
}

install_debian() {
    sudo apt update
    sudo apt install -y python3 python3-pip python3-venv
    PYTHON=python3
}

case "$OS" in
    arch|manjaro) install_arch ;;
    ubuntu|debian|linuxmint|pop) install_debian ;;
    *)
        echo -e "${RED}❌ Distro não suportada automaticamente${RESET}"
        exit 1
        ;;
esac

echo -e "${GREEN}✔ Python pronto${RESET}"
echo

# ==============================================================
# CRIAR ESTRUTURA DO PROJETO
# ==============================================================
type_text "📂 Criando estrutura do projeto..."

mkdir -p $PROJECT/{calculadora/versions,tests}
touch $PROJECT/calculadora/__init__.py
touch $PROJECT/tests/__init__.py

# __init__.py
cat <<EOF > $PROJECT/calculadora/__init__.py
from .calculadora import Calculadora
__all__ = ["Calculadora"]
EOF

# TESTES
cat <<EOF > $PROJECT/tests/test_calculadora.py
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
EOF

# VERSÕES TDD
cat <<EOF > $PROJECT/calculadora/versions/calculadora_red.py
class Calculadora:
    pass
EOF

cat <<EOF > $PROJECT/calculadora/versions/calculadora_green.py
class Calculadora:
    def somar(self, a, b): return a + b
    def subtrair(self, a, b): return a - b
    def multiplicar(self, a, b): return a * b
    def dividir(self, a, b):
        if b == 0: raise ValueError("Divisão por zero")
        return a / b
EOF

cat <<EOF > $PROJECT/calculadora/versions/calculadora_refactor.py
class Calculadora:
    def somar(self, a: float, b: float) -> float: return a + b
    def subtrair(self, a: float, b: float) -> float: return a - b
    def multiplicar(self, a: float, b: float) -> float: return a * b
    def dividir(self, a: float, b: float) -> float:
        if b == 0: raise ValueError("Divisão por zero não é permitida")
        return a / b
EOF

echo -e "${GREEN}✔ Estrutura criada${RESET}"
echo

cd $PROJECT

# ==============================================================
# VENV
# ==============================================================
type_text "🐍 Criando ambiente virtual..."

$PYTHON -m venv $VENV
source $VENV/bin/activate
pip install -q --upgrade pip pytest

echo -e "${GREEN}✔ Ambiente pronto${RESET}"
echo

# ==============================================================
# CICLO TDD REAL
# ==============================================================
type_text "▶ Iniciando CICLO TDD REAL (RED → GREEN → REFACTOR)"
echo

# 🔴 RED
echo -e "${RED}🔴 FASE RED — testes DEVEM falhar${RESET}"
cp calculadora/versions/calculadora_red.py calculadora/calculadora.py
pytest && { echo -e "${RED}❌ ERRO: RED não falhou${RESET}"; exit 1; } \
|| echo -e "${GREEN}✔ RED confirmado (falhou como esperado)${RESET}"
sleep 2

# 🟢 GREEN
echo
echo -e "${GREEN}🟢 FASE GREEN — código mínimo${RESET}"
cp calculadora/versions/calculadora_green.py calculadora/calculadora.py
pytest
echo -e "${GREEN}✔ GREEN confirmado${RESET}"
sleep 2

# ♻️ REFACTOR
echo
echo -e "${YELLOW}♻️ FASE REFACTOR — melhoria segura${RESET}"
cp calculadora/versions/calculadora_refactor.py calculadora/calculadora.py
pytest
echo -e "${GREEN}✔ REFACTOR confirmado${RESET}"

echo
echo -e "${BLUE}==============================================================${RESET}"
echo -e "${GREEN}✅ CICLO TDD EXECUTADO COM SUCESSO — TDD REAL${RESET}"
echo -e "${BLUE}==============================================================${RESET}"
