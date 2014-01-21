-- 
-- Created by SQL::Translator::Producer::PostgreSQL
-- Created on Tue Jan 21 22:02:29 2014
-- 
;
--
-- Table: account.
--
CREATE TABLE "account" (
  "acc_id" serial NOT NULL,
  "if_acc_id" integer,
  "last_update_id" text,
  "msd_customer_id" integer,
  "notes" text,
  "oed_sid" serial,
  "organisation" text NOT NULL,
  "vista_id" bigint,
  "account_type_id" integer DEFAULT 1 NOT NULL,
  "creation_date" timestamp with time zone DEFAULT now(),
  "group_acc_id" integer,
  "last_update_time" timestamp with time zone DEFAULT now(),
  "maintainer" text,
  "org_size_id" integer DEFAULT 1 NOT NULL,
  "parent_acc_id" integer,
  "contact_given_name" text,
  "contact_family_name" text,
  "contact_title" text,
  "contact_job_title" text,
  "contact_address_1" text,
  "contact_address_2" text,
  "contact_city" text,
  "contact_county" text,
  "contact_country_id" character varying(3),
  "contact_telephone" text,
  "contact_mobile_telephone" text,
  "contact_fax" text,
  "contact_email" text,
  "contact_postcode" text,
  PRIMARY KEY ("acc_id"),
  CONSTRAINT "account_if_acc_id_key" UNIQUE ("if_acc_id"),
  CONSTRAINT "account_msd_customer_id_key" UNIQUE ("msd_customer_id"),
  CONSTRAINT "account_oed_sid_key" UNIQUE ("oed_sid"),
  CONSTRAINT "account_vista_id_key" UNIQUE ("vista_id")
);
CREATE INDEX "account_idx_account_type_id" on "account" ("account_type_id");
CREATE INDEX "account_idx_contact_country_id" on "account" ("contact_country_id");
CREATE INDEX "account_idx_group_acc_id" on "account" ("group_acc_id");
CREATE INDEX "account_idx_maintainer" on "account" ("maintainer");
CREATE INDEX "account_idx_org_size_id" on "account" ("org_size_id");
CREATE INDEX "account_idx_parent_acc_id" on "account" ("parent_acc_id");

;
--
-- Table: account_attribute.
--
CREATE TABLE "account_attribute" (
  "account_attribute_id" serial NOT NULL,
  "name" text NOT NULL,
  "value" text NOT NULL,
  "account_attribute_group_id" integer NOT NULL,
  "last_update_id" text,
  "last_update_time" timestamp with time zone DEFAULT now(),
  PRIMARY KEY ("account_attribute_id"),
  CONSTRAINT "account_attribute_uq_group_name" UNIQUE ("account_attribute_group_id", "name")
);
CREATE INDEX "account_attribute_idx_account_attribute_group_id" on "account_attribute" ("account_attribute_group_id");

;
--
-- Table: account_attribute_group.
--
CREATE TABLE "account_attribute_group" (
  "account_attribute_group_id" serial NOT NULL,
  "acc_id" integer NOT NULL,
  "last_update_id" text,
  "last_update_time" timestamp with time zone DEFAULT now(),
  PRIMARY KEY ("account_attribute_group_id")
);
CREATE INDEX "account_attribute_group_idx_acc_id" on "account_attribute_group" ("acc_id");

;
--
-- Table: account_preference.
--
CREATE TABLE "account_preference" (
  "last_update_id" text,
  "name" text NOT NULL,
  "value" text,
  "acc_id" integer NOT NULL,
  "last_update_time" timestamp with time zone DEFAULT now(),
  PRIMARY KEY ("name", "acc_id")
);
CREATE INDEX "account_preference_idx_acc_id" on "account_preference" ("acc_id");

;
--
-- Table: account_type.
--
CREATE TABLE "account_type" (
  "account_type_id" serial NOT NULL,
  "description" text NOT NULL,
  "is_account_group" boolean DEFAULT false NOT NULL,
  "is_subscription_group" boolean DEFAULT false NOT NULL,
  "last_update_id" text,
  "last_update_time" timestamp with time zone DEFAULT now(),
  PRIMARY KEY ("account_type_id"),
  CONSTRAINT "account_type_description_key" UNIQUE ("description")
);

;
--
-- Table: authorisation_history.
--
CREATE TABLE "authorisation_history" (
  "authorisation_history_id" serial NOT NULL,
  "authorisation_type" text NOT NULL,
  "credential_type" text NOT NULL,
  "credential_value" text NOT NULL,
  "last_update_id" text,
  "acc_id" integer NOT NULL,
  "event_timestamp" timestamp with time zone DEFAULT now() NOT NULL,
  "last_update_time" timestamp with time zone DEFAULT now(),
  "site_id" text NOT NULL,
  "site_name" text,
  "organisation" text,
  "summarised" boolean DEFAULT false NOT NULL,
  PRIMARY KEY ("authorisation_history_id")
);

;
--
-- Table: content_unit_type.
--
CREATE TABLE "content_unit_type" (
  "content_unit_type_id" character varying(50) NOT NULL,
  "description" text NOT NULL,
  "last_update_id" text,
  "last_update_time" timestamp with time zone DEFAULT now(),
  PRIMARY KEY ("content_unit_type_id"),
  CONSTRAINT "content_unit_type_description_ukey" UNIQUE ("description")
);

;
--
-- Table: country.
--
CREATE TABLE "country" (
  "country_id" character varying(3) NOT NULL,
  "last_update_id" text,
  "name" text NOT NULL,
  "territory" character(3) NOT NULL,
  "last_update_time" timestamp with time zone DEFAULT now(),
  PRIMARY KEY ("country_id")
);

;
--
-- Table: credential_ip.
--
CREATE TABLE "credential_ip" (
  "allow" boolean DEFAULT true NOT NULL,
  "credential_ip_id" serial NOT NULL,
  "ip_address" inet NOT NULL,
  "last_update_id" text,
  "acc_id" integer NOT NULL,
  "last_update_time" timestamp with time zone,
  PRIMARY KEY ("credential_ip_id")
);
CREATE INDEX "credential_ip_idx_acc_id" on "credential_ip" ("acc_id");

;
--
-- Table: credential_libcard.
--
CREATE TABLE "credential_libcard" (
  "credential_libcard_id" serial NOT NULL,
  "last_update_id" text,
  "pattern" text NOT NULL,
  "acc_id" integer NOT NULL,
  "last_update_time" timestamp with time zone,
  "code" text,
  PRIMARY KEY ("credential_libcard_id")
);
CREATE INDEX "credential_libcard_idx_acc_id" on "credential_libcard" ("acc_id");

;
--
-- Table: credential_referrer.
--
CREATE TABLE "credential_referrer" (
  "credential_referrer_id" serial NOT NULL,
  "last_update_id" text,
  "referrer" text NOT NULL,
  "acc_id" integer NOT NULL,
  "last_update_time" timestamp with time zone,
  PRIMARY KEY ("credential_referrer_id"),
  CONSTRAINT "credential_referrer_referrer_key" UNIQUE ("referrer")
);
CREATE INDEX "credential_referrer_idx_acc_id" on "credential_referrer" ("acc_id");

;
--
-- Table: credential_shibboleth.
--
CREATE TABLE "credential_shibboleth" (
  "credential_shibboleth_id" serial NOT NULL,
  "acc_id" integer NOT NULL,
  "entity_id" text NOT NULL,
  "organisation_id" text NOT NULL,
  "last_update_id" text,
  "last_update_time" timestamp with time zone,
  PRIMARY KEY ("credential_shibboleth_id"),
  CONSTRAINT "credential_shibboleth_organisation_id_key" UNIQUE ("organisation_id")
);
CREATE INDEX "credential_shibboleth_idx_acc_id" on "credential_shibboleth" ("acc_id");

;
--
-- Table: credential_userpass.
--
CREATE TABLE "credential_userpass" (
  "credential_userpass_id" serial NOT NULL,
  "last_update_id" text,
  "password" text NOT NULL,
  "username" text NOT NULL,
  "acc_id" integer NOT NULL,
  "last_update_time" timestamp with time zone,
  "make_public" boolean DEFAULT false NOT NULL,
  PRIMARY KEY ("credential_userpass_id")
);
CREATE INDEX "credential_userpass_idx_acc_id" on "credential_userpass" ("acc_id");

;
--
-- Table: credential_userpass_reset.
--
CREATE TABLE "credential_userpass_reset" (
  "credential_userpass_reset_id" text NOT NULL,
  "acc_id" integer NOT NULL,
  "subs_id" integer,
  "username" text,
  "creation_time" timestamp with time zone DEFAULT now() NOT NULL,
  "last_update_id" text,
  "last_update_time" timestamp with time zone DEFAULT now(),
  PRIMARY KEY ("credential_userpass_reset_id")
);
CREATE INDEX "credential_userpass_reset_idx_acc_id" on "credential_userpass_reset" ("acc_id");
CREATE INDEX "credential_userpass_reset_idx_subs_id" on "credential_userpass_reset" ("subs_id");

