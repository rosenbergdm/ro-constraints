--
-- PostgreSQL database dump
--

-- Dumped from database version 13.3
-- Dumped by pg_dump version 13.3

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
-- Name: disease_site; Type: TABLE; Schema: public; Owner: davidrosenberg
--

CREATE TABLE public.disease_site (
    id integer NOT NULL,
    description character varying(32)
);


ALTER TABLE public.disease_site OWNER TO davidrosenberg;

--
-- Name: disease_site_id_seq; Type: SEQUENCE; Schema: public; Owner: davidrosenberg
--

CREATE SEQUENCE public.disease_site_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.disease_site_id_seq OWNER TO davidrosenberg;

--
-- Name: disease_site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: davidrosenberg
--

ALTER SEQUENCE public.disease_site_id_seq OWNED BY public.disease_site.id;


--
-- Name: dose_type; Type: TABLE; Schema: public; Owner: davidrosenberg
--

CREATE TABLE public.dose_type (
    id integer NOT NULL,
    description character varying(16)
);


ALTER TABLE public.dose_type OWNER TO davidrosenberg;

--
-- Name: dose_type_id_seq; Type: SEQUENCE; Schema: public; Owner: davidrosenberg
--

CREATE SEQUENCE public.dose_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dose_type_id_seq OWNER TO davidrosenberg;

--
-- Name: dose_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: davidrosenberg
--

ALTER SEQUENCE public.dose_type_id_seq OWNED BY public.dose_type.id;


--
-- Name: fractionation; Type: TABLE; Schema: public; Owner: davidrosenberg
--

CREATE TABLE public.fractionation (
    id integer NOT NULL,
    description character varying(32),
    fractions_min integer,
    fractions_max integer
);


ALTER TABLE public.fractionation OWNER TO davidrosenberg;

--
-- Name: fractionation_id_seq; Type: SEQUENCE; Schema: public; Owner: davidrosenberg
--

CREATE SEQUENCE public.fractionation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fractionation_id_seq OWNER TO davidrosenberg;

--
-- Name: fractionation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: davidrosenberg
--

ALTER SEQUENCE public.fractionation_id_seq OWNED BY public.fractionation.id;


--
-- Name: intent; Type: TABLE; Schema: public; Owner: davidrosenberg
--

CREATE TABLE public.intent (
    id integer NOT NULL,
    description character varying(16)
);


ALTER TABLE public.intent OWNER TO davidrosenberg;

--
-- Name: intent_id_seq; Type: SEQUENCE; Schema: public; Owner: davidrosenberg
--

CREATE SEQUENCE public.intent_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.intent_id_seq OWNER TO davidrosenberg;

--
-- Name: intent_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: davidrosenberg
--

ALTER SEQUENCE public.intent_id_seq OWNED BY public.intent.id;


--
-- Name: note; Type: TABLE; Schema: public; Owner: davidrosenberg
--

CREATE TABLE public.note (
    id integer NOT NULL,
    region integer,
    text text NOT NULL,
    parent integer
);


ALTER TABLE public.note OWNER TO davidrosenberg;

--
-- Name: note_id_seq; Type: SEQUENCE; Schema: public; Owner: davidrosenberg
--

CREATE SEQUENCE public.note_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.note_id_seq OWNER TO davidrosenberg;

--
-- Name: note_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: davidrosenberg
--

ALTER SEQUENCE public.note_id_seq OWNED BY public.note.id;


--
-- Name: protocol; Type: TABLE; Schema: public; Owner: davidrosenberg
--

CREATE TABLE public.protocol (
    id integer NOT NULL,
    name character varying(128) NOT NULL,
    year integer
);


ALTER TABLE public.protocol OWNER TO davidrosenberg;

--
-- Name: protocol_id_seq; Type: SEQUENCE; Schema: public; Owner: davidrosenberg
--

CREATE SEQUENCE public.protocol_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.protocol_id_seq OWNER TO davidrosenberg;

--
-- Name: protocol_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: davidrosenberg
--

ALTER SEQUENCE public.protocol_id_seq OWNED BY public.protocol.id;


--
-- Name: publication; Type: TABLE; Schema: public; Owner: davidrosenberg
--

CREATE TABLE public.publication (
    id integer NOT NULL,
    title character varying(128) DEFAULT NULL::character varying,
    doi character varying(32) DEFAULT NULL::character varying,
    pubmed character varying(32) DEFAULT NULL::character varying
);


ALTER TABLE public.publication OWNER TO davidrosenberg;

--
-- Name: publication_id_seq; Type: SEQUENCE; Schema: public; Owner: davidrosenberg
--

CREATE SEQUENCE public.publication_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.publication_id_seq OWNER TO davidrosenberg;

--
-- Name: publication_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: davidrosenberg
--

ALTER SEQUENCE public.publication_id_seq OWNED BY public.publication.id;


--
-- Name: region; Type: TABLE; Schema: public; Owner: davidrosenberg
--

CREATE TABLE public.region (
    id integer NOT NULL,
    target integer NOT NULL,
    fractionation integer NOT NULL,
    intent integer,
    volume integer,
    volume_type integer,
    volume_deviation integer,
    volume_deviation_type integer,
    prv integer,
    dose integer,
    dose_type integer,
    dose_deviation integer,
    dose_deviation_type integer,
    conversion character varying(16) DEFAULT NULL::character varying,
    importance character varying(16) DEFAULT NULL::character varying
);


ALTER TABLE public.region OWNER TO davidrosenberg;

--
-- Name: region_disease_site; Type: TABLE; Schema: public; Owner: davidrosenberg
--

CREATE TABLE public.region_disease_site (
    id integer NOT NULL,
    region integer,
    disease_site integer
);


ALTER TABLE public.region_disease_site OWNER TO davidrosenberg;

--
-- Name: region_disease_site_id_seq; Type: SEQUENCE; Schema: public; Owner: davidrosenberg
--

CREATE SEQUENCE public.region_disease_site_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.region_disease_site_id_seq OWNER TO davidrosenberg;

--
-- Name: region_disease_site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: davidrosenberg
--

ALTER SEQUENCE public.region_disease_site_id_seq OWNED BY public.region_disease_site.id;


--
-- Name: region_id_seq; Type: SEQUENCE; Schema: public; Owner: davidrosenberg
--

CREATE SEQUENCE public.region_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.region_id_seq OWNER TO davidrosenberg;

--
-- Name: region_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: davidrosenberg
--

ALTER SEQUENCE public.region_id_seq OWNED BY public.region.id;


--
-- Name: region_protocols; Type: TABLE; Schema: public; Owner: davidrosenberg
--

CREATE TABLE public.region_protocols (
    id integer NOT NULL,
    region integer,
    protocol integer
);


ALTER TABLE public.region_protocols OWNER TO davidrosenberg;

--
-- Name: region_protocols_id_seq; Type: SEQUENCE; Schema: public; Owner: davidrosenberg
--

CREATE SEQUENCE public.region_protocols_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.region_protocols_id_seq OWNER TO davidrosenberg;

--
-- Name: region_protocols_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: davidrosenberg
--

ALTER SEQUENCE public.region_protocols_id_seq OWNED BY public.region_protocols.id;


--
-- Name: region_publications; Type: TABLE; Schema: public; Owner: davidrosenberg
--

CREATE TABLE public.region_publications (
    id integer NOT NULL,
    region integer,
    publication integer
);


ALTER TABLE public.region_publications OWNER TO davidrosenberg;

--
-- Name: region_publications_id_seq; Type: SEQUENCE; Schema: public; Owner: davidrosenberg
--

CREATE SEQUENCE public.region_publications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.region_publications_id_seq OWNER TO davidrosenberg;

--
-- Name: region_publications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: davidrosenberg
--

ALTER SEQUENCE public.region_publications_id_seq OWNED BY public.region_publications.id;


--
-- Name: target; Type: TABLE; Schema: public; Owner: davidrosenberg
--

CREATE TABLE public.target (
    id integer NOT NULL,
    name character varying(32),
    alphabeta integer
);


ALTER TABLE public.target OWNER TO davidrosenberg;

--
-- Name: target_id_seq; Type: SEQUENCE; Schema: public; Owner: davidrosenberg
--

CREATE SEQUENCE public.target_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.target_id_seq OWNER TO davidrosenberg;

--
-- Name: target_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: davidrosenberg
--

ALTER SEQUENCE public.target_id_seq OWNED BY public.target.id;


--
-- Name: volume_type; Type: TABLE; Schema: public; Owner: davidrosenberg
--

CREATE TABLE public.volume_type (
    id integer NOT NULL,
    description character varying(16)
);


ALTER TABLE public.volume_type OWNER TO davidrosenberg;

--
-- Name: volume_type_id_seq; Type: SEQUENCE; Schema: public; Owner: davidrosenberg
--

CREATE SEQUENCE public.volume_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.volume_type_id_seq OWNER TO davidrosenberg;

--
-- Name: volume_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: davidrosenberg
--

ALTER SEQUENCE public.volume_type_id_seq OWNED BY public.volume_type.id;


--
-- Name: disease_site id; Type: DEFAULT; Schema: public; Owner: davidrosenberg
--

ALTER TABLE ONLY public.disease_site ALTER COLUMN id SET DEFAULT nextval('public.disease_site_id_seq'::regclass);


--
-- Name: dose_type id; Type: DEFAULT; Schema: public; Owner: davidrosenberg
--

ALTER TABLE ONLY public.dose_type ALTER COLUMN id SET DEFAULT nextval('public.dose_type_id_seq'::regclass);


--
-- Name: fractionation id; Type: DEFAULT; Schema: public; Owner: davidrosenberg
--

ALTER TABLE ONLY public.fractionation ALTER COLUMN id SET DEFAULT nextval('public.fractionation_id_seq'::regclass);


--
-- Name: intent id; Type: DEFAULT; Schema: public; Owner: davidrosenberg
--

ALTER TABLE ONLY public.intent ALTER COLUMN id SET DEFAULT nextval('public.intent_id_seq'::regclass);


--
-- Name: note id; Type: DEFAULT; Schema: public; Owner: davidrosenberg
--

ALTER TABLE ONLY public.note ALTER COLUMN id SET DEFAULT nextval('public.note_id_seq'::regclass);


--
-- Name: protocol id; Type: DEFAULT; Schema: public; Owner: davidrosenberg
--

ALTER TABLE ONLY public.protocol ALTER COLUMN id SET DEFAULT nextval('public.protocol_id_seq'::regclass);


--
-- Name: publication id; Type: DEFAULT; Schema: public; Owner: davidrosenberg
--

ALTER TABLE ONLY public.publication ALTER COLUMN id SET DEFAULT nextval('public.publication_id_seq'::regclass);


--
-- Name: region id; Type: DEFAULT; Schema: public; Owner: davidrosenberg
--

ALTER TABLE ONLY public.region ALTER COLUMN id SET DEFAULT nextval('public.region_id_seq'::regclass);


--
-- Name: region_disease_site id; Type: DEFAULT; Schema: public; Owner: davidrosenberg
--

ALTER TABLE ONLY public.region_disease_site ALTER COLUMN id SET DEFAULT nextval('public.region_disease_site_id_seq'::regclass);


--
-- Name: region_protocols id; Type: DEFAULT; Schema: public; Owner: davidrosenberg
--

ALTER TABLE ONLY public.region_protocols ALTER COLUMN id SET DEFAULT nextval('public.region_protocols_id_seq'::regclass);


--
-- Name: region_publications id; Type: DEFAULT; Schema: public; Owner: davidrosenberg
--

ALTER TABLE ONLY public.region_publications ALTER COLUMN id SET DEFAULT nextval('public.region_publications_id_seq'::regclass);


--
-- Name: target id; Type: DEFAULT; Schema: public; Owner: davidrosenberg
--

ALTER TABLE ONLY public.target ALTER COLUMN id SET DEFAULT nextval('public.target_id_seq'::regclass);


--
-- Name: volume_type id; Type: DEFAULT; Schema: public; Owner: davidrosenberg
--

ALTER TABLE ONLY public.volume_type ALTER COLUMN id SET DEFAULT nextval('public.volume_type_id_seq'::regclass);


--
-- Data for Name: disease_site; Type: TABLE DATA; Schema: public; Owner: davidrosenberg
--

COPY public.disease_site (id, description) FROM stdin;
1	H&N
2	NSCLC
3	Pediatrics
4	Pancreas
5	Meningioma
6	Nasopharynx
7	Sarcoma
8	H&N: Oral Cavity
9	Esophageal
10	Gastric
11	Breast
12	Mesothelioma
13	Gynecological
14	Cervix
15	Testicular
16	Rectal
17	Anal
18	Prostate
19	Bladder
\.


--
-- Data for Name: dose_type; Type: TABLE DATA; Schema: public; Owner: davidrosenberg
--

COPY public.dose_type (id, description) FROM stdin;
1	Gy
2	%
3	GY
\.


--
-- Data for Name: fractionation; Type: TABLE DATA; Schema: public; Owner: davidrosenberg
--

COPY public.fractionation (id, description, fractions_min, fractions_max) FROM stdin;
1	Conventional	\N	\N
2	\N	3	\N
3	\N	5	\N
4	\N	1	\N
5	\N	10	\N
6	BID	\N	\N
7	\N	8	\N
8	\N	15	16
9	\N	2	\N
10	\N	20	\N
11	\N	28	\N
\.


--
-- Data for Name: intent; Type: TABLE DATA; Schema: public; Owner: davidrosenberg
--

COPY public.intent (id, description) FROM stdin;
1	General
2	Intact
3	Postop
4	Re-irradiation
\.


--
-- Data for Name: note; Type: TABLE DATA; Schema: public; Owner: davidrosenberg
--

COPY public.note (id, region, text, parent) FROM stdin;
\.


--
-- Data for Name: protocol; Type: TABLE DATA; Schema: public; Owner: davidrosenberg
--

COPY public.protocol (id, name, year) FROM stdin;
\.


--
-- Data for Name: publication; Type: TABLE DATA; Schema: public; Owner: davidrosenberg
--

COPY public.publication (id, title, doi, pubmed) FROM stdin;
\.


--
-- Data for Name: region; Type: TABLE DATA; Schema: public; Owner: davidrosenberg
--

