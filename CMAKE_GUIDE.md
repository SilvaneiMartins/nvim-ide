# 🔨 Guia CMake + Neovim (Windows)

## ✅ Setup Inicial

### Você já tem:
- ✅ CMake 4.2.0 instalado
- ✅ Neovim com clangd LSP
- ✅ Overseer.nvim para task management

### Próximo passo:
Certifique-se que CMake está no PATH:
```powershell
# Teste no PowerShell
cmake --version
```

Se der erro, adicione ao PATH:
```powershell
# Windows - adicione ao PATH de sistema
C:\Program Files\CMake\bin
```

---

## 📁 Estrutura de Projeto CMake

Crie um projeto com esta estrutura:

```
my_project/
├── CMakeLists.txt          # ← Arquivo principal
├── src/
│   ├── main.cpp
│   ├── app.cpp
│   └── app.h
├── include/
│   └── app.h
└── build/                  # ← Criado automaticamente
    ├── CMakeCache.txt
    ├── Makefile (ou .sln no Windows)
    └── main.exe
```

---

## 📝 CMakeLists.txt Exemplo

```cmake
cmake_minimum_required(VERSION 3.10)
project(MyApp)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Executável
add_executable(main 
    src/main.cpp
    src/app.cpp
)

# Include directories
target_include_directories(main PRIVATE include)

# Testes (opcional)
enable_testing()
add_test(NAME MyTest COMMAND main)
```

---

## 🚀 Usando CMake no Neovim

### Keymaps Disponíveis

| Comando | Atalho | O que faz |
|---------|--------|-----------|
| Configure | `<leader>cc` | Roda `cmake -B build` |
| Build | `<leader>cb` | Roda `cmake --build build` |
| Test | `<leader>ct` | Roda `ctest` |
| Run | `<leader>cR` | Executa o binário compilado |
| Open Tasks | `<leader>co` | Abre lista de tasks |
| Quick Action | `<leader>cq` | Menu rápido |

### Workflow Típico

1. **Abra um arquivo .cpp ou CMakeLists.txt**
   ```
   nvim src/main.cpp
   ```

2. **Configure o projeto** (primeira vez)
   ```
   <leader>cc
   ```
   Isto cria o diretório `build/` com os arquivos necessários.

3. **Compile**
   ```
   <leader>cb
   ```
   Gera o executável em `build/main.exe`

4. **Execute** (se configurado em CMakeLists.txt)
   ```
   <leader>cR
   ```

5. **Veja logs** (se algo falhar)
   ```
   <leader>co
   ```
   Abre o painel de tasks com outputs.

---

## 🛠️ Compiladores no Windows

CMake usa automaticamente:
- **MinGW** (se instalado)
- **MSVC** (Visual Studio - recomendado no Windows)
- **Clang** (se instalado)

Para forçar um compilador específico:

```powershell
# Force MinGW
cmake -B build -G "MinGW Makefiles"

# Force MSVC
cmake -B build -G "Visual Studio 17 2022"

# Force Clang
cmake -B build -G "Ninja" -DCMAKE_CXX_COMPILER=clang++
```

---

## 🐛 Troubleshooting

### CMake configure falha
```powershell
# Limpe o build anterior
rm -r build

# Configure novamente
<leader>cc
```

### Não encontra o compilador
```powershell
# Verifique qual compilador está disponível
cmake --help-manual cmake-generators
```

### Arquivo .sln gerado (MSVC)
Se CMake gerou um `.sln`, abra-o no Visual Studio ou use:
```powershell
cd build
cmake --build . --config Debug
```

### "Clang-format" não funciona
Certifique-se que clang-format está instalado:
```powershell
# Via Mason no Neovim
:Mason
# Procure e instale "clang-format"
```

---

## 📚 Recursos

- CMake Docs: https://cmake.org/documentation/
- Clang-Tools: https://clang.llvm.org/
- Overseer.nvim: https://github.com/stevearc/overseer.nvim

---

## 💡 Dicas

1. **Use `<leader>co` frequentemente** para ver o status das tasks
2. **Adicione breakpoints com `<leader>dbb`** depois de compilar com `-DCMAKE_BUILD_TYPE=Debug`
3. **Use `<leader>cf`** para formatar seu código C++ automaticamente
4. **Para projetos grandes**, use `ninja` em vez de `make` para builds mais rápidos

---

## ✨ Exemplo Prático Completo

```bash
# 1. Crie um projeto
mkdir my_project && cd my_project

# 2. Crie a estrutura
mkdir src include build

# 3. Arquivo main.cpp
cat > src/main.cpp << 'EOF'
#include <iostream>
int main() {
    std::cout << "Hello from CMake!" << std::endl;
    return 0;
}
EOF

# 4. CMakeLists.txt
cat > CMakeLists.txt << 'EOF'
cmake_minimum_required(VERSION 3.10)
project(MyApp)
set(CMAKE_CXX_STANDARD 17)
add_executable(main src/main.cpp)
EOF

# 5. Abra no Neovim
nvim src/main.cpp

# 6. No Neovim: <leader>cc (configure)
# 7. No Neovim: <leader>cb (build)
# 8. No Neovim: <leader>cR (run)
```

Output esperado:
```
Hello from CMake!
```

---

Pronto! Você tem um setup CMake completo no Neovim! 🎉
