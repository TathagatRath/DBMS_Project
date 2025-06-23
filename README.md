

-- ============================================
-- DROP AND CREATE TABLES
-- ============================================
DROP TABLE Prescribes CASCADE CONSTRAINTS;
DROP TABLE Sells CASCADE CONSTRAINTS;
DROP TABLE Contract CASCADE CONSTRAINTS;
DROP TABLE Drug CASCADE CONSTRAINTS;
DROP TABLE Pharmacy CASCADE CONSTRAINTS;
DROP TABLE PharmaceuticalCompany CASCADE CONSTRAINTS;
DROP TABLE Patient CASCADE CONSTRAINTS;
DROP TABLE Doctor CASCADE CONSTRAINTS;
CREATE TABLE Doctor (
    AadharID CHAR(12) PRIMARY KEY,
    Name VARCHAR2(100) NOT NULL,
    Specialty VARCHAR2(100),
    YearsOfExperience INT
);

CREATE TABLE Patient (
    AadharID CHAR(12) PRIMARY KEY,
    Name VARCHAR2(100) NOT NULL,
    Address VARCHAR2(1000), 
    Age INT,
    PrimaryPhysicianID CHAR(12),
    FOREIGN KEY (PrimaryPhysicianID) REFERENCES Doctor(AadharID)
);

CREATE TABLE PharmaceuticalCompany (
    Company_Name VARCHAR2(100) PRIMARY KEY,
    Phone_Number VARCHAR2(15)
);

CREATE TABLE Drug (
    Trade_Name VARCHAR2(100),
    Formula VARCHAR2(1000), 
    Company_Name VARCHAR2(100),
    PRIMARY KEY (Trade_Name, Company_Name),
    FOREIGN KEY (Company_Name) REFERENCES PharmaceuticalCompany(Company_Name)
        ON DELETE CASCADE
);

CREATE TABLE Pharmacy (
    Name VARCHAR2(100) PRIMARY KEY,
    Address VARCHAR2(1000), 
    PhoneNumber VARCHAR2(15)
);

CREATE TABLE Sells (
    Pharmacy_Name VARCHAR2(100),
    Trade_Name VARCHAR2(100),
    Company_Name VARCHAR2(100),
    Price DECIMAL(10, 2),
    PRIMARY KEY (Pharmacy_Name, Trade_Name, Company_Name),
    FOREIGN KEY (Pharmacy_Name) REFERENCES Pharmacy(Name),
    FOREIGN KEY (Trade_Name, Company_Name) REFERENCES Drug(Trade_Name, Company_Name)
);

