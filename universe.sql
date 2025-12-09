--
-- PostgreSQL database dump
--

-- Dumped from database version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)
-- Dumped by pg_dump version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)

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

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

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
-- Name: asteroid; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.asteroid (
    asteroid_id integer NOT NULL,
    name character varying(60) NOT NULL,
    planet_id integer,
    size_m integer NOT NULL,
    composition text,
    potentially_hazardous boolean DEFAULT false NOT NULL,
    discovered boolean DEFAULT true NOT NULL
);


ALTER TABLE public.asteroid OWNER TO freecodecamp;

--
-- Name: asteroid_asteroid_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.asteroid_asteroid_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.asteroid_asteroid_id_seq OWNER TO freecodecamp;

--
-- Name: asteroid_asteroid_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.asteroid_asteroid_id_seq OWNED BY public.asteroid.asteroid_id;


--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(60) NOT NULL,
    description text,
    size_kly integer NOT NULL,
    star_count integer NOT NULL,
    mass numeric(12,2) NOT NULL,
    has_habitable_zones boolean DEFAULT false NOT NULL,
    discovered boolean DEFAULT true NOT NULL
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(60) NOT NULL,
    planet_id integer NOT NULL,
    diameter_km integer NOT NULL,
    mass numeric(8,3) NOT NULL,
    tidally_locked boolean DEFAULT false NOT NULL,
    has_atmosphere boolean DEFAULT false NOT NULL,
    note text
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(60) NOT NULL,
    star_id integer NOT NULL,
    mass numeric(8,3) NOT NULL,
    radius_km integer NOT NULL,
    habitable boolean DEFAULT false NOT NULL,
    has_rings boolean DEFAULT false NOT NULL,
    description text
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(60) NOT NULL,
    galaxy_id integer NOT NULL,
    spectral_type character varying(10) NOT NULL,
    mass numeric(8,3) NOT NULL,
    age_million_years integer NOT NULL,
    is_main_sequence boolean DEFAULT true NOT NULL,
    is_variable boolean DEFAULT false NOT NULL
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: asteroid asteroid_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.asteroid ALTER COLUMN asteroid_id SET DEFAULT nextval('public.asteroid_asteroid_id_seq'::regclass);


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Data for Name: asteroid; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.asteroid VALUES (5, 'Ceres-1', NULL, 940000, 'Rock/ice', false, true);
INSERT INTO public.asteroid VALUES (6, 'Asteroid-A', 5, 1200, 'Metallic', false, true);
INSERT INTO public.asteroid VALUES (7, 'Asteroid-B', 3, 500, 'Carbonaceous', false, true);
INSERT INTO public.asteroid VALUES (8, 'Asteroid-C', 11, 800, 'Silicate', true, true);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Milky Way', 'Home galaxy', 105000, 200000000, 1.50, true, true);
INSERT INTO public.galaxy VALUES (2, 'Andromeda', 'Nearest large neighbor', 220000, 1000000000, 1.20, true, true);
INSERT INTO public.galaxy VALUES (3, 'Triangulum', 'Nearby spiral', 60000, 40000000, 5.00, false, true);
INSERT INTO public.galaxy VALUES (4, 'Sombrero', 'Large bulge galaxy', 50000, 80000000, 9.00, false, true);
INSERT INTO public.galaxy VALUES (5, 'Whirlpool', 'Grand-design spiral', 60000, 35000000, 8.30, false, true);
INSERT INTO public.galaxy VALUES (6, 'Cartwheel', 'Ring galaxy', 150000, 20000000, 4.40, false, true);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (49, 'Luna', 3, 3474, 0.073, true, false, 'Earth''s moon');
INSERT INTO public.moon VALUES (50, 'Phobos', 4, 22, 0.000, true, false, 'Mars inner moon');
INSERT INTO public.moon VALUES (51, 'Deimos', 4, 12, 0.000, true, false, 'Mars outer moon');
INSERT INTO public.moon VALUES (52, 'Io', 5, 3643, 0.000, false, false, 'Volcanic moon of Jupiter');
INSERT INTO public.moon VALUES (53, 'Europa', 5, 3122, 0.000, false, false, 'Icy ocean moon of Jupiter');
INSERT INTO public.moon VALUES (54, 'Ganymede', 5, 5262, 0.000, false, false, 'Largest moon');
INSERT INTO public.moon VALUES (55, 'Callisto', 5, 4821, 0.000, false, false, 'Heavily cratered');
INSERT INTO public.moon VALUES (56, 'Titan', 5, 5150, 0.000, false, true, 'Thick atmosphere');
INSERT INTO public.moon VALUES (57, 'Enceladus', 5, 504, 0.000, false, false, 'Cryovolcanic');
INSERT INTO public.moon VALUES (58, 'Triton', 8, 2706, 0.000, true, false, 'Neptune-like moon of Sirius-1');
INSERT INTO public.moon VALUES (59, 'Nix', 5, 50, 0.000, true, false, 'Small moon');
INSERT INTO public.moon VALUES (60, 'Hydra', 5, 50, 0.000, true, false, 'Small moon 2');
INSERT INTO public.moon VALUES (61, 'Moon-A', 1, 10, 0.000, true, false, 'Fictional small moon of Mercury');
INSERT INTO public.moon VALUES (62, 'Moon-B', 2, 15, 0.000, true, false, 'Fictional small moon of Venus');
INSERT INTO public.moon VALUES (63, 'Moon-C', 6, 40, 0.000, true, false, 'Alpha-Cen-Bb moon');
INSERT INTO public.moon VALUES (64, 'Moon-D', 7, 30, 0.000, true, false, 'Proxima-b moon');
INSERT INTO public.moon VALUES (65, 'Moon-E', 9, 25, 0.000, false, false, 'Vega-1 moon');
INSERT INTO public.moon VALUES (66, 'Moon-F', 10, 100, 0.000, false, false, 'Betelgeuse-1 moon');
INSERT INTO public.moon VALUES (67, 'Moon-G', 11, 85, 0.000, false, false, 'Rigel-1 moon');
INSERT INTO public.moon VALUES (68, 'Moon-H', 12, 45, 0.000, true, false, 'Sirius-2 moon');
INSERT INTO public.moon VALUES (69, 'Moon-I', 5, 35, 0.000, true, false, 'Additional small moon');
INSERT INTO public.moon VALUES (70, 'Moon-J', 5, 60, 0.000, false, false, 'Extra moon');
INSERT INTO public.moon VALUES (71, 'Moon-K', 3, 12, 0.000, true, false, 'Tiny moon');
INSERT INTO public.moon VALUES (72, 'Moon-L', 1, 8, 0.000, true, false, 'Tiny relic moon');


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 'Mercury', 1, 0.330, 2439, false, false, 'Small rocky planet');
INSERT INTO public.planet VALUES (2, 'Venus', 1, 4.870, 6051, false, false, 'Thick clouds');
INSERT INTO public.planet VALUES (3, 'Earth', 1, 5.972, 6371, true, false, 'Blue planet');
INSERT INTO public.planet VALUES (4, 'Mars', 1, 0.642, 3389, false, false, 'Red planet');
INSERT INTO public.planet VALUES (5, 'Jupiter', 1, 1898.000, 69911, false, true, 'Gas giant');
INSERT INTO public.planet VALUES (6, 'Alpha-Cen-Bb', 2, 1.100, 7100, false, false, 'Exoplanet around Alpha Centauri A');
INSERT INTO public.planet VALUES (7, 'Proxima-b', 3, 1.270, 7100, true, false, 'Potentially habitable exoplanet');
INSERT INTO public.planet VALUES (8, 'Sirius-1', 4, 2.500, 9000, false, false, 'Exoplanet in Sirius system');
INSERT INTO public.planet VALUES (9, 'Vega-1', 5, 3.200, 9500, false, false, 'Hot exoplanet');
INSERT INTO public.planet VALUES (10, 'Betelgeuse-1', 6, 5.000, 11000, false, false, 'Massive exoplanet');
INSERT INTO public.planet VALUES (11, 'Rigel-1', 7, 6.000, 12000, false, false, 'Giant exoplanet');
INSERT INTO public.planet VALUES (12, 'Sirius-2', 4, 0.900, 6000, false, false, 'Second planet in Sirius');


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 'Sun', 1, 'G2V', 1.000, 4600, true, false);
INSERT INTO public.star VALUES (2, 'Alpha Centauri A', 1, 'G2V', 1.100, 5000, true, false);
INSERT INTO public.star VALUES (3, 'Proxima Centauri', 1, 'M5V', 0.122, 4500, true, true);
INSERT INTO public.star VALUES (4, 'Sirius', 2, 'A1V', 2.060, 242, true, false);
INSERT INTO public.star VALUES (5, 'Vega', 2, 'A0V', 2.135, 455, true, false);
INSERT INTO public.star VALUES (6, 'Betelgeuse', 3, 'M2I', 18.000, 8000, false, true);
INSERT INTO public.star VALUES (7, 'Rigel', 4, 'B8I', 21.000, 9000, false, true);


--
-- Name: asteroid_asteroid_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.asteroid_asteroid_id_seq', 8, true);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 6, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 72, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 12, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 7, true);


--
-- Name: asteroid asteroid_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.asteroid
    ADD CONSTRAINT asteroid_name_key UNIQUE (name);


--
-- Name: asteroid asteroid_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.asteroid
    ADD CONSTRAINT asteroid_pkey PRIMARY KEY (asteroid_id);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: asteroid asteroid_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.asteroid
    ADD CONSTRAINT asteroid_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id) ON DELETE CASCADE;


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--

