# Comandos y atajos de Git

Referencia de todos los comandos y atajos relacionados con Git definidos en esta
configuración. `<leader>` es la tecla líder configurada.

> No hay plugins de GitHub (PRs, issues) instalados; todo lo de abajo trabaja
> sobre el repositorio Git local.

## Diffview (`sindrets/diffview.nvim`)

Definido en `lua/plugins/gitconfig.lua`.

### Atajos globales

| Modo | Atajo        | Acción                                                |
| ---- | ------------ | ----------------------------------------------------- |
| n    | `<leader>gd` | Abrir Diffview (cambios del working tree vs. índice)  |
| n    | `<leader>gh` | Historial del archivo actual (`DiffviewFileHistory %`) |
| n    | `<leader>gH` | Historial de la rama (`DiffviewFileHistory`)          |

### Comandos

| Comando                  | Descripción                                  |
| ------------------------ | -------------------------------------------- |
| `:DiffviewOpen [rev]`    | Abre la vista de diffs (opcionalmente vs. `rev`) |
| `:DiffviewFileHistory [path]` | Historial de commits de un archivo o de la rama |
| `:DiffviewClose`         | Cierra Diffview                              |

### Dentro de la vista de diff

| Modo | Atajo        | Acción                          |
| ---- | ------------ | ------------------------------- |
| n    | `q`          | Cerrar Diffview                 |
| n    | `]x`         | Siguiente conflicto             |
| n    | `[x`         | Anterior conflicto              |
| n    | `<leader>co` | Resolver conflicto: elegir OURS   |
| n    | `<leader>ct` | Resolver conflicto: elegir THEIRS |
| n    | `<leader>cb` | Resolver conflicto: elegir BASE   |
| n    | `<leader>ca` | Resolver conflicto: elegir ALL    |
| n    | `<leader>cn` | Resolver conflicto: elegir NONE   |

### Dentro del panel de archivos

| Modo | Atajo   | Acción                 |
| ---- | ------- | ---------------------- |
| n    | `q`     | Cerrar Diffview        |
| n    | `j`     | Siguiente entrada      |
| n    | `k`     | Anterior entrada       |
| n    | `<CR>`  | Abrir diff del archivo |
| n    | `s`     | Stage / unstage archivo |
| n    | `S`     | Stage de todo          |
| n    | `U`     | Unstage de todo        |
| n    | `R`     | Refrescar lista        |

## Gitsigns (`lewis6991/gitsigns.nvim`)

Definido en `lua/plugins/gitconfig.lua`. Los atajos son locales al buffer y solo
existen en archivos dentro de un repositorio Git. En which-key, `<leader>h`
aparece como el grupo **Git [H]unk**.

### Navegación

| Modo | Atajo | Acción                                                  |
| ---- | ----- | ------------------------------------------------------- |
| n    | `]c`  | Siguiente hunk (en modo diff: siguiente cambio nativo)  |
| n    | `[c`  | Hunk anterior (en modo diff: cambio anterior nativo)    |

### Hunks y buffer

| Modo | Atajo        | Acción                                   |
| ---- | ------------ | ---------------------------------------- |
| n    | `<leader>hs` | Stage del hunk                           |
| v    | `<leader>hs` | Stage de las líneas seleccionadas        |
| n    | `<leader>hr` | Reset del hunk                           |
| v    | `<leader>hr` | Reset de las líneas seleccionadas        |
| n    | `<leader>hS` | Stage del buffer completo                |
| n    | `<leader>hR` | Reset del buffer completo                |
| n    | `<leader>hp` | Previsualizar hunk                       |
| n    | `<leader>hb` | Blame de la línea actual                 |
| n    | `<leader>hd` | Diff contra el índice                    |
| n    | `<leader>hD` | Diff contra el último commit (`@`)       |

### Toggles

| Modo | Atajo        | Acción                                          |
| ---- | ------------ | ----------------------------------------------- |
| n    | `<leader>tb` | Activar/desactivar blame en la línea actual     |
| n    | `<leader>tD` | Previsualizar hunk inline (líneas eliminadas)   |

### Comandos útiles

| Comando                         | Descripción                         |
| ------------------------------- | ----------------------------------- |
| `:Gitsigns stage_hunk`          | Stage del hunk bajo el cursor       |
| `:Gitsigns reset_hunk`          | Reset del hunk bajo el cursor       |
| `:Gitsigns preview_hunk`        | Previsualizar hunk                  |
| `:Gitsigns blame_line`          | Blame de la línea                   |
| `:Gitsigns blame`               | Blame del archivo completo          |
| `:Gitsigns diffthis [rev]`      | Diff del buffer contra `rev`        |
| `:Gitsigns toggle_signs`        | Mostrar/ocultar signos en la columna |
| `:Gitsigns setqflist`           | Enviar hunks a la quickfix list     |

## Telescope (`nvim-telescope/telescope.nvim`)

Definido en `lua/plugins/telescope.lua`.

| Modo | Atajo        | Acción                                       |
| ---- | ------------ | -------------------------------------------- |
| n    | `<leader>gs` | Archivos modificados (`Telescope git_status`) |

Otros pickers de Git disponibles sin atajo asignado:

| Comando                     | Descripción                      |
| --------------------------- | -------------------------------- |
| `:Telescope git_files`      | Archivos rastreados por Git      |
| `:Telescope git_commits`    | Commits del repositorio          |
| `:Telescope git_bcommits`   | Commits del buffer actual        |
| `:Telescope git_branches`   | Ramas (checkout, crear, borrar)  |
| `:Telescope git_stash`      | Stashes                          |

## Neo-tree (`nvim-neo-tree/neo-tree.nvim`)

Definido en `lua/plugins/neotree.lua`.

| Modo | Atajo        | Acción                                          |
| ---- | ------------ | ----------------------------------------------- |
| n    | `<leader>ge` | Explorador flotante de estado Git               |

Dentro del explorador `git_status`:

| Atajo  | Acción                        |
| ------ | ----------------------------- |
| `<CR>` | Abrir archivo                 |
| `J`    | Abrir en split vertical       |
| `K`    | Abrir en split horizontal     |
| `a`    | `git add` del archivo         |
| `A`    | `git add` de todo             |
| `u`    | Unstage del archivo           |
| `r`    | Revertir cambios del archivo  |
| `q`    | Cerrar ventana                |
| `?`    | Mostrar ayuda                 |

En el explorador `filesystem` (`<leader>e`) se puede cambiar a la pestaña
**󰊢 Git** desde el winbar.

## Indicadores visuales

- **Oil** (`refractalize/oil-git-status.nvim`, `lua/plugins/navigation.lua`):
  muestra el estado Git de cada archivo en el buffer de Oil.
- **Statusline** (`lua/config/statusline.lua`): rama actual y contadores de
  líneas añadidas / modificadas / eliminadas (datos de gitsigns).
- **Folds** (`lua/plugins/fold.lua`): el texto de los folds incluye el conteo
  de cambios de gitsigns.
