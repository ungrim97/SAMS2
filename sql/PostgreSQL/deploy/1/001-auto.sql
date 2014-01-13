-- 
-- Created by SQL::Translator::Producer::PostgreSQL
-- Created on Mon Jan 13 00:22:23 2014
-- 
;
--
-- Table: contact_titles.
--
CREATE TABLE "contact_titles" (
  "title_id" serial NOT NULL,
  "description" text NOT NULL,
  PRIMARY KEY ("title_id")
);

;
--
-- Table: languages.
--
CREATE TABLE "languages" (
  "language_id" serial NOT NULL,
  "language_code" character varying(2) NOT NULL,
  "language_name" text NOT NULL,
  PRIMARY KEY ("language_id"),
  CONSTRAINT "languages_language_code" UNIQUE ("language_code")
);

;
--
-- Table: account_types.
--
CREATE TABLE "account_types" (
  "account_type_id" serial NOT NULL,
  "description" text NOT NULL,
  "last_update_user" integer,
  "last_update_time" timestamp with time zone DEFAULT now(),
  PRIMARY KEY ("account_type_id")
);
CREATE INDEX "account_types_idx_last_update_user" on "account_types" ("last_update_user");

;
--
-- Table: countries.
--
CREATE TABLE "countries" (
  "country_id" serial NOT NULL,
  "country_code" character varying(3) NOT NULL,
  "country_name" text NOT NULL,
  "language_id" integer NOT NULL,
  PRIMARY KEY ("country_id")
);
CREATE INDEX "countries_idx_language_id" on "countries" ("language_id");

;
--
-- Table: translations.
--
CREATE TABLE "translations" (
  "area" text NOT NULL,
  "name" text NOT NULL,
  "literal" text NOT NULL,
  "language_id" integer NOT NULL
);
CREATE INDEX "translations_idx_language_id" on "translations" ("language_id");

;
--
-- Table: accounts.
--
CREATE TABLE "accounts" (
  "account_id" serial NOT NULL,
  "alt_account_id_1" text,
  "alt_account_id_2" text,
  "legacy_account_id" text,
  "account_name" text NOT NULL,
  "account_type_id" integer NOT NULL,
  "contact_name" text NOT NULL,
  "street_1" text NOT NULL,
  "street_2" text,
  "city" text NOT NULL,
  "county" text NOT NULL,
  "postcode" text NOT NULL,
  "country_id" integer NOT NULL,
  "contact_title_id" integer NOT NULL,
  "contact_job_title" text,
  "contact_number" text NOT NULL,
  "mobile_number" text,
  "fax_number" text,
  "email_address" text NOT NULL,
  "last_update_date" timestamp with time zone DEFAULT now(),
  "last_update_user" integer,
  PRIMARY KEY ("account_id")
);
CREATE INDEX "accounts_idx_account_type_id" on "accounts" ("account_type_id");
CREATE INDEX "accounts_idx_contact_title_id" on "accounts" ("contact_title_id");
CREATE INDEX "accounts_idx_country_id" on "accounts" ("country_id");
CREATE INDEX "accounts_idx_last_update_user" on "accounts" ("last_update_user");

;
--
-- Foreign Key Definitions
--

;
ALTER TABLE "account_types" ADD CONSTRAINT "account_types_fk_last_update_user" FOREIGN KEY ("last_update_user")
  REFERENCES "accounts" ("account_id") DEFERRABLE;

;
ALTER TABLE "countries" ADD CONSTRAINT "countries_fk_language_id" FOREIGN KEY ("language_id")
  REFERENCES "languages" ("language_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "translations" ADD CONSTRAINT "translations_fk_language_id" FOREIGN KEY ("language_id")
  REFERENCES "languages" ("language_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "accounts" ADD CONSTRAINT "accounts_fk_account_type_id" FOREIGN KEY ("account_type_id")
  REFERENCES "account_types" ("account_type_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "accounts" ADD CONSTRAINT "accounts_fk_contact_title_id" FOREIGN KEY ("contact_title_id")
  REFERENCES "contact_titles" ("title_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "accounts" ADD CONSTRAINT "accounts_fk_country_id" FOREIGN KEY ("country_id")
  REFERENCES "countries" ("country_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "accounts" ADD CONSTRAINT "accounts_fk_last_update_user" FOREIGN KEY ("last_update_user")
  REFERENCES "accounts" ("account_id") DEFERRABLE;

;
