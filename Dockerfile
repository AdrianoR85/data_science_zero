# Dockerfile

# 1. Imagem de Base
# Começamos com uma imagem oficial do Python, versão 3.9. É leve e estável.
FROM python:3.9-slim

# 2. Definir o Diretório de Trabalho
# Dentro do container, todo nosso trabalho acontecerá na pasta /app.
WORKDIR /app

# 3. Copiar os Arquivos para o Container
# Copia o arquivo de dependências e a pasta com o código do livro para dentro do container.
COPY requirements.txt .
COPY scratch/ ./scratch/

# 🛠️ Instalar git
RUN apt-get update && apt-get install -y git

# 4. Instalar as Dependências
# Executa o 'pip' para instalar as bibliotecas que listamos no requirements.txt.
RUN pip install --no-cache-dir -r requirements.txt

# 5. Expor a Porta
# Informa ao Docker que o container vai "ouvir" na porta 8888, que é a porta padrão do Jupyter.
EXPOSE 8888

# 6. Comando de Inicialização
# Este é o comando que será executado quando o container iniciar.
# Ele inicia o Jupyter Notebook, permitindo acesso de qualquer IP (dentro da rede do Docker)
# e desativa a necessidade de um token, além de permitir a execução como usuário 'root'.
CMD ["jupyter", "notebook",  "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--notebook-dir=/app/notebooks"]