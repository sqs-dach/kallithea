--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

-- CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'md55680c213885903959e054c9111613ddf';






--
-- Database creation
--

REVOKE ALL ON DATABASE template1 FROM PUBLIC;
REVOKE ALL ON DATABASE template1 FROM postgres;
GRANT ALL ON DATABASE template1 TO postgres;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


\connect postgres

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.2
-- Dumped by pg_dump version 9.5.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: cache_invalidation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE cache_invalidation (
    cache_id integer NOT NULL,
    cache_key character varying(255),
    cache_args character varying(255),
    cache_active boolean
);


ALTER TABLE cache_invalidation OWNER TO postgres;

--
-- Name: cache_invalidation_cache_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cache_invalidation_cache_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cache_invalidation_cache_id_seq OWNER TO postgres;

--
-- Name: cache_invalidation_cache_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE cache_invalidation_cache_id_seq OWNED BY cache_invalidation.cache_id;


--
-- Name: changeset_comments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE changeset_comments (
    comment_id integer NOT NULL,
    repo_id integer NOT NULL,
    revision character varying(40),
    pull_request_id integer,
    line_no character varying(10),
    f_path character varying(1000),
    user_id integer NOT NULL,
    text text NOT NULL,
    created_on timestamp without time zone NOT NULL,
    modified_at timestamp without time zone NOT NULL
);


ALTER TABLE changeset_comments OWNER TO postgres;

--
-- Name: changeset_comments_comment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE changeset_comments_comment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE changeset_comments_comment_id_seq OWNER TO postgres;

--
-- Name: changeset_comments_comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE changeset_comments_comment_id_seq OWNED BY changeset_comments.comment_id;


--
-- Name: changeset_statuses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE changeset_statuses (
    changeset_status_id integer NOT NULL,
    repo_id integer NOT NULL,
    user_id integer NOT NULL,
    revision character varying(40) NOT NULL,
    status character varying(128) NOT NULL,
    changeset_comment_id integer NOT NULL,
    modified_at timestamp without time zone NOT NULL,
    version integer NOT NULL,
    pull_request_id integer
);


ALTER TABLE changeset_statuses OWNER TO postgres;

--
-- Name: changeset_statuses_changeset_status_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE changeset_statuses_changeset_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE changeset_statuses_changeset_status_id_seq OWNER TO postgres;

--
-- Name: changeset_statuses_changeset_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE changeset_statuses_changeset_status_id_seq OWNED BY changeset_statuses.changeset_status_id;


--
-- Name: db_migrate_version; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE db_migrate_version (
    repository_id character varying(250) NOT NULL,
    repository_path text,
    version integer
);


ALTER TABLE db_migrate_version OWNER TO postgres;

--
-- Name: gists; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE gists (
    gist_id integer NOT NULL,
    gist_access_id character varying(250),
    gist_description text,
    user_id integer,
    gist_expires double precision NOT NULL,
    gist_type character varying(128) NOT NULL,
    created_on timestamp without time zone NOT NULL,
    modified_at timestamp without time zone NOT NULL
);


ALTER TABLE gists OWNER TO postgres;

--
-- Name: gists_gist_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE gists_gist_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE gists_gist_id_seq OWNER TO postgres;

--
-- Name: gists_gist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE gists_gist_id_seq OWNED BY gists.gist_id;


--
-- Name: groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE groups (
    group_id integer NOT NULL,
    group_name character varying(255) NOT NULL,
    group_parent_id integer,
    group_description character varying(10000),
    enable_locking boolean NOT NULL,
    user_id integer NOT NULL,
    created_on timestamp without time zone NOT NULL,
    CONSTRAINT groups_check CHECK ((group_id <> group_parent_id))
);


ALTER TABLE groups OWNER TO postgres;

--
-- Name: groups_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE groups_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE groups_group_id_seq OWNER TO postgres;

--
-- Name: groups_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE groups_group_id_seq OWNED BY groups.group_id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE notifications (
    notification_id integer NOT NULL,
    subject character varying(512),
    body text,
    created_by integer,
    created_on timestamp without time zone NOT NULL,
    type character varying(255)
);


ALTER TABLE notifications OWNER TO postgres;

--
-- Name: notifications_notification_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE notifications_notification_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE notifications_notification_id_seq OWNER TO postgres;

--
-- Name: notifications_notification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE notifications_notification_id_seq OWNED BY notifications.notification_id;


--
-- Name: permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE permissions (
    permission_id integer NOT NULL,
    permission_name character varying(255),
    permission_longname character varying(255)
);


ALTER TABLE permissions OWNER TO postgres;

--
-- Name: permissions_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE permissions_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE permissions_permission_id_seq OWNER TO postgres;

--
-- Name: permissions_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE permissions_permission_id_seq OWNED BY permissions.permission_id;


--
-- Name: pull_request_reviewers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE pull_request_reviewers (
    pull_requests_reviewers_id integer NOT NULL,
    pull_request_id integer NOT NULL,
    user_id integer
);


ALTER TABLE pull_request_reviewers OWNER TO postgres;

--
-- Name: pull_request_reviewers_pull_requests_reviewers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE pull_request_reviewers_pull_requests_reviewers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pull_request_reviewers_pull_requests_reviewers_id_seq OWNER TO postgres;

--
-- Name: pull_request_reviewers_pull_requests_reviewers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE pull_request_reviewers_pull_requests_reviewers_id_seq OWNED BY pull_request_reviewers.pull_requests_reviewers_id;


--
-- Name: pull_requests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE pull_requests (
    pull_request_id integer NOT NULL,
    title character varying(255),
    description text,
    status character varying(255) NOT NULL,
    created_on timestamp without time zone NOT NULL,
    updated_on timestamp without time zone NOT NULL,
    user_id integer NOT NULL,
    revisions text,
    org_repo_id integer NOT NULL,
    org_ref character varying(255) NOT NULL,
    other_repo_id integer NOT NULL,
    other_ref character varying(255) NOT NULL
);


ALTER TABLE pull_requests OWNER TO postgres;

--
-- Name: pull_requests_pull_request_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE pull_requests_pull_request_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pull_requests_pull_request_id_seq OWNER TO postgres;

--
-- Name: pull_requests_pull_request_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE pull_requests_pull_request_id_seq OWNED BY pull_requests.pull_request_id;


--
-- Name: repo_to_perm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE repo_to_perm (
    repo_to_perm_id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL,
    repository_id integer NOT NULL
);


ALTER TABLE repo_to_perm OWNER TO postgres;

--
-- Name: repo_to_perm_repo_to_perm_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE repo_to_perm_repo_to_perm_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE repo_to_perm_repo_to_perm_id_seq OWNER TO postgres;

--
-- Name: repo_to_perm_repo_to_perm_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE repo_to_perm_repo_to_perm_id_seq OWNED BY repo_to_perm.repo_to_perm_id;


--
-- Name: repositories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE repositories (
    repo_id integer NOT NULL,
    repo_name character varying(255) NOT NULL,
    repo_state character varying(255),
    clone_uri character varying(255),
    repo_type character varying(255) NOT NULL,
    user_id integer NOT NULL,
    private boolean,
    statistics boolean,
    downloads boolean,
    description character varying(10000),
    created_on timestamp without time zone NOT NULL,
    updated_on timestamp without time zone NOT NULL,
    landing_revision character varying(255) NOT NULL,
    enable_locking boolean NOT NULL,
    locked character varying(255),
    changeset_cache bytea,
    fork_id integer,
    group_id integer
);