;
--
-- Table: currency.
--
CREATE TABLE "currency" (
  "currency_id" serial NOT NULL,
  "name" character varying(50) NOT NULL,
  "code" character varying(3) NOT NULL,
  "last_update_id" text,
  "last_update_time" timestamp with time zone DEFAULT now(),
  PRIMARY KEY ("currency_id"),
  CONSTRAINT "currency_uq_code" UNIQUE ("code"),
  CONSTRAINT "currency_uq_name" UNIQUE ("name")
);

;
--
-- Table: custom_account_field.
--
CREATE TABLE "custom_account_field" (
  "account_preference_name" text NOT NULL,
  "label" text NOT NULL,
  "description" text,
  PRIMARY KEY ("account_preference_name")
);

;
--
-- Table: custom_subscription_field.
--
CREATE TABLE "custom_subscription_field" (
  "subscription_preference_name" text NOT NULL,
  "label" text NOT NULL,
  "description" text,
  PRIMARY KEY ("subscription_preference_name")
);

;
--
-- Table: daily_stats.
--
CREATE TABLE "daily_stats" (
  "acc_id" integer NOT NULL,
  "site_id" text NOT NULL,
  "day" timestamp with time zone NOT NULL,
  "credential_type" text NOT NULL,
  "browse_requests" integer NOT NULL,
  "content_requests" integer NOT NULL,
  "menu_requests" integer NOT NULL,
  "page_requests" integer NOT NULL,
  "raw_requests" integer NOT NULL,
  "search_requests" integer NOT NULL,
  "sessions" integer NOT NULL,
  "total_session_duration" interval NOT NULL,
  "live_subs" integer NOT NULL,
  "concurrency_turnaways" integer NOT NULL,
  "licence_turnaways" integer NOT NULL,
  PRIMARY KEY ("acc_id", "site_id", "day", "credential_type")
);

;
--
-- Table: daily_stats_consortia.
--
CREATE TABLE "daily_stats_consortia" (
  "acc_id" integer NOT NULL,
  "site_id" text NOT NULL,
  "day" timestamp with time zone NOT NULL,
  "credential_type" text NOT NULL,
  "group_subs_id" text,
  "consortium_id" text NOT NULL,
  "browse_requests" integer NOT NULL,
  "content_requests" integer NOT NULL,
  "menu_requests" integer NOT NULL,
  "page_requests" integer NOT NULL,
  "raw_requests" integer NOT NULL,
  "search_requests" integer NOT NULL,
  "sessions" integer NOT NULL,
  "total_session_duration" interval NOT NULL,
  "live_subs" integer NOT NULL,
  "concurrency_turnaways" integer NOT NULL,
  "licence_turnaways" integer NOT NULL,
  PRIMARY KEY ("acc_id", "site_id", "day", "credential_type", "consortium_id")
);

;
--
-- Table: db_updates.
--
CREATE TABLE "db_updates" (
  "id" serial NOT NULL,
  "script_number" text NOT NULL,
  "when_realised" timestamp with time zone DEFAULT now() NOT NULL,
  "applied_by" text NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "db_updates_uq_script_number" UNIQUE ("script_number")
);

;
--
-- Table: ecommerce_transaction.
--
CREATE TABLE "ecommerce_transaction" (
  "ecommerce_transaction_id" serial NOT NULL,
  "transaction_start_datetime" timestamp NOT NULL,
  "cart_contents" text NOT NULL,
  "psp_status_message" text,
  "psp_transaction_id" text,
  "sams_status_message" text,
  "amount" text NOT NULL,
  "last_update_id" text,
  "last_update_time" timestamp with time zone DEFAULT now(),
  "acc_id" integer,
  "ecommerce_transaction_status_id" integer NOT NULL,
  PRIMARY KEY ("ecommerce_transaction_id")
);
CREATE INDEX "ecommerce_transaction_idx_acc_id" on "ecommerce_transaction" ("acc_id");
CREATE INDEX "ecommerce_transaction_idx_ecommerce_transaction_status_id" on "ecommerce_transaction" ("ecommerce_transaction_status_id");

;
--
-- Table: ecommerce_transaction_status.
--
CREATE TABLE "ecommerce_transaction_status" (
  "ecommerce_transaction_status_id" integer NOT NULL,
  "status" text NOT NULL,
  "last_update_id" text,
  "last_update_time" timestamp with time zone DEFAULT now(),
  PRIMARY KEY ("ecommerce_transaction_status_id"),
  CONSTRAINT "ecommerce_transaction_status_uq_status" UNIQUE ("status")
);

;
--
-- Table: group_member.
--
CREATE TABLE "group_member" (
  "group_member_id" serial NOT NULL,
  "last_update_id" text,
  "credential_userpass_id" integer NOT NULL,
  "group_name_id" text NOT NULL,
  "last_update_time" timestamp with time zone DEFAULT now(),
  PRIMARY KEY ("group_member_id"),
  CONSTRAINT "group_member_credential_userpass_id_key" UNIQUE ("credential_userpass_id", "group_name_id")
);
CREATE INDEX "group_member_idx_credential_userpass_id" on "group_member" ("credential_userpass_id");
CREATE INDEX "group_member_idx_group_name_id" on "group_member" ("group_name_id");

;
--
-- Table: group_name.
--
CREATE TABLE "group_name" (
  "group_name_id" text NOT NULL,
  "last_update_id" text,
  "privilege_level" integer DEFAULT 0 NOT NULL,
  "last_update_time" timestamp with time zone DEFAULT now(),
  PRIMARY KEY ("group_name_id")
);

;
--
-- Table: invoice_payment_type.
--
CREATE TABLE "invoice_payment_type" (
  "invoice_payment_type_id" serial NOT NULL,
  "name" text NOT NULL,
  "last_update_time" timestamp with time zone DEFAULT now(),
  "last_update_id" text,
  PRIMARY KEY ("invoice_payment_type_id"),
  CONSTRAINT "invoice_payment_type_uq_name" UNIQUE ("name")
);

;
--
-- Table: monthly_stats.
--
CREATE TABLE "monthly_stats" (
  "acc_id" integer NOT NULL,
  "site_id" text NOT NULL,
  "month" timestamp with time zone NOT NULL,
  "credential_type" text NOT NULL,
  "browse_requests" integer NOT NULL,
  "content_requests" integer NOT NULL,
  "menu_requests" integer NOT NULL,
  "page_requests" integer NOT NULL,
  "raw_requests" integer NOT NULL,
  "search_requests" integer NOT NULL,
  "sessions" integer NOT NULL,
  "total_session_duration" interval NOT NULL,
  "live_subs" integer NOT NULL,
  "concurrency_turnaways" integer NOT NULL,
  "licence_turnaways" integer NOT NULL,
  PRIMARY KEY ("acc_id", "site_id", "month", "credential_type")
);

;
--
-- Table: monthly_stats_consortia.
--
CREATE TABLE "monthly_stats_consortia" (
  "acc_id" integer NOT NULL,
  "site_id" text NOT NULL,
  "month" timestamp with time zone NOT NULL,
  "credential_type" text NOT NULL,
  "consortium_id" text NOT NULL,
  "group_subs_id" text,
  "browse_requests" integer NOT NULL,
  "content_requests" integer NOT NULL,
  "menu_requests" integer NOT NULL,
  "page_requests" integer NOT NULL,
  "raw_requests" integer NOT NULL,
  "search_requests" integer NOT NULL,
  "sessions" integer NOT NULL,
  "total_session_duration" interval NOT NULL,
  "live_subs" integer NOT NULL,
  "concurrency_turnaways" integer NOT NULL,
  "licence_turnaways" integer NOT NULL,
  PRIMARY KEY ("acc_id", "site_id", "month", "credential_type", "consortium_id")
);

;
--
-- Table: named_user.
--
CREATE TABLE "named_user" (
  "named_user_id" serial NOT NULL,
  "acc_id" integer NOT NULL,
  "subs_id" integer NOT NULL,
  "is_admin" boolean DEFAULT false,
  "last_update_id" text,
  "last_update_time" timestamp with time zone,
  "is_user" boolean DEFAULT true,
  PRIMARY KEY ("named_user_id"),
  CONSTRAINT "named_user_unique_acc_and_sub_key" UNIQUE ("acc_id", "subs_id")
);
CREATE INDEX "named_user_idx_acc_id" on "named_user" ("acc_id");
CREATE INDEX "named_user_idx_subs_id" on "named_user" ("subs_id");

;
--
-- Table: named_user_config.
--
CREATE TABLE "named_user_config" (
  "subs_id" integer NOT NULL,
  "max_users" integer NOT NULL,
  "last_update_id" text,
  "last_update_time" timestamp with time zone,
  PRIMARY KEY ("subs_id")
);

;
--
-- Table: oauth_client_server.
--
CREATE TABLE "oauth_client_server" (
  "oauth_client_server_id" text NOT NULL,
  "client_id" text NOT NULL,
  "client_secret" text NOT NULL,
  "last_update_id" text,
  "last_update_time" timestamp with time zone DEFAULT now(),
  "image_url" text,
  PRIMARY KEY ("oauth_client_server_id"),
  CONSTRAINT "oauth_client_server_client_id_key" UNIQUE ("client_id")
);

