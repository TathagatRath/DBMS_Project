-- ============================================================
-- PHARMACY MANAGEMENT SYSTEM — TEST CASES
-- Oracle SQL*Plus  |  Run after procedures.sql
-- ============================================================

SET SERVEROUTPUT ON
SET LINESIZE 150
SET PAGESIZE 50
SET COLSEP " | "
SET VERIFY OFF

COLUMN TRADE_NAME         FORMAT A20
COLUMN FORMULA            FORMAT A30
COLUMN COMPANY_NAME       FORMAT A20
COLUMN PRESCRIPTION_DATE  FORMAT A12
COLUMN NAME               FORMAT A25
COLUMN ADDRESS            FORMAT A40

-- ============================================================
-- 1. ManagePharmacy
-- ============================================================

-- ADD a new pharmacy
EXEC ManagePharmacy('ADD', 'Test Pharmacy', '123 Test Lane', '+91-9999999999');
SELECT * FROM Pharmacy WHERE Name = 'Test Pharmacy';

-- ============================================================
-- 2. ManagePrescription
-- ============================================================

-- [PASS] Add a new prescription
EXEC ManagePrescription('ADD', '112233445566', '798512347812', 'Metformin', 'Biocon', DATE '2025-04-22', 2);
SELECT * FROM Prescribes
 WHERE PatientID = '112233445566' AND DoctorID = '798512347812'
   AND Trade_Name = 'Metformin' AND Company_Name = 'Biocon';

-- [FAIL] Duplicate: same patient, doctor, and date
EXEC ManagePrescription('ADD', '112233445566', '798512347812', 'Metformin', 'Biocon', DATE '2025-04-22', 2);
-- Expected: Error about duplicate prescription

-- [FAIL] Back-dated: a newer prescription already exists for this pair
EXEC ManagePrescription('ADD', '112233445566', '798512347812', 'Metformin', 'Biocon', DATE '2025-06-01', 5);
EXEC ManagePrescription('ADD', '112233445566', '798512347812', 'Metformin', 'Biocon', DATE '2025-05-01', 3);
-- Expected: Error about newer prescription already existing

-- [PASS] Newer insert auto-deletes older entry
EXEC ManagePrescription('ADD', '223344556677', '234567894567', 'Saridon', 'Cipla', DATE '2025-04-01', 2);
EXEC ManagePrescription('ADD', '223344556677', '234567894567', 'Saridon', 'Cipla', DATE '2025-04-15', 2);
SELECT * FROM Prescribes
 WHERE PatientID = '223344556677' AND DoctorID = '234567894567'
   AND Trade_Name = 'Saridon' AND Company_Name = 'Cipla';
-- Expected: only the 2025-04-15 record remains

-- [PASS] Same date, different drug
EXEC ManagePrescription('ADD', '112233445566', '798512347812', 'Dolo 650', 'Sun Pharma', DATE '2025-04-22', 1);
SELECT * FROM Prescribes
 WHERE PatientID = '112233445566' AND DoctorID = '798512347812'
   AND Trade_Name = 'Dolo 650' AND Company_Name = 'Sun Pharma';

-- [FAIL] Non-existent patient
EXEC ManagePrescription('ADD', '000000000000', '798512347812', 'Metformin', 'Biocon', DATE '2025-04-22', 1);

-- [FAIL] Non-existent doctor
EXEC ManagePrescription('ADD', '112233445566', '000000000000', 'Metformin', 'Biocon', DATE '2025-04-22', 1);

-- [FAIL] Non-existent drug / company
EXEC ManagePrescription('ADD', '112233445566', '798512347812', 'NonexistentDrug', 'FakeCompany', DATE '2025-04-22', 1);

-- [PASS] Update prescription quantity and date
EXEC ManagePrescription('UPDATE', '112233445566', '798512347812', 'Metformin', 'Biocon', DATE '2025-04-23', 4);
SELECT * FROM Prescribes
 WHERE PatientID = '112233445566' AND DoctorID = '798512347812'
   AND Trade_Name = 'Metformin' AND Company_Name = 'Biocon';

-- [PASS] Delete a prescription
EXEC ManagePrescription('DELETE', '112233445566', '798512347812', 'Metformin', 'Biocon');
SELECT * FROM Prescribes
 WHERE PatientID = '112233445566' AND DoctorID = '798512347812'
   AND Trade_Name = 'Metformin' AND Company_Name = 'Biocon';
-- Expected: 0 rows

-- [PASS / graceful] Update and delete on non-existent records
EXEC ManagePrescription('UPDATE', '000000000000', '000000000000', 'FakeDrug', 'FakeCompany', DATE '2025-04-22', 1);
EXEC ManagePrescription('DELETE', '000000000000', '000000000000', 'FakeDrug', 'FakeCompany');

-- ============================================================
-- 3. patient_prescriptions_report — April 2025
-- ============================================================
EXEC patient_prescriptions_report('876543210987', DATE '2025-04-01', DATE '2025-04-30');

-- ============================================================
-- 4. PrintPrescriptionDetails
-- ============================================================

-- [PASS] Valid prescription date
EXEC PrintPrescriptionDetails('876543210987', DATE '2025-04-22');

-- [PASS / graceful] Date with no prescriptions
EXEC PrintPrescriptionDetails('876543210987', DATE '2025-01-01');
-- Expected: No prescriptions found for this date

-- [FAIL] Invalid patient ID
EXEC PrintPrescriptionDetails('000000000000', SYSDATE);
-- Expected: Error: Patient 000000000000 not found

-- ============================================================
-- 5. GetCompanyDrugs — Sun Pharma
-- ============================================================
VARIABLE drugs REFCURSOR
EXEC :drugs := GetCompanyDrugs('Sun Pharma');
PRINT drugs

-- ============================================================
-- 6. GetStockPosition — Apollo Pharmacy
-- ============================================================
VARIABLE stock REFCURSOR
EXEC GetStockPosition('Apollo Pharmacy', :stock);
PRINT stock

-- ============================================================
-- 7. GetContactDetails — Apollo Pharmacy & Sun Pharma
-- ============================================================
VARIABLE ph_phone VARCHAR2(15)
VARIABLE co_phone VARCHAR2(15)
EXEC GetContactDetails('Apollo Pharmacy', 'Sun Pharma', :ph_phone, :co_phone);
PRINT ph_phone
PRINT co_phone

-- ============================================================
-- 8. GetDoctorPatients — Dr. Alok Pandey (123456789012)
-- ============================================================
VARIABLE patients REFCURSOR
EXEC :patients := GetDoctorPatients('123456789012');
PRINT patients
