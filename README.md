<div align="center">
  <h1>gen-commit</h1>
  <i>generate conventional commit messages using LLM</i>
</div>

---

Let's be honest. We've all been there:

- `git commit -m "update"`
- `git commit -m "fixed stuff"`
- `git commit -m "asdfghjkl"` (in a moment of pure despair)

`gen-commit` was born from the tears of countless mysterious merge conflicts and the desperate need for _someone_ (or something) to make our commit history look like we actually know what we're doing. You're welcome.

---

## 🧑‍💻 Usage

```bash
gen-commit [OPTIONS]
```

### Options

- `-h, --help`: Show help message
- `-m, --model MODEL`: Specify the model to use with llm command
- `-p, --print`: Print the generated message only
- `-D, --debug`: Special debug mode (no real committing etc.)
- `-v, --verbose`: Show all output
- `-a, --all`: Analyze all changes
- `-c, --commit`: Automatically commit without confirmation
- `-s, --scope SCOPE`: Specify scope for commit message

### Examples

```bash
# Interactive mode
gen-commit

# Analyze all changes (staged, unstaged & untracked)
gen-commit -a

# Auto-commit changes
gen-commit -c

# Print only (no commit)
gen-commit -p

# Use specific scope
gen-commit -s frontend
```

## 🛠️ Prerequisites

- [Nix](https://nixos.org/download.html) (with flake support)
- [llm](https://github.com/simonw/llm) command-line tool
- git

## ⚡ Installation

### Using Nix Flake

```nix
{
  inputs = {
    gen-commit = {
      url = "github:rodeyseijkens/gen-commit";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, gen-commit, ... }:
  {
    devShells.x86_64-linux.default = nixpkgs.legacyPackages.x86_64-linux.mkShell {
      packages = [
        gen-commit.packages.x86_64-linux.default
      ];
    };
  };
}
```

## 🧠 How it works

The tool analyzes your git changes (staged or unstaged) and uses the `llm` command to generate an appropriate commit message following the Conventional Commits specification with gitmoji.

### Commit Message Format

```text
<type>[scope]: <gitmoji> <description>
```

---

## 📜 License

<span style="color:#fabd2f">MIT</span> — see the [LICENSE](../../LICENSE) file for details.

---

<p align="center">
  <b>Made with ❤️ by <a href="https://github.com/rodeyseijkens">@rodeyseijkens</a></b>
</p>
