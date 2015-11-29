--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: accounts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE accounts (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE accounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE accounts_id_seq OWNED BY accounts.id;


--
-- Name: admins; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE admins (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    failed_attempts integer DEFAULT 0 NOT NULL,
    locked_at timestamp without time zone,
    role character varying(255),
    account_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: admins_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE admins_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE admins_id_seq OWNED BY admins.id;


--
-- Name: admins_notifiable_apps; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE admins_notifiable_apps (
    id integer NOT NULL,
    admin_id integer,
    app_id integer
);


--
-- Name: admins_notifiable_apps_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE admins_notifiable_apps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admins_notifiable_apps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE admins_notifiable_apps_id_seq OWNED BY admins_notifiable_apps.id;


--
-- Name: delayed_jobs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE delayed_jobs (
    id integer NOT NULL,
    priority integer DEFAULT 0 NOT NULL,
    attempts integer DEFAULT 0 NOT NULL,
    handler text NOT NULL,
    last_error text,
    run_at timestamp without time zone,
    locked_at timestamp without time zone,
    failed_at timestamp without time zone,
    locked_by character varying(255),
    queue character varying(255),
    notification_id integer,
    app_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: delayed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE delayed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: delayed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE delayed_jobs_id_seq OWNED BY delayed_jobs.id;


--
-- Name: notifiable_apps; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE notifiable_apps (
    id integer NOT NULL,
    name character varying(255),
    configuration text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    account_id integer,
    access_id character varying(255),
    secret_key character varying(255)
);


--
-- Name: notifiable_apps_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE notifiable_apps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notifiable_apps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE notifiable_apps_id_seq OWNED BY notifiable_apps.id;


--
-- Name: notifiable_apps_notifications_api_users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE notifiable_apps_notifications_api_users (
    id integer NOT NULL,
    app_id integer,
    notifications_api_user_id integer
);


--
-- Name: notifiable_apps_notifications_api_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE notifiable_apps_notifications_api_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notifiable_apps_notifications_api_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE notifiable_apps_notifications_api_users_id_seq OWNED BY notifiable_apps_notifications_api_users.id;


--
-- Name: notifiable_device_tokens; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE notifiable_device_tokens (
    id integer NOT NULL,
    token character varying(255),
    provider character varying(255),
    locale character varying(255),
    is_valid boolean DEFAULT true,
    user_id integer,
    app_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    name character varying(255),
    custom_properties hstore
);


--
-- Name: notifiable_device_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE notifiable_device_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notifiable_device_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE notifiable_device_tokens_id_seq OWNED BY notifiable_device_tokens.id;


--
-- Name: notifiable_localized_notifications; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE notifiable_localized_notifications (
    id integer NOT NULL,
    message text,
    params text,
    locale character varying(255),
    notification_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: notifiable_localized_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE notifiable_localized_notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notifiable_localized_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE notifiable_localized_notifications_id_seq OWNED BY notifiable_localized_notifications.id;


--
-- Name: notifiable_notifications; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE notifiable_notifications (
    id integer NOT NULL,
    app_id integer,
    sent_count integer DEFAULT 0,
    gateway_accepted_count integer DEFAULT 0,
    opened_count integer DEFAULT 0,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: notifiable_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE notifiable_notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notifiable_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE notifiable_notifications_id_seq OWNED BY notifiable_notifications.id;


--
-- Name: notifiable_statuses; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE notifiable_statuses (
    id integer NOT NULL,
    localized_notification_id integer,
    device_token_id integer,
    status integer,
    created_at timestamp without time zone
);


--
-- Name: notifiable_statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE notifiable_statuses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notifiable_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE notifiable_statuses_id_seq OWNED BY notifiable_statuses.id;


--
-- Name: notifications_api_users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE notifications_api_users (
    id integer NOT NULL,
    service_name character varying(255) DEFAULT ''::character varying NOT NULL,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    failed_attempts integer DEFAULT 0 NOT NULL,
    locked_at timestamp without time zone,
    access_id character varying(255),
    secret_key character varying(255),
    account_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: notifications_api_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE notifications_api_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notifications_api_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE notifications_api_users_id_seq OWNED BY notifications_api_users.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    alias character varying(255) NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY accounts ALTER COLUMN id SET DEFAULT nextval('accounts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY admins ALTER COLUMN id SET DEFAULT nextval('admins_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY admins_notifiable_apps ALTER COLUMN id SET DEFAULT nextval('admins_notifiable_apps_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY delayed_jobs ALTER COLUMN id SET DEFAULT nextval('delayed_jobs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY notifiable_apps ALTER COLUMN id SET DEFAULT nextval('notifiable_apps_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY notifiable_apps_notifications_api_users ALTER COLUMN id SET DEFAULT nextval('notifiable_apps_notifications_api_users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY notifiable_device_tokens ALTER COLUMN id SET DEFAULT nextval('notifiable_device_tokens_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY notifiable_localized_notifications ALTER COLUMN id SET DEFAULT nextval('notifiable_localized_notifications_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY notifiable_notifications ALTER COLUMN id SET DEFAULT nextval('notifiable_notifications_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY notifiable_statuses ALTER COLUMN id SET DEFAULT nextval('notifiable_statuses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY notifications_api_users ALTER COLUMN id SET DEFAULT nextval('notifications_api_users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (id);


--
-- Name: admins_notifiable_apps_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY admins_notifiable_apps
    ADD CONSTRAINT admins_notifiable_apps_pkey PRIMARY KEY (id);


--
-- Name: admins_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY admins
    ADD CONSTRAINT admins_pkey PRIMARY KEY (id);


--
-- Name: delayed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY delayed_jobs
    ADD CONSTRAINT delayed_jobs_pkey PRIMARY KEY (id);


--
-- Name: notifiable_apps_notifications_api_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY notifiable_apps_notifications_api_users
    ADD CONSTRAINT notifiable_apps_notifications_api_users_pkey PRIMARY KEY (id);


--
-- Name: notifiable_apps_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY notifiable_apps
    ADD CONSTRAINT notifiable_apps_pkey PRIMARY KEY (id);


--
-- Name: notifiable_device_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY notifiable_device_tokens
    ADD CONSTRAINT notifiable_device_tokens_pkey PRIMARY KEY (id);


--
-- Name: notifiable_localized_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY notifiable_localized_notifications
    ADD CONSTRAINT notifiable_localized_notifications_pkey PRIMARY KEY (id);


--
-- Name: notifiable_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY notifiable_notifications
    ADD CONSTRAINT notifiable_notifications_pkey PRIMARY KEY (id);


--
-- Name: notifiable_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY notifiable_statuses
    ADD CONSTRAINT notifiable_statuses_pkey PRIMARY KEY (id);


--
-- Name: notifications_api_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY notifications_api_users
    ADD CONSTRAINT notifications_api_users_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: delayed_jobs_priority; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX delayed_jobs_priority ON delayed_jobs USING btree (priority, run_at);


--
-- Name: index_admins_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_admins_on_email ON admins USING btree (email);


--
-- Name: index_admins_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_admins_on_reset_password_token ON admins USING btree (reset_password_token);


--
-- Name: index_notifiable_device_tokens_on_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_notifiable_device_tokens_on_token ON notifiable_device_tokens USING btree (token);


--
-- Name: index_notifiable_device_tokens_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_notifiable_device_tokens_on_user_id ON notifiable_device_tokens USING btree (user_id);


--
-- Name: index_notifications_api_users_on_access_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_notifications_api_users_on_access_id ON notifications_api_users USING btree (access_id);


--
-- Name: index_notifications_api_users_on_secret_key; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_notifications_api_users_on_secret_key ON notifications_api_users USING btree (secret_key);


--
-- Name: index_users_on_alias; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_alias ON users USING btree (alias);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

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

INSERT INTO schema_migrations (version) VALUES ('20150622164049');

INSERT INTO schema_migrations (version) VALUES ('20150622164050');

INSERT INTO schema_migrations (version) VALUES ('20150622164051');

