-- Rolle f�r das Administrations-Team
CREATE ROLE DBARC3_ROLE_CUSTOMER_ADMIN;
GRANT SELECT, INSERT, UPDATE, DELETE ON ADDRESSES TO DBARC3_ROLE_CUSTOMER_ADMIN;
GRANT SELECT, INSERT, UPDATE, DELETE ON CUSTOMERS TO DBARC3_ROLE_CUSTOMER_ADMIN;
GRANT SELECT ON ADR_TYPES TO DBARC3_ROLE_CUSTOMER_ADMIN;
GRANT SELECT ON COUNTRIES TO DBARC3_ROLE_CUSTOMER_ADMIN;

-- Hinzuf�gen der Rolle f�r die Administratoren
GRANT DBARC3_ROLE_CUSTOMER_ADMIN TO DANIJEL;
GRANT DBARC3_ROLE_CUSTOMER_ADMIN TO BIANCA;


-- Konfigurationstabelle f�r die CRMs und ihre L�ndercodes
CREATE TABLE CRM_TEAM
(
    USERNAME varchar2(50),
    CTR_CODE varchar2(2),
    CONSTRAINT pk_crm_team PRIMARY KEY (USERNAME, CTR_CODE)
);

-- Hinzuf�gen jedes Mitgliedes mit seinen L�ndercodes
INSERT INTO CRM_TEAM (USERNAME, CTR_CODE)
VALUES ('HUGENTOBLER', 'CH');
INSERT INTO CRM_TEAM (USERNAME, CTR_CODE)
VALUES ('SONDEREGGER', 'CH');
INSERT INTO CRM_TEAM (USERNAME, CTR_CODE)
VALUES ('SCHMIDT', 'DE');
INSERT INTO CRM_TEAM (USERNAME, CTR_CODE)
VALUES ('NELSON', 'US');
INSERT INTO CRM_TEAM (USERNAME, CTR_CODE)
VALUES ('NELSON', 'CA');
INSERT INTO CRM_TEAM (USERNAME, CTR_CODE)
VALUES ('JASON', 'US');
INSERT INTO CRM_TEAM (USERNAME, CTR_CODE)
VALUES ('JASON', 'CA');
INSERT INTO CRM_TEAM (USERNAME, CTR_CODE)
VALUES ('KELLY', 'GB');
INSERT INTO CRM_TEAM (USERNAME, CTR_CODE)
VALUES ('KELLY', 'NZ');
INSERT INTO CRM_TEAM (USERNAME, CTR_CODE)
VALUES ('KELLY', 'SG');
INSERT INTO CRM_TEAM (USERNAME, CTR_CODE)
VALUES ('DUPONT', 'FR');
INSERT INTO CRM_TEAM (USERNAME, CTR_CODE)
VALUES ('DUPONT', 'IT');
INSERT INTO CRM_TEAM (USERNAME, CTR_CODE)
VALUES ('DUPONT', 'NL');
INSERT INTO CRM_TEAM (USERNAME, CTR_CODE)
VALUES ('DUPONT', 'DK');
INSERT INTO CRM_TEAM (USERNAME, CTR_CODE)
VALUES ('DUPONT', 'IS');
COMMIT;

-- VIEW erstellen um nur Userdaten zu sehen, welche den L�ndercode des CRMs haben
CREATE OR REPLACE VIEW DBARC3_VIEW_CRM AS
SELECT CUSTOMERS.FIRST_NAME,
       CUSTOMERS.LAST_NAME,
       CUSTOMERS.DATE_OF_BIRTH,
       CUSTOMERS.TITLE,
       CUSTOMERS.GENDER,
       CUSTOMERS.MARITAL_STATUS,
       CUSTOMERS.MEMBER_FLAG,
       CUSTOMERS.ACTIVE_FLAG,
       CUSTOMERS.EMAIL_ADDRESS,
       CUSTOMERS.LANGUAGE_CODE,
       ADR_TYPES.LABEL AS ADDRESS_TYPE,
       ADDRESSES.STREET,
       ADDRESSES.STREET_NO,
       ADDRESSES.ZIP_CODE,
       ADDRESSES.CITY,
       COUNTRIES.NAME  AS COUNTRY_NAME