CREATE TABLE Prescribes (
    PatientID CHAR(12),
    DoctorID CHAR(12),
    Trade_Name VARCHAR2(100),
    Company_Name VARCHAR2(100),
    Prescription_Date DATE,
    Quantity INT,
    PRIMARY KEY (PatientID, DoctorID, Trade_Name, Company_Name),
    FOREIGN KEY (PatientID) REFERENCES Patient (AadharID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor (AadharID),
    FOREIGN KEY (Trade_Name, Company_Name) REFERENCES Drug(Trade_Name, Company_Name)
        ON DELETE CASCADE
);

CREATE TABLE Contract (
    Pharmacy_Name VARCHAR2(100),
    Company_Name VARCHAR2(100),
    Start_Date DATE,
    End_Date DATE,
    Content VARCHAR2(2000), 
    SupervisorID CHAR(12),
    PRIMARY KEY (Pharmacy_Name, Company_Name),
    FOREIGN KEY (Pharmacy_Name) REFERENCES Pharmacy(Name),
    FOREIGN KEY (Company_Name) REFERENCES PharmaceuticalCompany(Company_Name)
);
@"D:/Bits Hyderabad_Campus Diaries/DBMS Project/insert_data.sql"

-- ============================================
-- INSERT DATA
-- ============================================
SET DEFINE OFF;
INSERT ALL
    INTO Doctor VALUES ('798512347812', 'Dr. Rohan Sharma', 'Cardiology', 15)
    INTO Doctor VALUES ('234567894567', 'Dr. Priya Patel', 'Pediatrics', 8)
    INTO Doctor VALUES ('345678901234', 'Dr. Amit Khanna', 'Orthopedics', 12)
    INTO Doctor VALUES ('456789012345', 'Dr. Anjali Desai', 'Dermatology', 10)
    INTO Doctor VALUES ('567890123456', 'Dr. Vikram Singh', 'Oncology', 18)
    INTO Doctor VALUES ('678901234567', 'Dr. Neha Gupta', 'Neurology', 7)
    INTO Doctor VALUES ('789012345678', 'Dr. Arjun Reddy', 'General Surgery', 14)
    INTO Doctor VALUES ('890123456789', 'Dr. Sneha Iyer', 'Ophthalmology', 9)
    INTO Doctor VALUES ('901234567890', 'Dr. Rajesh Mehta', 'Endocrinology', 11)
    INTO Doctor VALUES ('012345678901', 'Dr. Kavita Joshi', 'Psychiatry', 6)
    INTO Doctor VALUES ('112233445566', 'Dr. Sanjay Verma', 'Urology', 13)
    INTO Doctor VALUES ('223344556677', 'Dr. Pooja Choudhary', 'Gynecology', 5)
    INTO Doctor VALUES ('334455667788', 'Dr. Rohit Malhotra', 'ENT', 16)
    INTO Doctor VALUES ('445566778899', 'Dr. Ananya Rao', 'Rheumatology', 4)
    INTO Doctor VALUES ('556677889900', 'Dr. Akash Deshpande', 'Pulmonology', 17)
    INTO Doctor VALUES ('667788990011', 'Dr. Meera Krishnan', 'Nephrology', 8)
    INTO Doctor VALUES ('778899001122', 'Dr. Vivek Nair', 'Hematology', 10)
    INTO Doctor VALUES ('889900112233', 'Dr. Shalini Sengupta', 'Gastroenterology', 9)
    INTO Doctor VALUES ('990011223344', 'Dr. Karan Bajaj', 'Dermatology', 7)
    INTO Doctor VALUES ('001122334455', 'Dr. Nandini Rana', 'Cardiology', 12)
    INTO Doctor VALUES ('123456789012', 'Dr. Alok Pandey', 'Orthopedics', 14)
    INTO Doctor VALUES ('987654321098', 'Dr. Swati Mishra', 'Pediatrics', 6)
    INTO Doctor VALUES ('876543210987', 'Dr. Ravi Shukla', 'Oncology', 11)
    INTO Doctor VALUES ('765432109876', 'Dr. Anika Trivedi', 'Neurology', 5)
    INTO Doctor VALUES ('654321098765', 'Dr. Siddharth Bose', 'General Surgery', 9)
SELECT 1 FROM DUAL;

INSERT ALL
    INTO Patient VALUES ('112233445566', 'Rahul Verma', '12 Gandhi Road, Mumbai', 35, '798512347812')
    INTO Patient VALUES ('223344556677', 'Priya Menon', '45 Nehru Nagar, Delhi', 28, '234567894567')
    INTO Patient VALUES ('334455667788', 'Arjun Iyer', '78 Tagore Street, Bangalore', 42, '345678901234')
    INTO Patient VALUES ('445566778899', 'Ananya Deshpande', '32 Patel Chowk, Pune', 19, '456789012345')
    INTO Patient VALUES ('556677889900', 'Vikram Reddy', '9 Bose Lane, Hyderabad', 55, '567890123456')
    INTO Patient VALUES ('667788990011', 'Neha Chatterjee', '21 Tilak Road, Kolkata', 31, '678901234567')
    INTO Patient VALUES ('778899001122', 'Rohan Malhotra', '63 Azad Marg, Chennai', 24, '789012345678')
    INTO Patient VALUES ('889900112233', 'Pooja Srinivasan', '87 Nariman Point, Mumbai', 67, '890123456789')
    INTO Patient VALUES ('990011223344', 'Amit Trivedi', '14 Brigade Road, Bangalore', 38, '901234567890')
    INTO Patient VALUES ('001122334455', 'Kavita Nair', '29 Marine Drive, Mumbai', 29, '012345678901')
    INTO Patient VALUES ('123456789012', 'Sanjay Gupta', '5 Jubilee Hills, Hyderabad', 43, '112233445566')
    INTO Patient VALUES ('234567890123', 'Meera Joshi', '8 Banjara Hills, Hyderabad', 26, '223344556677')
    INTO Patient VALUES ('345678901234', 'Rajesh Khanna', '17 Koregaon Park, Pune', 50, '334455667788')
    INTO Patient VALUES ('456789012345', 'Anjali Rao', '23 Church Street, Bangalore', 33, '445566778899')
    INTO Patient VALUES ('567890123456', 'Vivek Sengupta', '41 Park Street, Kolkata', 22, '556677889900')
    INTO Patient VALUES ('678901234567', 'Shalini Bose', '9 MG Road, Delhi', 45, '667788990011')
    INTO Patient VALUES ('789012345678', 'Karan Desai', '3 Connaught Place, Delhi', 39, '778899001122')
    INTO Patient VALUES ('890123456789', 'Nandini Reddy', '12 Hitech City, Hyderabad', 31, '889900112233')
    INTO Patient VALUES ('901234567890', 'Alok Mishra', '7 Boat Club Road, Chennai', 28, '990011223344')
    INTO Patient VALUES ('012345678901', 'Swati Pandey', '19 Anna Salai, Chennai', 53, '001122334455')
    INTO Patient VALUES ('987654321098', 'Ravi Shukla', '54 Shivaji Nagar, Pune', 36, '123456789012')
    INTO Patient VALUES ('876543210987', 'Anika Trivedi', '32 Cunningham Road, Bangalore', 27, '987654321098')
    INTO Patient VALUES ('765432109876', 'Siddharth Rao', '8 Worli Sea Face, Mumbai', 44, '876543210987')
    INTO Patient VALUES ('654321098765', 'Aditi Choudhary', '5 Salt Lake, Kolkata', 29, '765432109876')
    INTO Patient VALUES ('543210987654', 'Rohit Bajaj', '23 Ameerpet, Hyderabad', 38, '654321098765')
SELECT 1 FROM DUAL;

INSERT ALL
    INTO  PharmaceuticalCompany VALUES ('Sun Pharma', '+91-9876543200')
    INTO  PharmaceuticalCompany VALUES ('Cipla', '+91-9876543201')
    INTO  PharmaceuticalCompany VALUES ('Dr. Reddy''s', '+91-9876543202')
    INTO  PharmaceuticalCompany VALUES ('Lupin', '+91-9876543203')
    INTO  PharmaceuticalCompany VALUES ('Aurobindo', '+91-9876543204')
    INTO  PharmaceuticalCompany VALUES ('Cadila', '+91-9876543205')
    INTO  PharmaceuticalCompany VALUES ('Torrent', '+91-9876543206')
    INTO  PharmaceuticalCompany VALUES ('Glenmark', '+91-9876543207')
    INTO  PharmaceuticalCompany VALUES ('Biocon', '+91-9876543208')
    INTO  PharmaceuticalCompany VALUES ('Alkem', '+91-9876543209')
    INTO  PharmaceuticalCompany VALUES ('Divi''s Labs', '+91-9876543210')
    INTO  PharmaceuticalCompany VALUES ('Ipca', '+91-9876543211')
    INTO  PharmaceuticalCompany VALUES ('Wockhardt', '+91-9876543212')
    INTO  PharmaceuticalCompany VALUES ('Natco', '+91-9876543213')
    INTO  PharmaceuticalCompany VALUES ('Jubilant', '+91-9876543214')
    INTO  PharmaceuticalCompany VALUES ('Mankind', '+91-9876543215')
    INTO  PharmaceuticalCompany VALUES ('Zydus', '+91-9876543216')
    INTO  PharmaceuticalCompany VALUES ('Strides', '+91-9876543217')
    INTO  PharmaceuticalCompany VALUES ('Granules', '+91-9876543218')
    INTO  PharmaceuticalCompany VALUES ('Alembic', '+91-9876543219')
    INTO  PharmaceuticalCompany VALUES ('Abbott India', '+91-9876543220')
    INTO  PharmaceuticalCompany VALUES ('Bharat Biotech', '+91-9876543221')
    INTO  PharmaceuticalCompany VALUES ('Serum Institute', '+91-9876543222')
    INTO  PharmaceuticalCompany VALUES ('Panacea', '+91-9876543223')
    INTO  PharmaceuticalCompany VALUES ('GSK India', '+91-9876543224')
SELECT 1 FROM DUAL;

INSERT ALL
    INTO Drug VALUES ('Dolo 650', 'C16H19NO4', 'Sun Pharma')
    INTO Drug VALUES ('Saridon', 'C10H13N', 'Cipla')
    INTO Drug VALUES ('Crocin', 'C8H9NO2', 'Dr. Reddy''s')
    INTO Drug VALUES ('Combiflam', 'C16H19NO4', 'Lupin')
    INTO Drug VALUES ('Disprin', 'C9H8O4', 'Aurobindo')
    INTO Drug VALUES ('Vicks', 'C10H14O', 'Cadila')
    INTO Drug VALUES ('Amoxil', 'C16H19N3O5S', 'Torrent')
    INTO Drug VALUES ('Ciplox', 'C17H18ClN3O4', 'Glenmark')
    INTO Drug VALUES ('Metformin', 'C4H11N5', 'Biocon')
    INTO Drug VALUES ('Pantoprazole', 'C16H15N3O4S', 'Alkem')
    INTO Drug VALUES ('Azithromycin', 'C38H72N2O12', 'Divi''s Labs')
    INTO Drug VALUES ('Paracetamol', 'C8H9NO2', 'Ipca')
    INTO Drug VALUES ('Ibuprofen', 'C13H18O2', 'Wockhardt')
    INTO Drug VALUES ('Cetirizine', 'C21H25ClN2O5', 'Natco')
    INTO Drug VALUES ('Loratadine', 'C22H23ClN2O3', 'Jubilant')
    INTO Drug VALUES ('Omeprazole', 'C17H19N3O3', 'Mankind')
    INTO Drug VALUES ('Ranitidine', 'C13H22N4O3', 'Zydus')
    INTO Drug VALUES ('Levocetirizine', 'C21H25ClN2O5', 'Strides')
    INTO Drug VALUES ('Diclofenac', 'C14H11Cl2NO2', 'Granules')
    INTO Drug VALUES ('Naproxen', 'C14H14O3', 'Alembic')
    INTO Drug VALUES ('Aspirin', 'C9H8O4', 'Abbott India')
    INTO Drug VALUES ('Clarithromycin', 'C18H19ClN4', 'Bharat Biotech')
    INTO Drug VALUES ('Cefixime', 'C16H15ClN6O4S', 'Serum Institute')
    INTO Drug VALUES ('Ceftriaxone', 'C18H16N2O7S3', 'Panacea')
    INTO Drug VALUES ('Cloxacillin', 'C15H14ClNO2', 'GSK India')
SELECT 1 FROM DUAL;

INSERT ALL
    INTO Pharmacy VALUES ('Apollo Pharmacy', '12 MG Road, Bangalore', '+91-9876500000')
    INTO Pharmacy VALUES ('MedPlus', '45 Park Street, Kolkata', '+91-9876500001')
    INTO Pharmacy VALUES ('1mg', '78 Marine Drive, Mumbai', '+91-9876500002')
    INTO Pharmacy VALUES ('Netmeds', '23 Connaught Place, Delhi', '+91-9876500003')
    INTO Pharmacy VALUES ('PharmEasy', '56 Brigade Road, Bangalore', '+91-9876500004')
    INTO Pharmacy VALUES ('HealthKart', '89 Nehru Nagar, Delhi', '+91-9876500005')
    INTO Pharmacy VALUES ('Care24', '34 Anna Salai, Chennai', '+91-9876500006')
    INTO Pharmacy VALUES ('Medlife', '67 MG Road, Pune', '+91-9876500007')
    INTO Pharmacy VALUES ('SastaSundar', '90 Salt Lake, Kolkata', '+91-9876500008')
    INTO Pharmacy VALUES ('Guardian Pharmacy', '12 Banjara Hills, Hyderabad', '+91-9876500009')
    INTO Pharmacy VALUES ('MedPlus Mart', '45 Jubilee Hills, Hyderabad', '+91-9876500010')
    INTO Pharmacy VALUES ('Apollo Clinic', '78 Koregaon Park, Pune', '+91-9876500011')
    INTO Pharmacy VALUES ('Wellness Pharmacy', '23 Church Street, Bangalore', '+91-9876500012')
    INTO Pharmacy VALUES ('LifeCare', '56 Park Street, Kolkata', '+91-9876500013')
    INTO Pharmacy VALUES ('Health & Glow', '89 Marine Drive, Mumbai', '+91-9876500014')
    INTO Pharmacy VALUES ('Medicover', '34 Connaught Place, Delhi', '+91-9876500015')
    INTO Pharmacy VALUES ('Fortis Pharmacy', '67 Brigade Road, Bangalore', '+91-9876500016')
    INTO Pharmacy VALUES ('Max Healthcare', '90 Nehru Nagar, Delhi', '+91-9876500017')
    INTO Pharmacy VALUES ('Cloudnine Pharmacy', '12 Anna Salai, Chennai', '+91-9876500018')
    INTO Pharmacy VALUES ('Narayana Pharmacy', '45 MG Road, Pune', '+91-9876500019')
    INTO Pharmacy VALUES ('KIMS Pharmacy', '78 Salt Lake, Kolkata', '+91-9876500020')
    INTO Pharmacy VALUES ('Manipal Pharmacy', '23 Banjara Hills, Hyderabad', '+91-9876500021')
    INTO Pharmacy VALUES ('Aster Pharmacy', '56 Jubilee Hills, Hyderabad', '+91-9876500022')
    INTO Pharmacy VALUES ('Columbia Asia Pharmacy', '89 Koregaon Park, Pune', '+91-9876500023')
    INTO Pharmacy VALUES ('Vasan Pharmacy', '34 Church Street, Bangalore', '+91-9876500024')
SELECT 1 FROM DUAL;

INSERT ALL
    INTO Sells VALUES ('Apollo Pharmacy', 'Dolo 650', 'Sun Pharma', 282.55)
    INTO Sells VALUES ('MedPlus', 'Saridon', 'Cipla', 310.75)
    INTO Sells VALUES ('1mg', 'Crocin', 'Dr. Reddy''s', 583.64)
    INTO Sells VALUES ('Netmeds', 'Combiflam', 'Lupin', 89.23)
    INTO Sells VALUES ('PharmEasy', 'Disprin', 'Aurobindo', 513.95)
    INTO Sells VALUES ('HealthKart', 'Vicks', 'Cadila', 720.00)
    INTO Sells VALUES ('Care24', 'Amoxil', 'Torrent', 150.50)
    INTO Sells VALUES ('Medlife', 'Ciplox', 'Glenmark', 95.75)
    INTO Sells VALUES ('SastaSundar', 'Metformin', 'Biocon', 65.25)
    INTO Sells VALUES ('Guardian Pharmacy', 'Pantoprazole', 'Alkem', 85.90)
    INTO Sells VALUES ('MedPlus Mart', 'Azithromycin', 'Divi''s Labs', 120.00)
    INTO Sells VALUES ('Apollo Clinic', 'Paracetamol', 'Ipca', 15.99)
    INTO Sells VALUES ('Wellness Pharmacy', 'Ibuprofen', 'Wockhardt', 45.50)
    INTO Sells VALUES ('LifeCare', 'Cetirizine', 'Natco', 30.75)
    INTO Sells VALUES ('Health & Glow', 'Loratadine', 'Jubilant', 55.25)
    INTO Sells VALUES ('Medicover', 'Omeprazole', 'Mankind', 65.00)
    INTO Sells VALUES ('Fortis Pharmacy', 'Ranitidine', 'Zydus', 42.50)
    INTO Sells VALUES ('Max Healthcare', 'Levocetirizine', 'Strides', 38.75)
    INTO Sells VALUES ('Cloudnine Pharmacy', 'Diclofenac', 'Granules', 28.90)
    INTO Sells VALUES ('Narayana Pharmacy', 'Naproxen', 'Alembic', 75.60)
    INTO Sells VALUES ('KIMS Pharmacy', 'Aspirin', 'Abbott India', 25.00)
    INTO Sells VALUES ('Manipal Pharmacy', 'Clarithromycin', 'Bharat Biotech', 185.00)
    INTO Sells VALUES ('Aster Pharmacy', 'Cefixime', 'Serum Institute', 320.50)
    INTO Sells VALUES ('Columbia Asia Pharmacy', 'Ceftriaxone', 'Panacea', 450.75)
    INTO Sells VALUES ('Vasan Pharmacy', 'Cloxacillin', 'GSK India', 95.25)
SELECT 1 FROM DUAL;

INSERT ALL
    INTO Prescribes VALUES ('112233445566', '798512347812', 'Dolo 650', 'Sun Pharma', TO_DATE('2025-01-01', 'YYYY-MM-DD'), 1)
    INTO Prescribes VALUES ('223344556677', '234567894567', 'Saridon', 'Cipla', TO_DATE('2025-01-06', 'YYYY-MM-DD'), 2)
    INTO Prescribes VALUES ('334455667788', '345678901234', 'Crocin', 'Dr. Reddy''s', TO_DATE('2025-01-11', 'YYYY-MM-DD'), 3)
    INTO Prescribes VALUES ('445566778899', '456789012345', 'Combiflam', 'Lupin', TO_DATE('2025-01-16', 'YYYY-MM-DD'), 4)
    INTO Prescribes VALUES ('556677889900', '567890123456', 'Disprin', 'Aurobindo', TO_DATE('2025-01-21', 'YYYY-MM-DD'), 5)
    INTO Prescribes VALUES ('667788990011', '678901234567', 'Vicks', 'Cadila', TO_DATE('2025-01-26', 'YYYY-MM-DD'), 1)
    INTO Prescribes VALUES ('778899001122', '789012345678', 'Amoxil', 'Torrent', TO_DATE('2025-01-31', 'YYYY-MM-DD'), 2)
    INTO Prescribes VALUES ('889900112233', '890123456789', 'Ciplox', 'Glenmark', TO_DATE('2025-02-05', 'YYYY-MM-DD'), 3)
    INTO Prescribes VALUES ('990011223344', '901234567890', 'Metformin', 'Biocon', TO_DATE('2025-02-10', 'YYYY-MM-DD'), 4)
    INTO Prescribes VALUES ('001122334455', '012345678901', 'Pantoprazole', 'Alkem', TO_DATE('2025-02-15', 'YYYY-MM-DD'), 5)
    INTO Prescribes VALUES ('123456789012', '112233445566', 'Azithromycin', 'Divi''s Labs', TO_DATE('2025-02-20', 'YYYY-MM-DD'), 1)
    INTO Prescribes VALUES ('234567890123', '223344556677', 'Paracetamol', 'Ipca', TO_DATE('2025-02-25', 'YYYY-MM-DD'), 2)
    INTO Prescribes VALUES ('345678901234', '334455667788', 'Ibuprofen', 'Wockhardt', TO_DATE('2025-03-02', 'YYYY-MM-DD'), 3)
    INTO Prescribes VALUES ('456789012345', '445566778899', 'Cetirizine', 'Natco', TO_DATE('2025-03-07', 'YYYY-MM-DD'), 4)
    INTO Prescribes VALUES ('567890123456', '556677889900', 'Loratadine', 'Jubilant', TO_DATE('2025-03-12', 'YYYY-MM-DD'), 5)
    INTO Prescribes VALUES ('678901234567', '667788990011', 'Omeprazole', 'Mankind', TO_DATE('2025-03-17', 'YYYY-MM-DD'), 1)
    INTO Prescribes VALUES ('789012345678', '778899001122', 'Ranitidine', 'Zydus', TO_DATE('2025-03-22', 'YYYY-MM-DD'), 2)
    INTO Prescribes VALUES ('890123456789', '889900112233', 'Levocetirizine', 'Strides', TO_DATE('2025-03-27', 'YYYY-MM-DD'), 3)
    INTO Prescribes VALUES ('901234567890', '990011223344', 'Diclofenac', 'Granules', TO_DATE('2025-04-01', 'YYYY-MM-DD'), 4)
    INTO Prescribes VALUES ('012345678901', '001122334455', 'Naproxen', 'Alembic', TO_DATE('2025-04-06', 'YYYY-MM-DD'), 5)
    INTO Prescribes VALUES ('987654321098', '123456789012', 'Aspirin', 'Abbott India', TO_DATE('2025-04-11', 'YYYY-MM-DD'), 1)
    INTO Prescribes VALUES ('876543210987', '987654321098', 'Clarithromycin', 'Bharat Biotech', TO_DATE('2025-04-16', 'YYYY-MM-DD'), 2)
    INTO Prescribes VALUES ('765432109876', '876543210987', 'Cefixime', 'Serum Institute', TO_DATE('2025-04-21', 'YYYY-MM-DD'), 3)
    INTO Prescribes VALUES ('654321098765', '765432109876', 'Ceftriaxone', 'Panacea', TO_DATE('2025-04-26', 'YYYY-MM-DD'), 4)
    INTO Prescribes VALUES ('543210987654', '654321098765', 'Cloxacillin', 'GSK India', TO_DATE('2025-05-01', 'YYYY-MM-DD'), 5)

SELECT 1 FROM DUAL;

INSERT ALL
    INTO Contract VALUES ('Apollo Pharmacy', 'Sun Pharma', TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('2026-12-31', 'YYYY-MM-DD'), 'Annual Supply Agreement', '798512347812')
    INTO Contract VALUES ('MedPlus', 'Cipla', TO_DATE('2024-02-01', 'YYYY-MM-DD'), TO_DATE('2025-11-30', 'YYYY-MM-DD'), 'Exclusive Distribution', '234567894567')
    INTO Contract VALUES ('1mg', 'Dr. Reddy''s', TO_DATE('2023-12-15', 'YYYY-MM-DD'), TO_DATE('2025-06-14', 'YYYY-MM-DD'), 'Bulk Purchase Contract', '345678901234')
    INTO Contract VALUES ('Netmeds', 'Lupin', TO_DATE('2024-03-10', 'YYYY-MM-DD'), TO_DATE('2026-03-09', 'YYYY-MM-DD'), 'Inventory Management', '456789012345')
    INTO Contract VALUES ('PharmEasy', 'Aurobindo', TO_DATE('2024-04-05', 'YYYY-MM-DD'), TO_DATE('2025-09-04', 'YYYY-MM-DD'), 'Direct Supply Contract', '567890123456')
    INTO Contract VALUES ('HealthKart', 'Cadila', TO_DATE('2023-11-01', 'YYYY-MM-DD'), TO_DATE('2025-10-31', 'YYYY-MM-DD'), 'Seasonal Supply Agreement', '678901234567')
    INTO Contract VALUES ('Care24', 'Torrent', TO_DATE('2024-05-20', 'YYYY-MM-DD'), TO_DATE('2026-05-19', 'YYYY-MM-DD'), 'Emergency Supply Contract', '789012345678')
    INTO Contract VALUES ('Medlife', 'Glenmark', TO_DATE('2024-06-15', 'YYYY-MM-DD'), TO_DATE('2025-12-14', 'YYYY-MM-DD'), 'Specialty Drugs Agreement', '890123456789')
    INTO Contract VALUES ('SastaSundar', 'Biocon', TO_DATE('2023-09-01', 'YYYY-MM-DD'), TO_DATE('2025-08-31', 'YYYY-MM-DD'), 'Insulin Supply Contract', '901234567890')
    INTO Contract VALUES ('Guardian Pharmacy', 'Alkem', TO_DATE('2024-07-01', 'YYYY-MM-DD'), TO_DATE('2026-06-30', 'YYYY-MM-DD'), 'OTC Drugs Agreement', '012345678901')
    INTO Contract VALUES ('MedPlus Mart', 'Divi''s Labs', TO_DATE('2024-08-12', 'YYYY-MM-DD'), TO_DATE('2025-11-11', 'YYYY-MM-DD'), 'API Supply Contract', '112233445566')
    INTO Contract VALUES ('Apollo Clinic', 'Ipca', TO_DATE('2023-10-01', 'YYYY-MM-DD'), TO_DATE('2025-09-30', 'YYYY-MM-DD'), 'Malaria Drugs Supply', '223344556677')
    INTO Contract VALUES ('Wellness Pharmacy', 'Wockhardt', TO_DATE('2024-09-15', 'YYYY-MM-DD'), TO_DATE('2026-03-14', 'YYYY-MM-DD'), 'Vaccine Distribution', '334455667788')
    INTO Contract VALUES ('LifeCare', 'Natco', TO_DATE('2024-10-10', 'YYYY-MM-DD'), TO_DATE('2025-12-09', 'YYYY-MM-DD'), 'Cancer Drugs Agreement', '445566778899')
    INTO Contract VALUES ('Health & Glow', 'Jubilant', TO_DATE('2023-08-01', 'YYYY-MM-DD'), TO_DATE('2025-07-31', 'YYYY-MM-DD'), 'Nutritional Supplements', '556677889900')
    INTO Contract VALUES ('Medicover', 'Mankind', TO_DATE('2024-11-05', 'YYYY-MM-DD'), TO_DATE('2026-05-04', 'YYYY-MM-DD'), 'Contraceptives Supply', '667788990011')
    INTO Contract VALUES ('Fortis Pharmacy', 'Zydus', TO_DATE('2023-07-15', 'YYYY-MM-DD'), TO_DATE('2025-06-14', 'YYYY-MM-DD'), 'Cardiac Drugs Contract', '778899001122')
    INTO Contract VALUES ('Max Healthcare', 'Strides', TO_DATE('2024-12-01', 'YYYY-MM-DD'), TO_DATE('2026-11-30', 'YYYY-MM-DD'), 'Pediatric Medicines', '889900112233')
    INTO Contract VALUES ('Cloudnine Pharmacy', 'Granules', TO_DATE('2023-06-10', 'YYYY-MM-DD'), TO_DATE('2025-05-09', 'YYYY-MM-DD'), 'Women''s Health Products', '990011223344')
    INTO Contract VALUES ('Narayana Pharmacy', 'Alembic', TO_DATE('2024-01-15', 'YYYY-MM-DD'), TO_DATE('2026-01-14', 'YYYY-MM-DD'), 'Psychiatric Drugs', '001122334455')
    INTO Contract VALUES ('KIMS Pharmacy', 'Abbott India', TO_DATE('2023-05-01', 'YYYY-MM-DD'), TO_DATE('2025-04-30', 'YYYY-MM-DD'), 'Diabetes Care Products', '123456789012')
    INTO Contract VALUES ('Manipal Pharmacy', 'Bharat Biotech', TO_DATE('2024-02-20', 'YYYY-MM-DD'), TO_DATE('2026-02-19', 'YYYY-MM-DD'), 'Vaccine Distribution', '987654321098')
    INTO Contract VALUES ('Aster Pharmacy', 'Serum Institute', TO_DATE('2023-04-15', 'YYYY-MM-DD'), TO_DATE('2025-03-14', 'YYYY-MM-DD'), 'Immunization Program', '876543210987')
    INTO Contract VALUES ('Columbia Asia Pharmacy', 'Panacea', TO_DATE('2024-03-25', 'YYYY-MM-DD'), TO_DATE('2026-03-24', 'YYYY-MM-DD'), 'Pediatric Vaccines', '765432109876')
    INTO Contract VALUES ('Vasan Pharmacy', 'GSK India', TO_DATE('2023-03-01', 'YYYY-MM-DD'), TO_DATE('2025-02-28', 'YYYY-MM-DD'), 'Respiratory Products', '654321098765')

SELECT 1 FROM DUAL;

-- ============================================
-- STORED PROCEDURES AND FUNCTIONS
-- ============================================
-- 1. Add/Update/Delete Pharmacy
CREATE OR REPLACE PROCEDURE ManagePharmacy(
    p_action VARCHAR2,
    p_name VARCHAR2,
    p_address VARCHAR2 DEFAULT NULL,
    p_phone VARCHAR2 DEFAULT NULL
) IS
    v_count NUMBER;
BEGIN
    CASE UPPER(p_action)
        WHEN 'ADD' THEN
            INSERT INTO Pharmacy VALUES (p_name, p_address, p_phone);
            DBMS_OUTPUT.PUT_LINE('Pharmacy added: ' || p_name);
        WHEN 'UPDATE' THEN
            UPDATE Pharmacy SET Address = p_address, PhoneNumber = p_phone WHERE Name = p_name;
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

-- 1. Add/Update/Delete Doctor
CREATE OR REPLACE PROCEDURE ManageDoctor(
    p_action VARCHAR2,
    p_id CHAR,
    p_name VARCHAR2 DEFAULT NULL,
    p_specialty VARCHAR2 DEFAULT NULL,
    p_experience INT DEFAULT NULL
) IS
BEGIN
    CASE UPPER(p_action)
        WHEN 'ADD' THEN
            INSERT INTO Doctor VALUES (p_id, p_name, p_specialty, p_experience);
            DBMS_OUTPUT.PUT_LINE('Doctor added: ' || p_name);
        WHEN 'UPDATE' THEN
            UPDATE Doctor SET Name = p_name, Specialty = p_specialty, YearsOfExperience = p_experience WHERE AadharID = p_id;
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

-- 1. Add/Update/Delete Patient
CREATE OR REPLACE PROCEDURE ManagePatient(
    p_action VARCHAR2,
    p_id CHAR,
    p_name VARCHAR2 DEFAULT NULL,
    p_address VARCHAR2 DEFAULT NULL,
    p_age INT DEFAULT NULL,
    p_physician CHAR DEFAULT NULL
) IS
BEGIN
    CASE UPPER(p_action)
        WHEN 'ADD' THEN
            INSERT INTO Patient VALUES (p_id, p_name, p_address, p_age, p_physician);
            DBMS_OUTPUT.PUT_LINE('Patient added: ' || p_name);
        WHEN 'UPDATE' THEN
            UPDATE Patient SET Name = p_name, Address = p_address, Age = p_age, PrimaryPhysicianID = p_physician WHERE AadharID = p_id;
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

-- 1. Add/Update/Delete PharmaceuticalCompany
CREATE OR REPLACE PROCEDURE ManageCompany(
    p_action VARCHAR2,
    p_name VARCHAR2,
    p_phone VARCHAR2 DEFAULT NULL
) IS
BEGIN
    CASE UPPER(p_action)
        WHEN 'ADD' THEN
            INSERT INTO PharmaceuticalCompany VALUES (p_name, p_phone);
            DBMS_OUTPUT.PUT_LINE('Company added: ' || p_name);
        WHEN 'UPDATE' THEN
            UPDATE PharmaceuticalCompany SET Phone_Number = p_phone WHERE Company_Name = p_name;
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

-- 1. Add/Update/Delete Drug
CREATE OR REPLACE PROCEDURE ManageDrug(
    p_action VARCHAR2,
    p_trade_name VARCHAR2,
    p_formula VARCHAR2 DEFAULT NULL,
    p_company VARCHAR2 DEFAULT NULL
) IS
BEGIN
    CASE UPPER(p_action)
        WHEN 'ADD' THEN
            INSERT INTO Drug VALUES (p_trade_name, p_formula, p_company);
            DBMS_OUTPUT.PUT_LINE('Drug added: ' || p_trade_name);
        WHEN 'UPDATE' THEN
            UPDATE Drug SET Formula = p_formula WHERE Trade_Name = p_trade_name AND Company_Name = p_company;
            DBMS_OUTPUT.PUT_LINE('Drug updated: ' || p_trade_name);
        WHEN 'DELETE' THEN
            DELETE FROM Drug WHERE Trade_Name = p_trade_name AND Company_Name = p_company;
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

-- 1. Add/Update/Delete Contract
CREATE OR REPLACE PROCEDURE ManageContract(
    p_action VARCHAR2,
    p_pharmacy VARCHAR2,
    p_company VARCHAR2,
    p_start_date DATE DEFAULT NULL,
    p_end_date DATE DEFAULT NULL,
    p_content VARCHAR2 DEFAULT NULL,
    p_supervisor CHAR DEFAULT NULL
) IS
BEGIN
    CASE UPPER(p_action)
        WHEN 'ADD' THEN
            INSERT INTO Contract VALUES (p_pharmacy, p_company, p_start_date, p_end_date, p_content, p_supervisor);
            DBMS_OUTPUT.PUT_LINE('Contract added: ' || p_pharmacy || ' - ' || p_company);
        WHEN 'UPDATE' THEN
            UPDATE Contract SET Start_Date = p_start_date, End_Date = p_end_date, Content = p_content, SupervisorID = p_supervisor
            WHERE Pharmacy_Name = p_pharmacy AND Company_Name = p_company;
            DBMS_OUTPUT.PUT_LINE('Contract updated: ' || p_pharmacy || ' - ' || p_company);
        WHEN 'DELETE' THEN
            DELETE FROM Contract WHERE Pharmacy_Name = p_pharmacy AND Company_Name = p_company;
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

--Add/Delete/Update Prescriptions

CREATE OR REPLACE PROCEDURE ManagePrescription(
    p_action VARCHAR2,
    p_patient_id CHAR,
    p_doctor_id CHAR,
    p_trade_name VARCHAR2,
    p_company VARCHAR2,
    p_prescription_date DATE DEFAULT NULL,
    p_quantity INT DEFAULT NULL
) IS
    v_count NUMBER;
BEGIN
    CASE UPPER(p_action)
        WHEN 'ADD' THEN
            -- Check for existing prescription on same date
            SELECT COUNT(*) INTO v_count FROM Prescribes
            WHERE PatientID = p_patient_id
            AND DoctorID = p_doctor_id
            AND Prescription_Date = p_prescription_date;

            IF v_count > 0 THEN
                DBMS_OUTPUT.PUT_LINE('Error: Prescription already exists for this patient, doctor, and date.');
                RETURN;
            END IF;

            -- Check for newer prescriptions
            SELECT COUNT(*) INTO v_count FROM Prescribes
            WHERE PatientID = p_patient_id
            AND DoctorID = p_doctor_id
            AND Prescription_Date > p_prescription_date;

            IF v_count > 0 THEN
                DBMS_OUTPUT.PUT_LINE('Error: Newer prescription exists for this patient and doctor.');
                RETURN;
            END IF;

            -- Delete older prescriptions
            DELETE FROM Prescribes
            WHERE PatientID = p_patient_id
            AND DoctorID = p_doctor_id
            AND Prescription_Date < p_prescription_date;

            -- Insert new prescription
            INSERT INTO Prescribes VALUES (
                p_patient_id,
                p_doctor_id,
                p_trade_name,
                p_company,
                p_prescription_date,
                p_quantity
            );
            DBMS_OUTPUT.PUT_LINE('Prescription added for patient ' || p_patient_id);

        WHEN 'UPDATE' THEN
            UPDATE Prescribes SET
                Prescription_Date = p_prescription_date,
                Quantity = p_quantity
            WHERE PatientID = p_patient_id
            AND DoctorID = p_doctor_id
            AND Trade_Name = p_trade_name
            AND Company_Name = p_company;
            DBMS_OUTPUT.PUT_LINE('Prescription updated for patient ' || p_patient_id);

        WHEN 'DELETE' THEN
            DELETE FROM Prescribes
            WHERE PatientID = p_patient_id
            AND DoctorID = p_doctor_id
            AND Trade_Name = p_trade_name
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

--2 Generate Prescription Reports
CREATE OR REPLACE PROCEDURE patient_prescriptions_report(
    p_patient_id CHAR,
    p_start_date DATE,
    p_end_date DATE
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
    v_found BOOLEAN := FALSE;
BEGIN
    -- Get patient name
    SELECT Name INTO v_patient_name FROM Patient 
    WHERE AadharID = p_patient_id;
    
    DBMS_OUTPUT.PUT_LINE('==================================================');
    DBMS_OUTPUT.PUT_LINE('Prescription Report for Patient: ' || v_patient_name);
    DBMS_OUTPUT.PUT_LINE('Period: ' || TO_CHAR(p_start_date, 'DD-MON-YYYY') || 
                       ' to ' || TO_CHAR(p_end_date, 'DD-MON-YYYY'));
    DBMS_OUTPUT.PUT_LINE('==================================================');
    
    FOR r_pres IN c_prescriptions LOOP
        v_found := TRUE;
        DBMS_OUTPUT.PUT_LINE('Date: ' || TO_CHAR(r_pres.Prescription_Date, 'DD-MON-YYYY'));
        DBMS_OUTPUT.PUT_LINE('Doctor: ' || r_pres.DoctorName || ' (' || r_pres.Specialty || ')');
        DBMS_OUTPUT.PUT_LINE('Medication: ' || r_pres.Trade_Name || 
                           ' (' || r_pres.Company_Name || ')');
        DBMS_OUTPUT.PUT_LINE('Quantity: ' || r_pres.Quantity);
        DBMS_OUTPUT.PUT_LINE('--------------------------------------------------');
    END LOOP;
    
    IF NOT v_found THEN
        DBMS_OUTPUT.PUT_LINE('No prescriptions found for this period');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: Patient ' || p_patient_id || ' not found');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/



-- 3. Print details of a prescription for a given patient for a given date
BEGIN
   EXECUTE IMMEDIATE 'DROP PROCEDURE print_prescription_details_by_date';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -4043 THEN
         RAISE;
      END IF;
END;
/
CREATE OR REPLACE PROCEDURE PrintPrescriptionDetails(
    p_patient_id IN CHAR,
    p_presc_date IN DATE
) AS
    v_patient_name Patient.Name%TYPE;
    v_doctor_name Doctor.Name%TYPE;
    v_specialty Doctor.Specialty%TYPE;
    v_trade_name Prescribes.Trade_Name%TYPE;
    v_company_name Prescribes.Company_Name%TYPE;
    v_formula Drug.Formula%TYPE;
    v_quantity Prescribes.Quantity%TYPE;
    v_found BOOLEAN := FALSE;
BEGIN
    -- Get patient name
    SELECT Name INTO v_patient_name FROM Patient WHERE AadharID = p_patient_id;

    -- Fetch prescription details
    FOR rec IN (
        SELECT d.Name AS doctor_name, d.Specialty, p.Trade_Name, p.Company_Name, dr.Formula, p.Quantity
        FROM Prescribes p
        JOIN Doctor d ON p.DoctorID = d.AadharID
        JOIN Drug dr ON p.Trade_Name = dr.Trade_Name AND p.Company_Name = dr.Company_Name
        WHERE p.PatientID = p_patient_id AND p.Prescription_Date = p_presc_date
    ) LOOP
        v_found := TRUE;
        DBMS_OUTPUT.PUT_LINE('Prescription Details for ' || v_patient_name);
        DBMS_OUTPUT.PUT_LINE('Doctor: ' || rec.doctor_name);
        DBMS_OUTPUT.PUT_LINE('Specialty: ' || rec.Specialty);
        DBMS_OUTPUT.PUT_LINE('Medication: ' || rec.Trade_Name);
        DBMS_OUTPUT.PUT_LINE('Company: ' || rec.Company_Name);
        DBMS_OUTPUT.PUT_LINE('Formula: ' || rec.Formula);
        DBMS_OUTPUT.PUT_LINE('Quantity: ' || rec.Quantity);
    END LOOP;

    IF NOT v_found THEN
        DBMS_OUTPUT.PUT_LINE('No prescriptions found for this date');
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: Patient ' || p_patient_id || ' not found');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/



-- 4. Get the details of drugs produced by a pharmaceutical company
CREATE OR REPLACE FUNCTION GetCompanyDrugs(
    p_company VARCHAR2
) RETURN SYS_REFCURSOR
IS
    v_drugs SYS_REFCURSOR;
BEGIN
    OPEN v_drugs FOR
        SELECT Trade_Name, Formula
        FROM Drug
        WHERE Company_Name = p_company;
    RETURN v_drugs;
END;
/

-- 5. Print the stock position of a pharmacy
CREATE OR REPLACE PROCEDURE GetStockPosition(
    p_pharmacy VARCHAR2,
    p_stock OUT SYS_REFCURSOR
) IS
BEGIN
    OPEN p_stock FOR
        SELECT s.Trade_Name, s.Company_Name, s.Price
        FROM Sells s
        WHERE s.Pharmacy_Name = p_pharmacy;
END;
/

-- 6. Print the contact details of a pharmacy-pharmaceutical company
CREATE OR REPLACE PROCEDURE GetContactDetails(
    p_pharmacy VARCHAR2,
    p_company VARCHAR2,
    p_pharmacy_phone OUT VARCHAR2,
    p_company_phone OUT VARCHAR2
) IS
BEGIN
    SELECT ph.PhoneNumber, pc.Phone_Number
    INTO p_pharmacy_phone, p_company_phone
    FROM Pharmacy ph, PharmaceuticalCompany pc
    WHERE ph.Name = p_pharmacy
    AND pc.Company_Name = p_company;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No contact details found');
END;
/

-- 7. Print the list of patients for a given doctor
CREATE OR REPLACE FUNCTION GetDoctorPatients(
    p_doctor_id CHAR
) RETURN SYS_REFCURSOR
IS
    v_patients SYS_REFCURSOR;
BEGIN
    OPEN v_patients FOR
        SELECT p.Name, p.Age, p.Address
        FROM Patient p
        WHERE p.PrimaryPhysicianID = p_doctor_id;
    RETURN v_patients;
END;
/

-- ============================================
-- TEST QUERIES
-- ============================================
-- Formatting Setup
SET LINESIZE 150
SET PAGESIZE 50
SET COLSEP " | "
COLUMN TRADE_NAME FORMAT A20
COLUMN FORMULA FORMAT A30
COLUMN COMPANY_NAME FORMAT A20
COLUMN PRESCRIPTION_DATE FORMAT A12
COLUMN NAME FORMAT A25
COLUMN ADDRESS FORMAT A40
SET SERVEROUTPUT ON
SET VERIFY OFF

-- 1. Add/Update/Delete Pharmacy (Test)
EXEC ManagePharmacy('ADD', 'Test Pharmacy', '123 Test Lane', '+91-9999999999');
SELECT * FROM Pharmacy WHERE Name = 'Test Pharmacy';

--Test for Prescribe
-- Test 1: Add new prescription
EXEC ManagePrescription('ADD', '112233445566', '798512347812', 'Metformin', 'Biocon', DATE '2025-04-22', 2);
SELECT * FROM Prescribes WHERE PatientID = '112233445566' AND DoctorID = '798512347812' AND Trade_Name = 'Metformin' AND Company_Name = 'Biocon';

-- Test 1.1: Duplicate:
-- Should fail: Prescription for this doctor, patient, and date already exists
EXEC ManagePrescription('ADD', '112233445566', '798512347812', 'Metformin', 'Biocon', DATE '2025-04-22', 2);
-- Expected output: Error about duplicate prescription

--Attempt to Add Prescription When a Newer One Exists
-- Insert a prescription with a future date
EXEC ManagePrescription('ADD', '112233445566', '798512347812', 'Metformin', 'Biocon', DATE '2025-06-01', 5);
-- Now try to add an older prescription for the same doctor and patient
EXEC ManagePrescription('ADD', '112233445566', '798512347812', 'Metformin', 'Biocon', DATE '2025-05-01', 3);
-- Expected output: Error about newer prescription already existing

-- Insert an old prescription
EXEC ManagePrescription('ADD', '223344556677', '234567894567', 'Saridon', 'Cipla', DATE '2025-04-01', 2);

-- Insert a newer prescription (should delete the old one)
EXEC ManagePrescription('ADD', '223344556677', '234567894567', 'Saridon', 'Cipla', DATE '2025-04-15', 2);

-- Check only the latest prescription exists
SELECT * FROM Prescribes WHERE PatientID = '223344556677' AND DoctorID = '234567894567' AND Trade_Name = 'Saridon' AND Company_Name = 'Cipla';

-- Should succeed: Different drug, same doctor/patient/date
EXEC ManagePrescription('ADD', '112233445566', '798512347812', 'Dolo 650', 'Sun Pharma', DATE '2025-04-22', 1);
SELECT * FROM Prescribes WHERE PatientID = '112233445566' AND DoctorID = '798512347812' AND Trade_Name = 'Dolo 650' AND Company_Name = 'Sun Pharma';

-- Should fail: Patient does not exist
EXEC ManagePrescription('ADD', '000000000000', '798512347812', 'Metformin', 'Biocon', DATE '2025-04-22', 1);

-- Should fail: Doctor does not exist
EXEC ManagePrescription('ADD', '112233445566', '000000000000', 'Metformin', 'Biocon', DATE '2025-04-22', 1);

-- Should fail: Drug/Company does not exist
EXEC ManagePrescription('ADD', '112233445566', '798512347812', 'NonexistentDrug', 'FakeCompany', DATE '2025-04-22', 1);

-- Should succeed: Update quantity and date
EXEC ManagePrescription('UPDATE', '112233445566', '798512347812', 'Metformin', 'Biocon', DATE '2025-04-23', 4);
SELECT * FROM Prescribes WHERE PatientID = '112233445566' AND DoctorID = '798512347812' AND Trade_Name = 'Metformin' AND Company_Name = 'Biocon';

-- Should succeed: Delete existing prescription
EXEC ManagePrescription('DELETE', '112233445566', '798512347812', 'Metformin', 'Biocon');
SELECT * FROM Prescribes WHERE PatientID = '112233445566' AND DoctorID = '798512347812' AND Trade_Name = 'Metformin' AND Company_Name = 'Biocon';

-- Should output an error or a message indicating no such prescription
EXEC ManagePrescription('UPDATE', '000000000000', '000000000000', 'FakeDrug', 'FakeCompany', DATE '2025-04-22', 1);
EXEC ManagePrescription('DELETE', '000000000000', '000000000000', 'FakeDrug', 'FakeCompany');


-- 2. Prescription Report for Patient 876543210987 (April 2025)
EXEC patient_prescriptions_report('876543210987', DATE '2025-04-01', DATE '2025-04-30');




-- 3. Prescription Details for Patient 876543210987 on 2025-04-11
-- Test 1: Valid prescription (from insert_data.sql)
EXEC PrintPrescriptionDetails('876543210987', DATE '2025-04-22');

-- Expected Output:
-- Prescription Details for Anika Trivedi
-- Date: 22-APR-2025
-- -------------------------------------------
-- Doctor: Dr. Swati Mishra
-- Specialty: Pediatrics
-- Medication: Cetirizine
-- Company: Natco
-- Formula: C21H25ClN2O5
-- Quantity: 3
-------------------------------------------


-- Test 2: No prescriptions
EXEC PrintPrescriptionDetails('876543210987', DATE '2025-01-01');

-- Expected Output:
-- No prescriptions found for this date

-- Test 3: Invalid patient
EXEC PrintPrescriptionDetails('000000000000', SYSDATE);

-- Expected Output:
-- Error: Patient 000000000000 not found




-- 4. Drugs by Sun Pharma
VARIABLE drugs REFCURSOR
EXEC :drugs := GetCompanyDrugs('Sun Pharma');
PRINT drugs

-- 5. Stock Position of Apollo Pharmacy
VARIABLE stock REFCURSOR
EXEC GetStockPosition('Apollo Pharmacy', :stock);
PRINT stock

-- 6. Contact Details for Apollo Pharmacy & Sun Pharma
VARIABLE ph_phone VARCHAR2(15)
VARIABLE co_phone VARCHAR2(15)
EXEC GetContactDetails('Apollo Pharmacy', 'Sun Pharma', :ph_phone, :co_phone);
PRINT ph_phone
PRINT co_phone

-- 7. Patients for Doctor 123456789012 (Dr. Alok Pandey)
VARIABLE patients REFCURSOR
EXEC :patients := GetDoctorPatients('123456789012');
PRINT patients