COPY public.region (id, target, fractionation, intent, volume, volume_type, volume_deviation, volume_deviation_type, prv, dose, dose_type, dose_deviation, dose_deviation_type, conversion, importance) FROM stdin;
1	1	1	1	0	1	\N	\N	\N	5000	1	\N	\N	\N	\N
2	1	1	1	0	1	\N	\N	\N	6000	1	7200	1	\N	\N
3	1	2	1	3020	2	\N	\N	\N	1800	1	\N	\N	\N	\N
4	1	3	1	1600	2	\N	\N	\N	2500	1	\N	\N	\N	\N
5	1	4	2	1000	2	\N	\N	\N	1200	1	\N	\N	\N	\N
6	1	2	3	1680	2	\N	\N	\N	2400	1	\N	\N	\N	\N
7	1	4	1	800	2	800	3	\N	1200	1	\N	\N	\N	\N
8	1	3	3	5	2	\N	\N	\N	3350	1	\N	\N	\N	\N
9	1	2	1	700	2	\N	\N	\N	2300	1	\N	\N	\N	\N
10	1	3	1	1000	2	1000	3	\N	3000	1	\N	\N	\N	\N
11	1	1	1	100	2	\N	\N	\N	5800	1	\N	\N	\N	Should
12	1	1	1	0	1	\N	\N	\N	6800	1	\N	\N	\N	Should
13	1	4	1	5000	4	\N	\N	\N	500	1	\N	\N	\N	\N
14	2	1	1	3	2	\N	\N	\N	5400	1	\N	\N	\N	\N
15	2	1	1	3	2	\N	\N	30	6000	1	\N	\N	\N	Absolute
16	2	1	1	100	2	1000	2	\N	5900	1	\N	\N	\N	\N
17	2	4	1	0	1	\N	\N	\N	1500	1	\N	\N	\N	\N
18	2	4	1	100	2	\N	\N	\N	1200	1	\N	\N	\N	\N
19	2	4	1	10	2	0	3	\N	1000	1	\N	\N	\N	\N
20	2	2	1	0	1	\N	\N	\N	2310	1	\N	\N	\N	\N
21	2	2	1	10	2	0	3	\N	1800	1	\N	\N	\N	\N
22	2	3	1	0	1	\N	\N	\N	3100	1	\N	\N	\N	\N
23	2	3	1	10	2	0	3	\N	2300	1	\N	\N	\N	\N
24	2	5	1	0	1	\N	\N	\N	4050	1	\N	\N	\N	\N
25	2	5	1	50	2	\N	\N	\N	2940	1	\N	\N	\N	\N
26	2	1	1	0	1	\N	\N	\N	5500	1	6000	1	\N	\N
27	2	1	1	3	2	\N	\N	30	5200	1	\N	\N	\N	\N
28	3	1	1	0	1	\N	\N	\N	4460	1	\N	\N	EQD2	\N
29	3	1	1	0	1	\N	\N	\N	4500	1	\N	\N	\N	Absolute
30	3	6	2	0	1	\N	\N	\N	3600	1	\N	\N	\N	\N
31	3	6	2	0	1	\N	\N	\N	4100	1	\N	\N	\N	\N
32	3	4	1	0	1	\N	\N	\N	2270	1	\N	\N	\N	\N
33	3	1	1	0	1	\N	\N	50	5000	1	\N	\N	\N	Absolute
34	3	4	1	0	1	\N	\N	\N	1240	1	1400	1	\N	\N
35	3	4	1	10	2	0	5	\N	1000	1	\N	\N	\N	\N
36	3	4	1	1000	4	\N	\N	\N	1000	1	\N	\N	\N	\N
37	3	4	1	120	2	\N	\N	\N	700	1	800	1	\N	\N
38	3	4	1	100	2	500	2	\N	700	1	\N	\N	\N	\N
39	3	2	1	10	2	0	5	\N	1800	1	\N	\N	\N	\N
40	3	2	1	120	2	\N	\N	\N	1230	1	1300	1	\N	\N
41	3	2	1	1000	4	\N	\N	\N	1800	1	\N	\N	\N	\N
42	3	2	1	100	2	\N	\N	\N	1230	1	\N	\N	\N	\N
43	3	2	1	0	1	\N	\N	\N	2250	1	\N	\N	\N	\N
44	3	2	1	0	1	\N	\N	\N	2190	1	\N	\N	\N	\N
45	3	2	1	0	1	\N	\N	\N	2030	1	\N	\N	\N	\N
46	3	3	1	0	1	\N	\N	30	3200	1	\N	\N	\N	\N
47	3	3	1	120	2	\N	\N	\N	1450	1	1560	1	\N	\N
48	3	3	1	10	2	0	5	\N	2200	1	2300	1	\N	\N
49	3	3	1	0	1	\N	\N	\N	2530	1	\N	\N	\N	\N
50	3	3	1	0	1	\N	\N	\N	2800	1	\N	\N	\N	\N
51	3	3	1	1000	4	\N	\N	\N	2300	1	\N	\N	\N	\N
52	3	3	1	100	2	\N	\N	\N	1450	1	\N	\N	\N	\N
53	3	3	1	0	1	\N	\N	\N	3000	1	\N	\N	\N	\N
54	3	3	1	50	2	\N	\N	\N	1350	1	\N	\N	\N	\N
55	3	7	1	0	1	\N	\N	\N	3650	1	\N	\N	Extrapolation	\N
56	3	7	1	50	2	\N	\N	\N	3200	1	\N	\N	\N	\N
57	3	7	1	0	1	\N	\N	\N	2800	1	\N	\N	\N	\N
58	3	7	1	50	2	\N	\N	\N	1550	1	\N	\N	Extrapolation	\N
59	3	7	1	0	1	\N	\N	30	3400	1	\N	\N	\N	\N
60	3	7	1	25	2	\N	\N	\N	2700	1	\N	\N	Extrapolation	\N
61	3	7	1	10	2	\N	\N	\N	3200	1	\N	\N	\N	\N
62	3	5	1	0	1	\N	\N	\N	4000	1	\N	\N	\N	\N
63	3	5	1	0	1	\N	\N	\N	3400	1	\N	\N	\N	\N
64	3	5	1	35	2	\N	\N	\N	2940	1	\N	\N	\N	\N
65	3	5	1	10	2	\N	\N	\N	3200	1	\N	\N	\N	\N
66	3	5	1	100	2	\N	\N	\N	3500	1	\N	\N	\N	\N
67	3	5	1	0	1	\N	\N	30	3400	1	\N	\N	\N	\N
68	3	5	1	120	2	\N	\N	\N	1789	1	\N	\N	\N	\N
69	3	8	1	0	1	\N	\N	30	4200	1	\N	\N	\N	\N
70	3	8	1	0	1	\N	\N	\N	3000	1	\N	\N	\N	\N
71	3	8	1	0	1	\N	\N	\N	3950	1	\N	\N	\N	\N
72	3	8	1	0	1	\N	\N	\N	3300	1	3500	1	\N	\N
73	3	8	1	0	1	\N	\N	30	4020	1	4390	1	\N	\N
74	3	8	1	0	1	\N	\N	\N	3650	1	4020	1	\N	\N
75	3	1	1	0	1	\N	\N	\N	5400	1	\N	\N	\N	\N
76	3	3	1	25	2	\N	\N	\N	2250	1	\N	\N	\N	\N
77	3	9	1	0	1	\N	\N	20	1700	1	\N	\N	\N	\N
78	3	1	1	0	1	\N	\N	\N	5040	1	\N	\N	\N	\N
79	4	1	1	0	1	\N	\N	\N	5400	1	5500	1	\N	Must
80	4	1	1	0	1	\N	\N	30	6000	1	\N	\N	\N	Must
81	4	4	1	0	1	\N	\N	\N	1000	1	1200	1	\N	\N
82	4	4	1	10	2	0	6	\N	800	1	\N	\N	\N	\N
83	4	2	1	0	1	\N	\N	\N	1739	1	\N	\N	\N	\N
84	4	2	1	10	2	\N	\N	\N	1500	1	\N	\N	\N	\N
85	4	2	1	20	2	\N	\N	\N	1530	1	\N	\N	\N	\N
86	4	3	1	0	1	\N	\N	\N	2500	1	\N	\N	\N	\N
87	4	3	1	20	2	\N	\N	\N	2300	1	\N	\N	\N	\N
88	4	3	1	10	2	\N	\N	\N	2250	1	\N	\N	\N	\N
89	4	5	1	0	1	\N	\N	\N	3220	1	\N	\N	\N	\N
90	4	5	1	20	2	\N	\N	\N	2940	1	\N	\N	\N	\N
91	4	1	1	3	2	\N	\N	\N	5400	1	5600	1	\N	\N
92	4	1	1	3	2	\N	\N	\N	4680	1	5400	1	\N	\N
93	4	1	1	10000	4	\N	\N	\N	5400	1	\N	\N	\N	\N
94	5	1	1	3	2	\N	\N	\N	5000	1	5500	1	\N	\N
95	5	1	1	10000	4	\N	\N	\N	5400	1	\N	\N	\N	\N
96	6	4	1	0	1	\N	\N	\N	900	1	\N	\N	\N	\N
97	6	3	1	0	1	\N	\N	\N	2500	1	\N	\N	\N	\N
98	6	2	1	0	1	\N	\N	\N	1710	1	\N	\N	\N	\N
99	6	4	1	0	1	\N	\N	\N	400	1	\N	\N	\N	\N
100	6	5	1	0	1	\N	\N	\N	3220	1	\N	\N	\N	\N
101	6	1	1	500	4	\N	\N	\N	5500	1	6000	1	\N	Should
102	6	1	1	0	1	\N	\N	\N	4500	1	5000	1	\N	Should
103	6	1	1	0	1	\N	\N	\N	4500	1	5500	1	\N	\N
104	6	3	4	0	1	\N	\N	\N	1500	1	\N	\N	\N	\N
105	6	1	1	0	1	\N	\N	\N	3500	1	\N	\N	\N	\N
106	6	1	1	5000	4	\N	\N	\N	3000	1	\N	\N	\N	\N
107	6	1	1	0	1	\N	\N	\N	2000	1	\N	\N	\N	\N
108	6	1	1	10000	4	\N	\N	\N	4000	1	\N	\N	\N	\N
109	7	1	1	0	1	\N	\N	\N	4500	1	\N	\N	\N	\N
110	7	4	1	0	1	\N	\N	\N	1300	1	1900	1	\N	\N
111	7	3	1	4000	4	\N	\N	\N	730	1	\N	\N	\N	\N
112	7	1	1	0	1	\N	\N	\N	4000	1	\N	\N	\N	\N
113	7	1	1	0	1	\N	\N	\N	2000	1	\N	\N	\N	Should
114	7	1	1	0	1	\N	\N	\N	2000	1	\N	\N	\N	Should
115	7	1	1	0	1	\N	\N	\N	1800	1	\N	\N	\N	\N
116	8	1	1	0	1	\N	\N	\N	1600	1	1700	1	\N	\N
117	8	1	1	0	1	\N	\N	\N	1400	1	\N	\N	\N	\N
118	8	1	1	0	1	\N	\N	\N	900	1	1000	1	\N	\N
119	8	1	1	0	1	\N	\N	\N	720	1	\N	\N	EQD2	Can
120	9	1	1	0	1	\N	\N	\N	1000	1	\N	\N	\N	\N
121	10	1	1	0	1	\N	\N	\N	600	1	1500	1	\N	\N
122	10	4	1	10	2	\N	\N	\N	150	1	\N	\N	\N	\N
123	10	2	1	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
124	10	3	4	0	1	\N	\N	\N	500	1	\N	\N	\N	\N
125	10	1	1	0	1	\N	\N	\N	700	1	\N	\N	\N	\N
126	10	8	1	0	1	\N	\N	\N	400	1	\N	\N	\N	\N
127	10	1	1	3	2	\N	\N	\N	500	1	700	1	\N	\N
128	10	1	1	0	1	\N	\N	\N	2500	1	\N	\N	\N	\N
129	10	1	1	0	1	\N	\N	\N	1440	1	\N	\N	\N	\N
130	10	1	1	10000	4	\N	\N	\N	600	1	\N	\N	\N	\N
131	11	1	1	0	1	\N	\N	\N	5500	1	\N	\N	\N	\N
132	11	1	1	0	1	\N	\N	\N	3500	1	\N	\N	\N	\N
133	11	3	1	0	1	\N	\N	\N	3200	1	\N	\N	\N	\N
134	11	2	1	0	1	\N	\N	\N	2600	1	\N	\N	\N	\N
135	11	4	1	10	2	\N	\N	\N	800	1	\N	\N	\N	\N
136	11	2	1	0	1	\N	\N	\N	2400	1	\N	\N	\N	\N
137	11	2	1	300	2	\N	\N	\N	2039	1	2200	1	\N	\N
138	11	2	1	50	2	\N	\N	\N	2400	1	2600	1	\N	\N
139	11	3	1	50	2	\N	\N	\N	2700	1	2900	1	\N	\N
140	11	3	1	300	2	\N	\N	\N	2700	1	3000	1	\N	\N
141	11	3	1	0	1	\N	\N	\N	3050	1	\N	\N	\N	\N
142	11	1	1	0	1	\N	\N	\N	3000	1	\N	\N	\N	\N
143	11	1	1	10000	4	\N	\N	\N	4500	1	\N	\N	\N	\N
144	12	1	1	3	2	\N	\N	\N	4500	1	\N	\N	\N	Must
145	12	2	1	0	1	\N	\N	\N	2550	1	\N	\N	\N	\N
146	12	2	1	0	1	\N	\N	\N	2400	1	\N	\N	\N	\N
147	12	2	1	500	2	\N	\N	\N	2190	1	\N	\N	\N	\N
148	12	2	1	50	2	\N	\N	\N	2400	1	2600	1	\N	\N
149	12	3	4	0	1	\N	\N	\N	1500	1	\N	\N	\N	\N
150	12	3	1	0	1	\N	\N	\N	3200	1	\N	\N	\N	\N
151	12	3	1	500	2	\N	\N	\N	3000	1	\N	\N	\N	\N
152	12	1	1	3	2	\N	\N	30	5000	1	\N	\N	\N	Must
153	12	1	1	3	2	\N	\N	\N	4500	1	5000	1	\N	\N
154	13	1	1	0	1	\N	\N	\N	3000	1	\N	\N	\N	Must
155	13	1	1	0	1	\N	\N	30	3500	1	\N	\N	\N	Must
156	14	1	1	0	1	\N	\N	\N	6900	1	\N	\N	\N	\N
157	14	1	1	10	2	0	3	\N	7500	1	\N	\N	\N	\N
158	14	1	1	50	2	100	7	\N	7400	1	\N	\N	\N	\N
159	14	1	1	100	2	100	3	\N	7000	1	\N	\N	\N	\N
160	14	1	1	200	2	200	3	\N	6600	1	\N	\N	\N	\N
161	14	4	1	0	1	\N	\N	\N	1750	1	\N	\N	\N	\N
162	14	4	1	300	2	\N	\N	\N	1400	1	\N	\N	\N	\N
163	14	2	1	0	1	\N	\N	\N	2600	1	\N	\N	\N	\N
164	14	2	1	0	1	\N	\N	\N	2400	1	\N	\N	\N	\N
165	14	2	1	300	2	\N	\N	\N	2039	1	2200	1	\N	\N
166	14	2	1	50	2	\N	\N	\N	2400	1	2600	1	\N	\N
167	14	3	1	50	2	\N	\N	\N	2700	1	2900	1	\N	\N
168	14	3	1	300	2	\N	\N	\N	2700	1	3000	1	\N	\N
169	14	3	1	0	1	\N	\N	\N	3050	1	\N	\N	\N	\N
170	14	3	1	0	1	\N	\N	\N	3200	1	\N	\N	\N	\N
171	14	3	1	0	1	\N	\N	\N	3500	1	\N	\N	\N	\N
172	14	7	1	50	2	\N	\N	\N	3800	1	4136	1	\N	\N
173	14	7	1	0	1	\N	\N	\N	3900	1	\N	\N	\N	\N
174	14	7	1	50	2	\N	\N	\N	2700	1	3800	1	\N	\N
175	14	5	1	0	1	\N	\N	\N	5500	1	\N	\N	Extrapolation	\N
176	14	5	1	20	2	\N	\N	\N	5000	1	\N	\N	\N	\N
177	14	5	1	0	1	\N	\N	\N	3900	1	\N	\N	\N	\N
178	14	5	1	300	2	\N	\N	\N	3490	1	\N	\N	\N	\N
179	14	8	1	0	1	\N	\N	\N	5000	1	\N	\N	\N	\N
180	14	8	1	0	1	\N	\N	\N	4980	1	5200	1	\N	\N
181	14	1	1	0	1	\N	\N	\N	6600	1	\N	\N	\N	\N
182	15	1	1	\N	\N	\N	\N	\N	6600	1	7000	1	\N	\N
183	15	4	1	0	1	\N	\N	\N	1600	1	\N	\N	\N	\N
184	15	4	1	500	2	\N	\N	\N	1400	1	\N	\N	\N	\N
185	15	2	1	500	2	\N	\N	\N	2190	1	\N	\N	\N	\N
186	15	2	1	0	1	\N	\N	\N	2550	1	\N	\N	\N	\N
187	15	2	1	0	1	\N	\N	\N	2400	1	\N	\N	\N	\N
188	15	3	1	500	2	\N	\N	\N	3000	1	\N	\N	\N	\N
189	15	3	1	0	1	\N	\N	\N	3200	1	\N	\N	\N	\N
190	15	5	1	0	1	\N	\N	\N	4190	1	\N	\N	\N	\N
191	15	5	1	500	2	\N	\N	\N	3910	1	\N	\N	\N	\N
192	16	1	1	0	1	\N	\N	\N	6600	1	7000	1	\N	\N
193	16	2	1	0	1	\N	\N	\N	2400	1	\N	\N	\N	\N
194	16	2	1	500	2	\N	\N	\N	2250	1	\N	\N	\N	\N
195	16	3	1	500	2	\N	\N	\N	3000	1	\N	\N	\N	\N
196	16	3	1	0	1	\N	\N	\N	3200	1	\N	\N	\N	\N
197	16	5	1	500	2	\N	\N	\N	3910	1	\N	\N	\N	\N
198	16	5	1	0	1	\N	\N	\N	4190	1	\N	\N	\N	\N
199	16	4	1	500	2	\N	\N	\N	1440	1	\N	\N	\N	\N
200	16	4	1	0	1	\N	\N	\N	1600	1	1800	1	\N	\N
201	16	9	1	0	1	\N	\N	\N	2600	1	\N	\N	\N	\N
202	17	1	1	0	1	\N	\N	\N	2000	1	3000	1	\N	\N
203	17	4	1	0	1	\N	\N	\N	2600	1	2750	1	\N	\N
204	17	4	1	1000	2	\N	\N	\N	2300	1	2550	1	\N	\N
205	17	2	1	1000	2	\N	\N	\N	3000	1	3100	1	\N	\N
206	17	2	1	0	1	\N	\N	\N	3300	1	\N	\N	\N	\N
207	17	3	1	0	1	\N	\N	\N	3850	1	3950	1	\N	\N
208	17	3	4	1000	2	\N	\N	\N	3950	1	\N	\N	\N	\N
209	17	3	1	1000	2	\N	\N	\N	3650	1	\N	\N	\N	\N
210	17	3	1	1000	2	\N	\N	\N	3000	1	\N	\N	\N	\N
211	17	3	1	0	1	\N	\N	\N	3200	1	\N	\N	\N	\N
212	17	5	1	0	1	\N	\N	\N	8200	1	\N	\N	\N	\N
213	17	5	1	0	1	\N	\N	\N	5230	1	\N	\N	\N	\N
214	17	5	1	6000	2	\N	\N	\N	5000	1	\N	\N	\N	\N
215	17	5	1	1000	2	\N	\N	\N	4810	1	\N	\N	\N	\N
216	17	5	1	12000	2	\N	\N	\N	4000	1	\N	\N	\N	\N
217	17	5	1	25000	2	\N	\N	\N	3000	1	\N	\N	\N	\N
218	17	1	1	5000	4	\N	\N	\N	2000	1	\N	\N	\N	\N
219	18	1	4	0	1	\N	\N	\N	12000	1	\N	\N	EQD2	\N
220	18	1	1	0	1	\N	\N	\N	4000	1	\N	\N	\N	Can
221	18	3	4	0	1	\N	\N	\N	3250	1	\N	\N	\N	\N
222	19	1	1	0	1	\N	\N	\N	6500	1	7200	1	\N	\N
223	19	1	1	0	1	\N	\N	\N	7000	1	7200	1	\N	\N
224	19	3	4	0	1	\N	\N	\N	500	1	\N	\N	\N	\N
225	20	1	1	0	1	\N	\N	\N	2000	1	\N	\N	\N	Can
226	20	1	1	0	1	\N	\N	\N	3500	1	5000	1	\N	\N
227	21	1	1	0	1	\N	\N	\N	3000	1	\N	\N	\N	Can
228	22	1	1	0	1	\N	\N	\N	4000	1	5000	1	\N	\N
229	22	1	1	0	1	\N	\N	\N	3000	1	6000	1	\N	Should
230	22	1	1	0	1	\N	\N	\N	5500	1	6500	1	\N	\N
231	23	1	1	0	1	\N	\N	\N	2500	1	\N	\N	\N	Must
232	23	1	1	0	1	\N	\N	\N	6000	1	\N	\N	\N	\N
233	23	1	1	0	1	\N	\N	\N	3500	1	\N	\N	\N	\N
234	23	1	1	0	1	\N	\N	30	3000	1	\N	\N	\N	Must
235	23	1	1	0	1	\N	\N	\N	3000	1	4140	1	\N	\N
236	24	1	1	0	1	\N	\N	\N	2600	1	3300	1	\N	\N
237	24	1	1	5000	4	\N	\N	\N	3000	1	\N	\N	\N	\N
238	25	1	1	0	1	\N	\N	\N	2000	1	2400	1	\N	Should
239	25	1	1	5000	4	\N	\N	\N	3000	1	\N	\N	\N	\N
240	25	1	1	3300	4	\N	\N	\N	4000	1	\N	\N	\N	\N
241	26	1	1	0	1	\N	\N	\N	2400	1	2600	1	\N	Should
242	26	1	1	2000	2	\N	\N	\N	2000	1	\N	\N	\N	\N
243	26	9	1	0	1	\N	\N	\N	500	1	\N	\N	\N	\N
244	27	1	1	0	1	\N	\N	\N	3000	1	3500	1	\N	Should
245	28	1	1	0	1	\N	\N	\N	3900	1	\N	\N	\N	\N
246	29	1	1	0	1	\N	\N	\N	4500	1	\N	\N	\N	\N
247	29	1	1	0	1	\N	\N	\N	3700	1	4000	1	\N	Should
248	29	3	4	0	1	\N	\N	\N	3000	1	\N	\N	\N	\N
249	29	1	1	2500	4	\N	\N	\N	5000	1	\N	\N	\N	\N
250	29	1	1	6250	4	\N	\N	\N	2500	1	\N	\N	\N	\N
251	29	1	1	9300	4	\N	\N	\N	500	1	\N	\N	\N	\N
252	29	1	1	8200	4	\N	\N	\N	2000	1	\N	\N	\N	\N
253	29	1	1	6300	4	7000	4	\N	2500	1	\N	\N	\N	\N
254	29	1	1	6200	4	\N	\N	\N	3000	1	\N	\N	\N	\N
255	29	1	1	220	2	\N	\N	\N	2500	1	\N	\N	\N	\N
256	29	1	1	2000	4	\N	\N	\N	2600	1	\N	\N	\N	\N
257	29	1	1	0	1	\N	\N	\N	3060	1	\N	\N	\N	\N
258	30	1	1	0	1	\N	\N	\N	6100	1	\N	\N	\N	\N
259	30	1	1	9860	4	\N	\N	\N	2700	1	\N	\N	\N	\N
260	31	1	1	0	1	\N	\N	\N	3000	1	5500	1	\N	Should
261	32	1	1	0	1	\N	\N	\N	\N	\N	5500	1	\N	Should
262	33	1	1	0	1	\N	\N	\N	5000	1	5500	1	\N	Should
263	34	1	1	0	1	\N	\N	\N	5000	1	\N	\N	\N	\N
264	34	1	1	0	1	\N	\N	\N	5000	1	\N	\N	\N	\N
265	35	1	1	0	1	\N	\N	\N	6300	1	6600	1	\N	\N
266	35	1	1	0	1	\N	\N	\N	4500	1	\N	\N	\N	\N
267	35	1	1	1500	4	\N	\N	\N	6000	1	\N	\N	\N	\N
268	35	1	1	3300	4	\N	\N	\N	5000	1	\N	\N	\N	\N
269	35	1	1	6600	4	\N	\N	\N	5000	1	\N	\N	\N	\N
270	35	3	4	0	1	\N	\N	\N	1500	1	\N	\N	\N	\N
271	35	4	1	0	1	\N	\N	\N	2020	1	\N	\N	\N	\N
272	35	4	1	400	2	\N	\N	\N	1050	1	\N	\N	\N	\N
273	35	9	1	0	1	\N	\N	\N	2000	1	\N	\N	\N	\N
274	35	9	1	0	1	\N	\N	\N	800	1	\N	\N	\N	\N
275	35	1	1	0	1	\N	\N	\N	1980	1	\N	\N	\N	\N
276	36	1	1	0	1	\N	\N	\N	3500	1	4000	1	\N	Should
277	36	1	1	0	1	\N	\N	\N	5000	1	\N	\N	\N	\N
278	36	1	1	0	1	\N	\N	\N	2000	1	\N	\N	\N	\N
279	37	1	1	0	1	\N	\N	\N	4000	1	\N	\N	\N	Should
280	38	1	1	3300	4	\N	\N	\N	5000	1	\N	\N	\N	\N
281	38	1	1	1500	4	\N	\N	\N	6000	1	\N	\N	\N	\N
282	38	1	1	0	1	\N	\N	\N	4500	1	\N	\N	\N	\N
283	38	9	1	0	1	\N	\N	\N	2000	1	\N	\N	\N	\N
284	38	9	1	0	1	\N	\N	\N	800	1	\N	\N	\N	\N
285	39	1	1	100	4	200	4	\N	7000	1	7500	1	\N	\N
286	39	1	1	0	1	\N	\N	\N	6600	1	\N	\N	\N	\N
287	39	1	1	1400	4	\N	\N	\N	6000	1	\N	\N	\N	\N
288	39	1	1	0	1	\N	\N	\N	7200	1	\N	\N	\N	Should
289	39	3	4	0	1	\N	\N	\N	2000	1	\N	\N	\N	\N
290	39	1	1	4200	4	\N	\N	\N	4400	1	\N	\N	\N	\N
291	39	1	1	2500	4	\N	\N	\N	5200	1	\N	\N	\N	\N
292	39	1	1	100	2	\N	\N	\N	7500	1	\N	\N	\N	\N
293	40	1	1	0	1	\N	\N	\N	3000	1	\N	\N	\N	Should
294	40	1	1	0	1	\N	\N	\N	5000	1	\N	\N	\N	\N
295	41	1	1	100	2	100	3	\N	7400	1	\N	\N	\N	\N
296	41	1	1	0	1	\N	\N	\N	3400	1	3700	1	\N	\N
297	41	1	1	1700	4	\N	\N	\N	6000	1	\N	\N	\N	\N
298	41	1	1	700	4	\N	\N	\N	6000	1	\N	\N	\N	\N
299	41	1	1	3300	4	\N	\N	\N	5500	1	\N	\N	\N	\N
300	41	4	1	0	1	\N	\N	\N	1540	1	\N	\N	\N	\N
301	41	4	1	500	2	\N	\N	\N	1190	1	\N	\N	\N	\N
302	41	2	1	0	1	\N	\N	\N	2700	1	\N	\N	\N	\N
303	41	2	1	500	2	\N	\N	\N	1770	1	\N	\N	\N	\N
304	41	2	1	0	1	\N	\N	\N	2520	1	\N	\N	\N	\N
305	41	3	1	5	2	\N	\N	\N	5250	1	6300	1	\N	\N
306	41	3	1	0	1	\N	\N	\N	4000	1	\N	\N	\N	\N
307	41	3	1	500	2	\N	\N	\N	3500	1	\N	\N	\N	\N
308	41	3	1	50	2	\N	\N	\N	3200	1	3400	1	\N	\N
309	41	3	1	500	2	\N	\N	\N	1950	1	2750	1	\N	\N
310	41	3	1	0	1	\N	\N	\N	3500	1	\N	\N	\N	\N
311	41	7	1	0	1	\N	\N	\N	6300	1	\N	\N	Extrapolation	\N
312	41	7	1	50	2	\N	\N	\N	4000	1	\N	\N	\N	\N
313	41	7	1	0	1	\N	\N	\N	4000	1	4352	1	\N	\N
314	41	7	1	500	2	\N	\N	\N	3279	1	\N	\N	Extrapolation	\N
315	41	7	1	500	2	\N	\N	\N	4000	1	\N	\N	\N	\N
316	41	7	1	0	1	\N	\N	\N	4500	1	\N	\N	\N	\N
317	41	5	1	0	1	\N	\N	\N	5000	1	\N	\N	Extrapolation	\N
318	41	5	1	500	2	\N	\N	\N	2460	1	\N	\N	\N	\N
319	41	5	1	0	1	\N	\N	\N	4500	1	\N	\N	\N	\N
320	41	5	1	100	2	\N	\N	\N	4000	1	\N	\N	\N	\N
321	41	5	1	500	2	\N	\N	\N	4000	1	\N	\N	\N	\N
322	41	1	1	2000	4	\N	\N	\N	7000	1	\N	\N	\N	\N
323	41	1	1	4000	4	\N	\N	\N	5000	1	\N	\N	\N	\N
324	41	1	1	5000	4	\N	\N	\N	3500	1	\N	\N	\N	\N
325	41	1	1	0	1	0	1	\N	5000	1	6000	1	\N	\N
326	41	8	1	0	1	\N	\N	\N	5890	1	6130	1	\N	\N
327	41	8	1	0	1	\N	\N	\N	5310	1	\N	\N	\N	\N
328	41	8	1	0	1	\N	\N	\N	5050	1	\N	\N	\N	\N
329	41	8	1	500	2	\N	\N	\N	4800	1	\N	\N	\N	\N
330	41	8	1	400	2	\N	\N	\N	5000	1	\N	\N	\N	\N
331	41	8	1	0	1	\N	\N	\N	4000	1	5000	1	\N	\N
332	41	8	1	0	1	\N	\N	\N	3100	1	3200	1	\N	\N
333	41	9	1	0	1	\N	\N	\N	2000	1	\N	\N	\N	\N
334	41	1	1	5000	4	\N	\N	\N	4000	1	\N	\N	\N	\N
335	42	1	1	0	1	\N	\N	\N	2600	1	3500	1	\N	\N
336	42	1	1	0	1	\N	\N	\N	1500	1	2000	1	\N	\N
337	42	1	1	0	1	\N	\N	\N	7000	1	\N	\N	\N	\N
338	42	1	1	3300	4	\N	\N	\N	6000	1	\N	\N	\N	\N
339	42	1	1	6700	4	\N	\N	\N	4500	1	\N	\N	\N	\N
340	42	1	1	8000	4	10000	4	\N	4000	1	\N	\N	\N	\N
341	42	1	1	2500	4	3300	4	\N	5000	1	\N	\N	\N	\N
342	42	1	1	3500	4	\N	\N	\N	4500	1	\N	\N	\N	\N
343	42	4	1	0	1	\N	\N	\N	2200	1	\N	\N	\N	\N
344	42	4	1	1500	2	\N	\N	\N	1600	1	\N	\N	\N	\N
345	42	2	1	0	1	\N	\N	\N	3600	1	\N	\N	\N	\N
346	42	2	1	0	1	\N	\N	\N	3000	1	\N	\N	\N	\N
347	42	2	1	50	2	\N	\N	\N	2400	1	2600	1	\N	\N
348	42	2	1	1500	2	\N	\N	\N	2400	1	\N	\N	\N	\N
349	42	3	1	0	1	\N	\N	\N	6200	1	\N	\N	\N	\N
350	42	3	1	5	2	\N	\N	\N	5250	1	6300	1	\N	\N
351	42	3	1	1000	2	\N	\N	\N	5000	1	\N	\N	\N	\N
352	42	3	1	0	1	\N	\N	\N	3800	1	\N	\N	\N	\N
353	42	3	1	0	1	\N	\N	\N	3000	1	\N	\N	\N	\N
354	42	3	1	1500	2	\N	\N	\N	3200	1	\N	\N	\N	\N
355	42	3	1	50	2	\N	\N	\N	2700	1	2900	1	\N	\N
356	42	7	1	0	1	\N	\N	\N	6400	1	\N	\N	Extrapolation	\N
357	42	7	1	50	2	\N	\N	\N	5000	1	6000	1	\N	\N
358	42	7	1	1000	2	\N	\N	\N	6000	1	\N	\N	\N	\N
359	42	7	1	0	1	\N	\N	\N	4400	1	\N	\N	\N	\N
360	42	7	1	1500	2	\N	\N	\N	3840	1	\N	\N	\N	\N
361	42	5	1	0	1	\N	\N	\N	6400	1	\N	\N	\N	\N
362	42	5	1	0	1	\N	\N	\N	6000	1	\N	\N	Extrapolation	\N
363	42	5	1	1000	2	\N	\N	\N	6000	1	\N	\N	\N	\N
364	42	5	1	100	2	\N	\N	\N	4500	1	\N	\N	\N	\N
365	42	5	1	1500	2	\N	\N	\N	4190	1	\N	\N	\N	\N
366	42	1	1	5000	4	\N	\N	\N	4000	1	4500	1	\N	\N
367	42	1	1	3000	4	\N	\N	\N	4000	1	4500	1	\N	\N
368	42	1	1	5000	4	\N	\N	\N	3000	1	\N	\N	\N	\N
369	42	1	1	10000	4	\N	\N	\N	3000	1	\N	\N	\N	\N
370	42	1	1	7700	4	\N	\N	\N	2000	1	\N	\N	\N	\N
371	42	1	1	8600	4	\N	\N	\N	1000	1	\N	\N	\N	\N
372	42	1	1	9400	4	\N	\N	\N	500	1	\N	\N	\N	\N
373	42	7	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
374	42	8	1	0	1	\N	\N	\N	6600	1	\N	\N	\N	\N
375	42	8	1	1000	2	\N	\N	\N	6200	1	\N	\N	\N	\N
376	42	8	1	0	1	\N	\N	\N	5500	1	\N	\N	\N	\N
377	42	8	1	100	2	\N	\N	\N	5000	1	\N	\N	\N	\N
378	42	8	1	0	1	\N	\N	\N	4980	1	5200	1	\N	\N
379	42	8	1	1000	4	\N	\N	\N	4000	1	\N	\N	\N	\N
380	42	8	1	0	1	\N	\N	\N	4000	1	5000	1	\N	\N
381	42	8	1	0	1	\N	\N	\N	1650	1	1850	1	\N	\N
382	42	1	1	0	1	\N	\N	\N	400	1	500	1	\N	\N
383	42	1	1	0	1	\N	\N	\N	3500	1	4000	1	\N	\N
384	42	1	1	500	4	\N	\N	\N	4000	1	\N	\N	\N	\N
385	42	1	1	1000	4	\N	\N	\N	2000	1	\N	\N	\N	\N
386	42	8	1	500	4	\N	\N	\N	1600	1	2000	1	\N	\N
387	42	8	1	3000	4	3500	4	\N	800	1	\N	\N	\N	\N
388	42	8	1	0	4	\N	\N	\N	1600	1	2000	1	\N	\N
389	42	8	1	1000	4	1500	4	\N	800	1	\N	\N	\N	\N
390	42	8	1	0	1	\N	\N	\N	320	1	400	1	\N	\N
391	42	1	1	500	4	\N	\N	\N	2000	1	2500	1	\N	\N
392	42	1	1	3000	4	3500	4	\N	1000	1	1500	1	\N	\N
393	42	1	1	0	4	\N	\N	\N	2000	1	2500	1	\N	\N
394	42	1	1	1000	4	1500	4	\N	1000	1	1500	1	\N	\N
395	42	3	1	500	4	\N	\N	\N	700	1	\N	\N	\N	\N
396	42	3	1	3000	4	\N	\N	\N	150	1	\N	\N	\N	\N
397	42	3	1	1000	4	\N	\N	\N	300	1	\N	\N	\N	\N
398	42	5	1	0	1	\N	\N	\N	3600	1	\N	\N	\N	\N
399	42	1	1	0	1	\N	\N	\N	3000	1	\N	\N	\N	\N
400	42	1	1	2000	4	3000	4	\N	3000	1	\N	\N	\N	\N
401	42	1	1	0	1	\N	\N	\N	500	1	1500	1	\N	\N
402	42	1	1	1000	4	3500	4	\N	1500	1	\N	\N	\N	\N
403	42	1	1	1500	4	2000	4	\N	3000	1	\N	\N	\N	\N
404	42	1	1	10000	4	\N	\N	\N	3000	1	\N	\N	\N	\N
405	42	1	1	0	1	\N	\N	\N	400	1	500	1	\N	\N
406	42	1	1	0	4	\N	\N	\N	2500	1	3000	1	\N	\N
407	42	1	1	500	4	\N	\N	\N	2500	1	3000	1	\N	\N
408	43	1	1	0	1	\N	\N	\N	4100	1	5100	1	\N	\N
409	44	4	1	0	1	\N	\N	\N	3700	1	\N	\N	\N	\N
410	44	4	1	1000	2	\N	\N	\N	3100	1	\N	\N	\N	\N
411	44	2	1	0	1	\N	\N	\N	4500	1	\N	\N	\N	\N
412	44	2	1	1000	2	\N	\N	\N	3900	1	\N	\N	\N	\N
413	44	2	1	50	2	\N	\N	\N	4500	1	\N	\N	\N	\N
414	44	3	1	0	1	\N	\N	\N	6200	1	\N	\N	\N	\N
415	44	3	1	5	2	\N	\N	\N	5250	1	6300	1	\N	\N
416	44	3	1	1000	2	\N	\N	\N	5000	1	\N	\N	\N	\N
417	44	3	1	1000	2	\N	\N	\N	4700	1	\N	\N	\N	\N
418	44	3	1	50	2	\N	\N	\N	5300	1	\N	\N	\N	\N
419	44	7	1	0	1	\N	\N	\N	6300	1	\N	\N	Extrapolation	\N
420	44	7	1	1000	2	\N	\N	\N	5680	1	\N	\N	Extrapolation	\N
421	44	5	1	0	1	\N	\N	\N	7500	1	\N	\N	Extrapolation	\N
422	44	5	1	100	2	\N	\N	\N	5000	1	\N	\N	\N	\N
423	44	5	1	1000	2	\N	\N	\N	6350	1	\N	\N	\N	\N
424	44	5	1	0	1	\N	\N	\N	6400	1	\N	\N	\N	\N
425	44	5	1	1000	2	\N	\N	\N	6000	1	\N	\N	\N	\N
426	44	7	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
427	44	8	1	0	1	\N	\N	\N	6400	1	\N	\N	\N	\N
428	44	8	1	1000	2	\N	\N	\N	6000	1	\N	\N	\N	\N
429	44	8	1	0	1	\N	\N	\N	5350	1	5500	1	\N	\N
430	45	1	1	1400	4	\N	\N	\N	1500	1	\N	\N	\N	\N
431	46	1	1	1000	4	\N	\N	\N	1500	1	\N	\N	\N	\N
432	47	1	1	0	1	\N	\N	\N	3000	1	4400	1	\N	\N
433	48	1	1	100	4	\N	\N	\N	1500	1	\N	\N	\N	\N
434	48	1	1	0	1	\N	\N	\N	4100	1	5600	1	\N	\N
435	48	1	1	1000	4	\N	\N	\N	500	1	\N	\N	\N	\N
436	48	1	1	500	4	\N	\N	\N	2500	1	\N	\N	\N	\N
437	48	1	1	0	1	\N	\N	\N	200	1	1000	1	\N	\N
438	49	4	1	0	1	\N	\N	\N	2020	1	\N	\N	\N	\N
439	49	4	1	400	2	\N	\N	\N	1050	1	\N	\N	\N	\N
440	49	4	1	400	2	\N	\N	\N	1739	1	\N	\N	\N	\N
441	49	2	1	0	1	\N	\N	\N	3000	1	\N	\N	\N	\N
442	49	2	1	400	2	\N	\N	\N	1500	1	\N	\N	\N	\N
443	49	2	1	500	2	\N	\N	\N	2580	1	\N	\N	\N	\N
444	49	2	1	50	2	\N	\N	\N	3000	1	3200	1	\N	\N
445	49	3	1	0	1	\N	\N	\N	6000	1	\N	\N	\N	\N
446	49	3	1	1000	2	\N	\N	\N	5000	1	\N	\N	\N	\N
447	49	3	1	500	2	\N	\N	\N	3200	1	\N	\N	\N	\N
448	49	3	1	400	2	\N	\N	\N	1650	1	1800	1	\N	\N
449	49	3	1	5	2	\N	\N	\N	5250	1	6300	1	\N	\N
450	49	3	1	3	2	\N	\N	\N	5000	1	\N	\N	\N	\N
451	49	3	1	33	2	\N	\N	\N	4710	1	\N	\N	\N	\N
452	49	3	1	0	1	\N	\N	\N	4000	1	\N	\N	\N	\N
453	49	3	1	50	2	\N	\N	\N	3200	1	3500	1	\N	\N
454	49	7	1	0	1	\N	\N	\N	6400	1	\N	\N	\N	\N
455	49	7	1	50	2	\N	\N	\N	3200	1	4400	1	\N	\N
456	49	7	1	0	1	\N	\N	\N	4400	1	4668	1	\N	\N
457	49	7	1	1000	2	\N	\N	\N	6000	1	\N	\N	\N	\N
458	49	7	1	400	2	\N	\N	\N	2080	1	\N	\N	Extrapolation	\N
459	49	7	1	0	1	\N	\N	\N	6300	1	\N	\N	Extrapolation	\N
460	49	5	1	0	1	\N	\N	\N	6400	1	\N	\N	\N	\N
461	49	5	1	1000	2	\N	\N	\N	6000	1	\N	\N	\N	\N
462	49	5	1	100	2	\N	\N	\N	4000	1	\N	\N	\N	\N
463	49	5	1	400	2	\N	\N	\N	2060	1	\N	\N	\N	\N
464	49	5	1	0	1	\N	\N	\N	6000	1	\N	\N	\N	\N
465	49	8	1	0	1	\N	\N	\N	6600	1	\N	\N	\N	\N
466	49	8	1	1000	2	\N	\N	\N	6200	1	\N	\N	\N	\N
467	49	8	1	0	1	\N	\N	\N	5200	1	5350	1	\N	\N
468	49	8	1	0	1	\N	\N	\N	4000	1	5000	1	\N	\N
469	49	9	1	0	1	\N	\N	\N	2000	1	\N	\N	\N	\N
470	50	1	1	0	1	\N	\N	\N	8000	1	\N	\N	\N	\N
471	50	4	1	0	1	\N	\N	\N	1330	1	\N	\N	\N	\N
472	50	4	1	50	2	\N	\N	\N	1240	1	\N	\N	\N	\N
473	50	2	1	0	1	\N	\N	\N	2310	1	\N	\N	\N	\N
474	50	2	1	50	2	\N	\N	\N	1889	1	\N	\N	\N	\N
475	50	3	1	0	1	\N	\N	\N	3300	1	\N	\N	\N	\N
476	50	3	1	50	2	\N	\N	\N	2100	1	\N	\N	\N	\N
477	50	5	1	0	1	\N	\N	\N	6000	1	\N	\N	\N	\N
478	50	5	1	100	2	\N	\N	\N	5000	1	\N	\N	\N	\N
479	50	1	1	1200	4	\N	\N	\N	7500	1	\N	\N	\N	\N
480	50	3	1	0	1	\N	\N	\N	3800	1	\N	\N	\N	\N
481	50	8	1	0	1	\N	\N	\N	4000	1	5000	1	\N	\N
482	50	9	1	0	1	\N	\N	\N	2000	1	\N	\N	\N	\N
483	51	1	1	0	1	\N	\N	\N	2000	1	\N	\N	\N	\N
484	51	1	1	0	1	\N	\N	\N	1500	1	1700	1	\N	\N
485	51	1	1	0	1	\N	\N	\N	1270	1	\N	\N	\N	\N
486	51	1	1	0	1	\N	\N	\N	1000	1	\N	\N	\N	\N
487	51	1	1	3700	4	4000	4	\N	2000	1	\N	\N	\N	\N
488	51	1	1	2500	4	3000	4	\N	2000	1	\N	\N	\N	\N
489	51	1	1	4000	4	\N	\N	\N	1000	1	\N	\N	\N	\N
490	51	1	1	6000	4	6500	4	\N	500	1	\N	\N	\N	\N
491	51	1	1	5000	4	\N	\N	\N	500	1	\N	\N	\N	\N
492	51	1	3	3600	4	\N	\N	\N	500	1	\N	\N	\N	\N
493	51	4	1	3700	4	\N	\N	\N	800	1	\N	\N	\N	\N
494	51	4	1	0	1	\N	\N	\N	700	1	\N	\N	\N	\N
495	51	4	1	0	1	\N	\N	\N	740	1	\N	\N	\N	\N
496	51	4	1	0	1	\N	\N	\N	760	1	\N	\N	\N	\N
497	51	2	1	1500	4	\N	\N	\N	2000	1	\N	\N	\N	\N
498	51	2	1	1000	4	\N	\N	\N	2000	1	\N	\N	\N	\N
499	51	2	1	0	1	\N	\N	\N	1240	1	\N	\N	\N	\N
500	51	2	1	0	1	\N	\N	\N	1140	1	\N	\N	\N	\N
501	51	2	1	0	1	\N	\N	\N	1100	1	\N	\N	\N	\N
502	51	2	1	0	1	\N	\N	\N	1050	1	\N	\N	\N	\N
503	51	2	1	0	1	\N	\N	\N	1160	1	\N	\N	\N	\N
504	51	3	1	0	1	\N	\N	\N	600	1	\N	\N	\N	\N
505	51	3	1	0	1	\N	\N	\N	1200	1	\N	\N	\N	\N
506	51	3	1	1000	4	\N	\N	\N	2000	1	\N	\N	\N	\N
507	51	3	1	0	1	\N	\N	\N	1250	1	\N	\N	\N	\N
508	51	3	1	0	1	\N	\N	\N	1350	1	\N	\N	\N	\N
509	51	3	1	0	1	\N	\N	\N	1350	1	\N	\N	\N	\N
510	51	7	1	0	1	\N	\N	\N	1200	1	\N	\N	\N	\N
511	51	7	1	1000	4	\N	\N	\N	2000	1	\N	\N	\N	\N
512	51	5	1	0	1	\N	\N	\N	900	1	\N	\N	\N	\N
513	51	5	1	0	1	\N	\N	\N	1650	1	\N	\N	\N	\N
514	51	5	1	0	1	\N	\N	\N	1200	1	\N	\N	\N	\N
515	51	5	1	0	1	\N	\N	\N	1520	1	\N	\N	\N	\N
516	51	5	1	700	4	\N	\N	\N	4000	1	\N	\N	\N	\N
517	51	1	1	0	1	\N	\N	\N	1800	1	\N	\N	\N	\N
518	51	8	1	0	1	\N	\N	\N	1650	1	1850	1	\N	\N
519	51	8	1	3700	4	4000	4	\N	1650	1	\N	\N	\N	\N
520	51	8	1	0	1	\N	\N	\N	1200	1	\N	\N	\N	\N
521	51	8	1	0	1	\N	\N	\N	1400	1	\N	\N	\N	\N
522	51	8	1	6500	4	7000	4	\N	500	1	\N	\N	\N	\N
523	51	8	1	4000	4	5000	4	\N	500	1	\N	\N	\N	\N
524	51	1	1	0	1	\N	\N	\N	850	1	\N	\N	\N	\N
525	51	1	1	1000	4	\N	\N	\N	4000	1	\N	\N	\N	\N
526	51	1	1	1500	4	\N	\N	\N	3000	1	\N	\N	\N	\N
527	51	1	1	2000	4	\N	\N	\N	2000	1	\N	\N	\N	\N
528	51	1	1	2000	4	3500	4	\N	2000	1	\N	\N	\N	\N
529	51	1	1	3500	4	6000	4	\N	500	1	\N	\N	\N	\N
530	51	1	1	0	1	\N	\N	\N	800	1	1350	1	\N	\N
531	51	9	1	0	1	\N	\N	\N	500	1	\N	\N	\N	\N
532	51	9	1	1000	4	\N	\N	\N	1000	1	\N	\N	\N	\N
533	51	9	1	3500	4	\N	\N	\N	500	1	\N	\N	\N	\N
534	51	9	1	300	4	\N	\N	\N	2000	1	\N	\N	\N	\N
535	51	1	1	10000	4	\N	\N	\N	1500	1	\N	\N	\N	\N
536	51	1	1	5000	4	\N	\N	\N	500	1	\N	\N	\N	\N
537	52	1	1	1500	4	2000	4	\N	2000	1	\N	\N	\N	\N
538	52	1	1	3500	4	4000	4	\N	2000	1	\N	\N	\N	\N
539	52	1	1	3500	4	4000	4	\N	1000	1	\N	\N	\N	\N
540	52	1	1	5000	4	6000	4	\N	1000	1	\N	\N	\N	\N
541	52	1	1	5000	4	5500	4	\N	500	1	\N	\N	\N	\N
542	52	1	1	6500	4	7000	4	\N	500	1	\N	\N	\N	\N
543	52	8	1	1500	4	2000	4	\N	1600	1	\N	\N	\N	\N
544	52	8	1	3500	4	4000	4	\N	800	1	\N	\N	\N	\N
545	52	8	1	5000	4	5500	4	\N	400	1	\N	\N	\N	\N
546	52	3	1	1500	4	1700	4	\N	800	1	\N	\N	\N	\N
547	52	3	1	2000	4	\N	\N	\N	1000	1	\N	\N	\N	\N
548	52	5	1	300	4	\N	\N	\N	2000	1	\N	\N	\N	\N
549	52	1	1	3000	4	\N	\N	\N	2000	1	\N	\N	\N	\N
550	52	1	1	3000	4	3500	4	\N	2000	1	\N	\N	\N	\N
551	52	1	1	5000	4	6000	4	\N	1000	1	\N	\N	\N	\N
552	52	1	1	6500	4	7500	4	\N	500	1	\N	\N	\N	\N
553	53	1	1	0	1	\N	\N	\N	800	1	\N	\N	\N	\N
554	53	1	1	700	4	1000	4	\N	2000	1	\N	\N	\N	\N
555	53	1	1	1300	4	\N	\N	\N	1000	1	\N	\N	\N	\N
556	53	1	1	6000	4	7500	4	\N	500	1	\N	\N	\N	\N
557	53	1	1	1000	4	1500	4	\N	500	1	\N	\N	\N	\N
558	53	1	1	500	4	\N	\N	\N	2000	1	\N	\N	\N	\N
559	53	8	1	1000	4	1500	4	\N	400	1	\N	\N	\N	\N
560	53	3	1	1000	4	\N	\N	\N	500	1	\N	\N	\N	\N
561	53	1	1	700	4	\N	\N	\N	2000	1	\N	\N	\N	\N
562	53	1	1	1000	4	\N	\N	\N	2000	1	\N	\N	\N	\N
563	54	4	1	0	1	\N	\N	\N	3300	1	\N	\N	\N	\N
564	54	4	1	0	1	\N	\N	\N	3000	1	\N	\N	\N	\N
565	54	4	1	500	2	\N	\N	\N	2800	1	\N	\N	\N	\N
566	54	4	1	100	2	\N	\N	\N	2200	1	\N	\N	\N	\N
567	54	2	1	0	1	\N	\N	\N	5000	1	\N	\N	\N	\N
568	54	2	1	3000	2	\N	\N	\N	3000	1	\N	\N	\N	\N
569	54	2	1	0	1	\N	\N	\N	3690	1	\N	\N	\N	\N
570	54	2	1	500	2	\N	\N	\N	4000	1	\N	\N	\N	\N
571	54	3	1	0	1	\N	\N	\N	5700	1	\N	\N	\N	\N
572	54	3	1	500	2	\N	\N	\N	4500	1	\N	\N	\N	\N
573	54	3	1	3000	2	\N	\N	\N	3500	1	\N	\N	\N	\N
574	54	3	1	0	1	\N	\N	\N	4300	1	\N	\N	\N	\N
575	54	5	1	0	1	\N	\N	\N	5760	1	\N	\N	\N	\N
576	54	5	1	100	2	\N	\N	\N	4600	1	\N	\N	\N	\N
577	54	2	1	100	2	\N	\N	\N	2880	1	\N	\N	\N	\N
578	55	4	1	0	1	\N	\N	\N	3000	1	\N	\N	\N	\N
579	55	2	1	50	2	\N	\N	\N	3700	1	\N	\N	\N	\N
580	55	2	1	3000	2	7000	2	\N	3000	1	\N	\N	\N	\N
581	55	3	1	0	1	\N	\N	\N	4300	1	\N	\N	\N	\N
582	55	3	1	50	2	\N	\N	\N	3900	1	\N	\N	\N	\N
583	55	3	1	3000	2	7000	2	\N	3200	1	\N	\N	\N	\N
584	55	7	1	50	2	\N	\N	\N	3900	1	\N	\N	\N	\N
585	55	7	1	3000	2	\N	\N	\N	3500	1	\N	\N	\N	\N
586	55	5	1	0	1	\N	\N	\N	8200	1	\N	\N	Extrapolation	\N
587	55	5	1	12000	2	\N	\N	\N	4000	1	\N	\N	\N	\N
588	55	5	1	6000	2	\N	\N	\N	5000	1	\N	\N	\N	\N
589	55	5	1	25000	2	\N	\N	\N	3000	1	\N	\N	\N	\N
590	55	7	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
591	56	3	1	0	1	\N	\N	\N	4800	1	\N	\N	\N	\N
592	56	3	1	100	2	\N	\N	\N	4750	1	\N	\N	\N	\N
593	56	3	1	2000	2	\N	\N	\N	4500	1	\N	\N	\N	\N
594	56	3	1	5000	2	\N	\N	\N	4250	1	\N	\N	\N	\N
595	56	1	1	0	1	\N	\N	\N	400	1	1500	1	\N	\N
596	56	1	1	1000	4	2000	4	\N	400	1	\N	\N	\N	\N
597	56	1	1	1000	4	\N	\N	\N	1000	1	\N	\N	\N	\N
598	56	1	1	5500	4	6000	4	\N	500	1	\N	\N	\N	Must
599	57	1	1	1000	4	\N	\N	\N	10500	2	\N	\N	\N	\N
600	57	3	1	500	4	\N	\N	\N	10500	2	\N	\N	\N	\N
601	57	3	1	5000	4	\N	\N	\N	1500	1	\N	\N	\N	\N
602	57	5	1	4500	4	5000	4	\N	2000	1	\N	\N	\N	\N
603	58	1	1	0	1	\N	\N	\N	310	1	496	1	\N	\N
604	58	1	1	500	4	\N	\N	\N	186	1	310	1	\N	\N
605	58	1	1	0	1	\N	\N	\N	600	1	\N	\N	\N	\N
606	58	8	1	0	1	\N	\N	\N	240	1	384	1	\N	\N
607	58	8	1	500	4	\N	\N	\N	144	1	240	1	\N	\N
608	58	3	1	0	1	\N	\N	\N	100	1	\N	\N	\N	\N
609	58	1	1	500	4	1000	4	\N	409	1	\N	\N	\N	\N
610	59	1	1	0	1	\N	\N	\N	5400	1	5500	1	\N	\N
611	59	1	1	0	1	\N	\N	\N	4500	1	5000	1	\N	\N
612	59	1	1	1000	4	\N	\N	\N	5400	1	\N	\N	\N	\N
613	59	1	1	1000	4	1500	4	\N	5000	1	\N	\N	\N	\N
614	59	1	1	100	2	\N	\N	\N	5000	1	\N	\N	\N	\N
615	59	1	1	1500	4	\N	\N	\N	4500	1	\N	\N	\N	\N
616	59	1	1	5000	4	\N	\N	\N	2000	1	\N	\N	\N	\N
617	59	4	1	0	1	\N	\N	\N	2200	1	\N	\N	\N	\N
618	59	4	1	0	1	\N	\N	\N	1240	1	\N	\N	\N	\N
619	59	4	1	500	2	\N	\N	\N	1540	1	1739	1	\N	\N
620	59	4	1	1000	2	\N	\N	\N	1120	1	\N	\N	\N	\N
621	59	2	1	0	1	\N	\N	\N	3000	1	\N	\N	\N	\N
622	59	2	1	0	1	\N	\N	\N	2220	1	\N	\N	\N	\N
623	59	2	1	1000	2	\N	\N	\N	2250	1	\N	\N	\N	\N
624	59	2	1	1000	2	\N	\N	\N	1650	1	\N	\N	\N	\N
625	59	3	1	1000	2	\N	\N	\N	3500	1	\N	\N	\N	\N
626	59	3	1	500	2	\N	\N	\N	2650	1	\N	\N	\N	\N
627	59	3	1	0	1	\N	\N	\N	3200	1	\N	\N	\N	\N
628	59	3	1	1000	2	\N	\N	\N	1800	1	\N	\N	\N	\N
629	59	3	1	50	2	\N	\N	\N	3300	1	3500	1	\N	\N
630	59	3	1	500	2	1000	2	\N	2500	1	\N	\N	\N	\N
631	59	3	1	5000	2	\N	\N	\N	1200	1	\N	\N	\N	\N
632	59	7	1	0	1	\N	\N	\N	4500	1	\N	\N	\N	\N
633	59	7	1	1000	2	\N	\N	\N	4000	1	\N	\N	\N	\N
634	59	5	1	0	1	\N	\N	\N	4190	1	\N	\N	\N	\N
635	59	5	1	0	1	\N	\N	\N	4500	1	\N	\N	\N	\N
636	59	5	1	1000	2	\N	\N	\N	4000	1	\N	\N	\N	\N
637	59	5	1	100	2	\N	\N	\N	3700	1	\N	\N	\N	\N
638	59	5	1	1000	2	\N	\N	\N	2260	1	\N	\N	\N	\N
639	59	1	1	0	1	\N	\N	\N	4820	1	\N	\N	\N	\N
640	59	1	1	7500	2	\N	\N	\N	4500	1	\N	\N	\N	\N
641	59	3	1	50	2	\N	\N	50	4000	1	\N	\N	\N	\N
642	59	3	1	100	2	\N	\N	50	3500	1	\N	\N	\N	\N
643	59	3	1	200	2	\N	\N	50	3000	1	\N	\N	\N	\N
644	59	3	1	100	2	\N	\N	\N	3300	1	\N	\N	\N	\N
645	59	3	1	300	2	\N	\N	\N	2000	1	\N	\N	\N	\N
646	59	3	1	900	2	\N	\N	\N	1500	1	\N	\N	\N	\N
647	59	8	1	0	1	\N	\N	\N	5000	1	\N	\N	\N	\N
648	59	8	1	1000	2	\N	\N	\N	4800	1	\N	\N	\N	\N
649	59	8	1	0	1	\N	\N	\N	4500	1	\N	\N	\N	\N
650	59	1	1	0	1	\N	\N	\N	4050	1	\N	\N	\N	\N
651	59	1	1	0	1	\N	\N	\N	3000	1	\N	\N	\N	\N
652	59	3	1	2000	2	\N	\N	50	2000	1	\N	\N	\N	\N
653	59	1	1	3300	4	\N	\N	\N	6000	1	\N	\N	\N	\N
654	59	1	1	6700	4	\N	\N	\N	5500	1	\N	\N	\N	\N
655	59	1	1	10000	4	\N	\N	\N	5000	1	\N	\N	\N	\N
656	59	9	1	0	1	\N	\N	\N	2000	1	\N	\N	\N	\N
657	60	1	1	0	1	\N	\N	\N	5000	1	\N	\N	\N	\N
658	60	1	1	200	2	\N	\N	\N	6000	1	\N	\N	\N	\N
659	60	1	1	1500	2	\N	\N	\N	5500	1	\N	\N	\N	Must
660	60	1	1	100	2	\N	\N	\N	5500	1	\N	\N	\N	\N
661	60	1	1	400	2	\N	\N	\N	5000	1	\N	\N	\N	\N
662	60	4	1	1000	2	\N	\N	\N	900	1	\N	\N	\N	\N
663	60	4	1	500	2	\N	\N	\N	1120	1	\N	\N	\N	\N
664	60	4	1	0	1	\N	\N	\N	1240	1	\N	\N	\N	\N
665	60	4	1	0	1	\N	\N	\N	1600	1	1700	1	\N	\N
666	60	2	1	1000	2	\N	\N	\N	1500	1	\N	\N	\N	\N
667	60	2	1	500	2	\N	\N	\N	1650	1	\N	\N	\N	\N
668	60	2	1	0	1	\N	\N	\N	2400	1	\N	\N	\N	\N
669	60	2	1	0	1	\N	\N	\N	3000	1	\N	\N	\N	\N
670	60	2	1	0	1	\N	\N	\N	2220	1	\N	\N	\N	\N
671	60	2	1	1000	2	\N	\N	\N	1140	1	\N	\N	\N	\N
672	60	3	1	500	2	\N	\N	\N	1800	1	1830	1	\N	\N
673	60	3	1	1000	2	\N	\N	\N	1250	1	\N	\N	\N	\N
674	60	3	1	50	2	\N	\N	\N	3000	1	\N	\N	\N	\N
675	60	3	1	50	2	\N	\N	\N	3500	1	\N	\N	\N	\N
676	60	3	1	1000	2	\N	\N	\N	3500	1	\N	\N	\N	\N
677	60	3	1	0	1	\N	\N	\N	3200	1	\N	\N	\N	\N
678	60	3	1	500	2	1000	2	\N	2500	1	\N	\N	\N	\N
679	60	7	1	0	1	\N	\N	\N	4500	1	\N	\N	\N	\N
680	60	7	1	1000	2	\N	\N	\N	4000	1	\N	\N	\N	\N
681	60	5	1	0	1	\N	\N	\N	4190	1	\N	\N	\N	\N
682	60	5	1	1000	2	\N	\N	\N	1520	1	\N	\N	\N	\N
683	60	5	1	500	2	\N	\N	\N	2260	1	\N	\N	\N	\N
684	60	5	1	100	2	\N	\N	\N	3700	1	\N	\N	\N	\N
685	60	5	1	1000	2	\N	\N	\N	4000	1	\N	\N	\N	\N
686	60	5	1	0	1	\N	\N	\N	4500	1	\N	\N	\N	\N
687	60	1	1	0	1	\N	\N	\N	5500	1	\N	\N	\N	\N
688	60	1	1	0	1	\N	\N	\N	5000	1	\N	\N	\N	\N
689	60	1	1	1000	4	\N	\N	\N	5000	1	\N	\N	\N	\N
690	60	1	1	1000	2	\N	\N	\N	5000	1	\N	\N	\N	\N
691	60	1	1	1500	4	\N	\N	\N	4500	1	\N	\N	\N	\N
692	60	4	1	0	1	\N	\N	\N	2300	1	\N	\N	\N	\N
693	60	4	1	300	2	\N	\N	\N	2000	1	\N	\N	\N	\N
694	60	4	1	900	2	\N	\N	\N	1500	1	\N	\N	\N	\N
695	60	3	1	50	2	\N	\N	50	4000	1	\N	\N	\N	\N
696	60	3	1	100	2	\N	\N	50	3500	1	\N	\N	\N	\N
697	60	3	1	300	2	\N	\N	50	3000	1	\N	\N	\N	\N
698	60	3	1	100	2	\N	\N	\N	3300	1	\N	\N	\N	\N
699	60	3	1	300	2	\N	\N	\N	2000	1	\N	\N	\N	\N
700	60	3	1	900	2	\N	\N	\N	1500	1	\N	\N	\N	\N
701	60	8	1	0	1	\N	\N	\N	4500	1	\N	\N	\N	\N
702	60	8	1	0	1	\N	\N	\N	5000	1	\N	\N	\N	\N
703	60	8	1	1000	2	\N	\N	\N	4800	1	\N	\N	\N	\N
704	60	3	1	3000	2	\N	\N	50	2000	1	\N	\N	\N	\N
705	61	1	1	0	1	\N	\N	\N	900	1	\N	\N	\N	\N
706	61	1	1	0	1	\N	\N	\N	1000	1	\N	\N	\N	\N
707	61	3	1	0	1	\N	\N	\N	200	1	\N	\N	\N	\N
708	61	1	1	2000	4	\N	\N	\N	1500	1	\N	\N	\N	\N
709	61	8	1	0	1	\N	\N	\N	600	1	\N	\N	\N	\N
710	62	1	1	0	1	\N	\N	\N	2500	1	3200	1	\N	\N
711	62	1	1	3000	4	\N	\N	\N	3600	1	4000	1	\N	\N
712	62	1	1	6600	4	\N	\N	\N	4800	1	\N	\N	\N	\N
713	62	1	1	6000	4	\N	\N	\N	3000	1	\N	\N	\N	\N
714	62	1	1	0	1	\N	\N	\N	3000	1	\N	\N	\N	\N
715	62	4	1	0	1	\N	\N	\N	910	1	\N	\N	\N	\N
716	62	4	1	0	1	\N	\N	\N	1100	1	\N	\N	\N	\N
717	62	2	1	0	1	\N	\N	\N	1920	1	\N	\N	\N	\N
718	62	2	1	0	1	\N	\N	\N	1710	1	\N	\N	\N	\N
719	62	2	1	0	1	\N	\N	\N	1500	1	1920	1	\N	\N
720	62	2	1	0	1	\N	\N	\N	1300	1	1500	1	\N	\N
721	62	3	1	0	1	\N	\N	\N	1300	1	1700	1	\N	\N
722	62	3	1	0	1	\N	\N	\N	2100	1	\N	\N	\N	\N
723	62	3	1	7000	4	\N	\N	\N	1000	1	\N	\N	\N	\N
724	62	3	1	6000	4	\N	\N	\N	500	1	\N	\N	\N	\N
725	62	3	1	0	1	\N	\N	\N	1520	1	\N	\N	\N	\N
726	62	5	1	0	1	\N	\N	\N	2670	1	\N	\N	\N	\N
727	62	5	1	3000	4	\N	\N	\N	2700	1	\N	\N	\N	\N
728	62	5	1	5000	4	\N	\N	\N	2400	1	\N	\N	\N	\N
729	62	1	1	3300	4	\N	\N	\N	5000	1	\N	\N	\N	\N
730	62	1	1	6700	4	\N	\N	\N	3500	1	\N	\N	\N	\N
731	62	1	1	3000	4	3300	4	\N	3000	1	\N	\N	\N	\N
732	62	2	1	0	1	\N	\N	\N	1500	1	\N	\N	\N	\N
733	62	8	1	70000	2	\N	\N	\N	2400	1	\N	\N	\N	\N
734	62	8	1	0	1	\N	\N	\N	2400	1	\N	\N	\N	\N
735	62	8	1	6000	4	\N	\N	\N	500	1	\N	\N	\N	\N
736	62	1	1	2000	4	\N	\N	\N	3000	1	\N	\N	\N	\N
737	62	1	1	3000	4	\N	\N	\N	2000	1	\N	\N	\N	\N
738	62	3	1	5000	4	\N	\N	\N	1200	1	\N	\N	\N	\N
739	62	1	1	3300	4	\N	\N	\N	6000	1	\N	\N	\N	\N
740	62	1	1	6700	4	\N	\N	\N	4700	1	\N	\N	\N	\N
741	62	1	1	10000	4	\N	\N	\N	3100	1	\N	\N	\N	\N
742	62	9	1	0	1	\N	\N	\N	800	1	\N	\N	\N	\N
743	62	9	1	0	1	\N	\N	\N	2400	1	\N	\N	\N	\N
744	62	9	1	0	1	\N	\N	\N	2400	1	\N	\N	\N	\N
745	62	1	1	0	1	\N	\N	\N	2340	1	\N	\N	\N	\N
746	62	1	1	5000	4	\N	\N	\N	3000	1	\N	\N	\N	\N
747	62	1	1	0	1	\N	\N	\N	1500	1	\N	\N	\N	\N
748	62	1	1	1500	4	\N	\N	\N	3000	1	\N	\N	\N	\N
749	62	1	1	10000	4	\N	\N	\N	2340	1	\N	\N	\N	\N
750	62	1	1	5000	4	\N	\N	\N	3000	1	\N	\N	\N	\N
751	63	1	1	0	1	\N	\N	\N	1000	1	\N	\N	\N	\N
752	64	1	1	0	1	\N	\N	\N	8000	1	\N	\N	\N	\N
753	64	4	1	0	1	\N	\N	\N	3000	1	\N	\N	\N	\N
754	64	2	1	0	1	\N	\N	\N	3600	1	\N	\N	\N	\N
755	64	2	1	50	2	\N	\N	\N	5000	1	\N	\N	\N	\N
756	64	2	1	2100	2	\N	\N	\N	3379	1	\N	\N	\N	\N
757	64	2	1	2400	2	\N	\N	\N	3200	1	\N	\N	\N	\N
758	64	3	1	2400	2	\N	\N	\N	3770	1	\N	\N	\N	\N
759	64	3	1	0	1	\N	\N	\N	4100	1	\N	\N	\N	\N
760	64	3	1	2100	2	\N	\N	\N	4000	1	\N	\N	\N	\N
761	64	3	1	50	2	\N	\N	\N	5000	1	\N	\N	\N	\N
762	64	8	1	0	1	\N	\N	\N	7000	1	\N	\N	\N	\N
763	65	1	1	0	1	\N	\N	\N	1800	1	\N	\N	\N	\N
764	65	1	1	2000	4	\N	\N	\N	3000	1	\N	\N	\N	\N
765	65	1	1	3000	4	\N	\N	\N	2000	1	\N	\N	\N	\N
766	65	1	1	3300	4	\N	\N	\N	1800	1	\N	\N	\N	\N
767	65	1	1	5000	4	6700	4	\N	1800	1	\N	\N	\N	\N
768	65	4	1	0	1	\N	\N	\N	950	1	\N	\N	\N	\N
769	65	4	1	0	1	\N	\N	\N	840	1	\N	\N	\N	\N
770	65	2	1	0	1	\N	\N	\N	1500	1	1600	1	\N	\N
771	65	3	1	0	1	\N	\N	\N	1750	1	1800	1	\N	\N
772	65	3	1	0	1	\N	\N	\N	1600	1	\N	\N	\N	\N
773	65	3	1	0	1	\N	\N	\N	1000	1	\N	\N	\N	\N
774	65	5	1	0	1	\N	\N	\N	2190	1	\N	\N	\N	\N
775	65	5	1	1000	4	\N	\N	\N	1000	1	\N	\N	\N	\N
776	65	3	1	7500	4	\N	\N	\N	1200	1	\N	\N	\N	\N
777	65	8	1	3300	4	\N	\N	\N	2000	1	\N	\N	\N	\N
778	65	1	1	0	1	\N	\N	\N	1800	1	\N	\N	\N	\N
779	65	1	1	3300	4	\N	\N	\N	1800	1	2000	1	\N	\N
780	65	1	1	3300	4	\N	\N	\N	3500	1	\N	\N	\N	\N
781	65	1	1	6700	4	\N	\N	\N	2000	1	\N	\N	\N	\N
782	65	1	1	0	1	\N	\N	\N	2300	1	\N	\N	\N	\N
783	65	3	1	2500	4	\N	\N	\N	1200	1	\N	\N	\N	\N
784	65	1	1	0	1	\N	\N	\N	1000	1	1500	1	\N	Must
785	65	1	1	3300	4	\N	\N	\N	5000	1	\N	\N	\N	\N
786	65	1	1	6700	4	\N	\N	\N	3000	1	\N	\N	\N	\N
787	65	1	1	10000	4	\N	\N	\N	2300	1	\N	\N	\N	\N
788	65	9	1	0	1	\N	\N	\N	500	1	\N	\N	\N	\N
789	65	1	1	5000	4	\N	\N	\N	2400	1	\N	\N	\N	\N
790	65	1	1	10000	4	\N	\N	\N	1440	1	\N	\N	\N	\N
791	66	1	1	0	1	\N	\N	\N	900	1	\N	\N	\N	\N
792	66	1	1	1500	4	2000	4	\N	2000	1	\N	\N	\N	\N
793	66	1	1	1000	4	1500	4	\N	1800	1	\N	\N	\N	\N
794	66	1	1	0	1	\N	\N	\N	800	1	\N	\N	\N	\N
795	66	1	1	3000	4	\N	\N	\N	600	1	\N	\N	\N	\N
796	66	4	1	3300	4	\N	\N	\N	1000	1	\N	\N	\N	\N
797	66	1	1	2500	4	\N	\N	\N	1800	1	\N	\N	\N	\N
798	67	3	1	1000	4	4500	4	\N	1000	1	\N	\N	\N	\N
799	67	1	1	3300	4	\N	\N	\N	3500	1	\N	\N	\N	\N
800	67	1	1	6700	4	\N	\N	\N	2000	1	\N	\N	\N	\N
801	67	1	1	0	1	\N	\N	\N	2300	1	\N	\N	\N	\N
802	67	1	1	0	1	\N	\N	\N	1440	1	\N	\N	\N	\N
803	67	1	1	0	1	\N	\N	\N	2400	1	\N	\N	\N	\N
804	67	1	1	0	1	\N	\N	\N	1800	1	\N	\N	\N	\N
805	67	1	1	7500	4	\N	\N	\N	1800	1	\N	\N	\N	\N
806	68	4	1	0	1	\N	\N	\N	1860	1	\N	\N	\N	\N
807	68	4	1	6700	4	\N	\N	\N	1060	1	\N	\N	\N	\N
808	68	4	1	1500	2	\N	\N	\N	1400	1	\N	\N	\N	\N
809	68	3	1	1500	2	\N	\N	\N	2300	1	\N	\N	\N	\N
810	68	2	1	1500	2	\N	\N	\N	1950	1	\N	\N	\N	\N
811	68	3	1	6700	4	\N	\N	\N	2300	1	\N	\N	\N	\N
812	69	1	1	500	2	1000	2	\N	5000	1	\N	\N	\N	Must
813	69	1	1	19500	2	\N	\N	\N	4500	1	\N	\N	\N	\N
814	69	1	1	15000	2	20000	2	\N	4500	1	\N	\N	\N	\N
815	69	1	1	0	1	\N	\N	\N	5000	1	5200	1	\N	\N
816	69	1	1	3000	4	7000	4	\N	4000	1	\N	\N	\N	\N
817	69	1	1	0	1	\N	\N	\N	5500	1	\N	\N	\N	\N
818	69	1	1	1000	4	\N	\N	\N	5000	1	\N	\N	\N	\N
819	69	1	1	1500	4	\N	\N	\N	4500	1	\N	\N	\N	\N
820	69	1	1	200	2	\N	\N	\N	5000	1	\N	\N	\N	\N
821	69	1	1	10000	2	\N	\N	\N	4000	1	\N	\N	\N	\N
822	69	1	1	6500	2	\N	\N	\N	4500	1	\N	\N	\N	\N
823	69	1	1	0	1	\N	\N	\N	4500	1	\N	\N	\N	\N
824	69	1	1	1000	2	\N	\N	\N	5000	1	\N	\N	\N	\N
825	69	1	1	7000	4	\N	\N	\N	2000	1	\N	\N	\N	\N
826	69	1	1	25000	2	30000	2	\N	4000	1	\N	\N	\N	Can
827	69	1	1	50000	2	65000	2	\N	3000	1	\N	\N	\N	Can
828	69	1	1	0	1	\N	\N	\N	10500	2	\N	\N	\N	Must
829	69	1	1	83000	2	\N	\N	\N	1500	1	\N	\N	\N	\N
830	69	1	1	7500	4	\N	\N	\N	4500	1	\N	\N	\N	\N
831	70	1	1	12000	2	\N	\N	\N	1500	1	\N	\N	\N	\N
832	70	4	1	500	2	\N	\N	\N	1190	1	\N	\N	\N	\N
833	70	4	1	0	1	\N	\N	\N	1540	1	\N	\N	\N	\N
834	70	2	1	50	2	\N	\N	\N	2520	1	\N	\N	\N	\N
835	70	2	1	3000	2	\N	\N	\N	1250	1	\N	\N	\N	\N
836	70	2	1	500	2	\N	\N	\N	1770	1	\N	\N	\N	\N
837	70	2	1	0	1	\N	\N	\N	3000	1	\N	\N	\N	\N
838	70	3	1	500	2	1000	2	\N	2500	1	\N	\N	\N	\N
839	70	3	1	500	2	\N	\N	\N	1950	1	\N	\N	\N	\N
840	70	3	1	50	2	\N	\N	\N	3000	1	3500	1	\N	\N
841	70	3	1	1000	2	\N	\N	\N	3500	1	\N	\N	\N	\N
842	70	7	1	0	1	\N	\N	\N	4500	1	\N	\N	\N	\N
843	70	7	1	1000	2	\N	\N	\N	4000	1	\N	\N	\N	\N
844	70	5	1	500	2	\N	\N	\N	2460	1	\N	\N	\N	\N
845	70	5	1	100	2	\N	\N	\N	3700	1	\N	\N	\N	\N
846	70	5	1	1000	2	\N	\N	\N	4000	1	\N	\N	\N	\N
847	70	5	1	0	1	\N	\N	\N	4500	1	\N	\N	\N	\N
848	70	5	1	0	1	\N	\N	\N	4600	1	\N	\N	\N	\N
849	70	3	1	50	2	\N	\N	50	4000	1	\N	\N	\N	\N
850	70	3	1	10	2	100	2	50	3500	1	\N	\N	\N	\N
851	70	3	1	100	2	300	2	50	3000	1	\N	\N	\N	\N
852	70	8	1	0	1	\N	\N	\N	5000	1	\N	\N	\N	\N
853	70	8	1	1000	2	\N	\N	\N	4800	1	\N	\N	\N	\N
854	70	8	1	0	1	\N	\N	\N	4500	1	\N	\N	\N	\N
855	70	10	1	0	1	\N	\N	\N	4000	1	\N	\N	\N	\N
856	70	10	1	9000	2	\N	\N	\N	3700	1	\N	\N	\N	\N
857	70	10	1	13000	2	\N	\N	\N	3300	1	\N	\N	\N	\N
858	70	3	1	1500	2	\N	\N	50	2000	1	\N	\N	\N	\N
859	70	11	1	0	1	\N	\N	\N	5200	1	\N	\N	\N	\N
860	70	11	1	200	2	\N	\N	\N	4600	1	\N	\N	\N	\N
861	70	11	1	100	4	\N	\N	\N	4000	1	\N	\N	\N	\N
862	70	3	1	100	2	\N	\N	\N	3000	1	\N	\N	\N	\N
863	70	3	1	500	2	\N	\N	\N	1810	1	\N	\N	\N	\N
864	70	1	1	3300	4	\N	\N	\N	5000	1	\N	\N	\N	\N
865	70	1	1	10000	4	\N	\N	\N	4000	1	\N	\N	\N	\N
866	70	1	1	2000	2	\N	\N	\N	5500	1	\N	\N	\N	\N
867	70	1	1	12000	2	\N	\N	\N	1500	1	\N	\N	\N	\N
868	70	3	1	18000	2	\N	\N	\N	1950	1	\N	\N	\N	\N
869	70	3	1	10000	2	\N	\N	\N	2220	1	\N	\N	\N	\N
870	70	3	1	6500	2	\N	\N	\N	2500	1	\N	\N	\N	\N
871	70	3	1	0	1	\N	\N	\N	2780	1	\N	\N	\N	\N
872	71	1	1	20000	2	\N	\N	\N	3000	1	\N	\N	\N	\N
873	71	1	1	15000	2	18000	2	\N	3500	1	\N	\N	\N	\N
874	71	1	1	2000	2	\N	\N	\N	4500	1	\N	\N	\N	\N
875	71	1	1	18600	2	\N	\N	\N	2500	1	\N	\N	\N	\N
876	71	1	1	15500	2	\N	\N	\N	3000	1	\N	\N	\N	\N
877	71	1	1	3040	2	\N	\N	\N	4000	1	\N	\N	\N	\N
878	71	1	1	10000	2	\N	\N	\N	4000	1	\N	\N	\N	\N
879	71	1	1	6500	2	\N	\N	\N	4500	1	\N	\N	\N	\N
880	71	1	1	11600	2	13900	2	\N	4500	1	\N	\N	\N	Must
881	71	1	1	10400	2	12700	2	\N	5000	1	\N	\N	\N	Must
882	71	1	1	9100	2	11500	2	\N	5500	1	\N	\N	\N	Must
883	71	1	1	7300	2	9800	2	\N	6000	1	\N	\N	\N	Must
884	71	1	1	2300	2	4000	2	\N	6500	1	\N	\N	\N	Must
885	71	1	1	0	2	1000	2	\N	7000	1	\N	\N	\N	Must
886	71	1	1	0	2	\N	\N	\N	7400	1	\N	\N	\N	Must
887	71	10	1	11600	2	13900	2	\N	3750	1	\N	\N	\N	Must
888	71	10	1	10400	2	12700	2	\N	4170	1	\N	\N	\N	Must
889	71	10	1	9100	2	11500	2	\N	4580	1	\N	\N	\N	Must
890	71	10	1	7300	2	9800	2	\N	5000	1	\N	\N	\N	Must
891	71	10	1	2300	2	4000	2	\N	5420	1	\N	\N	\N	Must
892	71	10	1	0	2	1000	2	\N	5830	1	\N	\N	\N	Must
893	71	10	1	0	2	\N	\N	\N	6170	1	\N	\N	\N	Must
894	72	1	1	0	1	\N	\N	\N	6000	1	\N	\N	\N	\N
895	72	4	1	0	1	\N	\N	\N	2920	1	\N	\N	\N	\N
896	72	4	1	0	1	\N	\N	\N	1839	1	\N	\N	\N	\N
897	72	4	1	2000	2	\N	\N	\N	1430	1	\N	\N	\N	\N
898	72	4	1	2000	2	\N	\N	\N	1800	1	\N	\N	\N	\N
899	72	2	1	2000	2	\N	\N	\N	2400	1	\N	\N	\N	\N
900	72	2	1	50	2	\N	\N	\N	2820	1	\N	\N	\N	\N
901	72	2	1	0	1	\N	\N	\N	3450	1	\N	\N	\N	\N
902	72	2	1	150	2	\N	\N	\N	4200	1	\N	\N	\N	\N
903	72	3	1	2000	2	\N	\N	\N	2500	1	\N	\N	\N	\N
904	72	3	1	2000	2	\N	\N	\N	2850	1	\N	\N	\N	\N
905	72	3	1	0	1	\N	\N	\N	4000	1	\N	\N	\N	\N
906	72	3	1	0	1	\N	\N	\N	3800	1	\N	\N	\N	\N
907	72	3	1	50	2	\N	\N	\N	3200	1	\N	\N	\N	\N
908	72	5	1	0	1	\N	\N	\N	5020	1	\N	\N	\N	\N
909	72	5	1	2000	2	\N	\N	\N	3220	1	\N	\N	\N	\N
910	72	8	1	0	1	\N	\N	\N	5000	1	\N	\N	\N	\N
911	72	10	1	0	1	\N	\N	\N	5000	1	\N	\N	\N	\N
912	72	1	1	20000	2	\N	\N	\N	3000	1	\N	\N	\N	\N
913	72	1	1	3300	4	\N	\N	\N	5500	1	\N	\N	\N	\N
914	72	1	1	10000	4	\N	\N	\N	4500	1	\N	\N	\N	\N
915	72	1	1	2000	2	\N	\N	\N	6000	1	\N	\N	\N	\N
916	72	1	1	15000	2	18000	2	\N	3500	1	\N	\N	\N	\N
917	72	1	1	2000	2	\N	\N	\N	4500	1	\N	\N	\N	\N
918	72	9	1	0	1	\N	\N	\N	2000	1	\N	\N	\N	\N
919	73	1	1	0	1	\N	\N	\N	6250	1	\N	\N	\N	\N
920	73	1	1	200	4	\N	\N	\N	6000	1	\N	\N	\N	\N
921	73	11	1	0	1	\N	\N	\N	5500	1	\N	\N	\N	\N
922	73	1	1	0	1	\N	\N	\N	10500	2	\N	\N	\N	Must
923	74	1	1	1500	4	2000	4	\N	7500	1	\N	\N	\N	\N
924	74	1	1	2000	4	3000	4	\N	7000	1	\N	\N	\N	\N
925	74	1	1	2500	4	4000	4	\N	6500	1	\N	\N	\N	\N
926	74	1	1	5000	4	\N	\N	\N	5000	1	\N	\N	\N	\N
927	74	1	1	200	2	\N	\N	\N	6500	1	6950	1	EQD2	\N
928	74	1	1	1100	2	\N	\N	\N	5500	1	\N	\N	EQD2	\N
929	74	1	1	5500	4	6000	4	\N	4000	1	\N	\N	\N	\N
930	74	4	1	2000	2	\N	\N	\N	1430	1	2200	1	\N	\N
931	74	4	1	0	1	\N	\N	\N	1839	1	\N	\N	\N	\N
932	74	4	1	350	2	\N	\N	\N	3900	1	\N	\N	\N	\N
933	74	4	1	0	1	\N	\N	\N	4420	1	\N	\N	\N	\N
934	74	2	1	2000	2	\N	\N	\N	2400	1	2750	1	\N	\N
935	74	2	1	350	2	\N	\N	\N	4500	1	\N	\N	\N	\N
936	74	2	1	50	2	\N	\N	\N	2820	1	\N	\N	\N	\N
937	74	2	1	0	1	\N	\N	\N	4950	1	\N	\N	\N	\N
938	74	3	1	2000	2	\N	\N	\N	2500	1	3250	1	\N	\N
939	74	3	1	50	2	\N	\N	\N	3200	1	\N	\N	\N	\N
940	74	3	1	350	2	\N	\N	\N	5000	1	\N	\N	\N	\N
941	74	3	1	0	1	\N	\N	\N	5500	1	\N	\N	\N	\N
942	74	3	1	0	1	\N	\N	\N	3800	1	\N	\N	\N	\N
943	74	3	1	0	1	\N	\N	\N	3806	1	4000	1	\N	\N
944	74	3	1	300	2	\N	\N	\N	3440	1	3600	1	\N	\N
945	74	5	1	0	1	\N	\N	\N	5020	1	\N	\N	\N	\N
946	74	5	1	2000	2	\N	\N	\N	3220	1	\N	\N	\N	\N
947	74	1	1	2500	4	\N	\N	\N	6500	1	\N	\N	\N	\N
948	74	1	1	3500	4	5500	4	\N	6000	1	\N	\N	\N	\N
949	74	1	1	6000	4	\N	\N	\N	4500	1	\N	\N	\N	\N
950	74	1	1	8000	4	10000	4	\N	4000	1	\N	\N	\N	\N
951	74	1	1	6000	4	\N	\N	\N	3000	1	\N	\N	\N	\N
952	74	10	1	1	4	100	4	\N	6000	1	\N	\N	\N	\N
953	74	10	1	2200	4	\N	\N	\N	5000	1	\N	\N	\N	\N
954	74	10	1	3800	4	\N	\N	\N	4000	1	\N	\N	\N	\N
955	74	10	1	5700	4	\N	\N	\N	3000	1	\N	\N	\N	\N
956	74	10	1	8500	4	\N	\N	\N	2000	1	\N	\N	\N	\N
957	74	10	1	0	1	\N	\N	\N	2000	1	\N	\N	\N	\N
958	74	1	1	1000	2	\N	\N	\N	7200	1	\N	\N	\N	\N
959	74	1	1	1500	4	\N	\N	\N	7000	1	\N	\N	\N	\N
960	74	1	1	5000	4	\N	\N	\N	4500	1	\N	\N	\N	\N
961	74	11	1	1500	4	\N	\N	\N	7400	1	\N	\N	\N	\N
962	74	11	1	2500	4	\N	\N	\N	6900	1	\N	\N	\N	\N
963	74	11	1	1500	4	\N	\N	\N	6500	1	\N	\N	\N	\N
964	74	11	1	1000	2	\N	\N	\N	6500	1	\N	\N	\N	\N
965	74	11	1	3500	4	\N	\N	\N	6400	1	\N	\N	\N	\N
966	74	11	1	5000	4	\N	\N	\N	5900	1	\N	\N	\N	\N
967	74	11	1	2500	4	\N	\N	\N	5500	1	\N	\N	\N	\N
968	74	11	1	4500	4	\N	\N	\N	4500	1	\N	\N	\N	\N
969	74	11	1	0	1	\N	\N	\N	6200	1	\N	\N	\N	\N
970	74	11	1	1000	2	\N	\N	\N	7000	1	\N	\N	\N	\N
971	74	10	1	3000	4	\N	\N	\N	4600	1	\N	\N	\N	\N
972	74	10	1	5000	4	\N	\N	\N	3700	1	\N	\N	\N	\N
973	74	3	1	0	1	\N	\N	\N	3500	1	3800	1	\N	\N
974	74	3	1	1000	4	\N	\N	\N	3263	1	3400	1	\N	\N
975	74	3	1	2000	4	\N	\N	\N	2900	1	3000	1	\N	\N
976	74	3	1	5000	4	\N	\N	\N	1810	1	1900	1	\N	\N
977	74	1	1	0	1	\N	\N	\N	10500	2	\N	\N	\N	Must
978	74	1	1	7500	4	\N	\N	\N	4000	1	\N	\N	\N	Can
979	74	1	1	9500	4	\N	\N	\N	3000	1	\N	\N	\N	Can
980	74	1	1	8000	4	\N	\N	\N	3000	1	\N	\N	\N	Must
981	74	1	1	6000	4	\N	\N	\N	5000	1	\N	\N	\N	Must
982	74	1	1	5000	4	\N	\N	\N	6000	1	\N	\N	\N	Must
983	74	1	1	3000	4	\N	\N	\N	6500	1	\N	\N	\N	Must
984	74	1	1	1500	4	\N	\N	\N	7000	1	\N	\N	\N	Must
985	74	10	1	8000	4	\N	\N	\N	2500	1	\N	\N	\N	Must
986	74	10	1	6000	4	\N	\N	\N	4170	1	\N	\N	\N	Must
987	74	10	1	5000	4	\N	\N	\N	5000	1	\N	\N	\N	Must
988	74	10	1	3000	4	\N	\N	\N	5420	1	\N	\N	\N	Must
989	74	10	1	1500	4	\N	\N	\N	5830	1	\N	\N	\N	Must
990	74	1	1	10000	4	\N	\N	\N	4500	1	\N	\N	\N	\N
991	75	1	1	5000	4	\N	\N	\N	3000	1	\N	\N	\N	\N
992	76	1	1	2500	4	3000	4	\N	7500	1	\N	\N	\N	\N
993	76	1	1	3500	4	4000	4	\N	7000	1	\N	\N	\N	\N
994	76	1	1	7000	4	7700	8	\N	4000	1	\N	\N	\N	\N
995	76	1	1	5000	4	\N	\N	\N	5000	1	\N	\N	\N	\N
996	76	1	1	5000	4	5500	4	\N	6500	1	\N	\N	\N	\N
997	76	4	1	1500	2	\N	\N	\N	1140	1	1200	1	\N	\N
998	76	4	1	0	1	\N	\N	\N	1839	1	\N	\N	\N	\N
999	76	4	1	0	1	\N	\N	\N	2500	1	\N	\N	\N	\N
1000	76	2	1	1500	2	\N	\N	\N	1680	1	\N	\N	\N	\N
1001	76	2	1	0	1	\N	\N	\N	2820	1	\N	\N	\N	\N
1002	76	2	1	0	1	\N	\N	\N	3300	1	\N	\N	\N	\N
1003	76	3	1	1500	2	\N	\N	\N	1830	1	\N	\N	\N	\N
1004	76	3	1	1000	4	\N	\N	\N	1812	1	2000	1	\N	\N
1005	76	3	1	1500	2	\N	\N	\N	2000	1	\N	\N	\N	\N
1006	76	3	1	0	1	\N	\N	\N	3800	1	\N	\N	\N	\N
1007	76	3	1	0	1	\N	\N	\N	3806	1	4000	1	\N	\N
1008	76	5	1	0	1	\N	\N	\N	5020	1	\N	\N	\N	\N
1009	76	5	1	1500	2	\N	\N	\N	2300	1	\N	\N	\N	\N
1010	76	1	1	200	2	\N	\N	\N	8000	1	\N	\N	EQD2	\N
1011	76	1	1	1500	4	2000	4	\N	8000	1	\N	\N	\N	\N
1012	76	1	1	3500	4	7000	4	\N	4500	1	\N	\N	\N	\N
1013	76	1	1	3500	4	4000	4	\N	4000	1	\N	\N	\N	\N
1014	76	1	1	1500	4	\N	\N	\N	4500	1	\N	\N	\N	\N
1015	76	1	1	0	1	\N	\N	\N	5000	1	\N	\N	\N	\N
1016	76	1	1	5000	4	\N	\N	\N	3500	1	\N	\N	\N	\N
1017	76	1	1	500	4	\N	\N	\N	5000	1	\N	\N	\N	\N
1018	76	10	1	300	4	\N	\N	\N	6000	1	\N	\N	\N	\N
1019	76	10	1	500	4	\N	\N	\N	5680	1	\N	\N	\N	\N
1020	76	10	1	2500	4	\N	\N	\N	4800	1	\N	\N	\N	\N
1021	76	10	1	5000	4	\N	\N	\N	4000	1	\N	\N	\N	\N
1022	76	1	1	1500	4	\N	\N	\N	7000	1	\N	\N	\N	\N
1023	76	1	1	5000	4	\N	\N	\N	4500	1	\N	\N	\N	\N
1024	76	11	1	1000	2	\N	\N	\N	7000	1	\N	\N	\N	\N
1025	76	11	1	1500	4	\N	\N	\N	7900	1	\N	\N	\N	\N
1026	76	11	1	2500	4	\N	\N	\N	7400	1	\N	\N	\N	\N
1027	76	11	1	3500	4	4000	4	\N	6900	1	\N	\N	\N	\N
1028	76	11	1	5000	4	5500	4	\N	6400	1	\N	\N	\N	\N
1029	76	11	1	1500	4	\N	\N	\N	6500	1	\N	\N	\N	\N
1030	76	11	1	4500	4	\N	\N	\N	4500	1	\N	\N	\N	\N
1031	76	11	1	2500	4	\N	\N	\N	5500	1	\N	\N	\N	\N
1032	76	11	1	9000	4	\N	\N	\N	3500	1	\N	\N	\N	\N
1033	76	11	1	3500	4	\N	\N	\N	4000	1	\N	\N	\N	\N
1034	76	10	1	3000	4	\N	\N	\N	4600	1	\N	\N	\N	\N
1035	76	10	1	5000	4	\N	\N	\N	3700	1	\N	\N	\N	\N
1036	76	3	1	500	2	1000	2	\N	3700	1	\N	\N	\N	\N
1037	76	3	1	4000	4	\N	\N	\N	1810	1	\N	\N	\N	\N
1038	76	1	1	0	1	\N	\N	\N	10500	2	\N	\N	\N	Must
1039	76	1	1	6000	4	\N	\N	\N	4000	1	\N	\N	\N	Can
1040	76	1	1	8000	4	\N	\N	\N	3000	1	\N	\N	\N	Can
1041	76	3	1	4000	4	\N	\N	\N	2220	1	\N	\N	\N	\N
1042	76	3	1	1500	4	\N	\N	\N	2500	1	\N	\N	\N	\N
1043	76	3	1	0	1	\N	\N	\N	2780	1	\N	\N	\N	\N
1044	76	1	1	3000	4	\N	\N	\N	5000	1	\N	\N	\N	\N
1045	76	1	1	10000	4	\N	\N	\N	4500	1	\N	\N	\N	\N
1046	76	1	1	10000	4	\N	\N	\N	4500	1	\N	\N	\N	\N
1047	77	1	1	0	1	\N	\N	\N	7000	1	\N	\N	\N	\N
1048	77	4	1	0	1	\N	\N	\N	3500	1	\N	\N	\N	\N
1049	77	2	1	0	1	\N	\N	\N	4000	1	\N	\N	\N	\N
1050	77	3	1	0	1	\N	\N	\N	4500	1	\N	\N	\N	\N
1051	77	3	1	5000	4	\N	\N	\N	4200	1	\N	\N	\N	\N
1052	77	3	1	0	1	\N	\N	\N	3878	1	4350	1	\N	\N
1053	77	3	1	0	1	\N	\N	\N	3800	1	4200	1	\N	\N
1054	78	1	1	0	1	\N	\N	\N	4500	1	\N	\N	\N	\N
1055	78	1	1	5000	4	\N	\N	\N	3000	1	\N	\N	\N	\N
1056	78	4	1	1000	2	\N	\N	\N	1400	1	\N	\N	\N	\N
1057	78	4	1	1000	2	\N	\N	\N	1500	1	\N	\N	\N	\N
1058	78	2	1	1000	2	\N	\N	\N	2190	1	\N	\N	\N	\N
1059	78	2	1	1000	2	\N	\N	\N	2400	1	\N	\N	\N	\N
1060	78	3	1	1000	2	\N	\N	\N	3000	1	\N	\N	\N	\N
1061	78	5	1	1000	2	\N	\N	\N	3910	1	\N	\N	\N	\N
1062	78	1	1	3500	4	4000	4	\N	4000	1	\N	\N	\N	\N
1063	78	1	1	500	4	\N	\N	\N	4400	1	\N	\N	\N	\N
1064	78	1	1	2500	4	\N	\N	\N	4500	1	\N	\N	\N	\N
1065	78	1	1	0	1	\N	\N	\N	5000	1	\N	\N	\N	\N
1066	78	10	1	0	1	\N	\N	\N	3700	1	\N	\N	\N	\N
1067	78	10	1	500	4	\N	\N	\N	3500	1	\N	\N	\N	\N
1068	78	1	1	0	1	\N	\N	\N	5250	1	\N	\N	\N	\N
1069	78	1	1	200	4	\N	\N	\N	5000	1	\N	\N	\N	\N
1070	78	1	1	0	1	\N	\N	\N	5000	1	\N	\N	\N	\N
1071	78	11	1	0	1	\N	\N	\N	5250	1	\N	\N	\N	\N
1072	78	11	1	100	4	\N	\N	\N	5000	1	\N	\N	\N	\N
1073	78	11	1	0	1	\N	\N	\N	4000	1	\N	\N	\N	\N
1074	78	10	1	50	4	\N	\N	\N	4300	1	\N	\N	\N	\N
1075	78	3	1	1000	2	\N	\N	\N	1989	1	\N	\N	\N	\N
1076	78	3	1	100	2	\N	\N	\N	1560	1	\N	\N	\N	\N
1077	78	3	1	500	4	\N	\N	\N	1450	1	\N	\N	\N	\N
1078	78	1	1	500	4	\N	\N	\N	6000	1	\N	\N	\N	\N
1079	78	1	1	0	1	\N	\N	\N	5900	1	\N	\N	\N	\N
1080	78	1	1	0	1	\N	\N	\N	3700	1	\N	\N	\N	\N
1081	78	1	1	6400	4	\N	\N	\N	4000	1	\N	\N	\N	\N
1082	78	1	1	0	1	\N	\N	\N	2500	1	\N	\N	\N	\N
1083	78	1	1	0	1	\N	\N	\N	3000	1	4000	1	\N	\N
1084	78	1	1	5000	4	\N	\N	\N	3000	1	\N	\N	\N	\N
1085	78	1	1	1500	4	\N	\N	\N	3000	1	\N	\N	\N	\N
1086	78	1	1	4000	4	\N	\N	\N	4000	1	\N	\N	\N	\N
1087	78	1	1	1000	4	\N	\N	\N	5000	1	\N	\N	\N	\N
1088	78	1	1	5000	4	\N	\N	\N	5000	1	\N	\N	\N	Must
1089	78	10	1	5000	4	\N	\N	\N	4170	1	\N	\N	\N	Must
1090	78	3	1	4000	4	\N	\N	\N	2220	1	\N	\N	\N	\N
1091	78	3	1	1500	4	\N	\N	\N	2500	1	\N	\N	\N	\N
1092	78	3	1	0	1	\N	\N	\N	2780	1	\N	\N	\N	\N
1093	79	1	1	5000	4	\N	\N	\N	3000	1	\N	\N	\N	\N
1094	79	1	1	3500	4	\N	\N	\N	4000	1	\N	\N	\N	\N
1095	79	1	1	500	4	\N	\N	\N	5000	1	\N	\N	\N	\N
1096	80	1	1	2500	4	\N	\N	\N	7000	1	\N	\N	\N	\N
1097	80	11	1	3000	4	\N	\N	\N	6000	1	\N	\N	\N	\N
1098	80	10	1	2000	4	\N	\N	\N	5700	1	\N	\N	\N	\N
1099	81	1	1	0	1	\N	\N	\N	3420	1	\N	\N	\N	\N
1100	81	1	1	3700	4	6000	4	\N	4000	1	\N	\N	\N	\N
1101	81	1	1	7500	4	\N	\N	\N	2000	1	\N	\N	\N	\N
1102	81	1	1	9000	4	\N	\N	\N	1000	1	2500	1	\N	\N
1103	81	1	1	75000	2	\N	\N	\N	3000	1	\N	\N	\N	\N
1104	81	1	1	2300	4	\N	\N	\N	4000	1	\N	\N	\N	\N
1105	82	1	1	5000	4	\N	\N	\N	5000	1	\N	\N	\N	\N
1106	83	1	1	0	1	\N	\N	\N	5250	1	\N	\N	\N	\N
1107	83	1	1	6000	4	7000	4	\N	7000	1	\N	\N	\N	\N
1108	83	1	1	9000	4	9500	4	\N	5000	1	\N	\N	\N	\N
1109	83	1	1	0	1	\N	\N	\N	2400	1	\N	\N	\N	\N
1110	83	4	1	0	1	\N	\N	\N	3400	1	\N	\N	\N	\N
1111	83	4	1	300	2	\N	\N	\N	1400	1	1600	1	\N	\N
1112	83	2	1	300	2	\N	\N	\N	2190	1	2500	1	\N	\N
1113	83	2	1	0	1	\N	\N	\N	4200	1	\N	\N	\N	\N
1114	83	2	1	0	1	\N	\N	\N	4000	1	\N	\N	\N	\N
1115	83	3	1	300	2	\N	\N	\N	3000	1	\N	\N	\N	\N
1116	83	3	1	0	1	\N	\N	\N	5000	1	\N	\N	\N	\N
1117	83	5	1	0	1	\N	\N	\N	6700	1	\N	\N	\N	\N
1118	83	5	1	300	2	\N	\N	\N	3910	1	\N	\N	\N	\N
1119	83	10	1	5000	4	\N	\N	\N	2200	1	\N	\N	\N	\N
1120	83	1	1	5000	4	\N	\N	\N	5000	1	\N	\N	\N	\N
1121	83	11	1	0	1	\N	\N	\N	5100	1	\N	\N	\N	\N
1122	83	11	1	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1123	83	3	1	0	1	\N	\N	\N	3625	1	\N	\N	\N	\N
1124	83	3	1	300	2	\N	\N	\N	1989	1	\N	\N	\N	\N
1125	83	3	1	5000	4	\N	\N	\N	2950	1	\N	\N	\N	\N
1126	84	1	1	0	1	\N	\N	\N	12000	1	15000	1	\N	\N
1127	84	1	1	0	1	\N	\N	\N	8000	1	9000	1	\N	\N
1128	84	1	1	0	1	\N	\N	\N	6000	1	7000	1	\N	\N
1129	84	4	1	1000	2	\N	\N	\N	1400	1	\N	\N	\N	\N
1130	84	4	1	1000	2	\N	\N	\N	1500	1	\N	\N	\N	\N
1131	84	1	1	0	1	\N	\N	\N	6000	1	7000	1	\N	\N
1132	85	1	1	5000	4	\N	\N	\N	3000	1	\N	\N	\N	\N
1133	86	1	1	5000	4	6700	4	\N	2000	1	\N	\N	\N	\N
1134	86	1	1	2000	4	3500	4	\N	3000	1	\N	\N	\N	\N
1135	86	1	1	500	4	\N	\N	\N	4000	1	\N	\N	\N	\N
1136	87	1	1	5000	4	\N	\N	\N	300	1	\N	\N	\N	\N
1137	88	1	1	0	1	\N	\N	\N	3600	1	\N	\N	\N	Can
1138	89	1	1	0	1	\N	\N	\N	500	1	800	1	\N	Must
1139	89	1	1	2965	4	\N	\N	\N	550	1	\N	\N	\N	\N
1140	90	3	1	9500	4	\N	\N	\N	9500	2	\N	\N	\N	\N
1141	90	3	1	500	4	\N	\N	\N	10500	2	\N	\N	\N	\N
1142	90	3	1	200	4	\N	\N	\N	10700	2	\N	\N	\N	\N
1143	90	3	1	0	1	\N	\N	\N	11000	2	\N	\N	\N	\N
1144	90	3	1	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1145	90	3	1	0	1	\N	\N	\N	10500	2	11000	2	\N	\N
1146	90	3	1	9500	4	\N	\N	\N	3000	1	\N	\N	\N	\N
1147	90	3	1	9900	4	\N	\N	\N	2850	1	\N	\N	\N	\N
1148	90	5	1	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1149	90	11	1	0	1	\N	\N	\N	7700	1	8050	1	\N	\N
1150	90	11	1	0	1	\N	\N	\N	6509	1	7000	1	\N	\N
1151	90	11	1	0	1	\N	\N	\N	6650	1	7000	1	\N	\N
1152	90	10	1	0	1	\N	\N	\N	5700	1	\N	\N	\N	\N
1153	90	10	1	0	1	\N	\N	\N	6300	1	\N	\N	\N	\N
1154	90	10	1	0	1	\N	\N	\N	3878	1	4350	1	\N	\N
1155	90	10	1	0	1	\N	\N	\N	3370	1	3440	3	\N	\N
1156	90	10	1	0	1	\N	\N	\N	3440	1	3625	1	\N	\N
1157	90	1	1	9500	4	\N	\N	\N	4275	1	9500	2	\N	Must
1158	90	1	1	0	1	\N	\N	\N	4815	1	10700	2	\N	Must
1159	90	1	1	9000	4	\N	\N	\N	9900	2	\N	\N	\N	Must
1160	90	1	1	9900	4	\N	\N	\N	9000	2	\N	\N	\N	Must
1161	90	1	1	9700	4	\N	\N	\N	9700	2	\N	\N	\N	Must
1162	90	1	1	100	4	\N	\N	\N	11500	2	\N	\N	\N	Must
1163	90	1	1	1000	4	\N	\N	\N	11000	2	\N	\N	\N	Must
1164	90	1	1	0	1	\N	\N	\N	9000	2	9500	2	\N	Must
1165	90	10	1	0	1	\N	\N	\N	9000	2	9500	2	\N	Must
1166	90	3	1	9300	4	10000	4	\N	2325	1	\N	\N	\N	\N
1167	90	3	1	1000	4	\N	\N	\N	2625	1	\N	\N	\N	\N
1168	90	3	1	500	4	\N	\N	\N	2750	1	\N	\N	\N	\N
1169	90	3	1	0	1	\N	\N	\N	2875	1	\N	\N	\N	\N
1170	91	1	1	0	1	\N	\N	\N	4275	1	9500	2	\N	Must
1171	92	3	1	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1172	92	3	1	9800	4	\N	\N	\N	3000	1	\N	\N	\N	\N
1173	92	5	1	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1174	92	11	1	0	1	\N	\N	\N	6650	1	7000	1	\N	\N
1175	92	10	1	0	1	\N	\N	\N	6000	1	\N	\N	\N	\N
1176	93	1	1	0	1	\N	\N	\N	9000	2	\N	\N	\N	Must
1177	93	1	1	0	1	\N	\N	\N	10700	2	\N	\N	\N	Must
1178	94	1	1	0	1	\N	\N	\N	10000	2	\N	\N	\N	Must
1179	94	1	1	0	1	\N	\N	\N	10200	2	\N	\N	\N	Can
1180	95	1	1	110	9	\N	\N	\N	4300	1	\N	\N	\N	Can
1181	95	1	1	155	9	\N	\N	\N	3600	1	\N	\N	\N	Can
1182	96	1	1	9500	4	\N	\N	\N	4500	1	4750	1	\N	\N
1183	96	1	1	5000	4	\N	\N	\N	5400	1	5600	1	\N	\N
1184	96	1	1	3000	4	3500	4	\N	6000	1	\N	\N	\N	\N
1185	97	1	1	9500	4	\N	\N	\N	4500	1	4750	1	\N	\N
1186	98	1	1	9500	4	\N	\N	\N	4500	1	4750	1	\N	\N
1187	99	1	1	9000	4	\N	\N	\N	4000	1	4500	1	\N	\N
\.