FROM CUSTOMERS
         JOIN ADDRESSES ON CUSTOMERS.ID = ADDRESSES.CUST_ID
         JOIN ADR_TYPES ON ADR_TYPES.ADR_TYPE = ADDRESSES.ADR_TYPE
         JOIN COUNTRIES ON ADDRESSES.CTR_CODE = COUNTRIES.CODE
WHERE CTR_CODE IN (SELECT CTR_CODE FROM CRM_TEAM WHERE USERNAME = USER);

-- Rolle f�r CRM-Mitglieder erstellen und Rechte f�r die DBARC3_VIEW_CRM hinzuf�gen.
CREATE ROLE DBARC3_ROLE_CRM;
GRANT SELECT ON DBARC3_VIEW_CRM TO DBARC3_ROLE_CRM;

-- Rolle DBARC3_VIEW_CRM allen CRMs hinzuf�gen.
GRANT DBARC3_ROLE_CRM to HUGENTOBLER;
GRANT DBARC3_ROLE_CRM to SONDEREGGER;
GRANT DBARC3_ROLE_CRM to SCHMIDT;
GRANT DBARC3_ROLE_CRM to NELSON;
GRANT DBARC3_ROLE_CRM to JASON;
GRANT DBARC3_ROLE_CRM to KELLY;
GRANT DBARC3_ROLE_CRM to DUPONT;



-- View um nur Adressen des Types 'D' oder 'DP' in der Schweiz anzuzeigen
CREATE OR REPLACE VIEW DBARC3_VIEW_SUPPLIER_CH AS
SELECT TITLE, FIRST_NAME, LAST_NAME, STREET, STREET_NO, ZIP_CODE, CITY
FROM CUSTOMERS
         JOIN ADDRESSES ON ADDRESSES.CUST_ID = CUSTOMERS.ID
WHERE ADDRESSES.CTR_CODE = 'CH'
  AND (ADDRESSES.ADR_TYPE = 'D' OR ADDRESSES.ADR_TYPE = 'DP');


-- Rolle DBARC3_ROLE_SUPPLIER_CH erstellen f�r alle Lieferanten in der Schweiz
CREATE ROLE DBARC3_ROLE_SUPPLIER_CH;
GRANT SELECT ON DBARC3_VIEW_SUPPLIER_CH TO DBARC3_ROLE_SUPPLIER_CH;

-- Rolle DBARC3_ROLE_SUPPLIER_CH zum Lieferanten PAECKLI hinzuf�gen
GRANT DBARC3_ROLE_SUPPLIER_CH to PAECKLI;




-- Anpassungen der Datenschutzbestimmungen aus Aufg. 4
CREATE OR REPLACE VIEW DBARC3_VIEW_CRM AS
SELECT CUSTOMERS.FIRST_NAME,
       CUSTOMERS.LAST_NAME,
       TO_CHAR(CUSTOMERS.DATE_OF_BIRTH, 'DD.MM.') AS DATE_OF_BIRTH,
       CUSTOMERS.TITLE,
       CUSTOMERS.GENDER,
       CUSTOMERS.MEMBER_FLAG,
       CUSTOMERS.ACTIVE_FLAG,
       CUSTOMERS.EMAIL_ADDRESS,
       CUSTOMERS.LANGUAGE_CODE,
       ADR_TYPES.LABEL                            AS ADDRESS_TYPE,
       ADDRESSES.STREET,
       ADDRESSES.STREET_NO,
       ADDRESSES.ZIP_CODE,
       ADDRESSES.CITY,
       COUNTRIES.NAME                             AS COUNTRY_NAME
FROM CUSTOMERS
         JOIN ADDRESSES ON CUSTOMERS.ID = ADDRESSES.CUST_ID
         JOIN ADR_TYPES ON ADR_TYPES.ADR_TYPE = ADDRESSES.ADR_TYPE
         JOIN COUNTRIES ON ADDRESSES.CTR_CODE = COUNTRIES.CODE
WHERE CTR_CODE IN (SELECT CTR_CODE
                   FROM CRM_TEAM
                   WHERE USERNAME = USER);


-- Hinzuf�gen des neuen CRM-Kollegen Volker Volkmann
INSERT INTO CRM_TEAM (USERNAME, CTR_CODE)
VALUES ('VOLKMANN', 'DE');

GRANT DBARC3_ROLE_CRM to VOLKMANN;