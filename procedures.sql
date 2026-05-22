-- ============================================================
-- PHARMACY MANAGEMENT SYSTEM — STORED PROCEDURES & FUNCTIONS
-- Oracle PL/SQL  |  Run after schema.sql and insert_data.sql
-- ============================================================

-- ============================================================
-- MANAGE PROCEDURES  (ADD / UPDATE / DELETE wrappers)
-- ============================================================

-- ------------------------------------------------------------
-- ManagePharmacy
-- ------------------------------------------------------------
CREATE OR REPLACE PROCEDURE ManagePharmacy(
    p_action  VARCHAR2,
    p_name    VARCHAR2,
    p_address VARCHAR2 DEFAULT NULL,
    p_phone   VARCHAR2 DEFAULT NULL
) IS
BEGIN
    CASE UPPER(p_action)
        WHEN 'ADD' THEN
            INSERT INTO Pharmacy VALUES (p_name, p_address, p_phone);
            DBMS_OUTPUT.PUT_LINE('Pharmacy added: ' || p_name);
        WHEN 'UPDATE' THEN
            UPDATE Pharmacy
               SET Address = p_address, PhoneNumber = p_phone
             WHERE Name = p_name;
            DBMS_OUTPUT.PUT_LINE('Pharmacy updated: ' || p_name);
        WHEN 'DELETE' THEN
            DELETE FROM Pharmacy WHERE Name = p_name;
            DBMS_OUTPUT.PUT_LINE('Pharmacy deleted: ' || p_name);
        ELSE
            DBMS_OUTPUT.PUT_LINE('Unknown action: ' || p_action);
    END CASE;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error in ManagePharmacy: ' || SQLERRM);
END;
/

-- ------------------------------------------------------------
-- ManageDoctor
-- ------------------------------------------------------------
CREATE OR REPLACE PROCEDURE ManageDoctor(
    p_action     VARCHAR2,
    p_id         CHAR,
    p_name       VARCHAR2 DEFAULT NULL,
    p_specialty  VARCHAR2 DEFAULT NULL,
    p_experience INT      DEFAULT NULL
) IS
BEGIN
    CASE UPPER(p_action)
        WHEN 'ADD' THEN
            INSERT INTO Doctor VALUES (p_id, p_name, p_specialty, p_experience);
            DBMS_OUTPUT.PUT_LINE('Doctor added: ' || p_name);
        WHEN 'UPDATE' THEN
            UPDATE Doctor
               SET Name = p_name, Specialty = p_specialty, YearsOfExperience = p_experience
             WHERE AadharID = p_id;
            DBMS_OUTPUT.PUT_LINE('Doctor updated: ' || p_id);
        WHEN 'DELETE' THEN
            DELETE FROM Doctor WHERE AadharID = p_id;
            DBMS_OUTPUT.PUT_LINE('Doctor deleted: ' || p_id);
        ELSE
            DBMS_OUTPUT.PUT_LINE('Unknown action: ' || p_action);
    END CASE;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error in ManageDoctor: ' || SQLERRM);
END;
/

-- ------------------------------------------------------------
-- ManagePatient
-- ------------------------------------------------------------
CREATE OR REPLACE PROCEDURE ManagePatient(
    p_action    VARCHAR2,
    p_id        CHAR,
    p_name      VARCHAR2 DEFAULT NULL,
    p_address   VARCHAR2 DEFAULT NULL,
    p_age       INT      DEFAULT NULL,
    p_physician CHAR     DEFAULT NULL
) IS
BEGIN
    CASE UPPER(p_action)
        WHEN 'ADD' THEN
            INSERT INTO Patient VALUES (p_id, p_name, p_address, p_age, p_physician);
            DBMS_OUTPUT.PUT_LINE('Patient added: ' || p_name);
        WHEN 'UPDATE' THEN
            UPDATE Patient
               SET Name = p_name, Address = p_address, Age = p_age,
                   PrimaryPhysicianID = p_physician
             WHERE AadharID = p_id;
            DBMS_OUTPUT.PUT_LINE('Patient updated: ' || p_id);
        WHEN 'DELETE' THEN
            DELETE FROM Patient WHERE AadharID = p_id;
            DBMS_OUTPUT.PUT_LINE('Patient deleted: ' || p_id);
        ELSE
            DBMS_OUTPUT.PUT_LINE('Unknown action: ' || p_action);
    END CASE;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error in ManagePatient: ' || SQLERRM);
END;
/