ALTER TABLE repositories OWNER TO postgres;

--
-- Name: repositories_fields; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE repositories_fields (
    repo_field_id integer NOT NULL,
    repository_id integer NOT NULL,
    field_key character varying(250),
    field_label character varying(1024) NOT NULL,
    field_value character varying(10000) NOT NULL,
    field_desc character varying(1024) NOT NULL,
    field_type character varying(255) NOT NULL,
    created_on timestamp without time zone NOT NULL
);


ALTER TABLE repositories_fields OWNER TO postgres;

--
-- Name: repositories_fields_repo_field_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE repositories_fields_repo_field_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE repositories_fields_repo_field_id_seq OWNER TO postgres;

--
-- Name: repositories_fields_repo_field_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE repositories_fields_repo_field_id_seq OWNED BY repositories_fields.repo_field_id;


--
-- Name: repositories_repo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE repositories_repo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE repositories_repo_id_seq OWNER TO postgres;

--
-- Name: repositories_repo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE repositories_repo_id_seq OWNED BY repositories.repo_id;


--
-- Name: settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE settings (
    app_settings_id integer NOT NULL,
    app_settings_name character varying(255),
    app_settings_value character varying(4096),
    app_settings_type character varying(255)
);


ALTER TABLE settings OWNER TO postgres;

--
-- Name: settings_app_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE settings_app_settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE settings_app_settings_id_seq OWNER TO postgres;

--
-- Name: settings_app_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE settings_app_settings_id_seq OWNED BY settings.app_settings_id;


--
-- Name: statistics; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE statistics (
    stat_id integer NOT NULL,
    repository_id integer NOT NULL,
    stat_on_revision integer NOT NULL,
    commit_activity bytea NOT NULL,
    commit_activity_combined bytea NOT NULL,
    languages bytea NOT NULL
);


ALTER TABLE statistics OWNER TO postgres;

--
-- Name: statistics_stat_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE statistics_stat_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE statistics_stat_id_seq OWNER TO postgres;

--
-- Name: statistics_stat_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE statistics_stat_id_seq OWNED BY statistics.stat_id;


--
-- Name: ui; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE ui (
    ui_id integer NOT NULL,
    ui_section character varying(255),
    ui_key character varying(255),
    ui_value character varying(255),
    ui_active boolean
);


ALTER TABLE ui OWNER TO postgres;

--
-- Name: ui_ui_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE ui_ui_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ui_ui_id_seq OWNER TO postgres;

--
-- Name: ui_ui_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE ui_ui_id_seq OWNED BY ui.ui_id;


--
-- Name: user_api_keys; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE user_api_keys (
    user_api_key_id integer NOT NULL,
    user_id integer,
    api_key character varying(255) NOT NULL,
    description text,
    expires double precision NOT NULL,
    created_on timestamp without time zone NOT NULL
);


ALTER TABLE user_api_keys OWNER TO postgres;

--
-- Name: user_api_keys_user_api_key_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE user_api_keys_user_api_key_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_api_keys_user_api_key_id_seq OWNER TO postgres;

--
-- Name: user_api_keys_user_api_key_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE user_api_keys_user_api_key_id_seq OWNED BY user_api_keys.user_api_key_id;


--
-- Name: user_email_map; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE user_email_map (
    email_id integer NOT NULL,
    user_id integer,
    email character varying(255)
);


ALTER TABLE user_email_map OWNER TO postgres;

--
-- Name: user_email_map_email_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE user_email_map_email_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_email_map_email_id_seq OWNER TO postgres;

--
-- Name: user_email_map_email_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE user_email_map_email_id_seq OWNED BY user_email_map.email_id;


--
-- Name: user_followings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE user_followings (
    user_following_id integer NOT NULL,
    user_id integer NOT NULL,
    follows_repository_id integer,
    follows_user_id integer,
    follows_from timestamp without time zone
);


ALTER TABLE user_followings OWNER TO postgres;

--
-- Name: user_followings_user_following_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE user_followings_user_following_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_followings_user_following_id_seq OWNER TO postgres;

--
-- Name: user_followings_user_following_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE user_followings_user_following_id_seq OWNED BY user_followings.user_following_id;


--
-- Name: user_group_user_group_to_perm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE user_group_user_group_to_perm (
    user_group_user_group_to_perm_id integer NOT NULL,
    target_user_group_id integer NOT NULL,
    permission_id integer NOT NULL,
    user_group_id integer NOT NULL,
    CONSTRAINT user_group_user_group_to_perm_check CHECK ((target_user_group_id <> user_group_id))
);


ALTER TABLE user_group_user_group_to_perm OWNER TO postgres;

--
-- Name: user_group_user_group_to_perm_user_group_user_group_to_perm_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE user_group_user_group_to_perm_user_group_user_group_to_perm_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_group_user_group_to_perm_user_group_user_group_to_perm_seq OWNER TO postgres;

--
-- Name: user_group_user_group_to_perm_user_group_user_group_to_perm_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE user_group_user_group_to_perm_user_group_user_group_to_perm_seq OWNED BY user_group_user_group_to_perm.user_group_user_group_to_perm_id;


--
-- Name: user_ip_map; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE user_ip_map (
    ip_id integer NOT NULL,
    user_id integer,
    ip_addr character varying(255),
    active boolean
);


ALTER TABLE user_ip_map OWNER TO postgres;

--
-- Name: user_ip_map_ip_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE user_ip_map_ip_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_ip_map_ip_id_seq OWNER TO postgres;

--
-- Name: user_ip_map_ip_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE user_ip_map_ip_id_seq OWNED BY user_ip_map.ip_id;


--
-- Name: user_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE user_logs (
    user_log_id integer NOT NULL,
    user_id integer,
    username character varying(255),
    repository_id integer,
    repository_name character varying(255),
    user_ip character varying(255),
    action text,
    action_date timestamp without time zone
);


ALTER TABLE user_logs OWNER TO postgres;

--
-- Name: user_logs_user_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE user_logs_user_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_logs_user_log_id_seq OWNER TO postgres;

--
-- Name: user_logs_user_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE user_logs_user_log_id_seq OWNED BY user_logs.user_log_id;


