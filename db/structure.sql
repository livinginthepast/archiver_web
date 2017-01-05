--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.1
-- Dumped by pg_dump version 9.6.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET search_path = public, pg_catalog;

--
-- Name: oauth_provider; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE oauth_provider AS ENUM (
    'google',
    'developer'
);


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: assets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE assets (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    thing_id uuid NOT NULL,
    path character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: omniauths; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE omniauths (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    profile_id uuid NOT NULL,
    uid character varying NOT NULL,
    email character varying NOT NULL,
    name character varying NOT NULL,
    provider oauth_provider NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: profiles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE profiles (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    username character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: things; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE things (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    profile_id uuid NOT NULL,
    name character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: assets assets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY assets
    ADD CONSTRAINT assets_pkey PRIMARY KEY (id);


--
-- Name: omniauths omniauths_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY omniauths
    ADD CONSTRAINT omniauths_pkey PRIMARY KEY (id);


--
-- Name: profiles profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY profiles
    ADD CONSTRAINT profiles_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: things things_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY things
    ADD CONSTRAINT things_pkey PRIMARY KEY (id);


--
-- Name: index_assets_on_thing; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_assets_on_thing ON assets USING btree (thing_id) WHERE (deleted_at IS NULL);


--
-- Name: index_assets_on_thing_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_assets_on_thing_id ON assets USING btree (thing_id);


--
-- Name: index_omniauths_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_omniauths_on_email ON omniauths USING btree (lower((email)::text));


--
-- Name: index_omniauths_on_profile_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_omniauths_on_profile_id ON omniauths USING btree (profile_id);


--
-- Name: index_things_on_profile; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_things_on_profile ON things USING btree (profile_id);


--
-- Name: index_things_on_profile_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_things_on_profile_id ON things USING btree (profile_id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO schema_migrations (version) VALUES
('20170104185341');