;
--
-- Table: oauth_server_client.
--
CREATE TABLE "oauth_server_client" (
  "oauth_server_client_id" serial NOT NULL,
  "client_id" text NOT NULL,
  "client_secret" text NOT NULL,
  "endpoint" text NOT NULL,
  "last_update_id" text,
  "last_update_time" timestamp with time zone DEFAULT now(),
  PRIMARY KEY ("oauth_server_client_id"),
  CONSTRAINT "oauth_server_client_client_id_key" UNIQUE ("client_id")
);

;
--
-- Table: org_size.
--
CREATE TABLE "org_size" (
  "description" text NOT NULL,
  "last_update_id" text,
  "org_size_id" serial NOT NULL,
  "last_update_time" timestamp with time zone DEFAULT now(),
  PRIMARY KEY ("org_size_id"),
  CONSTRAINT "org_size_description_key" UNIQUE ("description")
);

;
--
-- Table: platform.
--
CREATE TABLE "platform" (
  "platform_id" text NOT NULL,
  "platform_name" text NOT NULL,
  "last_update_time" timestamp with time zone DEFAULT now(),
  "last_update_id" text,
  PRIMARY KEY ("platform_id")
);

;
--
-- Table: platform_content.
--
CREATE TABLE "platform_content" (
  "platform_id" text NOT NULL,
  "content_unit_id" text NOT NULL,
  "last_update_time" timestamp with time zone DEFAULT now(),
  "last_update_id" text,
  PRIMARY KEY ("platform_id", "content_unit_id")
);
CREATE INDEX "platform_content_idx_content_unit_id" on "platform_content" ("content_unit_id");

;
--
-- Table: product_content.
--
CREATE TABLE "product_content" (
  "pe_id" text NOT NULL,
  "content_unit_id" text NOT NULL,
  "last_update_time" timestamp with time zone DEFAULT now(),
  "last_update_id" text,
  PRIMARY KEY ("pe_id", "content_unit_id")
);
CREATE INDEX "product_content_idx_content_unit_id" on "product_content" ("content_unit_id");
CREATE INDEX "product_content_idx_pe_id" on "product_content" ("pe_id");

;
--
-- Table: product_edition.
--
CREATE TABLE "product_edition" (
  "immediate_access" boolean DEFAULT false NOT NULL,
  "last_update_id" text,
  "license_url" text,
  "notify" text,
  "pe_id" text NOT NULL,
  "pe_name" text NOT NULL,
  "product_url" text,
  "last_update_time" timestamp with time zone DEFAULT now(),
  "site_id" text NOT NULL,
  "product_type_id" text NOT NULL,
  "allow_ip_default" boolean NOT NULL,
  "allow_userpass_default" boolean NOT NULL,
  "deny_groups_default" text,
  "allow_referrer_default" boolean NOT NULL,
  "allow_libcard_default" boolean NOT NULL,
  "require_libcode_default" boolean,
  "isbn" text,
  "is_inheritable_default" boolean DEFAULT false,
  "description" text,
  "image_filename" text,
  "notes" text,
  "satisfy_all_selected_creds_default" boolean DEFAULT false,
  "allow_shibboleth_default" boolean DEFAULT false,
  "allow_oauth_default" boolean DEFAULT false,
  PRIMARY KEY ("pe_id"),
  CONSTRAINT "product_edition_pe_name_key" UNIQUE ("pe_name")
);
CREATE INDEX "product_edition_idx_site_id" on "product_edition" ("site_id");

;
--
-- Table: product_edition_sku.
--
CREATE TABLE "product_edition_sku" (
  "product_edition_sku_id" serial NOT NULL,
  "description" text NOT NULL,
  "last_update_id" text,
  "last_update_time" timestamp with time zone DEFAULT now(),
  "subs_duration_id" integer NOT NULL,
  "pe_id" text NOT NULL,
  PRIMARY KEY ("product_edition_sku_id")
);
CREATE INDEX "product_edition_sku_idx_pe_id" on "product_edition_sku" ("pe_id");
CREATE INDEX "product_edition_sku_idx_subs_duration_id" on "product_edition_sku" ("subs_duration_id");

;
--
-- Table: product_edition_sku_purchase_price.
--
CREATE TABLE "product_edition_sku_purchase_price" (
  "product_edition_sku_purchase_price_id" serial NOT NULL,
  "purchase_price" numeric(8,2) NOT NULL,
  "last_update_id" text,
  "last_update_time" timestamp with time zone DEFAULT now(),
  "product_edition_sku_id" integer NOT NULL,
  "currency_id" integer NOT NULL,
  PRIMARY KEY ("product_edition_sku_purchase_price_id"),
  CONSTRAINT "product_edition_sku_purchase_price_uq_pe_sku_id_cur_id" UNIQUE ("product_edition_sku_id", "currency_id")
);
CREATE INDEX "product_edition_sku_purchase_price_idx_currency_id" on "product_edition_sku_purchase_price" ("currency_id");
CREATE INDEX "product_edition_sku_purchase_price_idx_product_edition_sku_id" on "product_edition_sku_purchase_price" ("product_edition_sku_id");

;
--
-- Table: product_preference.
--
CREATE TABLE "product_preference" (
  "product_preference_id" serial NOT NULL,
  "last_update_id" text,
  "name" text NOT NULL,
  "value" text,
  "pe_id" text NOT NULL,
  "last_update_time" timestamp with time zone DEFAULT now(),
  PRIMARY KEY ("product_preference_id"),
  CONSTRAINT "prodcut_pref_uniq_name_pe_id" UNIQUE ("name", "pe_id")
);
CREATE INDEX "product_preference_idx_pe_id" on "product_preference" ("pe_id");

;
--
-- Table: publication_medium.
--
CREATE TABLE "publication_medium" (
  "publication_medium_id" text NOT NULL,
  "description" text,
  "last_update_id" text,
  "last_update_time" timestamp with time zone DEFAULT now(),
  PRIMARY KEY ("publication_medium_id")
);

;
--
-- Table: publisher_preference.
--
CREATE TABLE "publisher_preference" (
  "publisher_preference_id" serial NOT NULL,
  "last_update_id" text,
  "name" text NOT NULL,
  "value" text,
  "last_update_time" timestamp with time zone DEFAULT now(),
  PRIMARY KEY ("publisher_preference_id"),
  CONSTRAINT "publisher_preference_uniq_name" UNIQUE ("name")
);

;
--
-- Table: saved_report.
--
CREATE TABLE "saved_report" (
  "saved_report_id" serial NOT NULL,
  "last_update_id" text,
  "last_update_time" timestamp with time zone DEFAULT now(),
  "report_class" text NOT NULL,
  "report_path" text NOT NULL,
  PRIMARY KEY ("saved_report_id")
);

;
--
-- Table: saved_report_args.
--
CREATE TABLE "saved_report_args" (
  "saved_report_arg_id" serial NOT NULL,
  "saved_report_id" integer NOT NULL,
  "last_update_id" text,
  "last_update_time" timestamp with time zone DEFAULT now(),
  "arg_name" text NOT NULL,
  "arg_value" text,
  PRIMARY KEY ("saved_report_arg_id"),
  CONSTRAINT "saved_report_args_uniq_arg_name_saved_report_id" UNIQUE ("arg_name", "saved_report_id")
);
CREATE INDEX "saved_report_args_idx_saved_report_id" on "saved_report_args" ("saved_report_id");

;
--
-- Table: saved_report_schedule.
--
CREATE TABLE "saved_report_schedule" (
  "saved_report_schedule_id" serial NOT NULL,
  "saved_report_id" integer NOT NULL,
  "last_update_id" text,
  "last_update_time" timestamp with time zone DEFAULT now(),
  "run_time" time DEFAULT localtime,
  "run_day" integer[] DEFAULT '{}'::integer[] NOT NULL,
  "run_date" integer[] DEFAULT '{}'::integer[] NOT NULL,
  "run_month" integer[] DEFAULT '{}'::integer[] NOT NULL,
  PRIMARY KEY ("saved_report_schedule_id")
);
CREATE INDEX "saved_report_schedule_idx_saved_report_id" on "saved_report_schedule" ("saved_report_id");

;
--
-- Table: session.
--
CREATE TABLE "session" (
  "abuse_reason" text,
  "client_id" text NOT NULL,
  "client_session_id" text NOT NULL,
  "clientdata" text,
  "last_update_id" text,
  "session_id" serial NOT NULL,
  "shared_session" boolean DEFAULT false NOT NULL,
  "user_agent" text,
  "acc_id" integer,
  "last_access_time" timestamp with time zone NOT NULL,
  "last_update_time" timestamp with time zone DEFAULT now(),
  "start_time" timestamp with time zone NOT NULL,
  "site_id" text NOT NULL,
  PRIMARY KEY ("session_id"),
  CONSTRAINT "session_client_id_key" UNIQUE ("client_id", "client_session_id")
);
CREATE INDEX "session_idx_acc_id" on "session" ("acc_id");
CREATE INDEX "session_idx_site_id" on "session" ("site_id");