--
-- Name: user_repo_group_to_perm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE user_repo_group_to_perm (
    group_to_perm_id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE user_repo_group_to_perm OWNER TO postgres;

--
-- Name: user_repo_group_to_perm_group_to_perm_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE user_repo_group_to_perm_group_to_perm_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_repo_group_to_perm_group_to_perm_id_seq OWNER TO postgres;

--
-- Name: user_repo_group_to_perm_group_to_perm_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE user_repo_group_to_perm_group_to_perm_id_seq OWNED BY user_repo_group_to_perm.group_to_perm_id;


--
-- Name: user_to_notification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE user_to_notification (
    user_id integer NOT NULL,
    notification_id integer NOT NULL,
    read boolean,
    sent_on timestamp without time zone
);


ALTER TABLE user_to_notification OWNER TO postgres;

--
-- Name: user_to_perm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE user_to_perm (
    user_to_perm_id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE user_to_perm OWNER TO postgres;

--
-- Name: user_to_perm_user_to_perm_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE user_to_perm_user_to_perm_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_to_perm_user_to_perm_id_seq OWNER TO postgres;

--
-- Name: user_to_perm_user_to_perm_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE user_to_perm_user_to_perm_id_seq OWNED BY user_to_perm.user_to_perm_id;


--
-- Name: user_user_group_to_perm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE user_user_group_to_perm (
    user_user_group_to_perm_id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL,
    user_group_id integer NOT NULL
);


ALTER TABLE user_user_group_to_perm OWNER TO postgres;

--
-- Name: user_user_group_to_perm_user_user_group_to_perm_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE user_user_group_to_perm_user_user_group_to_perm_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_user_group_to_perm_user_user_group_to_perm_id_seq OWNER TO postgres;

--
-- Name: user_user_group_to_perm_user_user_group_to_perm_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE user_user_group_to_perm_user_user_group_to_perm_id_seq OWNED BY user_user_group_to_perm.user_user_group_to_perm_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE users (
    user_id integer NOT NULL,
    username character varying(255),
    password character varying(255),
    active boolean,
    admin boolean,
    firstname character varying(255),
    lastname character varying(255),
    email character varying(255),
    last_login timestamp without time zone,
    extern_type character varying(255),
    extern_name character varying(255),
    api_key character varying(255),
    inherit_default_permissions boolean NOT NULL,
    created_on timestamp without time zone NOT NULL,
    user_data bytea
);


ALTER TABLE users OWNER TO postgres;

--
-- Name: users_group_repo_group_to_perm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE users_group_repo_group_to_perm (
    users_group_repo_group_to_perm_id integer NOT NULL,
    users_group_id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE users_group_repo_group_to_perm OWNER TO postgres;

--
-- Name: users_group_repo_group_to_per_users_group_repo_group_to_per_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE users_group_repo_group_to_per_users_group_repo_group_to_per_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_group_repo_group_to_per_users_group_repo_group_to_per_seq OWNER TO postgres;

--
-- Name: users_group_repo_group_to_per_users_group_repo_group_to_per_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE users_group_repo_group_to_per_users_group_repo_group_to_per_seq OWNED BY users_group_repo_group_to_perm.users_group_repo_group_to_perm_id;


--
-- Name: users_group_repo_to_perm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE users_group_repo_to_perm (
    users_group_to_perm_id integer NOT NULL,
    users_group_id integer NOT NULL,
    permission_id integer NOT NULL,
    repository_id integer NOT NULL
);


ALTER TABLE users_group_repo_to_perm OWNER TO postgres;

--
-- Name: users_group_repo_to_perm_users_group_to_perm_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE users_group_repo_to_perm_users_group_to_perm_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_group_repo_to_perm_users_group_to_perm_id_seq OWNER TO postgres;

--
-- Name: users_group_repo_to_perm_users_group_to_perm_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE users_group_repo_to_perm_users_group_to_perm_id_seq OWNED BY users_group_repo_to_perm.users_group_to_perm_id;


--
-- Name: users_group_to_perm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE users_group_to_perm (
    users_group_to_perm_id integer NOT NULL,
    users_group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE users_group_to_perm OWNER TO postgres;

--
-- Name: users_group_to_perm_users_group_to_perm_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE users_group_to_perm_users_group_to_perm_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_group_to_perm_users_group_to_perm_id_seq OWNER TO postgres;

--
-- Name: users_group_to_perm_users_group_to_perm_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE users_group_to_perm_users_group_to_perm_id_seq OWNED BY users_group_to_perm.users_group_to_perm_id;


--
-- Name: users_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE users_groups (
    users_group_id integer NOT NULL,
    users_group_name character varying(255) NOT NULL,
    user_group_description character varying(10000),
    users_group_active boolean,
    users_group_inherit_default_permissions boolean NOT NULL,
    user_id integer NOT NULL,
    created_on timestamp without time zone NOT NULL,
    group_data bytea
);


ALTER TABLE users_groups OWNER TO postgres;

--
-- Name: users_groups_members; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE users_groups_members (
    users_group_member_id integer NOT NULL,
    users_group_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE users_groups_members OWNER TO postgres;

--
-- Name: users_groups_members_users_group_member_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE users_groups_members_users_group_member_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_groups_members_users_group_member_id_seq OWNER TO postgres;

--
-- Name: users_groups_members_users_group_member_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE users_groups_members_users_group_member_id_seq OWNED BY users_groups_members.users_group_member_id;


--
-- Name: users_groups_users_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE users_groups_users_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_groups_users_group_id_seq OWNER TO postgres;

--
-- Name: users_groups_users_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE users_groups_users_group_id_seq OWNED BY users_groups.users_group_id;


--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_user_id_seq OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE users_user_id_seq OWNED BY users.user_id;


--
-- Name: cache_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cache_invalidation ALTER COLUMN cache_id SET DEFAULT nextval('cache_invalidation_cache_id_seq'::regclass);


--
-- Name: comment_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY changeset_comments ALTER COLUMN comment_id SET DEFAULT nextval('changeset_comments_comment_id_seq'::regclass);


--
-- Name: changeset_status_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY changeset_statuses ALTER COLUMN changeset_status_id SET DEFAULT nextval('changeset_statuses_changeset_status_id_seq'::regclass);


--
-- Name: gist_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gists ALTER COLUMN gist_id SET DEFAULT nextval('gists_gist_id_seq'::regclass);


--
-- Name: group_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY groups ALTER COLUMN group_id SET DEFAULT nextval('groups_group_id_seq'::regclass);


--
-- Name: notification_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY notifications ALTER COLUMN notification_id SET DEFAULT nextval('notifications_notification_id_seq'::regclass);


--
-- Name: permission_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY permissions ALTER COLUMN permission_id SET DEFAULT nextval('permissions_permission_id_seq'::regclass);


--
-- Name: pull_requests_reviewers_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pull_request_reviewers ALTER COLUMN pull_requests_reviewers_id SET DEFAULT nextval('pull_request_reviewers_pull_requests_reviewers_id_seq'::regclass);


--
-- Name: pull_request_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pull_requests ALTER COLUMN pull_request_id SET DEFAULT nextval('pull_requests_pull_request_id_seq'::regclass);


--
-- Name: repo_to_perm_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY repo_to_perm ALTER COLUMN repo_to_perm_id SET DEFAULT nextval('repo_to_perm_repo_to_perm_id_seq'::regclass);


--
-- Name: repo_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY repositories ALTER COLUMN repo_id SET DEFAULT nextval('repositories_repo_id_seq'::regclass);


--
-- Name: repo_field_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY repositories_fields ALTER COLUMN repo_field_id SET DEFAULT nextval('repositories_fields_repo_field_id_seq'::regclass);


--
-- Name: app_settings_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY settings ALTER COLUMN app_settings_id SET DEFAULT nextval('settings_app_settings_id_seq'::regclass);


--
-- Name: stat_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY statistics ALTER COLUMN stat_id SET DEFAULT nextval('statistics_stat_id_seq'::regclass);


--
-- Name: ui_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ui ALTER COLUMN ui_id SET DEFAULT nextval('ui_ui_id_seq'::regclass);


--
-- Name: user_api_key_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_api_keys ALTER COLUMN user_api_key_id SET DEFAULT nextval('user_api_keys_user_api_key_id_seq'::regclass);


--
-- Name: email_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_email_map ALTER COLUMN email_id SET DEFAULT nextval('user_email_map_email_id_seq'::regclass);


--
-- Name: user_following_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_followings ALTER COLUMN user_following_id SET DEFAULT nextval('user_followings_user_following_id_seq'::regclass);


--
-- Name: user_group_user_group_to_perm_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_group_user_group_to_perm ALTER COLUMN user_group_user_group_to_perm_id SET DEFAULT nextval('user_group_user_group_to_perm_user_group_user_group_to_perm_seq'::regclass);


--
-- Name: ip_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_ip_map ALTER COLUMN ip_id SET DEFAULT nextval('user_ip_map_ip_id_seq'::regclass);


--
-- Name: user_log_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_logs ALTER COLUMN user_log_id SET DEFAULT nextval('user_logs_user_log_id_seq'::regclass);


--
-- Name: group_to_perm_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_repo_group_to_perm ALTER COLUMN group_to_perm_id SET DEFAULT nextval('user_repo_group_to_perm_group_to_perm_id_seq'::regclass);


--
-- Name: user_to_perm_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_to_perm ALTER COLUMN user_to_perm_id SET DEFAULT nextval('user_to_perm_user_to_perm_id_seq'::regclass);


--
-- Name: user_user_group_to_perm_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_user_group_to_perm ALTER COLUMN user_user_group_to_perm_id SET DEFAULT nextval('user_user_group_to_perm_user_user_group_to_perm_id_seq'::regclass);


--
-- Name: user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users ALTER COLUMN user_id SET DEFAULT nextval('users_user_id_seq'::regclass);


--
-- Name: users_group_repo_group_to_perm_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_group_repo_group_to_perm ALTER COLUMN users_group_repo_group_to_perm_id SET DEFAULT nextval('users_group_repo_group_to_per_users_group_repo_group_to_per_seq'::regclass);


--
-- Name: users_group_to_perm_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_group_repo_to_perm ALTER COLUMN users_group_to_perm_id SET DEFAULT nextval('users_group_repo_to_perm_users_group_to_perm_id_seq'::regclass);


--
-- Name: users_group_to_perm_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_group_to_perm ALTER COLUMN users_group_to_perm_id SET DEFAULT nextval('users_group_to_perm_users_group_to_perm_id_seq'::regclass);


--
-- Name: users_group_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_groups ALTER COLUMN users_group_id SET DEFAULT nextval('users_groups_users_group_id_seq'::regclass);


--
-- Name: users_group_member_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_groups_members ALTER COLUMN users_group_member_id SET DEFAULT nextval('users_groups_members_users_group_member_id_seq'::regclass);


--
-- Data for Name: cache_invalidation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY cache_invalidation (cache_id, cache_key, cache_args, cache_active) FROM stdin;
\.


--
-- Name: cache_invalidation_cache_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('cache_invalidation_cache_id_seq', 1, false);


--
-- Data for Name: changeset_comments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY changeset_comments (comment_id, repo_id, revision, pull_request_id, line_no, f_path, user_id, text, created_on, modified_at) FROM stdin;
\.


--
-- Name: changeset_comments_comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('changeset_comments_comment_id_seq', 1, false);


--
-- Data for Name: changeset_statuses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY changeset_statuses (changeset_status_id, repo_id, user_id, revision, status, changeset_comment_id, modified_at, version, pull_request_id) FROM stdin;
\.


--
-- Name: changeset_statuses_changeset_status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('changeset_statuses_changeset_status_id_seq', 1, false);


--
-- Data for Name: db_migrate_version; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY db_migrate_version (repository_id, repository_path, version) FROM stdin;
kallithea_db_migrations	versions	31
\.


--
-- Data for Name: gists; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY gists (gist_id, gist_access_id, gist_description, user_id, gist_expires, gist_type, created_on, modified_at) FROM stdin;
\.


--
-- Name: gists_gist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('gists_gist_id_seq', 1, false);


--
-- Data for Name: groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY groups (group_id, group_name, group_parent_id, group_description, enable_locking, user_id, created_on) FROM stdin;
\.


--
-- Name: groups_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('groups_group_id_seq', 1, false);


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY notifications (notification_id, subject, body, created_by, created_on, type) FROM stdin;
\.


--
-- Name: notifications_notification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('notifications_notification_id_seq', 1, false);


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY permissions (permission_id, permission_name, permission_longname) FROM stdin;
1	hg.admin	hg.admin
2	repository.none	repository.none
3	repository.read	repository.read
4	repository.write	repository.write
5	repository.admin	repository.admin
6	group.none	group.none
7	group.read	group.read
8	group.write	group.write
9	group.admin	group.admin
10	usergroup.none	usergroup.none
11	usergroup.read	usergroup.read
12	usergroup.write	usergroup.write
13	usergroup.admin	usergroup.admin
14	hg.repogroup.create.false	hg.repogroup.create.false
15	hg.repogroup.create.true	hg.repogroup.create.true
16	hg.usergroup.create.false	hg.usergroup.create.false
17	hg.usergroup.create.true	hg.usergroup.create.true
18	hg.create.none	hg.create.none
19	hg.create.repository	hg.create.repository
20	hg.create.write_on_repogroup.true	hg.create.write_on_repogroup.true
21	hg.create.write_on_repogroup.false	hg.create.write_on_repogroup.false
22	hg.fork.none	hg.fork.none
23	hg.fork.repository	hg.fork.repository
24	hg.register.none	hg.register.none
25	hg.register.manual_activate	hg.register.manual_activate
26	hg.register.auto_activate	hg.register.auto_activate
27	hg.extern_activate.manual	hg.extern_activate.manual
28	hg.extern_activate.auto	hg.extern_activate.auto
\.


--
-- Name: permissions_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('permissions_permission_id_seq', 28, true);


--
-- Data for Name: pull_request_reviewers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY pull_request_reviewers (pull_requests_reviewers_id, pull_request_id, user_id) FROM stdin;
\.


--
-- Name: pull_request_reviewers_pull_requests_reviewers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('pull_request_reviewers_pull_requests_reviewers_id_seq', 1, false);


--
-- Data for Name: pull_requests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY pull_requests (pull_request_id, title, description, status, created_on, updated_on, user_id, revisions, org_repo_id, org_ref, other_repo_id, other_ref) FROM stdin;
\.


--
-- Name: pull_requests_pull_request_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('pull_requests_pull_request_id_seq', 1, false);


--
-- Data for Name: repo_to_perm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY repo_to_perm (repo_to_perm_id, user_id, permission_id, repository_id) FROM stdin;
\.


--
-- Name: repo_to_perm_repo_to_perm_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('repo_to_perm_repo_to_perm_id_seq', 1, false);


--
-- Data for Name: repositories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY repositories (repo_id, repo_name, repo_state, clone_uri, repo_type, user_id, private, statistics, downloads, description, created_on, updated_on, landing_revision, enable_locking, locked, changeset_cache, fork_id, group_id) FROM stdin;
\.


--
-- Data for Name: repositories_fields; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY repositories_fields (repo_field_id, repository_id, field_key, field_label, field_value, field_desc, field_type, created_on) FROM stdin;
\.


--
-- Name: repositories_fields_repo_field_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('repositories_fields_repo_field_id_seq', 1, false);


--
-- Name: repositories_repo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('repositories_repo_id_seq', 1, false);


--
-- Data for Name: settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY settings (app_settings_id, app_settings_name, app_settings_value, app_settings_type) FROM stdin;
1	realm	Kallithea	unicode
2	title		unicode
3	ga_code		unicode
4	show_public_icon	True	bool
5	show_private_icon	True	bool
6	stylify_metatags	False	bool
7	dashboard_items	100	int
8	admin_grid_items	25	int
9	show_version	True	bool
10	use_gravatar	True	bool
11	gravatar_url	https://secure.gravatar.com/avatar/{md5email}?d=identicon&s={size}	unicode
12	clone_uri_tmpl	{scheme}://{user}@{netloc}/{repo}	unicode
13	update_url		unicode
14	auth_plugins	kallithea.lib.auth_modules.auth_internal	list
15	auth_internal_enabled	True	bool
16	default_repo_enable_locking	False	bool
17	default_repo_enable_downloads	False	bool
18	default_repo_enable_statistics	False	bool
19	default_repo_private	False	bool
20	default_repo_type	hg	unicode
\.


--
-- Name: settings_app_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('settings_app_settings_id_seq', 20, true);


--
-- Data for Name: statistics; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY statistics (stat_id, repository_id, stat_on_revision, commit_activity, commit_activity_combined, languages) FROM stdin;
\.


--
-- Name: statistics_stat_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('statistics_stat_id_seq', 1, false);


--
-- Data for Name: ui; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY ui (ui_id, ui_section, ui_key, ui_value, ui_active) FROM stdin;
1	hooks	changegroup.update	hg update >&2	f
2	hooks	changegroup.repo_size	python:kallithea.lib.hooks.repo_size	t
3	hooks	changegroup.push_logger	python:kallithea.lib.hooks.log_push_action	t
4	hooks	prechangegroup.pre_push	python:kallithea.lib.hooks.pre_push	t
5	hooks	outgoing.pull_logger	python:kallithea.lib.hooks.log_pull_action	t
6	hooks	preoutgoing.pre_pull	python:kallithea.lib.hooks.pre_pull	t
7	extensions	largefiles		t
8	largefiles	usercache	/opt/kallithea/repos/.cache/largefiles	t
9	extensions	hgsubversion		f
10	extensions	hggit		f
11	web	push_ssl	false	t
12	web	allow_archive	gz zip bz2	t
13	web	allow_push	*	t
14	web	baseurl	/	t
15	paths	/	/opt/kallithea/repos	t
\.


--
-- Name: ui_ui_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('ui_ui_id_seq', 15, true);


--
-- Data for Name: user_api_keys; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY user_api_keys (user_api_key_id, user_id, api_key, description, expires, created_on) FROM stdin;
\.


--
-- Name: user_api_keys_user_api_key_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('user_api_keys_user_api_key_id_seq', 1, false);


--
-- Data for Name: user_email_map; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY user_email_map (email_id, user_id, email) FROM stdin;
\.


--
-- Name: user_email_map_email_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('user_email_map_email_id_seq', 1, false);


--
-- Data for Name: user_followings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY user_followings (user_following_id, user_id, follows_repository_id, follows_user_id, follows_from) FROM stdin;
\.


--
-- Name: user_followings_user_following_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('user_followings_user_following_id_seq', 1, false);


--
-- Data for Name: user_group_user_group_to_perm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY user_group_user_group_to_perm (user_group_user_group_to_perm_id, target_user_group_id, permission_id, user_group_id) FROM stdin;
\.


--
-- Name: user_group_user_group_to_perm_user_group_user_group_to_perm_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('user_group_user_group_to_perm_user_group_user_group_to_perm_seq', 1, false);


--
-- Data for Name: user_ip_map; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY user_ip_map (ip_id, user_id, ip_addr, active) FROM stdin;
\.


--
-- Name: user_ip_map_ip_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('user_ip_map_ip_id_seq', 1, false);


--
-- Data for Name: user_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY user_logs (user_log_id, user_id, username, repository_id, repository_name, user_ip, action, action_date) FROM stdin;
\.


--
-- Name: user_logs_user_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('user_logs_user_log_id_seq', 1, false);


--
-- Data for Name: user_repo_group_to_perm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY user_repo_group_to_perm (group_to_perm_id, user_id, group_id, permission_id) FROM stdin;
\.


--
-- Name: user_repo_group_to_perm_group_to_perm_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('user_repo_group_to_perm_group_to_perm_id_seq', 1, false);


--
-- Data for Name: user_to_notification; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY user_to_notification (user_id, notification_id, read, sent_on) FROM stdin;
\.


--
-- Data for Name: user_to_perm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY user_to_perm (user_to_perm_id, user_id, permission_id) FROM stdin;
1	1	3
2	1	7
3	1	11
4	1	19
5	1	20
6	1	23
7	1	25
8	1	28
\.


--
-- Name: user_to_perm_user_to_perm_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('user_to_perm_user_to_perm_id_seq', 8, true);


--
-- Data for Name: user_user_group_to_perm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY user_user_group_to_perm (user_user_group_to_perm_id, user_id, permission_id, user_group_id) FROM stdin;
\.


--
-- Name: user_user_group_to_perm_user_user_group_to_perm_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('user_user_group_to_perm_user_user_group_to_perm_id_seq', 1, false);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY users (user_id, username, password, active, admin, firstname, lastname, email, last_login, extern_type, extern_name, api_key, inherit_default_permissions, created_on, user_data) FROM stdin;
1	default	$2a$10$SvV.q.1zcZWdTGsK7ihXSerti9LpUX2J.BHlIsiMtOShF5ab2XtCu	t	f	Anonymous	User	anonymous@kallithea-scm.org	\N	\N	\N	cdd0a366fda8d24b382e814b385a5c02a751304c	t	2016-05-18 21:39:06.833271	\N
2	admin	$2a$10$9RRMvLvWKm/Z/kaA0OcNk.O/orpz43qPtKoC1cHEFm1YSvUd23Pvq	t	t	Kallithea	Admin	\N	2016-05-18 21:44:51.870811	internal	\N	882b1a1f7019ce71a270225977eb8fc2c89a7bff	t	2016-05-18 21:39:44.28202	\N
\.


--
-- Name: users_group_repo_group_to_per_users_group_repo_group_to_per_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('users_group_repo_group_to_per_users_group_repo_group_to_per_seq', 1, false);


--
-- Data for Name: users_group_repo_group_to_perm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY users_group_repo_group_to_perm (users_group_repo_group_to_perm_id, users_group_id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: users_group_repo_to_perm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY users_group_repo_to_perm (users_group_to_perm_id, users_group_id, permission_id, repository_id) FROM stdin;
\.


--
-- Name: users_group_repo_to_perm_users_group_to_perm_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('users_group_repo_to_perm_users_group_to_perm_id_seq', 1, false);


--
-- Data for Name: users_group_to_perm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY users_group_to_perm (users_group_to_perm_id, users_group_id, permission_id) FROM stdin;
\.


--
-- Name: users_group_to_perm_users_group_to_perm_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('users_group_to_perm_users_group_to_perm_id_seq', 1, false);


--
-- Data for Name: users_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY users_groups (users_group_id, users_group_name, user_group_description, users_group_active, users_group_inherit_default_permissions, user_id, created_on, group_data) FROM stdin;
\.


--
-- Data for Name: users_groups_members; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY users_groups_members (users_group_member_id, users_group_id, user_id) FROM stdin;
\.


--
-- Name: users_groups_members_users_group_member_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('users_groups_members_users_group_member_id_seq', 1, false);


--
-- Name: users_groups_users_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('users_groups_users_group_id_seq', 1, false);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('users_user_id_seq', 2, true);


--
-- Name: cache_invalidation_cache_key_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cache_invalidation
    ADD CONSTRAINT cache_invalidation_cache_key_key UNIQUE (cache_key);


--
-- Name: cache_invalidation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cache_invalidation
    ADD CONSTRAINT cache_invalidation_pkey PRIMARY KEY (cache_id);


--
-- Name: changeset_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY changeset_comments
    ADD CONSTRAINT changeset_comments_pkey PRIMARY KEY (comment_id);


--
-- Name: changeset_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY changeset_statuses
    ADD CONSTRAINT changeset_statuses_pkey PRIMARY KEY (changeset_status_id);


--
-- Name: changeset_statuses_repo_id_revision_version_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY changeset_statuses
    ADD CONSTRAINT changeset_statuses_repo_id_revision_version_key UNIQUE (repo_id, revision, version);


--
-- Name: db_migrate_version_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY db_migrate_version
    ADD CONSTRAINT db_migrate_version_pkey PRIMARY KEY (repository_id);


--
-- Name: gists_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gists
    ADD CONSTRAINT gists_pkey PRIMARY KEY (gist_id);


--
-- Name: groups_group_name_group_parent_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY groups
    ADD CONSTRAINT groups_group_name_group_parent_id_key UNIQUE (group_name, group_parent_id);


--
-- Name: groups_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY groups
    ADD CONSTRAINT groups_group_name_key UNIQUE (group_name);


--
-- Name: groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (group_id);


--
-- Name: notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (notification_id);


--
-- Name: permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (permission_id);


--
-- Name: pull_request_reviewers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pull_request_reviewers
    ADD CONSTRAINT pull_request_reviewers_pkey PRIMARY KEY (pull_requests_reviewers_id);


--
-- Name: pull_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pull_requests
    ADD CONSTRAINT pull_requests_pkey PRIMARY KEY (pull_request_id);


--
-- Name: repo_to_perm_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY repo_to_perm
    ADD CONSTRAINT repo_to_perm_pkey PRIMARY KEY (repo_to_perm_id);


--
-- Name: repo_to_perm_user_id_repository_id_permission_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY repo_to_perm
    ADD CONSTRAINT repo_to_perm_user_id_repository_id_permission_id_key UNIQUE (user_id, repository_id, permission_id);


--
-- Name: repositories_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY repositories_fields
    ADD CONSTRAINT repositories_fields_pkey PRIMARY KEY (repo_field_id);


--
-- Name: repositories_fields_repository_id_field_key_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY repositories_fields
    ADD CONSTRAINT repositories_fields_repository_id_field_key_key UNIQUE (repository_id, field_key);


--
-- Name: repositories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY repositories
    ADD CONSTRAINT repositories_pkey PRIMARY KEY (repo_id);


--
-- Name: repositories_repo_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY repositories
    ADD CONSTRAINT repositories_repo_name_key UNIQUE (repo_name);


--
-- Name: settings_app_settings_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY settings
    ADD CONSTRAINT settings_app_settings_name_key UNIQUE (app_settings_name);


--
-- Name: settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY settings
    ADD CONSTRAINT settings_pkey PRIMARY KEY (app_settings_id);


--
-- Name: statistics_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY statistics
    ADD CONSTRAINT statistics_pkey PRIMARY KEY (stat_id);


--
-- Name: statistics_repository_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY statistics
    ADD CONSTRAINT statistics_repository_id_key UNIQUE (repository_id);


--
-- Name: ui_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ui
    ADD CONSTRAINT ui_pkey PRIMARY KEY (ui_id);


--
-- Name: ui_ui_key_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ui
    ADD CONSTRAINT ui_ui_key_key UNIQUE (ui_key);


--
-- Name: user_api_keys_api_key_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_api_keys
    ADD CONSTRAINT user_api_keys_api_key_key UNIQUE (api_key);


--
-- Name: user_api_keys_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_api_keys
    ADD CONSTRAINT user_api_keys_pkey PRIMARY KEY (user_api_key_id);


--
-- Name: user_email_map_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_email_map
    ADD CONSTRAINT user_email_map_email_key UNIQUE (email);


--
-- Name: user_email_map_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_email_map
    ADD CONSTRAINT user_email_map_pkey PRIMARY KEY (email_id);


--
-- Name: user_followings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_followings
    ADD CONSTRAINT user_followings_pkey PRIMARY KEY (user_following_id);


--
-- Name: user_followings_user_id_follows_repository_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_followings
    ADD CONSTRAINT user_followings_user_id_follows_repository_id_key UNIQUE (user_id, follows_repository_id);


--
-- Name: user_followings_user_id_follows_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_followings
    ADD CONSTRAINT user_followings_user_id_follows_user_id_key UNIQUE (user_id, follows_user_id);


--
-- Name: user_group_user_group_to_perm_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_group_user_group_to_perm
    ADD CONSTRAINT user_group_user_group_to_perm_pkey PRIMARY KEY (user_group_user_group_to_perm_id);


--
-- Name: user_group_user_group_to_perm_target_user_group_id_user_gro_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_group_user_group_to_perm
    ADD CONSTRAINT user_group_user_group_to_perm_target_user_group_id_user_gro_key UNIQUE (target_user_group_id, user_group_id, permission_id);


--
-- Name: user_ip_map_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_ip_map
    ADD CONSTRAINT user_ip_map_pkey PRIMARY KEY (ip_id);


--
-- Name: user_ip_map_user_id_ip_addr_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_ip_map
    ADD CONSTRAINT user_ip_map_user_id_ip_addr_key UNIQUE (user_id, ip_addr);


--
-- Name: user_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_logs
    ADD CONSTRAINT user_logs_pkey PRIMARY KEY (user_log_id);


--
-- Name: user_repo_group_to_perm_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_repo_group_to_perm
    ADD CONSTRAINT user_repo_group_to_perm_pkey PRIMARY KEY (group_to_perm_id);


--
-- Name: user_repo_group_to_perm_user_id_group_id_permission_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_repo_group_to_perm
    ADD CONSTRAINT user_repo_group_to_perm_user_id_group_id_permission_id_key UNIQUE (user_id, group_id, permission_id);


--
-- Name: user_to_notification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_to_notification
    ADD CONSTRAINT user_to_notification_pkey PRIMARY KEY (user_id, notification_id);


--
-- Name: user_to_perm_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_to_perm
    ADD CONSTRAINT user_to_perm_pkey PRIMARY KEY (user_to_perm_id);


--
-- Name: user_to_perm_user_id_permission_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_to_perm
    ADD CONSTRAINT user_to_perm_user_id_permission_id_key UNIQUE (user_id, permission_id);


--
-- Name: user_user_group_to_perm_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_user_group_to_perm
    ADD CONSTRAINT user_user_group_to_perm_pkey PRIMARY KEY (user_user_group_to_perm_id);


--
-- Name: user_user_group_to_perm_user_id_user_group_id_permission_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_user_group_to_perm
    ADD CONSTRAINT user_user_group_to_perm_user_id_user_group_id_permission_id_key UNIQUE (user_id, user_group_id, permission_id);


--
-- Name: users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users_group_repo_group_to_perm_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_group_repo_group_to_perm
    ADD CONSTRAINT users_group_repo_group_to_perm_pkey PRIMARY KEY (users_group_repo_group_to_perm_id);


--
-- Name: users_group_repo_group_to_perm_users_group_id_group_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_group_repo_group_to_perm
    ADD CONSTRAINT users_group_repo_group_to_perm_users_group_id_group_id_key UNIQUE (users_group_id, group_id);


--
-- Name: users_group_repo_to_perm_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_group_repo_to_perm
    ADD CONSTRAINT users_group_repo_to_perm_pkey PRIMARY KEY (users_group_to_perm_id);


--
-- Name: users_group_repo_to_perm_repository_id_users_group_id_permi_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_group_repo_to_perm
    ADD CONSTRAINT users_group_repo_to_perm_repository_id_users_group_id_permi_key UNIQUE (repository_id, users_group_id, permission_id);


--
-- Name: users_group_to_perm_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_group_to_perm
    ADD CONSTRAINT users_group_to_perm_pkey PRIMARY KEY (users_group_to_perm_id);


--
-- Name: users_group_to_perm_users_group_id_permission_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_group_to_perm
    ADD CONSTRAINT users_group_to_perm_users_group_id_permission_id_key UNIQUE (users_group_id, permission_id);


--
-- Name: users_groups_members_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_groups_members
    ADD CONSTRAINT users_groups_members_pkey PRIMARY KEY (users_group_member_id);


--
-- Name: users_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_groups
    ADD CONSTRAINT users_groups_pkey PRIMARY KEY (users_group_id);


--
-- Name: users_groups_users_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_groups
    ADD CONSTRAINT users_groups_users_group_name_key UNIQUE (users_group_name);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: cc_pull_request_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cc_pull_request_id_idx ON changeset_comments USING btree (pull_request_id);


--
-- Name: cc_revision_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cc_revision_idx ON changeset_comments USING btree (revision);


--
-- Name: cs_changeset_comment_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cs_changeset_comment_id_idx ON changeset_statuses USING btree (changeset_comment_id);


--
-- Name: cs_pull_request_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cs_pull_request_id_idx ON changeset_statuses USING btree (pull_request_id);


--
-- Name: cs_pull_request_id_user_id_version_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cs_pull_request_id_user_id_version_idx ON changeset_statuses USING btree (pull_request_id, user_id, version);


--
-- Name: cs_revision_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cs_revision_idx ON changeset_statuses USING btree (revision);


--
-- Name: cs_version_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cs_version_idx ON changeset_statuses USING btree (version);


--
-- Name: g_created_on_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX g_created_on_idx ON gists USING btree (created_on);


--
-- Name: g_gist_access_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX g_gist_access_id_idx ON gists USING btree (gist_access_id);


--
-- Name: key_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX key_idx ON cache_invalidation USING btree (cache_key);


--
-- Name: notification_type_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX notification_type_idx ON notifications USING btree (type);


--
-- Name: p_perm_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX p_perm_name_idx ON permissions USING btree (permission_name);


--
-- Name: pr_org_repo_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX pr_org_repo_id_idx ON pull_requests USING btree (org_repo_id);


--
-- Name: pr_other_repo_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX pr_other_repo_id_idx ON pull_requests USING btree (other_repo_id);


--
-- Name: r_repo_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX r_repo_name_idx ON repositories USING btree (repo_name);


--
-- Name: u_email_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX u_email_idx ON users USING btree (email);


--
-- Name: u_username_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX u_username_idx ON users USING btree (username);


--
-- Name: uak_api_key_expires_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX uak_api_key_expires_idx ON user_api_keys USING btree (api_key, expires);


--
-- Name: uak_api_key_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX uak_api_key_idx ON user_api_keys USING btree (api_key);


--
-- Name: uem_email_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX uem_email_idx ON user_email_map USING btree (email);


--
-- Name: changeset_comments_pull_request_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY changeset_comments
    ADD CONSTRAINT changeset_comments_pull_request_id_fkey FOREIGN KEY (pull_request_id) REFERENCES pull_requests(pull_request_id);


--
-- Name: changeset_comments_repo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY changeset_comments
    ADD CONSTRAINT changeset_comments_repo_id_fkey FOREIGN KEY (repo_id) REFERENCES repositories(repo_id);


--
-- Name: changeset_comments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY changeset_comments
    ADD CONSTRAINT changeset_comments_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: changeset_statuses_changeset_comment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY changeset_statuses
    ADD CONSTRAINT changeset_statuses_changeset_comment_id_fkey FOREIGN KEY (changeset_comment_id) REFERENCES changeset_comments(comment_id);


--
-- Name: changeset_statuses_pull_request_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY changeset_statuses
    ADD CONSTRAINT changeset_statuses_pull_request_id_fkey FOREIGN KEY (pull_request_id) REFERENCES pull_requests(pull_request_id);


--
-- Name: changeset_statuses_repo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY changeset_statuses
    ADD CONSTRAINT changeset_statuses_repo_id_fkey FOREIGN KEY (repo_id) REFERENCES repositories(repo_id);


--
-- Name: changeset_statuses_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY changeset_statuses
    ADD CONSTRAINT changeset_statuses_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: gists_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gists
    ADD CONSTRAINT gists_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: groups_group_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY groups
    ADD CONSTRAINT groups_group_parent_id_fkey FOREIGN KEY (group_parent_id) REFERENCES groups(group_id);


--
-- Name: groups_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY groups
    ADD CONSTRAINT groups_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: notifications_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY notifications
    ADD CONSTRAINT notifications_created_by_fkey FOREIGN KEY (created_by) REFERENCES users(user_id);


--
-- Name: pull_request_reviewers_pull_request_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pull_request_reviewers
    ADD CONSTRAINT pull_request_reviewers_pull_request_id_fkey FOREIGN KEY (pull_request_id) REFERENCES pull_requests(pull_request_id);


--
-- Name: pull_request_reviewers_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pull_request_reviewers
    ADD CONSTRAINT pull_request_reviewers_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: pull_requests_org_repo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pull_requests
    ADD CONSTRAINT pull_requests_org_repo_id_fkey FOREIGN KEY (org_repo_id) REFERENCES repositories(repo_id);


--
-- Name: pull_requests_other_repo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pull_requests
    ADD CONSTRAINT pull_requests_other_repo_id_fkey FOREIGN KEY (other_repo_id) REFERENCES repositories(repo_id);


--
-- Name: pull_requests_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pull_requests
    ADD CONSTRAINT pull_requests_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: repo_to_perm_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY repo_to_perm
    ADD CONSTRAINT repo_to_perm_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES permissions(permission_id);


--
-- Name: repo_to_perm_repository_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY repo_to_perm
    ADD CONSTRAINT repo_to_perm_repository_id_fkey FOREIGN KEY (repository_id) REFERENCES repositories(repo_id);


--
-- Name: repo_to_perm_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY repo_to_perm
    ADD CONSTRAINT repo_to_perm_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: repositories_fields_repository_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY repositories_fields
    ADD CONSTRAINT repositories_fields_repository_id_fkey FOREIGN KEY (repository_id) REFERENCES repositories(repo_id);


--
-- Name: repositories_fork_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY repositories
    ADD CONSTRAINT repositories_fork_id_fkey FOREIGN KEY (fork_id) REFERENCES repositories(repo_id);


--
-- Name: repositories_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY repositories
    ADD CONSTRAINT repositories_group_id_fkey FOREIGN KEY (group_id) REFERENCES groups(group_id);


--
-- Name: repositories_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY repositories
    ADD CONSTRAINT repositories_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: statistics_repository_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY statistics
    ADD CONSTRAINT statistics_repository_id_fkey FOREIGN KEY (repository_id) REFERENCES repositories(repo_id);


--
-- Name: user_api_keys_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_api_keys
    ADD CONSTRAINT user_api_keys_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: user_email_map_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_email_map
    ADD CONSTRAINT user_email_map_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: user_followings_follows_repository_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_followings
    ADD CONSTRAINT user_followings_follows_repository_id_fkey FOREIGN KEY (follows_repository_id) REFERENCES repositories(repo_id);


--
-- Name: user_followings_follows_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_followings
    ADD CONSTRAINT user_followings_follows_user_id_fkey FOREIGN KEY (follows_user_id) REFERENCES users(user_id);


--
-- Name: user_followings_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_followings
    ADD CONSTRAINT user_followings_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: user_group_user_group_to_perm_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_group_user_group_to_perm
    ADD CONSTRAINT user_group_user_group_to_perm_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES permissions(permission_id);


--
-- Name: user_group_user_group_to_perm_target_user_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_group_user_group_to_perm
    ADD CONSTRAINT user_group_user_group_to_perm_target_user_group_id_fkey FOREIGN KEY (target_user_group_id) REFERENCES users_groups(users_group_id);


--
-- Name: user_group_user_group_to_perm_user_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_group_user_group_to_perm
    ADD CONSTRAINT user_group_user_group_to_perm_user_group_id_fkey FOREIGN KEY (user_group_id) REFERENCES users_groups(users_group_id);


--
-- Name: user_ip_map_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_ip_map
    ADD CONSTRAINT user_ip_map_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: user_logs_repository_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_logs
    ADD CONSTRAINT user_logs_repository_id_fkey FOREIGN KEY (repository_id) REFERENCES repositories(repo_id);


--
-- Name: user_logs_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_logs
    ADD CONSTRAINT user_logs_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: user_repo_group_to_perm_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_repo_group_to_perm
    ADD CONSTRAINT user_repo_group_to_perm_group_id_fkey FOREIGN KEY (group_id) REFERENCES groups(group_id);


--
-- Name: user_repo_group_to_perm_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_repo_group_to_perm
    ADD CONSTRAINT user_repo_group_to_perm_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES permissions(permission_id);


--
-- Name: user_repo_group_to_perm_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_repo_group_to_perm
    ADD CONSTRAINT user_repo_group_to_perm_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: user_to_notification_notification_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_to_notification
    ADD CONSTRAINT user_to_notification_notification_id_fkey FOREIGN KEY (notification_id) REFERENCES notifications(notification_id);


--
-- Name: user_to_notification_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_to_notification
    ADD CONSTRAINT user_to_notification_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: user_to_perm_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_to_perm
    ADD CONSTRAINT user_to_perm_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES permissions(permission_id);


--
-- Name: user_to_perm_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_to_perm
    ADD CONSTRAINT user_to_perm_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: user_user_group_to_perm_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_user_group_to_perm
    ADD CONSTRAINT user_user_group_to_perm_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES permissions(permission_id);


--
-- Name: user_user_group_to_perm_user_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_user_group_to_perm
    ADD CONSTRAINT user_user_group_to_perm_user_group_id_fkey FOREIGN KEY (user_group_id) REFERENCES users_groups(users_group_id);


--
-- Name: user_user_group_to_perm_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_user_group_to_perm
    ADD CONSTRAINT user_user_group_to_perm_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: users_group_repo_group_to_perm_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_group_repo_group_to_perm
    ADD CONSTRAINT users_group_repo_group_to_perm_group_id_fkey FOREIGN KEY (group_id) REFERENCES groups(group_id);


--
-- Name: users_group_repo_group_to_perm_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_group_repo_group_to_perm
    ADD CONSTRAINT users_group_repo_group_to_perm_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES permissions(permission_id);


--
-- Name: users_group_repo_group_to_perm_users_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_group_repo_group_to_perm
    ADD CONSTRAINT users_group_repo_group_to_perm_users_group_id_fkey FOREIGN KEY (users_group_id) REFERENCES users_groups(users_group_id);


--
-- Name: users_group_repo_to_perm_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_group_repo_to_perm
    ADD CONSTRAINT users_group_repo_to_perm_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES permissions(permission_id);


--
-- Name: users_group_repo_to_perm_repository_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_group_repo_to_perm
    ADD CONSTRAINT users_group_repo_to_perm_repository_id_fkey FOREIGN KEY (repository_id) REFERENCES repositories(repo_id);


--
-- Name: users_group_repo_to_perm_users_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_group_repo_to_perm
    ADD CONSTRAINT users_group_repo_to_perm_users_group_id_fkey FOREIGN KEY (users_group_id) REFERENCES users_groups(users_group_id);


--
-- Name: users_group_to_perm_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_group_to_perm
    ADD CONSTRAINT users_group_to_perm_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES permissions(permission_id);


--
-- Name: users_group_to_perm_users_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_group_to_perm
    ADD CONSTRAINT users_group_to_perm_users_group_id_fkey FOREIGN KEY (users_group_id) REFERENCES users_groups(users_group_id);


--
-- Name: users_groups_members_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_groups_members
    ADD CONSTRAINT users_groups_members_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: users_groups_members_users_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_groups_members
    ADD CONSTRAINT users_groups_members_users_group_id_fkey FOREIGN KEY (users_group_id) REFERENCES users_groups(users_group_id);


--
-- Name: users_groups_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_groups
    ADD CONSTRAINT users_groups_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

\connect template1

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.2
-- Dumped by pg_dump version 9.5.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: template1; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