--
-- Data for Name: region_disease_site; Type: TABLE DATA; Schema: public; Owner: davidrosenberg
--

COPY public.region_disease_site (id, region, disease_site) FROM stdin;
1	27	1
2	29	1
3	29	2
4	29	3
5	70	4
6	78	3
7	91	5
8	92	3
9	92	5
10	93	3
11	94	5
12	95	3
13	105	3
14	106	3
15	107	3
16	108	3
17	115	3
18	120	3
19	127	5
20	128	6
21	129	3
22	130	3
23	142	3
24	143	3
25	172	2
26	218	7
27	230	8
28	235	3
29	250	3
30	251	3
31	252	3
32	253	3
33	254	3
34	255	3
35	256	3
36	257	3
37	275	3
38	292	6
39	296	2
40	305	2
41	334	3
42	336	9
43	338	2
44	339	2
45	340	2
46	341	2
47	342	9
48	349	2
49	350	2
50	351	2
51	353	4
52	366	9
53	367	10
54	368	9
55	369	9
56	370	9
57	371	9
58	372	9
59	382	11
60	383	11
61	384	11
62	385	11
63	386	11
64	387	11
65	388	11
66	389	11
67	390	11
68	391	11
69	392	11
70	393	11
71	394	11
72	395	11
73	396	11
74	397	11
75	398	11
76	399	10
77	399	9
78	400	10
79	400	9
80	401	3
81	402	3
82	403	3
83	404	3
84	405	11
85	406	11
86	407	11
87	408	2
88	414	2
89	415	2
90	416	2
91	430	2
92	431	2
93	432	2
94	433	2
95	434	2
96	435	11
97	436	11
98	437	3
99	445	2
100	446	2
101	449	2
102	450	2
103	451	2
104	454	2
105	457	2
106	459	2
107	460	2
108	461	2
109	464	2
110	467	2
111	468	2
112	483	9
113	483	2
114	483	10
115	485	9
116	486	2
117	487	2
118	487	3
119	488	9
120	488	3
121	489	9
122	489	10
123	492	2
124	517	10
125	524	12
126	525	10
127	525	9
128	526	10
129	526	9
130	527	10
131	527	9
132	527	3
133	528	3
134	529	3
135	530	3
136	535	3
137	536	10
138	536	9
139	537	11
140	538	11
141	539	11
142	540	11
143	541	11
144	542	11
145	543	11
146	544	11
147	545	11
148	546	11
149	547	11
150	548	11
151	549	3
152	550	11
153	551	11
154	552	11
155	557	11
156	558	11
157	559	11
158	560	11
159	561	12
160	562	3
161	595	3
162	596	3
163	597	3
164	598	3
165	599	11
166	600	11
167	601	11
168	602	11
169	603	11
170	604	11
171	605	11
172	606	11
173	607	11
174	608	11
175	609	11
176	610	4
177	610	10
178	639	10
179	641	4
180	642	4
181	643	4
182	644	4
183	645	4
184	646	4
185	650	10
186	651	10
187	652	4
188	653	7
189	654	7
190	655	7
191	658	13
192	659	13
193	660	13
194	661	13
195	687	4
196	688	4
197	689	4
198	690	4
199	691	4
200	692	4
201	693	4
202	694	4
203	695	4
204	696	4
205	697	4
206	698	4
207	699	4
208	700	4
209	704	4
210	705	4
211	706	3
212	709	4
213	733	4
214	734	4
215	736	10
216	736	9
217	737	10
218	737	9
219	739	7
220	740	7
221	741	7
222	745	3
223	746	3
224	747	3
225	748	3
226	749	3
227	750	3
228	751	3
229	762	4
230	776	4
231	777	4
232	778	9
233	778	10
234	778	3
235	779	9
236	779	10
237	780	10
238	781	10
239	782	10
240	783	4
241	784	14
242	785	7
243	786	7
244	787	7
245	789	3
246	790	3
247	794	15
248	797	3
249	799	10
250	800	10
251	801	10
252	802	3
253	803	3
254	804	3
255	805	3
256	813	16
257	813	17
258	813	10
259	814	18
260	817	4
261	817	16
262	817	17
263	818	4
264	818	18
265	819	4
266	821	16
267	822	16
268	823	10
269	823	9
270	824	4
271	825	15
272	826	14
273	827	14
274	828	14
275	829	7
276	830	3
277	849	4
278	850	4
279	851	4
280	854	4
281	858	4
282	859	18
283	860	18
284	861	18
285	862	18
286	863	18
287	864	7
288	865	7
289	866	7
290	867	7
291	868	16
292	869	16
293	870	16
294	871	16
295	872	17
296	872	16
297	873	17
298	873	16
299	874	17
300	875	17
301	876	17
302	877	17
303	878	16
304	879	16
305	880	19
306	881	19
307	882	19
308	883	19
309	884	19
310	885	19
311	886	19
312	887	19
313	888	19
314	889	19
315	890	19
316	891	19
317	892	19
318	893	19
319	910	4
320	912	17
321	912	16
322	913	7
323	914	7
324	915	7
325	916	17
326	916	16
327	917	17
328	919	18
329	920	18
330	921	18
331	922	14
332	927	13
333	928	13
334	929	18
335	940	18
336	941	18
337	942	18
338	943	18
339	944	18
340	958	18
341	959	18
342	960	18
343	961	18
344	962	18
345	963	18
346	964	18
347	965	18
348	966	18
349	967	18
350	968	18
351	969	18
352	970	18
353	971	18
354	972	18
355	973	18
356	974	18
357	975	18
358	976	18
359	977	14
360	978	14
361	979	14
362	980	19
363	981	19
364	982	19
365	983	19
366	984	19
367	985	19
368	986	19
369	987	19
370	988	19
371	989	19
372	990	3
373	991	7
374	994	18
375	995	18
376	1004	18
377	1007	18
378	1013	16
379	1013	17
380	1014	16
381	1015	16
382	1016	17
383	1017	17
384	1023	18
385	1024	18
386	1025	18
387	1026	18
388	1027	18
389	1028	18
390	1029	18
391	1030	18
392	1031	18
393	1032	18
394	1033	18
395	1034	18
396	1035	18
397	1036	18
398	1037	18
399	1038	14
400	1039	14
401	1040	14
402	1041	16
403	1042	16
404	1043	16
405	1044	17
406	1045	3
407	1046	3
408	1051	18
409	1052	18
410	1053	18
411	1055	17
412	1062	17
413	1062	16
414	1063	17
415	1064	16
416	1065	16
417	1068	18
418	1069	18
419	1070	16
420	1071	18
421	1072	18
422	1073	18
423	1074	18
424	1075	18
425	1076	18
426	1077	18
427	1078	7
428	1079	7
429	1080	7
430	1081	7
431	1082	3
432	1083	3
433	1085	13
434	1086	16
435	1088	19
436	1089	19
437	1090	16
438	1091	16
439	1092	16
440	1094	17
441	1095	17
442	1096	18
443	1097	18
444	1098	18
445	1099	13
446	1100	13
447	1101	14
448	1102	13
449	1103	17
450	1104	17
451	1105	7
452	1109	18
453	1119	18
454	1120	18
455	1121	18
456	1122	18
457	1123	18
458	1124	18
459	1125	18
460	1132	7
461	1133	17
462	1134	17
463	1135	17
464	1136	7
465	1137	16
466	1137	17
467	1138	13
468	1139	13
469	1140	11
470	1141	11
471	1142	11
472	1143	11
473	1144	11
474	1145	11
475	1146	11
476	1147	11
477	1148	11
478	1149	18
479	1150	18
480	1151	18
481	1152	18
482	1153	18
483	1154	18
484	1155	18
485	1156	18
486	1157	14
487	1158	14
488	1159	14
489	1160	14
490	1161	14
491	1162	14
492	1163	14
493	1164	19
494	1165	19
495	1166	16
496	1167	16
497	1168	16
498	1169	16
499	1170	14
500	1171	11
501	1172	11
502	1173	11
503	1174	18
504	1175	18
505	1176	14
506	1177	14
507	1178	14
508	1179	14
509	1180	14
510	1181	14
511	1182	11
512	1183	11
513	1184	11
514	1185	11
515	1186	11
516	1187	11
\.


