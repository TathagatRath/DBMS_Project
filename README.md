Pharmacy Management System — Oracle PL/SQL
A relational database project modelling a pharmacy management system built with Oracle SQL and PL/SQL. It covers schema design, stored procedures, cursors, ref cursors, and structured exception handling.
---
Schema Overview
Seven tables with referential integrity enforced via foreign keys:
Table	Description
Doctor-	Doctors with specialties and experience
Patient-	Patients linked to a primary physician
PharmaceuticalCompany-	Drug manufacturers
Drug-	Drugs identified by trade name + company
Pharmacy-	Pharmacy outlets
Sells-	Which pharmacy sells which drug and at what price
Prescribes-	Prescription records linking doctors, patients, and drugs
Contract-	Supply contracts between pharmacies and companies


Stored Procedures & Functions
Name	Type	Description
`ManageDoctor`	Procedure	ADD / UPDATE / DELETE a doctor
`ManagePatient`	Procedure	ADD / UPDATE / DELETE a patient
`ManagePharmacy`	Procedure	ADD / UPDATE / DELETE a pharmacy
`ManageCompany`	Procedure	ADD / UPDATE / DELETE a pharmaceutical company
`ManageDrug`	Procedure	ADD / UPDATE / DELETE a drug
`ManageContract`	Procedure	ADD / UPDATE / DELETE a contract
`ManagePrescription`	Procedure	ADD / UPDATE / DELETE a prescription with duplicate and date-conflict checks
`patient_prescriptions_report`	Procedure	Prints all prescriptions for a patient within a date range
`PrintPrescriptionDetails`	Procedure	Prints full prescription details for a patient on a given date
`GetCompanyDrugs`	Function	Returns a ref cursor of all drugs by a company
`GetStockPosition`	Procedure	Returns a ref cursor of drugs sold by a pharmacy
`GetContactDetails`	Procedure	Returns phone numbers for a pharmacy and company pair
`GetDoctorPatients`	Function	Returns a ref cursor of all patients under a doctor
---
How to Run
Requirements: Oracle Database (12c or later), SQL*Plus or SQL Developer
Steps:
```sql
-- 1. Create tables
@schema.sql

-- 2. Insert sample data
@data/insert_data.sql

-- 3. Create stored procedures and functions
@procedures.sql

-- 4. Run test cases
@tests.sql
```
> Make sure `SET SERVEROUTPUT ON` is active before running tests to see `DBMS_OUTPUT` messages.
---
Sample Data
25 Doctors across specialties (Cardiology, Oncology, Neurology, etc.)
25 Patients across Indian cities
25 Pharmaceutical companies (Sun Pharma, Cipla, Biocon, etc.)
25 Drugs with chemical formulas
25 Pharmacies (Apollo, MedPlus, 1mg, etc.)
25 Sells, Prescriptions, and Contracts records each
---
Key Design Decisions
`Drug` uses a composite primary key `(Trade_Name, Company_Name)` — the same drug name can be manufactured by different companies
`Prescribes` PK is `(PatientID, DoctorID, Trade_Name, Company_Name)` — a doctor can prescribe multiple drugs to one patient
`ManagePrescription` enforces a business rule: adding a newer prescription auto-deletes older ones for the same doctor-patient pair; adding an older prescription when a newer one exists is rejected
`ON DELETE CASCADE` is used on `Drug → Prescribes` and `PharmaceuticalCompany → Drug` to maintain referential integrity
---
Tech Stack
Oracle SQL & PL/SQL
SQL*Plus / SQL Developer