;
--
-- Table: session_credential_ip.
--
CREATE TABLE "session_credential_ip" (
  "session_id" integer NOT NULL,
  "acc_id" integer NOT NULL,
  "credential_ip_id" integer NOT NULL,
  "last_update_id" text,
  "last_update_time" timestamp with time zone DEFAULT now(),
  PRIMARY KEY ("session_id", "credential_ip_id"),
  CONSTRAINT "session_credential_ip_session_acc_unique" UNIQUE ("session_id", "acc_id")
);
CREATE INDEX "session_credential_ip_idx_acc_id" on "session_credential_ip" ("acc_id");
CREATE INDEX "session_credential_ip_idx_session_id" on "session_credential_ip" ("session_id");

;
--
-- Table: session_credential_libcard.
--
CREATE TABLE "session_credential_libcard" (
  "session_id" integer NOT NULL,
  "acc_id" integer NOT NULL,
  "credential_libcard_id" integer NOT NULL,
  "last_update_id" text,
  "last_update_time" timestamp with time zone DEFAULT now(),
  PRIMARY KEY ("session_id", "credential_libcard_id"),
  CONSTRAINT "session_credential_libcard_session_acc_unique" UNIQUE ("session_id", "acc_id")
);
CREATE INDEX "session_credential_libcard_idx_acc_id" on "session_credential_libcard" ("acc_id");
CREATE INDEX "session_credential_libcard_idx_session_id" on "session_credential_libcard" ("session_id");

;
--
-- Table: session_credential_oauth.
--
CREATE TABLE "session_credential_oauth" (
  "session_id" integer NOT NULL,
  "acc_id" integer NOT NULL,
  "credential_oauth_id" integer NOT NULL,
  "last_update_id" text,
  "last_update_time" timestamp with time zone DEFAULT now(),
  PRIMARY KEY ("session_id", "credential_oauth_id"),
  CONSTRAINT "session_credential_oauth_session_acc_unique" UNIQUE ("session_id", "acc_id")
);
CREATE INDEX "session_credential_oauth_idx_acc_id" on "session_credential_oauth" ("acc_id");
CREATE INDEX "session_credential_oauth_idx_session_id" on "session_credential_oauth" ("session_id");

;
--
-- Table: session_credential_referrer.
--
CREATE TABLE "session_credential_referrer" (
  "session_id" integer NOT NULL,
  "acc_id" integer NOT NULL,
  "credential_referrer_id" integer NOT NULL,
  "last_update_id" text,
  "last_update_time" timestamp with time zone DEFAULT now(),
  PRIMARY KEY ("session_id", "credential_referrer_id"),
  CONSTRAINT "session_credential_referrer_session_acc_unique" UNIQUE ("session_id", "acc_id")
);
CREATE INDEX "session_credential_referrer_idx_acc_id" on "session_credential_referrer" ("acc_id");
CREATE INDEX "session_credential_referrer_idx_session_id" on "session_credential_referrer" ("session_id");

;
--
-- Table: session_credential_shibboleth.
--
CREATE TABLE "session_credential_shibboleth" (
  "session_id" integer NOT NULL,
  "acc_id" integer NOT NULL,
  "credential_shibboleth_id" integer NOT NULL,
  "last_update_id" text,
  "last_update_time" timestamp with time zone DEFAULT now(),
  PRIMARY KEY ("session_id", "credential_shibboleth_id"),
  CONSTRAINT "session_credential_shibboleth_session_acc_unique" UNIQUE ("session_id", "acc_id")
);
CREATE INDEX "session_credential_shibboleth_idx_acc_id" on "session_credential_shibboleth" ("acc_id");
CREATE INDEX "session_credential_shibboleth_idx_session_id" on "session_credential_shibboleth" ("session_id");

;
--
-- Table: session_credential_userpass.
--
CREATE TABLE "session_credential_userpass" (
  "session_id" integer NOT NULL,
  "acc_id" integer NOT NULL,
  "credential_userpass_id" integer NOT NULL,
  "last_update_id" text,
  "last_update_time" timestamp with time zone DEFAULT now(),
  PRIMARY KEY ("session_id", "credential_userpass_id"),
  CONSTRAINT "session_credential_userpass_session_acc_unique" UNIQUE ("session_id", "acc_id")
);
CREATE INDEX "session_credential_userpass_idx_acc_id" on "session_credential_userpass" ("acc_id");
CREATE INDEX "session_credential_userpass_idx_session_id" on "session_credential_userpass" ("session_id");

;
--
-- Table: session_history.
--
CREATE TABLE "session_history" (
  "browse_requests" integer DEFAULT 0 NOT NULL,
  "client_id" text NOT NULL,
  "client_session_id" text NOT NULL,
  "content_requests" integer DEFAULT 0 NOT NULL,
  "host" text,
  "ip_address" inet,
  "last_update_id" text,
  "library_card" text,
  "menu_requests" integer DEFAULT 0 NOT NULL,
  "page_requests" integer DEFAULT 0 NOT NULL,
  "raw_requests" integer DEFAULT 0 NOT NULL,
  "referrer" text,
  "search_requests" integer DEFAULT 0 NOT NULL,
  "session_history_id" serial NOT NULL,
  "username" text,
  "acc_id" integer NOT NULL,
  "first_request" timestamp with time zone NOT NULL,
  "last_request" timestamp with time zone NOT NULL,
  "last_update_time" timestamp with time zone DEFAULT now(),
  "site_id" text NOT NULL,
  "site_name" text,
  "organisation" text,
  "summarised" boolean DEFAULT false NOT NULL,
  PRIMARY KEY ("session_history_id"),
  CONSTRAINT "session_history_client_id_key" UNIQUE ("client_id", "client_session_id")
);

;
--
-- Table: site.
--
CREATE TABLE "site" (
  "site_id" text NOT NULL,
  "site_name" text NOT NULL,
  "platform_id" text,
  "last_update_time" timestamp with time zone DEFAULT now(),
  "last_update_id" text,
  "site_url" text,
  PRIMARY KEY ("site_id"),
  CONSTRAINT "site_name_key" UNIQUE ("site_name")
);
CREATE INDEX "site_idx_platform_id" on "site" ("platform_id");

;
--
-- Table: site_preference.
--
CREATE TABLE "site_preference" (
  "id" serial NOT NULL,
  "name" text NOT NULL,
  "value" text,
  "last_update_id" text,
  "last_update_time" timestamp with time zone DEFAULT now(),
  "site_id" text NOT NULL,
  PRIMARY KEY ("id")
);
CREATE INDEX "site_preference_idx_site_id" on "site_preference" ("site_id");

;
--
-- Table: subs_duration.
--
CREATE TABLE "subs_duration" (
  "duration" interval NOT NULL,
  "grace_period" interval DEFAULT '00:00:00' NOT NULL,
  "last_update_id" text,
  "subs_duration_id" serial NOT NULL,
  "last_update_time" timestamp with time zone DEFAULT now(),
  PRIMARY KEY ("subs_duration_id"),
  CONSTRAINT "subs_duration_duration_key" UNIQUE ("duration")
);

;
--
-- Table: subscription.
--
CREATE TABLE "subscription" (
  "address1" text,
  "address2" text,
  "administered_by" character(3) NOT NULL,
  "alternative_subs_id" text,
  "allow_marketing_email" boolean DEFAULT true NOT NULL,
  "allow_notification_email" boolean DEFAULT true NOT NULL,
  "city" text,
  "concurrency" integer NOT NULL,
  "contact_forename" text,
  "contact_job_title" text,
  "contact_name" text,
  "contact_title" text,
  "county" text,
  "currency" character(3),
  "email" text,
  "fax" text,
  "grace_period" interval DEFAULT '00:00:00' NOT NULL,
  "if_sub_id" integer,
  "ignore_end" boolean DEFAULT false NOT NULL,
  "ignore_start" boolean DEFAULT false NOT NULL,
  "isbn" text,
  "last_update_id" text,
  "msd_order_id" integer,
  "notes" text,
  "postcode" text,
  "prepayment_required" boolean DEFAULT false NOT NULL,
  "price" numeric(9,2),
  "sales_rep" text,
  "status" text NOT NULL,
  "subs_id" serial NOT NULL,
  "telephone" text,
  "acc_id" integer NOT NULL,
  "country_id" character varying(3),
  "creation_date" timestamp with time zone DEFAULT now(),
  "end_date" date,
  "group_subs_id" integer,
  "last_update_time" timestamp with time zone,
  "pe_id" text NOT NULL,
  "start_date" date,
  "subscription_type_id" integer NOT NULL,
  "allow_ip" boolean NOT NULL,
  "allow_userpass" boolean NOT NULL,
  "deny_groups" text,
  "allow_referrer" boolean NOT NULL,
  "allow_libcard" boolean NOT NULL,
  "require_libcode" boolean,
  "publication_medium_id" text DEFAULT 'ONLINE' NOT NULL,
  "converted_to_sub_id" integer,
  "conversion_date" timestamp with time zone,
  "conversion_type" text,
  "is_inheritable" boolean DEFAULT false,
  "contact_mobile_telephone" text,
  "contact_acc_id" integer,
  "satisfy_all_selected_creds" boolean DEFAULT false,
  "allow_shibboleth" boolean DEFAULT false,
  "allow_oauth" boolean DEFAULT false,
  PRIMARY KEY ("subs_id"),
  CONSTRAINT "subscription_alternative_subs_id_key" UNIQUE ("alternative_subs_id"),
  CONSTRAINT "subscription_if_sub_id_key" UNIQUE ("if_sub_id"),
  CONSTRAINT "subscription_msd_order_id_key" UNIQUE ("msd_order_id")
);
CREATE INDEX "subscription_idx_acc_id" on "subscription" ("acc_id");
CREATE INDEX "subscription_idx_contact_acc_id" on "subscription" ("contact_acc_id");
CREATE INDEX "subscription_idx_country_id" on "subscription" ("country_id");
CREATE INDEX "subscription_idx_group_subs_id" on "subscription" ("group_subs_id");
CREATE INDEX "subscription_idx_pe_id" on "subscription" ("pe_id");
CREATE INDEX "subscription_idx_publication_medium_id" on "subscription" ("publication_medium_id");
CREATE INDEX "subscription_idx_subscription_type_id" on "subscription" ("subscription_type_id");

