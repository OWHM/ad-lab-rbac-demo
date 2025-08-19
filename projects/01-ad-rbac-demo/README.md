\# Active Directory RBAC Demo (One-Night Security Admin Project)



\## Overview

This project demonstrates how to set up a mini Active Directory (AD) environment, create Organizational Units (OUs), provision users, assign them to groups, and enforce Role-Based Access Control (RBAC) with shared folders.



✅ Outcome: A working AD domain with RBAC, screenshots proving access enforcement, and automation via PowerShell.



---



\## Steps Completed



\### 1. Prep Environment

\- Created a Windows Server 2019 VM in VirtualBox.

\- Specs: 2 vCPU, 4GB RAM, 40GB Disk.

\- Attached ISO from Microsoft Evaluation Center.



📸 \*Screenshot 1: VirtualBox VM Settings (before install)\*



---



\### 2. Promote to Domain Controller

\- Installed \*\*Active Directory Domain Services (AD DS)\*\*.

\- Promoted server to Domain Controller with domain: `uhlab.local`.



📸 \*Screenshot 2: Server Manager → Add Roles Wizard\*  

📸 \*Screenshot 3: Domain Promotion Wizard → Domain Name (`uhlab.local`)\*



---



\### 3. Create Organizational Units \& Groups

\- Created OUs:

&nbsp; - Healthcare\_Staff

&nbsp;   - Doctors

&nbsp;   - Nurses

&nbsp;   - IT

\- Created security groups: Doctors, Nurses, IT.



📸 \*Screenshot 4: ADUC with OU structure visible\*  

📸 \*Screenshot 5: ADUC showing Security Groups created\*



---



\### 4. Add Users

\- Used \*\*PowerShell Bulk Import\*\* (`New-BulkADUsers.ps1`) with `users.csv`.  

\- Example users:

&nbsp; - Dr. Alice (Doctors)

&nbsp; - Nurse Ben (Nurses)

&nbsp; - IT Sam (IT)



📸 \*Screenshot 6: PowerShell output of bulk user creation\*  

📸 \*Screenshot 7: ADUC showing users in their OUs\*



---



\### 5. Apply RBAC with Shared Folders

\- Created `C:\\Shares` with subfolders:

&nbsp; - Doctors

&nbsp; - Nurses

&nbsp; - IT

\- Applied NTFS permissions: each group has access to its folder, denied elsewhere.



📸 \*Screenshot 8: Folder Properties → Security Tab showing group permissions\*



---



\### 6. Test Access

\- Logged in as Dr. Alice → can access Doctors folder, denied Nurses folder.

\- Logged in as Nurse Ben → can access Nurses folder, denied Doctors folder.



📸 \*Screenshot 9: Dr. Alice opening Doctors folder successfully\*  

📸 \*Screenshot 10: Dr. Alice denied from Nurses folder\*  

📸 \*Screenshot 11: Nurse Ben denied from Doctors folder\*



---



\### 7. Evidence

All screenshots are saved in `/evidence/`.



---



\## Automation Artifacts

\- `users.csv` → bulk user list.

\- `New-BulkADUsers.ps1` → PowerShell script for provisioning.



---



\## Key Learnings

\- Setting up AD from scratch.

\- Creating OUs and enforcing group-based access.

\- Automating user provisioning via PowerShell.

\- Capturing and presenting security evidence.