--
-- Data for Name: region_protocols; Type: TABLE DATA; Schema: public; Owner: davidrosenberg
--

COPY public.region_protocols (id, region, protocol) FROM stdin;
\.


--
-- Data for Name: region_publications; Type: TABLE DATA; Schema: public; Owner: davidrosenberg
--

COPY public.region_publications (id, region, publication) FROM stdin;
\.


--
-- Data for Name: target; Type: TABLE DATA; Schema: public; Owner: davidrosenberg
--

COPY public.target (id, name, alphabeta) FROM stdin;
1	Brain	\N
2	Brainstem	\N
3	Cord	\N
4	Optic Chiasm	\N
5	Optic Nerve	\N
6	Cochlea	\N
7	Pituitary	\N
8	Hippocampus	\N
9	Circle_of_Willis	\N
10	Lens	\N
11	Orbit	\N
12	EyeBack (Retina)	\N
13	EyeFront	\N
14	Brachial_Plexus	\N
15	Cauda_Equina	\N
16	Sacral_Plexus	\N
17	Skin	\N
18	Carotid Artery	\N
19	Temporal Lobe	\N
20	Lips	\N
21	BuccalMuc	\N
22	Oral_Cavity	\N
23	Gland_Lacrimal	\N
24	Parotid_Ipsi	\N
25	Parotid_Contra	\N
26	Parotids	\N
27	Submandibular	\N
28	Submandibular_Contra	\N
29	Thyroid	\N
30	Pterygoid_Lat	\N
31	Constrictor_L	\N
32	Constrictor_M	\N
33	Constrictor_S	\N
34	Constrictors	\N
35	Larynx	\N
36	Larynx_Glottic	\N
37	Larynx_SGL	\N
38	Pharynx_post_wall	\N
39	Mandible	\N
40	Esophagus_Cervical	\N
41	Esophagus	\N
42	Heart	\N
43	Pericardium	\N
44	Great_Vessels	\N
45	L_Circumflex	\N
46	LAD	\N
47	Heart_Atria	\N
48	L_Ventricle	\N
49	Trachea	\N
50	Bronchial_Tree	\N
51	Lungs	\N
52	Lung_Ipsi	\N
53	Lung_Contra	\N
54	Rib	\N
55	Chest_Wall	\N
56	Breast	\N
57	Breast_Ipsi	\N
58	Breast_Contra	\N
59	Stomach	\N
60	Duodenum	\N
61	Spleen	\N
62	Liver	\N
63	Pancreas	\N
64	Biliary_Tree	\N
65	Renal_Cortex	\N
66	Renal_Cortex_Contra	\N
67	Renal_Cortex_Ipsi	\N
68	Renal_hilum	\N
69	Bowel_Bag	\N
70	Bowel_Loop_Sm	\N
71	Bowel_Loops	\N
72	Bowel_Loop_La	\N
73	Sigmoid	\N
74	Rectum	\N
75	Anus	\N
76	Bladder	\N
77	Ureter/Urethra	\N
78	Femoral_Heads	\N
79	Iliac_Crest	\N
80	Pubic_Bone	\N
81	Bone_Marrow	\N
82	Joint/Bone	\N
83	Penile_Bulb	\N
84	Vagina	\N
85	Vulva	\N
86	External_Genitalia	\N
87	Testes	\N
88	Gluteal_Folds	\N
89	Transposed_Ovaries	\N
90	PTV	\N
91	ITV	\N
92	CTV	\N
93	PTVn	\N
94	CTVn	\N
95	Conformality	\N
96	PTV_Breast/CW	\N
97	PTV_Axilla	\N
98	PTV_SCV	\N
99	PTV_IMN	\N
\.