;
--
-- Table: subscription_attribute.
--
CREATE TABLE "subscription_attribute" (
  "subscription_attribute_id" serial NOT NULL,
  "name" text NOT NULL,
  "value" text NOT NULL,
  "subscription_attribute_group_id" integer NOT NULL,
  "last_update_id" text,
  "last_update_time" timestamp with time zone DEFAULT now(),
  PRIMARY KEY ("subscription_attribute_id"),
  CONSTRAINT "subscription_attribute_uq_group_name" UNIQUE ("subscription_attribute_group_id", "name")
);
CREATE INDEX "subscription_attribute_idx_subscription_attribute_group_id" on "subscription_attribute" ("subscription_attribute_group_id");

;
--
-- Table: subscription_attribute_group.
--
CREATE TABLE "subscription_attribute_group" (
  "subscription_attribute_group_id" serial NOT NULL,
  "subs_id" integer NOT NULL,
  "last_update_id" text,
  "last_update_time" timestamp with time zone DEFAULT now(),
  PRIMARY KEY ("subscription_attribute_group_id")
);
CREATE INDEX "subscription_attribute_group_idx_subs_id" on "subscription_attribute_group" ("subs_id");

;
--
-- Table: subscription_ip.
--
CREATE TABLE "subscription_ip" (
  "subscription_ip_id" serial NOT NULL,
  "subs_id" integer NOT NULL,
  "ip_address" inet NOT NULL,
  "last_update_id" text,
  "last_update_time" timestamp with time zone,
  "notes" text,
  PRIMARY KEY ("subscription_ip_id"),
  CONSTRAINT "subscription_ip_unique_sub_and_ip_key" UNIQUE ("subs_id", "ip_address")
);
CREATE INDEX "subscription_ip_idx_subs_id" on "subscription_ip" ("subs_id");

;
--
-- Table: subscription_preference.
--
CREATE TABLE "subscription_preference" (
  "last_update_id" text,
  "name" text NOT NULL,
  "value" text,
  "subs_id" integer NOT NULL,
  "last_update_time" timestamp with time zone DEFAULT now(),
  PRIMARY KEY ("name", "subs_id")
);
CREATE INDEX "subscription_preference_idx_subs_id" on "subscription_preference" ("subs_id");

;
--
-- Table: subscription_token.
--
CREATE TABLE "subscription_token" (
  "administered_by" character(3) NOT NULL,
  "batch" integer NOT NULL,
  "concurrency" integer NOT NULL,
  "currency" character(3),
  "grace_period" interval DEFAULT '00:00:00' NOT NULL,
  "ignore_end" boolean DEFAULT false NOT NULL,
  "ignore_start" boolean DEFAULT false NOT NULL,
  "isbn" character(14),
  "last_update_id" text,
  "price" numeric(9,2),
  "subscription_token_id" text NOT NULL,
  "creation_date" timestamp with time zone DEFAULT now(),
  "end_date" date,
  "last_update_time" timestamp with time zone,
  "pe_id" text NOT NULL,
  "start_date" date,
  "subs_duration_id" integer,
  "subscription_type_id" integer NOT NULL,
  "start_on_activation" boolean,
  "status" text NOT NULL,
  "total_redemptions" integer DEFAULT 1 NOT NULL,
  PRIMARY KEY ("subscription_token_id")
);
CREATE INDEX "subscription_token_idx_batch" on "subscription_token" ("batch");
CREATE INDEX "subscription_token_idx_pe_id" on "subscription_token" ("pe_id");
CREATE INDEX "subscription_token_idx_subs_duration_id" on "subscription_token" ("subs_duration_id");
CREATE INDEX "subscription_token_idx_subscription_type_id" on "subscription_token" ("subscription_type_id");

;
--
-- Table: subscription_token_batch.
--
CREATE TABLE "subscription_token_batch" (
  "id" serial NOT NULL,
  "name" text NOT NULL,
  "notes" text,
  "last_update_time" timestamp with time zone,
  "last_update_id" text,
  PRIMARY KEY ("id")
);

;
--
-- Table: subscription_token_subscription.
--
CREATE TABLE "subscription_token_subscription" (
  "id" serial NOT NULL,
  "last_update_id" text,
  "activation_date" date,
  "subscription_token_id" text NOT NULL,
  "subscription_id" integer NOT NULL,
  PRIMARY KEY ("id")
);
CREATE INDEX "subscription_token_subscription_idx_subscription_id" on "subscription_token_subscription" ("subscription_id");
CREATE INDEX "subscription_token_subscription_idx_subscription_token_id" on "subscription_token_subscription" ("subscription_token_id");

;
--
-- Table: subscription_type.
--
CREATE TABLE "subscription_type" (
  "description" text NOT NULL,
  "last_update_id" text,
  "subscription_type_id" serial NOT NULL,
  "last_update_time" timestamp with time zone DEFAULT now(),
  PRIMARY KEY ("subscription_type_id"),
  CONSTRAINT "subscription_type_description_key" UNIQUE ("description")
);

;
--
-- Table: content_unit.
--
CREATE TABLE "content_unit" (
  "content_unit_id" text NOT NULL,
  "name" text,
  "publication_date" timestamp with time zone,
  "price" numeric(9,2),
  "date_added" timestamp with time zone DEFAULT now(),
  "last_update_time" timestamp with time zone DEFAULT now(),
  "last_update_id" text,
  "content_unit_type_id" character varying(50) NOT NULL,
  PRIMARY KEY ("content_unit_id")
);
CREATE INDEX "content_unit_idx_content_unit_type_id" on "content_unit" ("content_unit_type_id");

;
--
-- Table: oauth_server_authorization_grant.
--
CREATE TABLE "oauth_server_authorization_grant" (
  "oauth_server_authorization_grant_id" serial NOT NULL,
  "oauth_server_client_id" integer NOT NULL,
  "token" text NOT NULL,
  "is_active" boolean DEFAULT false NOT NULL,
  "last_update_id" text,
  "last_update_time" timestamp with time zone DEFAULT now(),
  PRIMARY KEY ("oauth_server_authorization_grant_id"),
  CONSTRAINT "oauth_server_authorization_grant_token_key" UNIQUE ("token")
);
CREATE INDEX "oauth_server_authorization_grant_idx_oauth_server_client_id" on "oauth_server_authorization_grant" ("oauth_server_client_id");

;
--
-- Table: subscription_token_batch_subscription_preference.
--
CREATE TABLE "subscription_token_batch_subscription_preference" (
  "subscription_token_batch_subscription_preference_id" serial NOT NULL,
  "name" text NOT NULL,
  "value" text NOT NULL,
  "last_update_id" text,
  "last_update_time" timestamp with time zone DEFAULT now(),
  "subscription_token_batch_id" integer NOT NULL,
  PRIMARY KEY ("subscription_token_batch_subscription_preference_id"),
  CONSTRAINT "subs_tok_batch_subscription_preference_uq_tok_batch_id_name" UNIQUE ("subscription_token_batch_id", "name")
);
CREATE INDEX "subscription_token_batch_subscription_preference_idx_subscription_token_batch_id" on "subscription_token_batch_subscription_preference" ("subscription_token_batch_id");

;
--
-- Table: credential_oauth.
--
CREATE TABLE "credential_oauth" (
  "credential_oauth_id" serial NOT NULL,
  "identity" text NOT NULL,
  "oauth_client_server_id" text NOT NULL,
  "acc_id" integer NOT NULL,
  "last_update_id" text,
  "last_update_time" timestamp with time zone DEFAULT now(),
  PRIMARY KEY ("credential_oauth_id"),
  CONSTRAINT "unique_identity_and_client_server_id" UNIQUE ("identity", "oauth_client_server_id")
);
CREATE INDEX "credential_oauth_idx_acc_id" on "credential_oauth" ("acc_id");
CREATE INDEX "credential_oauth_idx_oauth_client_server_id" on "credential_oauth" ("oauth_client_server_id");

