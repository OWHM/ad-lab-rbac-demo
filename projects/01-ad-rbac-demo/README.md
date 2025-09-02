# Active Directory RBAC Demo Lab

This lab simulates an Active Directory domain in a Windows Server VM.  
It demonstrates **user provisioning, OU structure, security groups, and role-based access control (RBAC)** with full evidence via screenshots and PowerShell automation.  

---

## 🛠️ Tools & Environment
- Windows Server 2019 (Desktop Experience) in VirtualBox  
- Active Directory Domain Services (AD DS)  
- PowerShell automation (`New-BulkADUsers.ps1`, `users.csv`)  
- NTFS + SMB shares for role-based access control  

---

## 🚀 Steps & Evidence

### 1. VM Setup & Roles
Configured Windows Server in VirtualBox and added the AD DS role.  
![VM settings](./evidence/01_vm_settings.png)  
![Add roles](./evidence/02_add_roles.png)  

---

### 2. Domain Controller Promotion
Promoted the server to Domain Controller for `uhlab.local`.  
![Domain promotion](./evidence/03_domain_promotion.png)  

---

### 3. Organizational Units & Groups
Created `Healthcare_Staff` OU with sub-OUs for Doctors, Nurses, and IT.  
Provisioned security groups for each department.  
![OU structure](./evidence/04_ou_structure.png)  
![OU structure via PowerShell](./evidence/05_ou_structure_powershell.png)  

---

### 4. Bulk User Provisioning
Created test users (Dr. Alice, Nurse Ben, IT Sam) via PowerShell CSV import.  
![Bulk user creation](./evidence/06_bulk_user_create.png)  
![Users and groups via PowerShell](./evidence/07a_users_and_groups_powershell.png)  
![Users in ADUC](./evidence/07b_users_in_aduc.png)  

---

### 5. Role-Based Access Control (RBAC)
Applied NTFS Modify rights per group to dedicated folders.  
- Doctors → `C:\Shares\Doctors`  
- Nurses → `C:\Shares\Nurses`  
- IT → `C:\Shares\IT`  

![Doctors folder permissions](./evidence/08a_ntfs_perms_doctors.png)  
![Nurses folder permissions](./evidence/08b_ntfs_perms_nurses.png)  
![IT folder permissions](./evidence/08c_ntfs_perms_it.png)  
![Permissions via PowerShell](./evidence/08d_ntfs_perms_powershell.png)  

---

### 6. Access Testing
Confirmed access works only for proper groups.  
- Dr. Alice → Doctors ✅, Nurses ❌  
- Nurse Ben → Nurses ✅, Doctors ❌  
- IT Sam → IT ✅  

![Access Doctors as Alice](./evidence/09_access_doctors_as_alice.png)  
![Denied Nurses as Alice](./evidence/10_denied_nurses_as_alice.png)  
![Denied Doctors as Ben](./evidence/11_denied_doctors_as_ben.png)  
![Access IT as Sam](./evidence/12a_access_it_as_sam.png)  
![Denied IT other folders](./evidence/12b_denied_it_other_folders.png)  

---

### 7. Final Sanity Check
Verified shares and group membership via PowerShell.  
![Final sanity check](./evidence/13_final_sanity_check.png)  

---

## 📌 Reflection
- Learned how to provision AD DS, OUs, groups, and users both via GUI and PowerShell.  
- Solved a **real-world NTFS ownership issue** using `takeown`, `icacls`, and `Set-Acl`.  
- Built repeatable automation with PowerShell for bulk provisioning.  
- Discovered that by default, **users cannot log on locally to DCs**. Wrote a PowerShell script to adjust `SeInteractiveLogonRight` for lab-only testing.  
- **Real-world note**: In production, users log on to domain-joined clients or member servers — never directly to DCs.  

---

## 📂 Repo Contents
- `users.csv` — test user list  
- `New-BulkADUsers.ps1` — bulk provisioning script  
- `Fix-LocalLogon.ps1` — lab-only script to allow test user login to DC  
- `evidence/` — screenshots documenting the lab  