--
-- Data for Name: volume_type; Type: TABLE DATA; Schema: public; Owner: davidrosenberg
--

COPY public.volume_type (id, description) FROM stdin;
1	MAX
2	cc
3	.5 cc
4	%
5	.35 cc
6	.2 cc
7	.0 cc
8	.5%
9	
\.


--
-- Name: disease_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: davidrosenberg
--

SELECT pg_catalog.setval('public.disease_site_id_seq', 1, false);


--
-- Name: dose_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: davidrosenberg
--

SELECT pg_catalog.setval('public.dose_type_id_seq', 1, false);


--
-- Name: fractionation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: davidrosenberg
--

SELECT pg_catalog.setval('public.fractionation_id_seq', 1, false);


--
-- Name: intent_id_seq; Type: SEQUENCE SET; Schema: public; Owner: davidrosenberg
--

SELECT pg_catalog.setval('public.intent_id_seq', 1, false);


--
-- Name: note_id_seq; Type: SEQUENCE SET; Schema: public; Owner: davidrosenberg
--

SELECT pg_catalog.setval('public.note_id_seq', 1, false);


--
-- Name: protocol_id_seq; Type: SEQUENCE SET; Schema: public; Owner: davidrosenberg
--

SELECT pg_catalog.setval('public.protocol_id_seq', 1, false);


