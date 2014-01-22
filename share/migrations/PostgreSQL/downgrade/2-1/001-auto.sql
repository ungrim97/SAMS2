-- Convert schema '/home/mikef/Programming/Perl/SAMS/share/migrations/_source/deploy/2/001-auto.yml' to '/home/mikef/Programming/Perl/SAMS/share/migrations/_source/deploy/1/001-auto.yml':;

;
BEGIN;

;
ALTER TABLE country DROP CONSTRAINT country_fk_language_id;

;
DROP INDEX country_idx_language_id;

;
ALTER TABLE account DROP COLUMN contact_name;

;
ALTER TABLE country DROP COLUMN language_id;

;
DROP TABLE languages CASCADE;

;
DROP TABLE translations CASCADE;

;

COMMIT;

