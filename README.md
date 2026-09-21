# Linux File Permissions – Self Learning Project

## Project Objective

The purpose of this project was to understand how Linux controls access to files and directories using users, groups, ownership, permissions, and Access Control Lists (ACLs).

Rather than only studying commands theoretically, I created a role-based access control scenario similar to what might be used in a small company and implemented it using Linux permission mechanisms.

---

## Scenario

A company maintains the following directory structure:

```text
/opt/company
├── projects
└── confidentials
```

Three employees work in the company:

| User | Role      |
| ---- | --------- |
| m1   | Manager   |
| d1   | Developer |
| i1   | Intern    |

---

## Access Requirements

| Role      | Projects Directory   | Confidentials Directory |
| --------- | -------------------- | ----------------------- |
| Manager   | Read, Write, Execute | Read, Write, Execute    |
| Developer | Read, Write, Execute | No Access               |
| Intern    | Read, Execute        | No Access               |

---

## Linux Concepts Used

This project helped me explore the following Linux concepts:

* User Management
* Group Management
* Ownership
* File Permissions
* Access Control Lists (ACL)
* Role-Based Access Control

### Permission Flow

```text
Users
  ↓
Groups
  ↓
Ownership
  ↓
Permissions
  ↓
ACL (Additional Access Rules)
```

---

## Implementation Steps

### Step 1 – Create Project Directories

```bash
sudo mkdir -p /opt/company/projects
sudo mkdir -p /opt/company/confidentials
```

---

### Step 2 – Create Groups

```bash
sudo groupadd manager
sudo groupadd developer
sudo groupadd intern
```

Groups are used to manage permissions collectively rather than assigning permissions to individual users.

---

### Step 3 – Create Users

```bash
sudo adduser m1
sudo adduser d1
sudo adduser i1
```

---

### Step 4 – Assign Users to Their Groups

```bash
sudo usermod -aG manager m1
sudo usermod -aG developer d1
sudo usermod -aG intern i1
```

Result:

```text
m1 → manager
d1 → developer
i1 → intern
```

---

### Step 5 – Configure the Projects Directory

The Developer group is set as the primary group owner of the directory.

```bash
sudo chown root:developer /opt/company/projects
sudo chmod 770 /opt/company/projects
```

Permission breakdown:

```text
Owner  → rwx
Group  → rwx
Others → ---
```

Additional access is provided using ACL:

Manager Group:

```bash
sudo setfacl -m g:manager:rwx /opt/company/projects
```

Intern Group:

```bash
sudo setfacl -m g:intern:r-x /opt/company/projects
```

---

### Step 6 – Configure the Confidentials Directory

Only managers should access confidential data.

```bash
sudo chown root:manager /opt/company/confidentials
sudo chmod 770 /opt/company/confidentials
```

Permission breakdown:

```text
Owner  → rwx
Group  → rwx
Others → ---
```

Since only the Manager group owns this directory, developers and interns cannot access it.

---

## Verification

To verify the configuration, I used:

```bash
ls -ld /opt/company/projects
ls -ld /opt/company/confidentials
```

To view ACL entries:

```bash
getfacl /opt/company/projects
```

To check user group membership:

```bash
groups m1
groups d1
groups i1
```

---

## Final Access Structure

```text
/opt/company
│
├── projects
│   ├── Manager    → rwx
│   ├── Developer  → rwx
│   └── Intern     → r-x
│
└── confidentials
    └── Manager    → rwx
```

---

## Commands Learned During This Project

### chmod

Changes file or directory permissions.

```bash
chmod 770 projects
```

---

### chown

Changes ownership of files and directories.

```bash
chown root:developer projects
```

---

### groupadd

Creates a new group.

```bash
groupadd developer
```

---

### usermod

Adds a user to a group.

```bash
usermod -aG developer d1
```

---

### setfacl

Adds additional permissions beyond the standard owner-group-other model.

```bash
setfacl -m g:manager:rwx projects
```

---

### getfacl

Displays ACL permissions.

```bash
getfacl projects
```

---

## Key Learnings

Through this project, I gained practical understanding of:

1. Linux user and group management.
2. Ownership and its role in access control.
3. The meaning of read (`r`), write (`w`), and execute (`x`) permissions.
4. How `chmod` modifies permissions.
5. How `chown` changes ownership.
6. The limitations of the traditional permission model.
7. How ACL provides flexible access control.
8. Designing permissions according to organizational roles.
9. Implementing a simple role-based access control system in Linux.

---

## Conclusion

This project helped me move beyond basic Linux commands and understand how access control is implemented in real environments. By combining users, groups, ownership, permissions, and ACLs, I was able to create a structured permission system that meets different requirements for managers, developers, and interns.
