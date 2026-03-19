# OSS Audit — Linux Kernel
### Open Source Software Capstone Project | VITyarthi

| Field | Details |
|-------|---------|
| **Student Name** | Dhruv Sanjay Chaudhari |
| **Registration Number** | 24BAI10807 |
| **Course** | Open Source Software (OSS NGMC) |
| **Software Audited** | Linux Kernel |
| **License** | GNU General Public License v2 (GPL v2) |

---

## About This Project

This repository contains the shell scripts for the Open Source Audit capstone project. The project examines the Linux Kernel across five dimensions: its origin story, its GPL v2 license, the ethics of open source, its Linux system footprint, and its place in the FOSS ecosystem.

---

## Scripts Overview

| Script | File | Purpose |
|--------|------|---------|
| Script 1 | `script1_system_identity.sh` | Displays a system identity report: kernel version, distro, user, uptime, and license info |
| Script 2 | `script2_package_inspector.sh` | Checks if the Linux kernel package is installed, displays its details, and prints a philosophy note |
| Script 3 | `script3_disk_permission_auditor.sh` | Audits key system directories and kernel-specific paths for permissions and disk usage |
| Script 4 | `script4_log_analyzer.sh` | Reads a log file, counts keyword matches, and prints the last 5 matching lines |
| Script 5 | `script5_manifesto_generator.sh` | Interactively generates a personalised open source philosophy statement and saves it to a file |

---

## Shell Concepts Demonstrated

| Concept | Used In |
|---------|---------|
| Variables and command substitution `$()` | Scripts 1, 2, 3, 4, 5 |
| `if-then-else` conditionals | Scripts 2, 3, 4 |
| `case` statement | Script 2 |
| `for` loop with arrays | Script 3 |
| `while read` loop | Script 4 |
| Do-while style retry loop | Script 4 |
| `read` for interactive user input | Script 5 |
| Writing to files with `>` and `>>` | Script 5 |
| Aliases concept (via function) | Script 5 |
| Pipe with `grep`, `awk`, `cut` | Scripts 2, 3, 4 |
| Command-line arguments `$1`, `$2` | Script 4 |

---

## How to Run the Scripts on Linux Ubuntu

### Step 1 — Clone the Repository
```bash
git clone https://github.com/dhruv/oss-audit-24BAI10807.git
cd oss-audit-24BAI10807
```

### Step 2 — Make Scripts Executable
```bash
chmod +x scripts/*.sh
```

### Step 3 — Run Each Script

**Script 1: System Identity Report**
```bash
bash scripts/script1_system_identity.sh
```
No arguments needed. Displays your system info and kernel license.

---

**Script 2: FOSS Package Inspector**
```bash
bash scripts/script2_package_inspector.sh
```
No arguments needed. Automatically detects the running kernel version and checks the package.

---

**Script 3: Disk and Permission Auditor**
```bash
bash scripts/script3_disk_permission_auditor.sh
```
No arguments needed. Audits standard directories plus Linux Kernel-specific paths.

---

**Script 4: Log File Analyzer**
```bash
# Default: searches /var/log/syslog for "error"
bash scripts/script4_log_analyzer.sh

# Custom log file and keyword:
bash scripts/script4_log_analyzer.sh /var/log/kern.log warning

# Search kernel messages for USB events:
bash scripts/script4_log_analyzer.sh /var/log/syslog usb
```
Arguments: `$1` = log file path (optional), `$2` = keyword (optional, default: "error")

---

**Script 5: Open Source Manifesto Generator**
```bash
bash scripts/script5_manifesto_generator.sh
```
Interactive. You will be prompted for 3 answers. Output is saved to `manifesto_dhruv.txt` in the current directory.

---

## Dependencies

All scripts require a standard Ubuntu/Debian system with:
- `bash` (pre-installed)
- `dpkg` (pre-installed on Ubuntu/Debian)
- `coreutils` — `uname`, `whoami`, `uptime`, `date`, `du`, `df` (pre-installed)
- `lsb-release` — for distro detection: `sudo apt install lsb-release`
- `gawk` — for `awk`: `sudo apt install gawk`

No external or non-standard packages are required.

---

## Repository Structure

```
oss-audit-24BAI10807/
├── README.md
└── scripts/
    ├── script1_system_identity.sh
    ├── script2_package_inspector.sh
    ├── script3_disk_permission_auditor.sh
    ├── script4_log_analyzer.sh
    └── script5_manifesto_generator.sh
```

---

## References

- [GNU GPL v2 License Text](https://www.gnu.org/licenses/old-licenses/gpl-2.0.html)
- [The Linux Kernel Archives](https://www.kernel.org)
- [The Free Software Definition — GNU Project](https://www.gnu.org/philosophy/free-sw.html)
- [The Cathedral and the Bazaar — Eric S. Raymond](http://www.catb.org/~esr/writings/cathedral-bazaar/)
- [Ubuntu Kernel Documentation](https://ubuntu.com/kernel)
