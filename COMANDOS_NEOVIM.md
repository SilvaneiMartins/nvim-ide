# Tutorial de Comandos Basicos do Neovim

Este guia foi criado a partir dos atalhos configurados em `lua/martins/core/keymaps.lua` e dos plugins principais desta configuracao.

Nesta configuracao, a tecla `<leader>` e o espaco. Entao, quando o guia disser `<leader>ee`, pressione `Espaco`, depois `e`, depois `e`.

## 1. Modos principais

O Neovim tem modos. O segredo e saber onde voce esta.

| Modo      | Para que serve                  | Como entrar         | Como sair             | 
|   ---     |       ---                       |     ---             |   ---                 |
| Normal    | Navegar, salvar, abrir comandos | Ja abre assim       | Use `i` para editar   |
| Insert    | Digitar texto                   | `i`, `a`, `o`       | `Esc` ou `jk`         |
| Visual    | Selecionar texto                | `v`, `V`, `Ctrl-v`  | `Esc`                 |
| Commando  | Rodar comandos com `:`          | `:`                 | `Enter` ou `Esc`      |

Atalho configurado:

| Tecla     | Acao  |
|   ---     | ---   |
| `jk`      | Sai do modo Insert e volta para Normal |

## 2. Abrir, criar e salvar arquivos

### Criar ou abrir arquivo pelo comando

No modo Normal:

```vim
:e nome-do-arquivo.txt
```

Se o arquivo nao existir, ele sera criado quando voce salvar.

### Salvar arquivo

```vim
:w
```

### Salvar e sair

```vim
:wq
```

### Sair sem salvar

```vim
:q!
```

### Criar arquivo ja dentro de uma pasta

```vim
:e pasta/nome-do-arquivo.txt
```

Se a pasta ainda nao existir, crie a pasta primeiro pela sidebar ou pelo terminal integrado/comando externo.

## 3. Editar texto basico

| Tecla     | Acao                                  |
|   ---     | ---                                   |
| `i`       | Entra em Insert antes do cursor       |
| `a`       | Entra em Insert depois do cursor      |
| `o`       | Cria linha abaixo e entra em Insert   |
| `O`       | Cria linha acima e entra em Insert    |
| `x`       | Apaga caractere no cursor             |
| `dd`      | Apaga a linha atual                   |
| `yy`      | Copia a linha atual                   |
| `p`       | Cola abaixo/depois do cursor          |
| `u`       | Desfaz                                |
| `Ctrl-r`  | Refaz                                 |

Fluxo comum:

```text
i       entra para editar
digite  escreve o conteudo
jk      volta para Normal
:w      salva
```

## 4. Navegacao dentro do arquivo

| Tecla         | Acao              |
|   ---         | ---               |
| `h`           | Esquerda          |
| `j`           | Baixo             |
| `k`           | Cima              |
| `l`           | Direita           |
| `gg`          | Inicio do arquivo |
| `G`           | Fim do arquivo    |
| `0`           | Inicio da linha   |
| `$`           | Fim da linha      |
| `w`           | Proxima palavra   |
| `b`           | Palavra anterior  |

## 5. Buscar texto

### Buscar no arquivo atual

```vim
/texto
```

Depois use:

| Tecla         | Acao                          |
| ---           | ---                           |
| `n`           | Proximo resultado             |
| `N`           | Resultado anterior            |
| `<leader>nh`  | Limpa os destaques da busca   |

### Buscar texto no projeto com Telescope

| Tecla         | Acao                      |
| ---           | ---                       |
| `<leader>fg`  | Busca texto no projeto    |
| `<leader>ff`  | Busca arquivos            |
| `<leader>fo`  | Arquivos recentes         |
| `<leader>fb`  | Buffers abertos           |
| `<leader>fk`  | Lista keymaps             |
| `<leader>fh`  | Help tags                 |
| `<leader>ft`  | TODOs                     |