;
--
-- Table: oauth_server_permission.
--
CREATE TABLE "oauth_server_permission" (
  "oauth_server_permission_id" serial NOT NULL,
  "oauth_server_client_id" integer NOT NULL,
  "acc_id" integer NOT NULL,
  "last_update_id" text,
  "last_update_time" timestamp with time zone DEFAULT now(),
  PRIMARY KEY ("oauth_server_permission_id")
);
CREATE INDEX "oauth_server_permission_idx_acc_id" on "oauth_server_permission" ("acc_id");
CREATE INDEX "oauth_server_permission_idx_oauth_server_client_id" on "oauth_server_permission" ("oauth_server_client_id");

;
--
-- Table: invoice.
--
CREATE TABLE "invoice" (
  "invoice_id" serial NOT NULL,
  "contact_title" text,
  "contact_given_name" text,
  "contact_family_name" text NOT NULL,
  "contact_organisation" text NOT NULL,
  "contact_address_1" text,
  "contact_address_2" text,
  "contact_city" text,
  "contact_county" text,
  "contact_country_id" character varying(3) NOT NULL,
  "contact_postcode" text,
  "issue_date" date DEFAULT now() NOT NULL,
  "last_update_time" timestamp with time zone DEFAULT now(),
  "last_update_id" text,
  "currency_id" integer NOT NULL,
  "acc_id" integer NOT NULL,
  "tax_rate" numeric(6,6) DEFAULT 0 NOT NULL,
  "payment_note" text,
  "subscription_dates" text,
  "contact_department" text,
  "ship_to_title" text,
  "ship_to_given_name" text,
  "ship_to_family_name" text,
  "ship_to_organisation" text,
  "ship_to_department" text,
  "ship_to_address_1" text,
  "ship_to_address_2" text,
  "ship_to_city" text,
  "ship_to_county" text,
  "ship_to_country_id" character varying(3),
  "ship_to_postcode" text,
  PRIMARY KEY ("invoice_id")
);
CREATE INDEX "invoice_idx_acc_id" on "invoice" ("acc_id");
CREATE INDEX "invoice_idx_contact_country_id" on "invoice" ("contact_country_id");
CREATE INDEX "invoice_idx_currency_id" on "invoice" ("currency_id");

;
--
-- Table: oauth_server_access_token.
--
CREATE TABLE "oauth_server_access_token" (
  "oauth_server_access_token_id" serial NOT NULL,
  "oauth_server_authorization_grant_id" integer NOT NULL,
  "acc_id" integer NOT NULL,
  "token" text NOT NULL,
  "is_active" boolean DEFAULT false NOT NULL,
  "last_update_id" text,
  "last_update_time" timestamp with time zone DEFAULT now(),
  PRIMARY KEY ("oauth_server_access_token_id"),
  CONSTRAINT "oauth_server_access_token_token_key" UNIQUE ("token")
);
CREATE INDEX "oauth_server_access_token_idx_acc_id" on "oauth_server_access_token" ("acc_id");
CREATE INDEX "oauth_server_access_token_idx_oauth_server_authorization_grant_id" on "oauth_server_access_token" ("oauth_server_authorization_grant_id");

;
--
-- Table: invoice_line_item.
--
CREATE TABLE "invoice_line_item" (
  "invoice_line_item_id" serial NOT NULL,
  "description" text NOT NULL,
  "amount" numeric(9,2) NOT NULL,
  "position" integer NOT NULL,
  "last_update_time" timestamp with time zone DEFAULT now(),
  "last_update_id" text,
  "invoice_id" integer NOT NULL,
  "tax" numeric(9,2) DEFAULT 0 NOT NULL,
  PRIMARY KEY ("invoice_line_item_id"),
  CONSTRAINT "invoice_line_item_uq_position_invoice_id" UNIQUE ("position", "invoice_id")
);
CREATE INDEX "invoice_line_item_idx_invoice_id" on "invoice_line_item" ("invoice_id");

;
--
-- Table: oauth_server_refresh_token.
--
CREATE TABLE "oauth_server_refresh_token" (
  "oauth_server_refresh_token_id" serial NOT NULL,
  "oauth_server_authorization_grant_id" integer NOT NULL,
  "oauth_server_access_token_id" integer NOT NULL,
  "token" text NOT NULL,
  "is_active" boolean DEFAULT false NOT NULL,
  "last_update_id" text,
  "last_update_time" timestamp with time zone DEFAULT now(),
  PRIMARY KEY ("oauth_server_refresh_token_id"),
  CONSTRAINT "oauth_server_refresh_token_token_key" UNIQUE ("token")
);
CREATE INDEX "oauth_server_refresh_token_idx_oauth_server_access_token_id" on "oauth_server_refresh_token" ("oauth_server_access_token_id");
CREATE INDEX "oauth_server_refresh_token_idx_oauth_server_authorization_grant_id" on "oauth_server_refresh_token" ("oauth_server_authorization_grant_id");

;
--
-- Table: subscription_invoice.
--
CREATE TABLE "subscription_invoice" (
  "subs_id" integer NOT NULL,
  "invoice_id" integer NOT NULL,
  "last_update_time" timestamp with time zone DEFAULT now(),
  "last_update_id" text,
  PRIMARY KEY ("subs_id"),
  CONSTRAINT "subscription_invoice_uq_subs_id_invoice_id" UNIQUE ("subs_id", "invoice_id")
);
CREATE INDEX "subscription_invoice_idx_invoice_id" on "subscription_invoice" ("invoice_id");

;
--
-- Table: invoice_payment.
--
CREATE TABLE "invoice_payment" (
  "invoice_payment_id" serial NOT NULL,
  "amount" numeric(9,2) NOT NULL,
  "payment_date" date NOT NULL,
  "last_update_time" timestamp with time zone DEFAULT now(),
  "last_update_id" text,
  "invoice_id" integer NOT NULL,
  "payment_reference" text,
  "invoice_payment_type_id" integer NOT NULL,
  "subs_id" integer,
  PRIMARY KEY ("invoice_payment_id")
);
CREATE INDEX "invoice_payment_idx_invoice_id" on "invoice_payment" ("invoice_id");
CREATE INDEX "invoice_payment_idx_invoice_payment_type_id" on "invoice_payment" ("invoice_payment_type_id");
CREATE INDEX "invoice_payment_idx_subs_id" on "invoice_payment" ("subs_id");

;
--
-- View: "consortium"
--
CREATE VIEW "consortium" ( "parent_acc_id", "member_acc_id", "organisation" ) AS
    SELECT DISTINCT ac.acc_id AS parent_acc_id, ac2.acc_id AS member_acc_id, ac2.organisation
       FROM account ac
          JOIN subscription s ON s.acc_id = ac.acc_id
          JOIN subscription s2 ON s.subs_id = s2.group_subs_id
          JOIN account ac2 ON ac2.acc_id = s2.acc_id;
;

;
--
-- View: "session_credentials_view"
--
CREATE VIEW "session_credentials_view" ( "abuse_reason", "client_id", "client_session_id", "clientdata", "last_update_id", "session_id", "shared_session", "user_agent", "acc_id", "last_access_time", "last_update_time", "start_time", "site_id", "credential_userpass_id", "credential_libcard_id", "credential_ip_id", "credential_referrer_id", "credential_shibboleth_id", "credential_oauth_id" ) AS
    SELECT s.abuse_reason, s.client_id, s.client_session_id, s.clientdata, s.last_update_id, s.session_id, s.shared_session, s.user_agent, s.acc_id, s.last_access_time, s.last_update_time, s.start_time, s.site_id, userpass.credential_userpass_id, libcard.credential_libcard_id, ip.credential_ip_id, referrer.credential_referrer_id, shibboleth.credential_shibboleth_id, oauth.credential_oauth_id
        FROM session s
            LEFT JOIN session_credential_userpass userpass ON userpass.session_id = s.session_id
            LEFT JOIN session_credential_libcard libcard ON libcard.session_id = s.session_id
            LEFT JOIN session_credential_ip ip ON ip.session_id = s.session_id
            LEFT JOIN session_credential_referrer referrer ON referrer.session_id = s.session_id
            LEFT JOIN session_credential_shibboleth shibboleth ON shibboleth.session_id = s.session_id
            LEFT JOIN session_credential_oauth oauth ON oauth.session_id = s.session_id;
;

;
--
-- View: "session_summary"
--
CREATE VIEW "session_summary" ( "client_id", "count" ) AS
    SELECT session.client_id, count(*) AS count
        FROM session
            GROUP BY session.client_id;
;

