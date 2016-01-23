CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
CREATE TABLE "notifiable_apps" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "configuration" text, "created_at" datetime, "updated_at" datetime, "account_id" integer);
CREATE TABLE "notifiable_device_tokens" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "token" varchar(255), "provider" varchar(255), "locale" varchar(255), "is_valid" boolean DEFAULT 't', "user_id" integer, "app_id" integer, "created_at" datetime, "updated_at" datetime, "name" varchar(255), "custom_properties" varchar(255));
CREATE UNIQUE INDEX "index_notifiable_device_tokens_on_token" ON "notifiable_device_tokens" ("token");
CREATE INDEX "index_notifiable_device_tokens_on_user_id" ON "notifiable_device_tokens" ("user_id");
CREATE TABLE "notifiable_notifications" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "app_id" integer, "sent_count" integer DEFAULT 0, "gateway_accepted_count" integer DEFAULT 0, "opened_count" integer DEFAULT 0, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "notifiable_localized_notifications" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "message" text, "params" text, "locale" varchar(255), "notification_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "notifiable_statuses" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "localized_notification_id" integer, "device_token_id" integer, "status" integer, "created_at" datetime);
CREATE TABLE "accounts" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "admins" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "email" varchar(255) DEFAULT '' NOT NULL, "encrypted_password" varchar(255) DEFAULT '' NOT NULL, "reset_password_token" varchar(255), "reset_password_sent_at" datetime, "remember_created_at" datetime, "sign_in_count" integer DEFAULT 0 NOT NULL, "current_sign_in_at" datetime, "last_sign_in_at" datetime, "current_sign_in_ip" varchar(255), "last_sign_in_ip" varchar(255), "failed_attempts" integer DEFAULT 0 NOT NULL, "locked_at" datetime, "role" varchar(255), "account_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE UNIQUE INDEX "index_admins_on_email" ON "admins" ("email");
CREATE UNIQUE INDEX "index_admins_on_reset_password_token" ON "admins" ("reset_password_token");
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "alias" varchar(255) NOT NULL);
CREATE UNIQUE INDEX "index_users_on_alias" ON "users" ("alias");
CREATE TABLE "notifications_api_users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "service_name" varchar(255) DEFAULT '' NOT NULL, "access_id" varchar(255), "secret_key" varchar(255), "account_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE UNIQUE INDEX "index_notifications_api_users_on_access_id" ON "notifications_api_users" ("access_id");
CREATE UNIQUE INDEX "index_notifications_api_users_on_secret_key" ON "notifications_api_users" ("secret_key");
CREATE TABLE "delayed_jobs" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "priority" integer DEFAULT 0 NOT NULL, "attempts" integer DEFAULT 0 NOT NULL, "handler" text NOT NULL, "last_error" text, "run_at" datetime, "locked_at" datetime, "failed_at" datetime, "locked_by" varchar(255), "queue" varchar(255), "notification_id" integer, "app_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE INDEX "delayed_jobs_priority" ON "delayed_jobs" ("priority", "run_at");
CREATE TABLE "notifiable_apps_notifications_api_users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "app_id" integer, "notifications_api_user_id" integer);
CREATE TABLE "admins_notifiable_apps" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "admin_id" integer, "app_id" integer);
CREATE TABLE "user_api_users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "service_name" varchar(255) DEFAULT '' NOT NULL, "access_id" varchar(255), "secret_key" varchar(255), "app_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE UNIQUE INDEX "index_user_api_users_on_access_id" ON "user_api_users" ("access_id");
CREATE UNIQUE INDEX "index_user_api_users_on_secret_key" ON "user_api_users" ("secret_key");
INSERT INTO schema_migrations (version) VALUES ('20131210115648');

INSERT INTO schema_migrations (version) VALUES ('20131210115649');

INSERT INTO schema_migrations (version) VALUES ('20131210115650');

INSERT INTO schema_migrations (version) VALUES ('20131210115651');

INSERT INTO schema_migrations (version) VALUES ('20131210115652');

INSERT INTO schema_migrations (version) VALUES ('20131210115653');

INSERT INTO schema_migrations (version) VALUES ('20131227155314');

INSERT INTO schema_migrations (version) VALUES ('20131227155315');

INSERT INTO schema_migrations (version) VALUES ('20131228011613');

INSERT INTO schema_migrations (version) VALUES ('20140106200109');

INSERT INTO schema_migrations (version) VALUES ('20140131164915');

INSERT INTO schema_migrations (version) VALUES ('20140304223526');

INSERT INTO schema_migrations (version) VALUES ('20140304223527');

INSERT INTO schema_migrations (version) VALUES ('20150221010358');

INSERT INTO schema_migrations (version) VALUES ('20150622164050');

INSERT INTO schema_migrations (version) VALUES ('20150622164051');

INSERT INTO schema_migrations (version) VALUES ('20150622164052');