-- ------------------------------------------------------------
-- ManageCompany
-- ------------------------------------------------------------
CREATE OR REPLACE PROCEDURE ManageCompany(
    p_action VARCHAR2,
    p_name   VARCHAR2,
    p_phone  VARCHAR2 DEFAULT NULL
) IS
BEGIN
    CASE UPPER(p_action)
        WHEN 'ADD' THEN
            INSERT INTO PharmaceuticalCompany VALUES (p_name, p_phone);
            DBMS_OUTPUT.PUT_LINE('Company added: ' || p_name);
        WHEN 'UPDATE' THEN
            UPDATE PharmaceuticalCompany
               SET Phone_Number = p_phone
             WHERE Company_Name = p_name;
            DBMS_OUTPUT.PUT_LINE('Company updated: ' || p_name);
        WHEN 'DELETE' THEN
            DELETE FROM PharmaceuticalCompany WHERE Company_Name = p_name;
            DBMS_OUTPUT.PUT_LINE('Company deleted: ' || p_name);
        ELSE
            DBMS_OUTPUT.PUT_LINE('Unknown action: ' || p_action);
    END CASE;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error in ManageCompany: ' || SQLERRM);
END;
/

-- ------------------------------------------------------------
-- ManageDrug
-- ------------------------------------------------------------
CREATE OR REPLACE PROCEDURE ManageDrug(
    p_action     VARCHAR2,
    p_trade_name VARCHAR2,
    p_formula    VARCHAR2 DEFAULT NULL,
    p_company    VARCHAR2 DEFAULT NULL
) IS
BEGIN
    CASE UPPER(p_action)
        WHEN 'ADD' THEN
            INSERT INTO Drug VALUES (p_trade_name, p_formula, p_company);
            DBMS_OUTPUT.PUT_LINE('Drug added: ' || p_trade_name);
        WHEN 'UPDATE' THEN
            UPDATE Drug
               SET Formula = p_formula
             WHERE Trade_Name = p_trade_name AND Company_Name = p_company;
            DBMS_OUTPUT.PUT_LINE('Drug updated: ' || p_trade_name);
        WHEN 'DELETE' THEN
            DELETE FROM Drug
             WHERE Trade_Name = p_trade_name AND Company_Name = p_company;
            DBMS_OUTPUT.PUT_LINE('Drug deleted: ' || p_trade_name);
        ELSE
            DBMS_OUTPUT.PUT_LINE('Unknown action: ' || p_action);
    END CASE;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error in ManageDrug: ' || SQLERRM);
END;
/

-- ------------------------------------------------------------
-- ManageContract
-- ------------------------------------------------------------
CREATE OR REPLACE PROCEDURE ManageContract(
    p_action     VARCHAR2,
    p_pharmacy   VARCHAR2,
    p_company    VARCHAR2,
    p_start_date DATE     DEFAULT NULL,
    p_end_date   DATE     DEFAULT NULL,
    p_content    VARCHAR2 DEFAULT NULL,
    p_supervisor CHAR     DEFAULT NULL
) IS
BEGIN
    CASE UPPER(p_action)
        WHEN 'ADD' THEN
            INSERT INTO Contract
            VALUES (p_pharmacy, p_company, p_start_date, p_end_date, p_content, p_supervisor);
            DBMS_OUTPUT.PUT_LINE('Contract added: ' || p_pharmacy || ' - ' || p_company);
        WHEN 'UPDATE' THEN
            UPDATE Contract
               SET Start_Date = p_start_date, End_Date = p_end_date,
                   Content = p_content, SupervisorID = p_supervisor
             WHERE Pharmacy_Name = p_pharmacy AND Company_Name = p_company;
            DBMS_OUTPUT.PUT_LINE('Contract updated: ' || p_pharmacy || ' - ' || p_company);
        WHEN 'DELETE' THEN
            DELETE FROM Contract
             WHERE Pharmacy_Name = p_pharmacy AND Company_Name = p_company;
            DBMS_OUTPUT.PUT_LINE('Contract deleted: ' || p_pharmacy || ' - ' || p_company);
        ELSE
            DBMS_OUTPUT.PUT_LINE('Unknown action: ' || p_action);
    END CASE;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error in ManageContract: ' || SQLERRM);
END;
/

-- ------------------------------------------------------------
-- ManagePrescription
-- Business rules enforced:
--   ADD: rejects duplicates and back-dated entries when a newer
--        prescription exists; auto-deletes older entries on
--        a successful newer insert.
-- ------------------------------------------------------------
CREATE OR REPLACE PROCEDURE ManagePrescription(
    p_action            VARCHAR2,
    p_patient_id        CHAR,
    p_doctor_id         CHAR,
    p_trade_name        VARCHAR2,
    p_company           VARCHAR2,
    p_prescription_date DATE DEFAULT NULL,
    p_quantity          INT  DEFAULT NULL
) IS
    v_count NUMBER;