Dentro do Telescope:

| Tecla             | Acao                  |
| ---               | ---                   |
| `Ctrl-j`          | Desce na lista        |
| `Ctrl-k`          | Sobe na lista         |
| `Enter`           | Abre o item selecionado |
| `Esc`             | Fecha                 |

## 6. Sidebar / explorador de arquivos

A sidebar usada nesta configuracao e o `nvim-tree`.

Atalhos configurados:

| Tecla             | Acao                                      |
| ---               | ---                                       |
| `<leader>ee`      | Abre/fecha a sidebar                      |
| `<leader>ef`      | Abre a sidebar focada no arquivo atual    |
| `<leader>ec`      | Recolhe as pastas abertas                 |
| `<leader>er`      | Atualiza a sidebar                        |

### Navegar da sidebar para o arquivo

1. Pressione `<leader>ee` para abrir a sidebar.
2. Use `j` e `k` para escolher um arquivo.
3. Pressione `Enter` para abrir o arquivo.
4. O cursor vai para o arquivo aberto.

### Ir do arquivo atual para a sidebar

Use:

```text
<leader>ef
```

Isso abre a sidebar ja apontando para o arquivo que voce esta editando.

### Alternar entre sidebar e arquivo

Como a sidebar e uma janela do Neovim, use os comandos de janela:

| Tecla             | Acao                              |
| ---               | ---                               |
| `Ctrl-w h`        | Vai para a janela da esquerda     |
| `Ctrl-w l`        | Vai para a janela da direita      |
| `Ctrl-w j`        | Vai para a janela de baixo        |
| `Ctrl-w k`        | Vai para a janela de cima         |

Se a sidebar estiver na esquerda:

```text
Ctrl-w h   vai para a sidebar
Ctrl-w l   volta para o arquivo
```

### Criar arquivo pela sidebar

1. Abra a sidebar com `<leader>ee`.
2. Navegue ate a pasta desejada.
3. Pressione `a`.
4. Digite o nome do arquivo, por exemplo `index.html`.
5. Pressione `Enter`.

### Criar pasta pela sidebar

1. Abra a sidebar com `<leader>ee`.
2. Navegue ate onde a pasta deve ser criada.
3. Pressione `a`.
4. Digite o nome da pasta terminando com `/`, por exemplo `src/`.
5. Pressione `Enter`.

### Criar arquivo dentro de uma pasta pela sidebar

Ao pressionar `a`, digite o caminho:

```text
src/app.lua
```

### Editar arquivo criado

1. Selecione o arquivo na sidebar.
2. Pressione `Enter`.
3. Pressione `i` para entrar no modo Insert.
4. Edite o conteudo.
5. Pressione `jk` para voltar ao modo Normal.
6. Salve com `:w`.

Comandos comuns dentro do `nvim-tree`:

| Tecla     | Acao                      |
| ---       | ---                       |
| `a`       | Criar arquivo ou pasta    |
| `r`       | Renomear                  |
| `d`       | Deletar                   |
| `c`       | Copiar                    |
| `x`       | Recortar                  |
| `p`       | Colar                     |
| `R`       | Atualizar                 |
| `Enter`   | Abrir arquivo ou pasta    |

## 7. Splits: editar mais de um arquivo na tela

Atalhos configurados:

| Tecla         | Acao                              |
| ---           | ---                               |
| `<leader>sv`  | Cria split vertical               |
| `<leader>sh`  | Cria split horizontal             |
| `<leader>se`  | Deixa splits com tamanhos iguais  |
| `<leader>sx`  | Fecha o split atual               |
| `<leader>sm`  | Maximiza/minimiza o split atual   |

Navegar entre splits:

| Tecla         | Acao              |
| ---           | ---               |
| `Ctrl-w h`    | Split da esquerda |
| `Ctrl-w l`    | Split da direita  |
| `Ctrl-w j`    | Split de baixo    |
| `Ctrl-w k`    | Split de cima     |