--
-- Name: publication_id_seq; Type: SEQUENCE SET; Schema: public; Owner: davidrosenberg
--

SELECT pg_catalog.setval('public.publication_id_seq', 1, false);


--
-- Name: region_disease_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: davidrosenberg
--

SELECT pg_catalog.setval('public.region_disease_site_id_seq', 1, false);


--
-- Name: region_id_seq; Type: SEQUENCE SET; Schema: public; Owner: davidrosenberg
--

SELECT pg_catalog.setval('public.region_id_seq', 1, false);


--
-- Name: region_protocols_id_seq; Type: SEQUENCE SET; Schema: public; Owner: davidrosenberg
--

SELECT pg_catalog.setval('public.region_protocols_id_seq', 1, false);


--
-- Name: region_publications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: davidrosenberg
--

SELECT pg_catalog.setval('public.region_publications_id_seq', 1, false);


--
-- Name: target_id_seq; Type: SEQUENCE SET; Schema: public; Owner: davidrosenberg
--

SELECT pg_catalog.setval('public.target_id_seq', 99, true);


--
-- Name: volume_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: davidrosenberg
--

SELECT pg_catalog.setval('public.volume_type_id_seq', 1, false);


--
-- Name: disease_site disease_site_pkey; Type: CONSTRAINT; Schema: public; Owner: davidrosenberg
--

