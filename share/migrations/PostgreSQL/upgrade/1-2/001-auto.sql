-- Convert schema '/home/mikef/Programming/Perl/SAMS/share/migrations/_source/deploy/1/001-auto.yml' to '/home/mikef/Programming/Perl/SAMS/share/migrations/_source/deploy/2/001-auto.yml':;

;
BEGIN;

;
CREATE TABLE "languages" (
  "language_id" serial NOT NULL,
  "language_code" character varying(2) NOT NULL,
  "language_name" text NOT NULL,
  PRIMARY KEY ("language_id"),
  CONSTRAINT "languages_language_code" UNIQUE ("language_code")
);

;
CREATE TABLE "translations" (
  "area" text NOT NULL,
  "name" text NOT NULL,
  "literal" text NOT NULL,
  "language_id" integer NOT NULL
);
CREATE INDEX "translations_idx_language_id" on "translations" ("language_id");

;
ALTER TABLE "translations" ADD CONSTRAINT "translations_fk_language_id" FOREIGN KEY ("language_id")
  REFERENCES "languages" ("language_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE account ADD COLUMN contact_name text;

;
ALTER TABLE country ADD COLUMN language_id integer;

;
CREATE INDEX country_idx_language_id on country (language_id);

;
ALTER TABLE country ADD CONSTRAINT country_fk_language_id FOREIGN KEY (language_id)
  REFERENCES languages (language_id) ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;

COMMIT;

