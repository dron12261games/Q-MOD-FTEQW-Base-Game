# FTEQW Base Game

## ENG

This project is a basic FTEQW game template built around QuakeC compilation and package generation for both Windows and Linux targets.

### Project layout

- `base/` — game source files, QuakeC scripts, and generated compiled binaries
- `linux/` — Linux engine and runtime files
- `windows/` — Windows engine and runtime files
- `tasks/` — build, clean, publish and launch scripts
- `.vscode/tasks.json` — VS Code tasks for common actions
- `.github/workflows/build.yml` — GitHub Actions workflow for automated package builds
- `out/` — generated packaging output, ignored by Git

### Requirements

- A working FTEQW project checkout
- QuakeC compiler files available under `linux/compiler/`
- The engine binaries available under `linux/` and `windows/`
- A shell environment for the `*.sh` scripts, or Windows CMD/PowerShell for the `*.bat` scripts

### Local setup

1. Clone the repository.
2. Open the project folder in VS Code.
3. Ensure the required FTE binaries and compiler are present in the expected folders.
4. Make the shell scripts executable on Unix-like systems if needed:

```bash
chmod +x tasks/*.sh
chmod +x linux/compiler/*
chmod +x linux/fteqw* 2>/dev/null || true
```

### Common commands

The project provides both direct script execution (if you don't want to use VS Code) and VS Code tasks.

#### Build only

Linux/macOS:

```bash
./tasks/Build.sh
```

Windows:

```bat
tasks\Build.bat
```

The build process:

- runs `Clean.sh` / `Clean.bat`
- compiles `base/progs.src` to `base/progs.dat`
- compiles `base/csprogs.src` to `base/csprogs.dat`
- verifies both output files exist

#### Publish package

Linux/macOS:

```bash
./tasks/Publish.sh
```

Windows:

```bat
tasks\Publish.bat
```

The publish flow:

1. runs `CleanPublish`
2. runs `Build`
3. creates packages under `out/windows` and `out/linux`
4. copies the base game files, engine files, and optional root files such as `default.fmf` and `maptimes.txt`

#### Clean generated files

```bash
./tasks/Clean.sh
./tasks/CleanPublish.sh
```

or on Windows:

```bat
tasks\Clean.bat
tasks\CleanPublish.bat
```

#### Launch the game

Linux/macOS:

```bash
./tasks/Launch.sh
```

Windows:

```bat
tasks\Launch.bat
```

This starts FTEQW in `-game base` mode.

### VS Code tasks

Open the VS Code task runner and use these tasks:

- Build
- Publish
- Clean
- Clean Publish
- Launch

These tasks are configured in `.vscode/tasks.json` and call the corresponding shell or batch scripts.

### GitHub Actions

The workflow in `.github/workflows/build.yml` runs automatically on pushes to `master` and can also be triggered manually with `workflow_dispatch`.

It does the following:

1. checks out the repository
2. makes the shell scripts executable
3. runs `./tasks/Publish.sh`
4. uploads two artifacts:
   - `fteqw-base-game-windows`
   - `fteqw-base-game-linux`

The generated packages are stored under `out/windows` and `out/linux` before upload.

### Output artifacts

After a successful publish, the project produces package directories such as:

```text
out/
  windows/
  linux/
```

These directories contain the generated mod bundles and platform runtime files ready for distribution or testing.

---

## RUS

Этот проект — базовый шаблон игры для FTEQW, построенный вокруг компиляции QuakeC и сборки пакетов для Windows и Linux.

### Структура проекта

- `base/` — исходники игры, QuakeC-скрипты и сгенерированные бинарники
- `linux/` — Linux-версии движка и runtime-файлы
- `windows/` — Windows-версии движка и runtime-файлы
- `tasks/` — скрипты сборки, очистки, публикации и запуска
- `.vscode/tasks.json` — задачи VS Code для повседневных действий
- `.github/workflows/build.yml` — workflow GitHub Actions для автоматической сборки пакетов
- `out/` — сгенерированные артефакты, исключены из Git

### Требования

- рабочая копия проекта FTEQW
- компилятор QuakeC в папке `linux/compiler/`
- бинарники движка в каталогах `linux/` и `windows/`
- для `*.sh` нужен shell-среда Unix/Linux/macOS, для `*.bat` — Windows CMD/PowerShell

### Развёртывание локально

1. Склонируйте репозиторий.
2. Откройте проект в VS Code.
3. Убедитесь, что все требуемые бинарники и компилятор находятся в папках проекта.
4. При необходимости сделайте shell-скрипты исполняемыми:

```bash
chmod +x tasks/*.sh
chmod +x linux/compiler/*
chmod +x linux/fteqw* 2>/dev/null || true
```

### Основные команды

Проект поддерживает запуск через скрипты напрямую (если вы не хотите использовать VS Code) и через задачи VS Code.

#### Только сборка

Linux/macOS:

```bash
./tasks/Build.sh
```

Windows:

```bat
tasks\Build.bat
```

Что делает сборка:

- запускает `Clean.sh` / `Clean.bat`
- компилирует `base/progs.src` в `base/progs.dat`
- компилирует `base/csprogs.src` в `base/csprogs.dat`
- проверяет наличие обоих файлов

#### Публикация пакета

Linux/macOS:

```bash
./tasks/Publish.sh
```

Windows:

```bat
tasks\Publish.bat
```

Порядок публикации:

1. выполняется `CleanPublish`
2. затем `Build`
3. создаются пакеты в папках `out/windows` и `out/linux`
4. копируются базовые файлы игры, runtime-файлы платформы и опциональные корневые файлы вроде `default.fmf` и `maptimes.txt`

#### Очистка сгенерированных файлов

```bash
./tasks/Clean.sh
./tasks/CleanPublish.sh
```

или в Windows:

```bat
tasks\Clean.bat
tasks\CleanPublish.bat
```

#### Запуск игры

Linux/macOS:

```bash
./tasks/Launch.sh
```

Windows:

```bat
tasks\Launch.bat
```

Запускает FTEQW в режиме `-game base`.

### Задачи VS Code

В панели задач VS Code доступны:

- Build
- Publish
- Clean
- Clean Publish
- Launch

Эти задачи описаны в `.vscode/tasks.json` и вызывают соответствующие shell- или batch-скрипты.

### GitHub Actions

Workflow в `.github/workflows/build.yml` запускается автоматически при пуше в ветку `master` и также может быть запущен вручную через `workflow_dispatch`.

Он делает следующее:

1. забирает репозиторий
2. делает shell-скрипты исполняемыми
3. запускает `./tasks/Publish.sh`
4. загружает два артефакта:
   - `fteqw-base-game-windows`
   - `fteqw-base-game-linux`

Готовые пакеты создаются в директориях `out/windows` и `out/linux` перед загрузкой в артефакты.

### Результирующие артефакты

После успешной публикации проект создаёт структуры вида:

```text
out/
  windows/
  linux/
```

Эти каталоги содержат готовые сборки модов и платформенные runtime-файлы для распространения или тестирования.

---