BEGIN
    CASE UPPER(p_action)

        WHEN 'ADD' THEN
            -- Reject if identical entry already exists on the same date
            SELECT COUNT(*) INTO v_count
              FROM Prescribes
             WHERE PatientID = p_patient_id
               AND DoctorID  = p_doctor_id
               AND Prescription_Date = p_prescription_date;

            IF v_count > 0 THEN
                DBMS_OUTPUT.PUT_LINE('Error: Prescription already exists for this patient, doctor, and date.');
                RETURN;
            END IF;

            -- Reject if a newer prescription already exists
            SELECT COUNT(*) INTO v_count
              FROM Prescribes
             WHERE PatientID = p_patient_id
               AND DoctorID  = p_doctor_id
               AND Prescription_Date > p_prescription_date;

            IF v_count > 0 THEN
                DBMS_OUTPUT.PUT_LINE('Error: Newer prescription exists for this patient and doctor.');
                RETURN;
            END IF;

            -- Remove older prescriptions for the same doctor-patient pair
            DELETE FROM Prescribes
             WHERE PatientID = p_patient_id
               AND DoctorID  = p_doctor_id
               AND Prescription_Date < p_prescription_date;

            INSERT INTO Prescribes
            VALUES (p_patient_id, p_doctor_id, p_trade_name, p_company,
                    p_prescription_date, p_quantity);
            DBMS_OUTPUT.PUT_LINE('Prescription added for patient ' || p_patient_id);

        WHEN 'UPDATE' THEN
            UPDATE Prescribes
               SET Prescription_Date = p_prescription_date,
                   Quantity          = p_quantity
             WHERE PatientID    = p_patient_id
               AND DoctorID     = p_doctor_id
               AND Trade_Name   = p_trade_name
               AND Company_Name = p_company;
            DBMS_OUTPUT.PUT_LINE('Prescription updated for patient ' || p_patient_id);

        WHEN 'DELETE' THEN
            DELETE FROM Prescribes
             WHERE PatientID    = p_patient_id
               AND DoctorID     = p_doctor_id
               AND Trade_Name   = p_trade_name
               AND Company_Name = p_company;
            DBMS_OUTPUT.PUT_LINE('Prescription deleted for patient ' || p_patient_id);

        ELSE
            DBMS_OUTPUT.PUT_LINE('Unknown action: ' || p_action);
    END CASE;
    COMMIT;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Error: Prescription already exists with identical details.');
    WHEN OTHERS THEN
        IF SQLCODE = -2291 THEN
            DBMS_OUTPUT.PUT_LINE('Error: Invalid patient or doctor ID.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        END IF;
END;
/

-- ============================================================
-- REPORT PROCEDURES
-- ============================================================

-- ------------------------------------------------------------
-- patient_prescriptions_report
-- Prints all prescriptions for a patient within a date range.
-- ------------------------------------------------------------
CREATE OR REPLACE PROCEDURE patient_prescriptions_report(
    p_patient_id CHAR,
    p_start_date DATE,
    p_end_date   DATE
) AS
    CURSOR c_prescriptions IS
        SELECT p.DoctorID, p.Prescription_Date,
               d.Name AS DoctorName, d.Specialty,
               p.Trade_Name, p.Company_Name, p.Quantity
          FROM Prescribes p
          JOIN Doctor d ON p.DoctorID = d.AadharID
         WHERE p.PatientID = p_patient_id
           AND p.Prescription_Date BETWEEN p_start_date AND p_end_date
         ORDER BY p.Prescription_Date DESC;

    v_patient_name Patient.Name%TYPE;
    v_found        BOOLEAN := FALSE;
BEGIN
    SELECT Name INTO v_patient_name
      FROM Patient WHERE AadharID = p_patient_id;

    DBMS_OUTPUT.PUT_LINE('==================================================');
    DBMS_OUTPUT.PUT_LINE('Prescription Report for Patient: ' || v_patient_name);
    DBMS_OUTPUT.PUT_LINE('Period: ' || TO_CHAR(p_start_date, 'DD-MON-YYYY') ||
                         ' to '    || TO_CHAR(p_end_date,   'DD-MON-YYYY'));
    DBMS_OUTPUT.PUT_LINE('==================================================');

    FOR r IN c_prescriptions LOOP
        v_found := TRUE;
        DBMS_OUTPUT.PUT_LINE('Date:       ' || TO_CHAR(r.Prescription_Date, 'DD-MON-YYYY'));
        DBMS_OUTPUT.PUT_LINE('Doctor:     ' || r.DoctorName || ' (' || r.Specialty || ')');
        DBMS_OUTPUT.PUT_LINE('Medication: ' || r.Trade_Name || ' (' || r.Company_Name || ')');
        DBMS_OUTPUT.PUT_LINE('Quantity:   ' || r.Quantity);
        DBMS_OUTPUT.PUT_LINE('--------------------------------------------------');
    END LOOP;

    IF NOT v_found THEN
        DBMS_OUTPUT.PUT_LINE('No prescriptions found for this period.');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: Patient ' || p_patient_id || ' not found.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

-- ------------------------------------------------------------
-- PrintPrescriptionDetails
-- Prints full prescription details for a patient on a given date.
-- ------------------------------------------------------------
CREATE OR REPLACE PROCEDURE PrintPrescriptionDetails(
    p_patient_id  IN CHAR,
    p_presc_date  IN DATE
) AS
    v_patient_name Patient.Name%TYPE;
    v_found        BOOLEAN := FALSE;
BEGIN
    SELECT Name INTO v_patient_name
      FROM Patient WHERE AadharID = p_patient_id;

    FOR rec IN (
        SELECT d.Name AS doctor_name, d.Specialty,
               p.Trade_Name, p.Company_Name, dr.Formula, p.Quantity
          FROM Prescribes p
          JOIN Doctor d  ON p.DoctorID     = d.AadharID
          JOIN Drug   dr ON p.Trade_Name   = dr.Trade_Name
                        AND p.Company_Name = dr.Company_Name
         WHERE p.PatientID         = p_patient_id
           AND p.Prescription_Date = p_presc_date
    ) LOOP
        v_found := TRUE;
        DBMS_OUTPUT.PUT_LINE('Prescription Details for ' || v_patient_name);
        DBMS_OUTPUT.PUT_LINE('Doctor:     ' || rec.doctor_name);
        DBMS_OUTPUT.PUT_LINE('Specialty:  ' || rec.Specialty);
        DBMS_OUTPUT.PUT_LINE('Medication: ' || rec.Trade_Name);
        DBMS_OUTPUT.PUT_LINE('Company:    ' || rec.Company_Name);
        DBMS_OUTPUT.PUT_LINE('Formula:    ' || rec.Formula);
        DBMS_OUTPUT.PUT_LINE('Quantity:   ' || rec.Quantity);
    END LOOP;

    IF NOT v_found THEN
        DBMS_OUTPUT.PUT_LINE('No prescriptions found for this date.');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: Patient ' || p_patient_id || ' not found.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

-- ============================================================
-- QUERY FUNCTIONS
-- ============================================================

-- ------------------------------------------------------------
-- GetCompanyDrugs  — returns all drugs manufactured by a company
-- ------------------------------------------------------------
CREATE OR REPLACE FUNCTION GetCompanyDrugs(
    p_company VARCHAR2
) RETURN SYS_REFCURSOR IS
    v_drugs SYS_REFCURSOR;
BEGIN
    OPEN v_drugs FOR
        SELECT Trade_Name, Formula
          FROM Drug
         WHERE Company_Name = p_company;
    RETURN v_drugs;
END;
/

-- ------------------------------------------------------------
-- GetStockPosition  — drugs sold by a pharmacy with prices
-- ------------------------------------------------------------
CREATE OR REPLACE PROCEDURE GetStockPosition(
    p_pharmacy VARCHAR2,
    p_stock    OUT SYS_REFCURSOR
) IS
BEGIN
    OPEN p_stock FOR
        SELECT Trade_Name, Company_Name, Price
          FROM Sells
         WHERE Pharmacy_Name = p_pharmacy;
END;
/

-- ------------------------------------------------------------
-- GetContactDetails  — phone numbers for a pharmacy-company pair
-- ------------------------------------------------------------
CREATE OR REPLACE PROCEDURE GetContactDetails(
    p_pharmacy      VARCHAR2,
    p_company       VARCHAR2,
    p_pharmacy_phone OUT VARCHAR2,
    p_company_phone  OUT VARCHAR2
) IS
BEGIN
    SELECT ph.PhoneNumber, pc.Phone_Number
      INTO p_pharmacy_phone, p_company_phone
      FROM Pharmacy ph, PharmaceuticalCompany pc
     WHERE ph.Name         = p_pharmacy
       AND pc.Company_Name = p_company;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No contact details found.');
END;
/

-- ------------------------------------------------------------
-- GetDoctorPatients  — all patients under a given doctor
-- ------------------------------------------------------------
CREATE OR REPLACE FUNCTION GetDoctorPatients(
    p_doctor_id CHAR
) RETURN SYS_REFCURSOR IS
    v_patients SYS_REFCURSOR;
BEGIN
    OPEN v_patients FOR
        SELECT Name, Age, Address
          FROM Patient
         WHERE PrimaryPhysicianID = p_doctor_id;
    RETURN v_patients;
END;
/
