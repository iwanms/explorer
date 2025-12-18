--
-- PostgreSQL database dump
--

\restrict OsqS1sd2O9xd6kjAcAjzDn7buh7kJJW8h5gtkfY5v4RQUMXXWJNjxRMrfghqxKw

-- Dumped from database version 16.11 (Ubuntu 16.11-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.11 (Ubuntu 16.11-0ubuntu0.24.04.1)

-- Started on 2025-12-18 23:11:45 WIB

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE explorer_db;
--
-- TOC entry 3447 (class 1262 OID 16874)
-- Name: explorer_db; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE explorer_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.UTF-8';


ALTER DATABASE explorer_db OWNER TO postgres;

\unrestrict OsqS1sd2O9xd6kjAcAjzDn7buh7kJJW8h5gtkfY5v4RQUMXXWJNjxRMrfghqxKw
\connect explorer_db
\restrict OsqS1sd2O9xd6kjAcAjzDn7buh7kJJW8h5gtkfY5v4RQUMXXWJNjxRMrfghqxKw

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 216 (class 1259 OID 16926)
-- Name: files; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.files (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(255) NOT NULL,
    folder_id uuid NOT NULL,
    size bigint,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.files OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16913)
-- Name: folders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.folders (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(255) NOT NULL,
    parent_id uuid,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.folders OWNER TO postgres;

--
-- TOC entry 3441 (class 0 OID 16926)
-- Dependencies: 216
-- Data for Name: files; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.files VALUES ('c3148814-44f8-4833-b7b8-f7218ec7ee8b', 'Test.pdf', '6bad8c1b-f2a9-46d4-82cb-7ce357cf5539', 102400, '2025-12-17 20:41:21.382937');
INSERT INTO public.files VALUES ('e8887cb7-81e4-4690-a5fa-ed6c609eaa96', 'Me.jpg', '10a72246-9e45-4bc2-ba7b-bc849697e271', 102400, '2025-12-17 22:07:33.176705');


--
-- TOC entry 3440 (class 0 OID 16913)
-- Dependencies: 215
-- Data for Name: folders; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.folders VALUES ('98a610c8-eec2-4628-ad3a-58c52eba108e', 'Documents', NULL, '2025-12-17 19:17:06.802819');
INSERT INTO public.folders VALUES ('10a72246-9e45-4bc2-ba7b-bc849697e271', 'Pictures', NULL, '2025-12-17 19:17:06.802819');
INSERT INTO public.folders VALUES ('55ec2d80-f67a-40ec-8a0b-d5b1ed337b79', 'Music', NULL, '2025-12-17 19:17:06.802819');
INSERT INTO public.folders VALUES ('6bad8c1b-f2a9-46d4-82cb-7ce357cf5539', 'Work', '98a610c8-eec2-4628-ad3a-58c52eba108e', '2025-12-17 19:17:16.436244');
INSERT INTO public.folders VALUES ('6369d2c0-0f3f-4d7e-9e2b-ce583a23a8ea', 'Personal', '98a610c8-eec2-4628-ad3a-58c52eba108e', '2025-12-17 19:17:16.436244');
INSERT INTO public.folders VALUES ('5171d104-dd24-4e0d-aceb-dcd48f85017a', 'Work 1', '6bad8c1b-f2a9-46d4-82cb-7ce357cf5539', '2025-12-18 22:40:50.120264');


--
-- TOC entry 3294 (class 2606 OID 16932)
-- Name: files files_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_pkey PRIMARY KEY (id);


--
-- TOC entry 3291 (class 2606 OID 16919)
-- Name: folders folders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.folders
    ADD CONSTRAINT folders_pkey PRIMARY KEY (id);


--
-- TOC entry 3292 (class 1259 OID 16925)
-- Name: idx_folders_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_folders_parent_id ON public.folders USING btree (parent_id);


--
-- TOC entry 3296 (class 2606 OID 16933)
-- Name: files files_folder_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_folder_id_fkey FOREIGN KEY (folder_id) REFERENCES public.folders(id) ON DELETE CASCADE;


--
-- TOC entry 3295 (class 2606 OID 16920)
-- Name: folders fk_parent; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.folders
    ADD CONSTRAINT fk_parent FOREIGN KEY (parent_id) REFERENCES public.folders(id) ON DELETE CASCADE;


-- Completed on 2025-12-18 23:11:45 WIB

--
-- PostgreSQL database dump complete
--

\unrestrict OsqS1sd2O9xd6kjAcAjzDn7buh7kJJW8h5gtkfY5v4RQUMXXWJNjxRMrfghqxKw