Fluxo util:

```text
<leader>sv   divide a tela verticalmente
<leader>ff   busca outro arquivo
Enter        abre no split atual
Ctrl-w h/l   alterna entre os arquivos
```

## 8. Abas

Atalhos configurados:

| Tecla         | Acao                              |
| ---           | ---                               |
| `<leader>to`  | Abre nova aba                     |
| `<leader>tx`  | Fecha aba atual                   |
| `<leader>tn`  | Proxima aba                       |
| `<leader>tp`  | Aba anterior                      |
| `<leader>tf`  | Abre o arquivo atual em nova aba  |

## 9. Incrementar e decrementar numeros

Atalhos configurados:

| Tecla         | Acao                              |
| ---           | ---                               |
| `<leader>+`   | Incrementa o numero sob o cursor  |
| `<leader>-`   | Decrementa o numero sob o cursor  |

Exemplo: coloque o cursor sobre `10` e pressione `<leader>+` para virar `11`.

## 10. Diagnosticos e erros

Atalhos uteis configurados:

| Tecla         | Acao                                  |
| ---           | ---                                   |
| `<leader>d`   | Mostra diagnostico da linha           |
| `<leader>D`   | Lista diagnosticos do arquivo         |
| `<leader>xx`  | Abre erros do workspace no Trouble    |
| `<leader>xf`  | Erros do arquivo atual                |
| `<leader>xq`  | Quickfix                              |
| `<leader>xr`  | Referencias do LSP                    |

## 11. Git

Atalhos uteis configurados:

| Tecla         | Acao                                              |
| ---           | ---                                               |
| `<leader>lg`  | Abre LazyGit                                      |
| `<leader>gb`  | Alterna Git Blame, dependendo do plugin carregado |
| `<leader>hs`  | Stage hunk                                        |
| `<leader>hr`  | Reset hunk                                        |
| `<leader>hp`  | Preview hunk                                      |
| `<leader>hB`  | Mostra/esconde blame da linha atual               |
| `<leader>hd`  | Diff do arquivo atual                             |

## 12. Fluxos prontos do dia a dia

### Criar um arquivo novo e editar

```text
<leader>ee       abre sidebar
a                cria arquivo
novo.txt         nome do arquivo
Enter            confirma
Enter            abre o arquivo
i                entra para editar
digite texto
jk               sai do Insert
:w               salva
```

### Criar uma pasta e um arquivo dentro dela

```text
<leader>ee       abre sidebar
a                cria
src/             cria a pasta
Enter            confirma
a                cria novamente
src/main.lua     cria arquivo dentro da pasta
Enter            confirma
Enter            abre arquivo
i                edita
jk               volta para Normal
:w               salva
```

### Abrir um arquivo rapido pelo nome

```text
<leader>ff       busca arquivos
digite parte do nome
Ctrl-j/Ctrl-k    escolhe
Enter            abre
```

### Procurar uma palavra no projeto

```text
<leader>fg       busca texto
digite a palavra
Ctrl-j/Ctrl-k    escolhe resultado
Enter            abre no local
```

### Voltar da edicao para a sidebar e depois para o arquivo

```text
<leader>ef       revela arquivo atual na sidebar
Ctrl-w l         volta para o arquivo, se a sidebar estiver a esquerda
```

## 13. Comandos que vale memorizar primeiro

| Tecla/comando             | Motivo                |
| ---                       | ---                   |
| `i`                       | Comecar a editar      |
| `jk`                      | Parar de editar       |
| `:w`                      | Salvar                |
| `:q`                      | Sair                  |
| `<leader>ee`              | Abrir/fechar sidebar  |
| `<leader>ff`              | Achar arquivo         |
| `<leader>fg`              | Buscar texto          |
| `Ctrl-w h/l/j/k`          | Trocar de janela      |
| `u`                       | Desfazer              |
| `p`                       | Colar                 |