;
--
-- View: "subscription_content_unit"
--
CREATE VIEW "subscription_content_unit" ( "subs_id", "acc_id", "pe_id", "content_unit_id", "name", "publication_date", "price", "date_added", "last_update_time", "last_update_id", "content_unit_type_id" ) AS
    SELECT s.subs_id, s.acc_id, pe.pe_id, cu.content_unit_id, cu.name, cu.publication_date, cu.price, cu.date_added, cu.last_update_time, cu.last_update_id, cu.content_unit_type_id
        FROM subscription s
            JOIN product_edition pe ON s.pe_id = pe.pe_id
            JOIN product_content pc ON pe.pe_id = pc.pe_id
            JOIN content_unit cu ON pc.content_unit_id = cu.content_unit_id;
;

;
--
-- View: "subscription_product_edition"
--
CREATE VIEW "subscription_product_edition" ( "subs_id", "acc_id", "immediate_access", "last_update_id", "license_url", "notify", "pe_id", "pe_name", "product_url", "last_update_time", "site_id", "product_type_id", "allow_ip_default", "allow_userpass_default", "deny_groups_default", "allow_referrer_default", "allow_libcard_default", "require_libcode_default", "isbn", "is_inheritable_default", "description", "image_filename", "notes" ) AS
    SELECT s.subs_id, s.acc_id, pe.immediate_access, pe.last_update_id, pe.license_url, pe.notify, pe.pe_id, pe.pe_name, pe.product_url, pe.last_update_time, pe.site_id, pe.product_type_id, pe.allow_ip_default, pe.allow_userpass_default, pe.deny_groups_default, pe.allow_referrer_default, pe.allow_libcard_default, pe.require_libcode_default, pe.isbn, pe.is_inheritable_default, pe.description, pe.image_filename, pe.notes
        FROM subscription s
            JOIN product_edition pe ON s.pe_id = pe.pe_id;
;

;
--
-- Foreign Key Definitions
--

