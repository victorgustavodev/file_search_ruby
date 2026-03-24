require 'fileutils'

def preparar_ambiente_de_teste
  puts "[*] Criando estrutura de pastas para a demonstração..."
  FileUtils.mkdir_p("sistema_arquivos/documentos/faculdade")
  FileUtils.mkdir_p("sistema_arquivos/imagens/viagens")
  FileUtils.mkdir_p("sistema_arquivos/projetos/ruby/recursividade")
  
  # Arquivos genéricos
  File.write("sistema_arquivos/documentos/notas.txt", "Matemática: 8, História: 9")
  File.write("sistema_arquivos/imagens/foto.png", "dados da imagem...")
  
  # Arquivo que vamos tentar encontrar:
  File.write("sistema_arquivos/projetos/ruby/recursividade/alvo.txt", "Você encontrou o arquivo secreto!")
end

def limpar_ambiente
  FileUtils.rm_rf("sistema_arquivos")
end

# =========================================================
# 2. A PARTE RELEVANTE: O Algoritmo Recursivo
# =========================================================
def buscar_arquivo(diretorio_atual, nome_do_arquivo)
  # Lê o conteúdo do diretório atual, ignorando as referências '.' e '..'
  itens = Dir.entries(diretorio_atual).reject { |item| item == '.' || item == '..' }

  itens.each do |item|
    caminho_completo = File.join(diretorio_atual, item)

    if File.directory?(caminho_completo)
      # PASSO RECURSIVO: Se o item for uma pasta, a função chama a si mesma
      # para investigar o que tem dentro dessa nova pasta.
      resultado = buscar_arquivo(caminho_completo, nome_do_arquivo)
      
      return resultado if resultado 
      
      # LINHA CHAVE
      elsif item == nome_do_arquivo

      return caminho_completo
    end
  end

  # Caso não encontre nada, retorna nil
  nil
end

#Exemplo de execução

preparar_ambiente_de_teste()

puts "\n[*] Iniciando busca recursiva pelo arquivo 'alvo.txt'..."
arquivo_procurado = "alvo.txt"
diretorio_raiz = "sistema_arquivos"

# Chama a função recursiva pela primeira vez
caminho_encontrado = buscar_arquivo(diretorio_raiz, arquivo_procurado)

puts "\n--- RESULTADO ---"
if caminho_encontrado
  puts "✅ Sucesso! O arquivo foi encontrado no caminho:"
  puts "   -> #{caminho_encontrado}"
  puts "\nConteúdo do arquivo: '#{File.read(caminho_encontrado)}'"
else
  puts "❌ Arquivo não encontrado."
end

# Limpa a sujeira do teste (opcional) :-)
limpar_ambiente()