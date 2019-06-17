--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.12
-- Dumped by pg_dump version 9.6.12

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: currency_week_data; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.currency_week_data (
    date date NOT NULL,
    cad double precision,
    usd double precision,
    cny double precision,
    gbp double precision,
    inr double precision
);


ALTER TABLE public.currency_week_data OWNER TO postgres;

--
-- Data for Name: currency_week_data; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.currency_week_data (date, cad, usd, cny, gbp, inr) FROM stdin;
2019-04-10	1.50320000000000009	1.1278999999999999	7.57580000000000009	0.860829999999999984	77.9945000000000022
2019-04-12	1.50819999999999999	1.13210000000000011	7.59389999999999965	0.8629	78.2914999999999992
2019-04-09	1.49839999999999995	1.12769999999999992	7.56880000000000042	0.863349999999999951	78.1880000000000024
2019-04-11	1.50669999999999993	1.12640000000000007	7.5671999999999997	0.861680000000000001	77.6855000000000047
2019-04-08	1.50419999999999998	1.12460000000000004	7.55609999999999982	0.861829999999999985	78.3215000000000003
\.


--
-- Name: currency_week_data currency_week_data_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.currency_week_data
    ADD CONSTRAINT currency_week_data_pkey PRIMARY KEY (date);


--
-- PostgreSQL database dump complete
--