;
ALTER TABLE "account" ADD CONSTRAINT "account_fk_account_type_id" FOREIGN KEY ("account_type_id")
  REFERENCES "account_type" ("account_type_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "account" ADD CONSTRAINT "account_fk_contact_country_id" FOREIGN KEY ("contact_country_id")
  REFERENCES "country" ("country_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "account" ADD CONSTRAINT "account_fk_group_acc_id" FOREIGN KEY ("group_acc_id")
  REFERENCES "account" ("acc_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "account" ADD CONSTRAINT "account_fk_maintainer" FOREIGN KEY ("maintainer")
  REFERENCES "group_name" ("group_name_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "account" ADD CONSTRAINT "account_fk_org_size_id" FOREIGN KEY ("org_size_id")
  REFERENCES "org_size" ("org_size_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "account" ADD CONSTRAINT "account_fk_parent_acc_id" FOREIGN KEY ("parent_acc_id")
  REFERENCES "account" ("acc_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "account_attribute" ADD CONSTRAINT "account_attribute_fk_account_attribute_group_id" FOREIGN KEY ("account_attribute_group_id")
  REFERENCES "account_attribute_group" ("account_attribute_group_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "account_attribute_group" ADD CONSTRAINT "account_attribute_group_fk_acc_id" FOREIGN KEY ("acc_id")
  REFERENCES "account" ("acc_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "account_preference" ADD CONSTRAINT "account_preference_fk_acc_id" FOREIGN KEY ("acc_id")
  REFERENCES "account" ("acc_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "credential_ip" ADD CONSTRAINT "credential_ip_fk_acc_id" FOREIGN KEY ("acc_id")
  REFERENCES "account" ("acc_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "credential_libcard" ADD CONSTRAINT "credential_libcard_fk_acc_id" FOREIGN KEY ("acc_id")
  REFERENCES "account" ("acc_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "credential_referrer" ADD CONSTRAINT "credential_referrer_fk_acc_id" FOREIGN KEY ("acc_id")
  REFERENCES "account" ("acc_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "credential_shibboleth" ADD CONSTRAINT "credential_shibboleth_fk_acc_id" FOREIGN KEY ("acc_id")
  REFERENCES "account" ("acc_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "credential_userpass" ADD CONSTRAINT "credential_userpass_fk_acc_id" FOREIGN KEY ("acc_id")
  REFERENCES "account" ("acc_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "credential_userpass_reset" ADD CONSTRAINT "credential_userpass_reset_fk_acc_id" FOREIGN KEY ("acc_id")
  REFERENCES "account" ("acc_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "credential_userpass_reset" ADD CONSTRAINT "credential_userpass_reset_fk_subs_id" FOREIGN KEY ("subs_id")
  REFERENCES "subscription" ("subs_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "ecommerce_transaction" ADD CONSTRAINT "ecommerce_transaction_fk_acc_id" FOREIGN KEY ("acc_id")
  REFERENCES "account" ("acc_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "ecommerce_transaction" ADD CONSTRAINT "ecommerce_transaction_fk_ecommerce_transaction_status_id" FOREIGN KEY ("ecommerce_transaction_status_id")
  REFERENCES "ecommerce_transaction_status" ("ecommerce_transaction_status_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "group_member" ADD CONSTRAINT "group_member_fk_credential_userpass_id" FOREIGN KEY ("credential_userpass_id")
  REFERENCES "credential_userpass" ("credential_userpass_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "group_member" ADD CONSTRAINT "group_member_fk_group_name_id" FOREIGN KEY ("group_name_id")
  REFERENCES "group_name" ("group_name_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "named_user" ADD CONSTRAINT "named_user_fk_acc_id" FOREIGN KEY ("acc_id")
  REFERENCES "account" ("acc_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "named_user" ADD CONSTRAINT "named_user_fk_subs_id" FOREIGN KEY ("subs_id")
  REFERENCES "subscription" ("subs_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "named_user_config" ADD CONSTRAINT "named_user_config_fk_subs_id" FOREIGN KEY ("subs_id")
  REFERENCES "subscription" ("subs_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "platform_content" ADD CONSTRAINT "platform_content_fk_content_unit_id" FOREIGN KEY ("content_unit_id")
  REFERENCES "content_unit" ("content_unit_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "product_content" ADD CONSTRAINT "product_content_fk_content_unit_id" FOREIGN KEY ("content_unit_id")
  REFERENCES "content_unit" ("content_unit_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "product_content" ADD CONSTRAINT "product_content_fk_pe_id" FOREIGN KEY ("pe_id")
  REFERENCES "product_edition" ("pe_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "product_edition" ADD CONSTRAINT "product_edition_fk_site_id" FOREIGN KEY ("site_id")
  REFERENCES "site" ("site_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "product_edition_sku" ADD CONSTRAINT "product_edition_sku_fk_pe_id" FOREIGN KEY ("pe_id")
  REFERENCES "product_edition" ("pe_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "product_edition_sku" ADD CONSTRAINT "product_edition_sku_fk_subs_duration_id" FOREIGN KEY ("subs_duration_id")
  REFERENCES "subs_duration" ("subs_duration_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "product_edition_sku_purchase_price" ADD CONSTRAINT "product_edition_sku_purchase_price_fk_currency_id" FOREIGN KEY ("currency_id")
  REFERENCES "currency" ("currency_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "product_edition_sku_purchase_price" ADD CONSTRAINT "product_edition_sku_purchase_price_fk_product_edition_sku_id" FOREIGN KEY ("product_edition_sku_id")
  REFERENCES "product_edition_sku" ("product_edition_sku_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "product_preference" ADD CONSTRAINT "product_preference_fk_pe_id" FOREIGN KEY ("pe_id")
  REFERENCES "product_edition" ("pe_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "saved_report_args" ADD CONSTRAINT "saved_report_args_fk_saved_report_id" FOREIGN KEY ("saved_report_id")
  REFERENCES "saved_report" ("saved_report_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "saved_report_schedule" ADD CONSTRAINT "saved_report_schedule_fk_saved_report_id" FOREIGN KEY ("saved_report_id")
  REFERENCES "saved_report" ("saved_report_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "session" ADD CONSTRAINT "session_fk_acc_id" FOREIGN KEY ("acc_id")
  REFERENCES "account" ("acc_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "session" ADD CONSTRAINT "session_fk_site_id" FOREIGN KEY ("site_id")
  REFERENCES "site" ("site_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "session_credential_ip" ADD CONSTRAINT "session_credential_ip_fk_acc_id" FOREIGN KEY ("acc_id")
  REFERENCES "account" ("acc_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "session_credential_ip" ADD CONSTRAINT "session_credential_ip_fk_session_id" FOREIGN KEY ("session_id")
  REFERENCES "session" ("session_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "session_credential_libcard" ADD CONSTRAINT "session_credential_libcard_fk_acc_id" FOREIGN KEY ("acc_id")
  REFERENCES "account" ("acc_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "session_credential_libcard" ADD CONSTRAINT "session_credential_libcard_fk_session_id" FOREIGN KEY ("session_id")
  REFERENCES "session" ("session_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "session_credential_oauth" ADD CONSTRAINT "session_credential_oauth_fk_acc_id" FOREIGN KEY ("acc_id")
  REFERENCES "account" ("acc_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "session_credential_oauth" ADD CONSTRAINT "session_credential_oauth_fk_session_id" FOREIGN KEY ("session_id")
  REFERENCES "session" ("session_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "session_credential_referrer" ADD CONSTRAINT "session_credential_referrer_fk_acc_id" FOREIGN KEY ("acc_id")
  REFERENCES "account" ("acc_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "session_credential_referrer" ADD CONSTRAINT "session_credential_referrer_fk_session_id" FOREIGN KEY ("session_id")
  REFERENCES "session" ("session_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "session_credential_shibboleth" ADD CONSTRAINT "session_credential_shibboleth_fk_acc_id" FOREIGN KEY ("acc_id")
  REFERENCES "account" ("acc_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "session_credential_shibboleth" ADD CONSTRAINT "session_credential_shibboleth_fk_session_id" FOREIGN KEY ("session_id")
  REFERENCES "session" ("session_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "session_credential_userpass" ADD CONSTRAINT "session_credential_userpass_fk_acc_id" FOREIGN KEY ("acc_id")
  REFERENCES "account" ("acc_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "session_credential_userpass" ADD CONSTRAINT "session_credential_userpass_fk_session_id" FOREIGN KEY ("session_id")
  REFERENCES "session" ("session_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "site" ADD CONSTRAINT "site_fk_platform_id" FOREIGN KEY ("platform_id")
  REFERENCES "platform" ("platform_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "site_preference" ADD CONSTRAINT "site_preference_fk_site_id" FOREIGN KEY ("site_id")
  REFERENCES "site" ("site_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "subscription" ADD CONSTRAINT "subscription_fk_acc_id" FOREIGN KEY ("acc_id")
  REFERENCES "account" ("acc_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "subscription" ADD CONSTRAINT "subscription_fk_contact_acc_id" FOREIGN KEY ("contact_acc_id")
  REFERENCES "account" ("acc_id") ON DELETE SET NULL ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "subscription" ADD CONSTRAINT "subscription_fk_country_id" FOREIGN KEY ("country_id")
  REFERENCES "country" ("country_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "subscription" ADD CONSTRAINT "subscription_fk_group_subs_id" FOREIGN KEY ("group_subs_id")
  REFERENCES "subscription" ("subs_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "subscription" ADD CONSTRAINT "subscription_fk_pe_id" FOREIGN KEY ("pe_id")
  REFERENCES "product_edition" ("pe_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "subscription" ADD CONSTRAINT "subscription_fk_publication_medium_id" FOREIGN KEY ("publication_medium_id")
  REFERENCES "publication_medium" ("publication_medium_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "subscription" ADD CONSTRAINT "subscription_fk_subscription_type_id" FOREIGN KEY ("subscription_type_id")
  REFERENCES "subscription_type" ("subscription_type_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "subscription_attribute" ADD CONSTRAINT "subscription_attribute_fk_subscription_attribute_group_id" FOREIGN KEY ("subscription_attribute_group_id")
  REFERENCES "subscription_attribute_group" ("subscription_attribute_group_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "subscription_attribute_group" ADD CONSTRAINT "subscription_attribute_group_fk_subs_id" FOREIGN KEY ("subs_id")
  REFERENCES "subscription" ("subs_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "subscription_ip" ADD CONSTRAINT "subscription_ip_fk_subs_id" FOREIGN KEY ("subs_id")
  REFERENCES "subscription" ("subs_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "subscription_preference" ADD CONSTRAINT "subscription_preference_fk_subs_id" FOREIGN KEY ("subs_id")
  REFERENCES "subscription" ("subs_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "subscription_token" ADD CONSTRAINT "subscription_token_fk_batch" FOREIGN KEY ("batch")
  REFERENCES "subscription_token_batch" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "subscription_token" ADD CONSTRAINT "subscription_token_fk_pe_id" FOREIGN KEY ("pe_id")
  REFERENCES "product_edition" ("pe_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "subscription_token" ADD CONSTRAINT "subscription_token_fk_subs_duration_id" FOREIGN KEY ("subs_duration_id")
  REFERENCES "subs_duration" ("subs_duration_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "subscription_token" ADD CONSTRAINT "subscription_token_fk_subscription_type_id" FOREIGN KEY ("subscription_type_id")
  REFERENCES "subscription_type" ("subscription_type_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "subscription_token_subscription" ADD CONSTRAINT "subscription_token_subscription_fk_subscription_id" FOREIGN KEY ("subscription_id")
  REFERENCES "subscription" ("subs_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "subscription_token_subscription" ADD CONSTRAINT "subscription_token_subscription_fk_subscription_token_id" FOREIGN KEY ("subscription_token_id")
  REFERENCES "subscription_token" ("subscription_token_id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE;

;
ALTER TABLE "content_unit" ADD CONSTRAINT "content_unit_fk_content_unit_type_id" FOREIGN KEY ("content_unit_type_id")
  REFERENCES "content_unit_type" ("content_unit_type_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

;
ALTER TABLE "oauth_server_authorization_grant" ADD CONSTRAINT "oauth_server_authorization_grant_fk_oauth_server_client_id" FOREIGN KEY ("oauth_server_client_id")
  REFERENCES "oauth_server_client" ("oauth_server_client_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

;
ALTER TABLE "subscription_token_batch_subscription_preference" ADD CONSTRAINT "subscription_token_batch_subscription_preference_fk_subscription_token_batch_id" FOREIGN KEY ("subscription_token_batch_id")
  REFERENCES "subscription_token_batch" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

;
ALTER TABLE "credential_oauth" ADD CONSTRAINT "credential_oauth_fk_acc_id" FOREIGN KEY ("acc_id")
  REFERENCES "account" ("acc_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

;
ALTER TABLE "credential_oauth" ADD CONSTRAINT "credential_oauth_fk_oauth_client_server_id" FOREIGN KEY ("oauth_client_server_id")
  REFERENCES "oauth_client_server" ("oauth_client_server_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

;
ALTER TABLE "oauth_server_permission" ADD CONSTRAINT "oauth_server_permission_fk_acc_id" FOREIGN KEY ("acc_id")
  REFERENCES "account" ("acc_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

;
ALTER TABLE "oauth_server_permission" ADD CONSTRAINT "oauth_server_permission_fk_oauth_server_client_id" FOREIGN KEY ("oauth_server_client_id")
  REFERENCES "oauth_server_client" ("oauth_server_client_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

;
ALTER TABLE "invoice" ADD CONSTRAINT "invoice_fk_acc_id" FOREIGN KEY ("acc_id")
  REFERENCES "account" ("acc_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

;
ALTER TABLE "invoice" ADD CONSTRAINT "invoice_fk_contact_country_id" FOREIGN KEY ("contact_country_id")
  REFERENCES "country" ("country_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

;
ALTER TABLE "invoice" ADD CONSTRAINT "invoice_fk_currency_id" FOREIGN KEY ("currency_id")
  REFERENCES "currency" ("currency_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

;
ALTER TABLE "oauth_server_access_token" ADD CONSTRAINT "oauth_server_access_token_fk_acc_id" FOREIGN KEY ("acc_id")
  REFERENCES "account" ("acc_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

;
ALTER TABLE "oauth_server_access_token" ADD CONSTRAINT "oauth_server_access_token_fk_oauth_server_authorization_grant_id" FOREIGN KEY ("oauth_server_authorization_grant_id")
  REFERENCES "oauth_server_authorization_grant" ("oauth_server_authorization_grant_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

;
ALTER TABLE "invoice_line_item" ADD CONSTRAINT "invoice_line_item_fk_invoice_id" FOREIGN KEY ("invoice_id")
  REFERENCES "invoice" ("invoice_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

;
ALTER TABLE "oauth_server_refresh_token" ADD CONSTRAINT "oauth_server_refresh_token_fk_oauth_server_access_token_id" FOREIGN KEY ("oauth_server_access_token_id")
  REFERENCES "oauth_server_access_token" ("oauth_server_access_token_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

;
ALTER TABLE "oauth_server_refresh_token" ADD CONSTRAINT "oauth_server_refresh_token_fk_oauth_server_authorization_grant_id" FOREIGN KEY ("oauth_server_authorization_grant_id")
  REFERENCES "oauth_server_authorization_grant" ("oauth_server_authorization_grant_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

;
ALTER TABLE "subscription_invoice" ADD CONSTRAINT "subscription_invoice_fk_invoice_id" FOREIGN KEY ("invoice_id")
  REFERENCES "invoice" ("invoice_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

;
ALTER TABLE "subscription_invoice" ADD CONSTRAINT "subscription_invoice_fk_subs_id" FOREIGN KEY ("subs_id")
  REFERENCES "subscription" ("subs_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

;
ALTER TABLE "invoice_payment" ADD CONSTRAINT "invoice_payment_fk_invoice_id" FOREIGN KEY ("invoice_id")
  REFERENCES "invoice" ("invoice_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

;
ALTER TABLE "invoice_payment" ADD CONSTRAINT "invoice_payment_fk_invoice_payment_type_id" FOREIGN KEY ("invoice_payment_type_id")
  REFERENCES "invoice_payment_type" ("invoice_payment_type_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

;
ALTER TABLE "invoice_payment" ADD CONSTRAINT "invoice_payment_fk_subs_id" FOREIGN KEY ("subs_id")
  REFERENCES "subscription" ("subs_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

;