ALTER TABLE ONLY public.disease_site
    ADD CONSTRAINT disease_site_pkey PRIMARY KEY (id);


--
-- Name: dose_type dose_type_pkey; Type: CONSTRAINT; Schema: public; Owner: davidrosenberg
--

ALTER TABLE ONLY public.dose_type
    ADD CONSTRAINT dose_type_pkey PRIMARY KEY (id);


--
-- Name: fractionation fractionation_pkey; Type: CONSTRAINT; Schema: public; Owner: davidrosenberg
--

ALTER TABLE ONLY public.fractionation
    ADD CONSTRAINT fractionation_pkey PRIMARY KEY (id);


--
-- Name: intent intent_pkey; Type: CONSTRAINT; Schema: public; Owner: davidrosenberg
--

ALTER TABLE ONLY public.intent
    ADD CONSTRAINT intent_pkey PRIMARY KEY (id);


--
-- Name: note note_pkey; Type: CONSTRAINT; Schema: public; Owner: davidrosenberg
--

ALTER TABLE ONLY public.note
    ADD CONSTRAINT note_pkey PRIMARY KEY (id);


--
-- Name: protocol protocol_pkey; Type: CONSTRAINT; Schema: public; Owner: davidrosenberg
--

ALTER TABLE ONLY public.protocol
    ADD CONSTRAINT protocol_pkey PRIMARY KEY (id);


