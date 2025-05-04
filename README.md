# Rust Learning Automation Script

This project contains a Bash script (`script.sh`) designed to automate the process of creating new Rust learning directories, initializing a Rust project, running it, and pushing changes to a Git repository. The script is tailored for a Windows environment using Git Bash.

---

## 📁 Files

- `script.sh`: The main Bash script that automates the creation of a new Rust project directory, initializes it with `cargo new`, runs the project with `cargo run`, and commits/pushes changes to the Git repository.
- `counter.txt`: A file used to track the lecture number or similar counter (ignored by Git).
- `.lec_counter`: A hidden file likely used to store the lecture counter state (ignored by Git).

---

## ✅ Prerequisites

- **Rust**: Ensure Rust is installed. You can install it from [rust-lang.org](https://www.rust-lang.org/).
- **Git**: Git must be installed, and Git Bash should be available for running the script.
- **Git Repository**: A remote Git repository should be set up and configured in the project directory.
- **Windows with Git Bash**: The script is designed to run in Git Bash on Windows.

---

## ⚙️ Setup

### 1. Clone the Repository (if applicable):
```bash
git clone <repository-url>
cd <repository-directory>
```

### 2. Ensure Script is Executable:
```bash
chmod +x script.sh
```

### 3. Configure `.gitignore`:
Make sure the following files are included:
```
counter.txt
.lec_counter
```

---

## 🚀 Usage

Run the script in Git Bash to create a new Rust project directory (e.g., `lec007`), initialize it, run the project, and push changes to the repository:

```bash
./script.sh
```

---

## 🔍 What the Script Does

- Reads or updates a counter (likely from `counter.txt` or `.lec_counter`) to generate a new directory name (e.g., `lec007`).
- Creates a new directory with `cargo new lecXXX`.
- Runs the project using `cargo run`.
- Commits the changes to the Git repository.
- Pushes the changes to the remote repository.

---

## 🧪 Example

If the counter is at 7, running `./script.sh` will:

- Create a directory named `lec007`.
- Initialize a Rust project inside `lec007` with `cargo new`.
- Run the project with `cargo run`.
- Commit and push the changes to the Git repository.

---

## 📝 Notes

- The `counter.txt` and `.lec_counter` files are used internally by the script to track the lecture number. They are ignored by Git to avoid unnecessary tracking.
- Ensure the remote Git repository is correctly set up with `git remote` before running the script.
- Modify `script.sh` if you need to change the naming convention (e.g., `lec007` to something else) or add additional automation steps.

---

## 🛠️ Troubleshooting

- **Script fails to run**: Ensure you are running it in Git Bash and that `chmod +x script.sh` has been executed.
- **Cargo errors**: Verify that Rust and Cargo are installed (`rustc --version` and `cargo --version`).
- **Git errors**: Confirm that the repository is initialized (`git init`) and a remote is set (`git remote -v`).
- **Permission issues**: Run Git Bash as an administrator if you encounter file permission errors.

---

## 🤝 Contributing

Feel free to fork this repository and submit pull requests for improvements to the script or documentation.

---

## 📄 License

This project is unlicensed and free to use/modify as needed.