--
-- Name: publication publication_pkey; Type: CONSTRAINT; Schema: public; Owner: davidrosenberg
--

ALTER TABLE ONLY public.publication
    ADD CONSTRAINT publication_pkey PRIMARY KEY (id);


--
-- Name: region_disease_site region_disease_site_pkey; Type: CONSTRAINT; Schema: public; Owner: davidrosenberg
--

ALTER TABLE ONLY public.region_disease_site
    ADD CONSTRAINT region_disease_site_pkey PRIMARY KEY (id);


--
-- Name: region region_pkey; Type: CONSTRAINT; Schema: public; Owner: davidrosenberg
--

ALTER TABLE ONLY public.region
    ADD CONSTRAINT region_pkey PRIMARY KEY (id);


--
-- Name: region_protocols region_protocols_pkey; Type: CONSTRAINT; Schema: public; Owner: davidrosenberg
--

ALTER TABLE ONLY public.region_protocols
    ADD CONSTRAINT region_protocols_pkey PRIMARY KEY (id);


--
-- Name: region_publications region_publications_pkey; Type: CONSTRAINT; Schema: public; Owner: davidrosenberg
--

ALTER TABLE ONLY public.region_publications
    ADD CONSTRAINT region_publications_pkey PRIMARY KEY (id);


--
-- Name: target target_pkey; Type: CONSTRAINT; Schema: public; Owner: davidrosenberg
--

ALTER TABLE ONLY public.target
    ADD CONSTRAINT target_pkey PRIMARY KEY (id);


--
-- Name: volume_type volume_type_pkey; Type: CONSTRAINT; Schema: public; Owner: davidrosenberg
--

ALTER TABLE ONLY public.volume_type
    ADD CONSTRAINT volume_type_pkey PRIMARY KEY (id);


--
-- Name: note note_parent_fkey; Type: FK CONSTRAINT; Schema: public; Owner: davidrosenberg
--

ALTER TABLE ONLY public.note
    ADD CONSTRAINT note_parent_fkey FOREIGN KEY (parent) REFERENCES public.note(id);


--
-- Name: note note_region_fkey; Type: FK CONSTRAINT; Schema: public; Owner: davidrosenberg
--

ALTER TABLE ONLY public.note
    ADD CONSTRAINT note_region_fkey FOREIGN KEY (region) REFERENCES public.region(id);


--
-- Name: region_disease_site region_disease_site_disease_site_fkey; Type: FK CONSTRAINT; Schema: public; Owner: davidrosenberg
--

ALTER TABLE ONLY public.region_disease_site
    ADD CONSTRAINT region_disease_site_disease_site_fkey FOREIGN KEY (disease_site) REFERENCES public.disease_site(id);


--
-- Name: region_disease_site region_disease_site_region_fkey; Type: FK CONSTRAINT; Schema: public; Owner: davidrosenberg
--

ALTER TABLE ONLY public.region_disease_site
    ADD CONSTRAINT region_disease_site_region_fkey FOREIGN KEY (region) REFERENCES public.region(id);


--
-- Name: region region_dose_deviation_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: davidrosenberg
--

ALTER TABLE ONLY public.region
    ADD CONSTRAINT region_dose_deviation_type_fkey FOREIGN KEY (dose_deviation_type) REFERENCES public.dose_type(id);


--
-- Name: region region_dose_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: davidrosenberg
--

ALTER TABLE ONLY public.region
    ADD CONSTRAINT region_dose_type_fkey FOREIGN KEY (dose_type) REFERENCES public.dose_type(id);


--
-- Name: region region_fractionation_fkey; Type: FK CONSTRAINT; Schema: public; Owner: davidrosenberg
--

ALTER TABLE ONLY public.region
    ADD CONSTRAINT region_fractionation_fkey FOREIGN KEY (fractionation) REFERENCES public.fractionation(id);


--
-- Name: region region_intent_fkey; Type: FK CONSTRAINT; Schema: public; Owner: davidrosenberg
--

ALTER TABLE ONLY public.region
    ADD CONSTRAINT region_intent_fkey FOREIGN KEY (intent) REFERENCES public.intent(id);


--
-- Name: region_protocols region_protocols_protocol_fkey; Type: FK CONSTRAINT; Schema: public; Owner: davidrosenberg
--

ALTER TABLE ONLY public.region_protocols
    ADD CONSTRAINT region_protocols_protocol_fkey FOREIGN KEY (protocol) REFERENCES public.protocol(id);


--
-- Name: region_protocols region_protocols_region_fkey; Type: FK CONSTRAINT; Schema: public; Owner: davidrosenberg
--

ALTER TABLE ONLY public.region_protocols
    ADD CONSTRAINT region_protocols_region_fkey FOREIGN KEY (region) REFERENCES public.region(id);


--
-- Name: region_publications region_publications_publication_fkey; Type: FK CONSTRAINT; Schema: public; Owner: davidrosenberg
--

ALTER TABLE ONLY public.region_publications
    ADD CONSTRAINT region_publications_publication_fkey FOREIGN KEY (publication) REFERENCES public.publication(id);


--
-- Name: region_publications region_publications_region_fkey; Type: FK CONSTRAINT; Schema: public; Owner: davidrosenberg
--

ALTER TABLE ONLY public.region_publications
    ADD CONSTRAINT region_publications_region_fkey FOREIGN KEY (region) REFERENCES public.region(id);


--
-- Name: region region_target_fkey; Type: FK CONSTRAINT; Schema: public; Owner: davidrosenberg
--

ALTER TABLE ONLY public.region
    ADD CONSTRAINT region_target_fkey FOREIGN KEY (target) REFERENCES public.target(id);


--
-- Name: region region_volume_deviation_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: davidrosenberg
--

ALTER TABLE ONLY public.region
    ADD CONSTRAINT region_volume_deviation_type_fkey FOREIGN KEY (volume_deviation_type) REFERENCES public.volume_type(id);


--
-- Name: region region_volume_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: davidrosenberg
--

ALTER TABLE ONLY public.region
    ADD CONSTRAINT region_volume_type_fkey FOREIGN KEY (volume_type) REFERENCES public.volume_type(id);


--
-- PostgreSQL database dump complete
--

