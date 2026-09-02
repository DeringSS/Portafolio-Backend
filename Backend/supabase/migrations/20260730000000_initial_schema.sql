--
-- PostgreSQL database dump
--

\restrict 5JaGf6KwhGIOt26qOCn5dI3CccasQGi7OR5jh0Ydkq5tXrZiTGvP5EZETqEQSm6

-- Dumped from database version 17.6
-- Dumped by pg_dump version 18.3

-- Started on 2026-07-30 15:24:39

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 13 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 3996 (class 0 OID 0)
-- Dependencies: 13
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 1180 (class 1247 OID 17518)
-- Name: categoria_habilidad; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.categoria_habilidad AS ENUM (
    'frontend',
    'backend',
    'devops',
    'base_datos',
    'herramientas',
    'otros'
);


ALTER TYPE public.categoria_habilidad OWNER TO postgres;

--
-- TOC entry 1183 (class 1247 OID 17532)
-- Name: categoria_tecnologia; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.categoria_tecnologia AS ENUM (
    'frontend',
    'backend',
    'devops',
    'base_datos',
    'herramientas',
    'otros'
);


ALTER TYPE public.categoria_tecnologia OWNER TO postgres;

--
-- TOC entry 1171 (class 1247 OID 17498)
-- Name: estado_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.estado_enum AS ENUM (
    'borrador',
    'publicado'
);


ALTER TYPE public.estado_enum OWNER TO postgres;

--
-- TOC entry 1168 (class 1247 OID 17492)
-- Name: idioma_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.idioma_enum AS ENUM (
    'es',
    'en'
);


ALTER TYPE public.idioma_enum OWNER TO postgres;

--
-- TOC entry 1177 (class 1247 OID 17512)
-- Name: tipo_educacion; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.tipo_educacion AS ENUM (
    'educacion',
    'certificacion'
);


ALTER TYPE public.tipo_educacion OWNER TO postgres;

--
-- TOC entry 1186 (class 1247 OID 17546)
-- Name: tipo_equipo; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.tipo_equipo AS ENUM (
    'solo',
    'equipo'
);


ALTER TYPE public.tipo_equipo OWNER TO postgres;

--
-- TOC entry 1174 (class 1247 OID 17504)
-- Name: tipo_experiencia; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.tipo_experiencia AS ENUM (
    'laboral',
    'freelance',
    'personal'
);


ALTER TYPE public.tipo_experiencia OWNER TO postgres;

--
-- TOC entry 444 (class 1255 OID 17786)
-- Name: actualizar_updated_at(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.actualizar_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.actualizar_updated_at() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 330 (class 1259 OID 17743)
-- Name: cv; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cv (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    archivo_url text NOT NULL,
    version text,
    activo boolean DEFAULT false,
    fecha_subida timestamp with time zone DEFAULT now()
);


ALTER TABLE public.cv OWNER TO postgres;

--
-- TOC entry 328 (class 1259 OID 17718)
-- Name: educacion_certificacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.educacion_certificacion (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    tipo public.tipo_educacion NOT NULL,
    institucion text NOT NULL,
    titulo text NOT NULL,
    fecha_inicio date,
    fecha_fin date,
    credencial_url text,
    logo_url text,
    orden integer DEFAULT 0,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.educacion_certificacion OWNER TO postgres;

--
-- TOC entry 329 (class 1259 OID 17728)
-- Name: educacion_traduccion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.educacion_traduccion (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    educacion_id uuid NOT NULL,
    idioma public.idioma_enum NOT NULL,
    titulo text NOT NULL,
    institucion text NOT NULL,
    descripcion text
);


ALTER TABLE public.educacion_traduccion OWNER TO postgres;

--
-- TOC entry 323 (class 1259 OID 17651)
-- Name: experiencia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.experiencia (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    empresa_o_proyecto text NOT NULL,
    rol text NOT NULL,
    tipo public.tipo_experiencia NOT NULL,
    fecha_inicio date NOT NULL,
    fecha_fin date,
    orden integer DEFAULT 0,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.experiencia OWNER TO postgres;

--
-- TOC entry 325 (class 1259 OID 17677)
-- Name: experiencia_tecnologia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.experiencia_tecnologia (
    experiencia_id uuid NOT NULL,
    tecnologia_id uuid NOT NULL
);


ALTER TABLE public.experiencia_tecnologia OWNER TO postgres;

--
-- TOC entry 324 (class 1259 OID 17662)
-- Name: experiencia_traduccion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.experiencia_traduccion (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    experiencia_id uuid NOT NULL,
    idioma public.idioma_enum NOT NULL,
    descripcion text,
    logros text
);


ALTER TABLE public.experiencia_traduccion OWNER TO postgres;

--
-- TOC entry 326 (class 1259 OID 17692)
-- Name: habilidad; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.habilidad (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    nombre text NOT NULL,
    categoria public.categoria_habilidad NOT NULL,
    nivel integer,
    anos_uso integer,
    icono_url text,
    orden integer DEFAULT 0,
    created_at timestamp with time zone DEFAULT now(),
    CONSTRAINT habilidad_nivel_check CHECK (((nivel >= 1) AND (nivel <= 5)))
);


ALTER TABLE public.habilidad OWNER TO postgres;

--
-- TOC entry 327 (class 1259 OID 17703)
-- Name: habilidad_traduccion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.habilidad_traduccion (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    habilidad_id uuid NOT NULL,
    idioma public.idioma_enum NOT NULL,
    nombre text NOT NULL
);


ALTER TABLE public.habilidad_traduccion OWNER TO postgres;

--
-- TOC entry 331 (class 1259 OID 17753)
-- Name: mensaje_contacto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mensaje_contacto (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    nombre text NOT NULL,
    email text NOT NULL,
    mensaje text NOT NULL,
    leido boolean DEFAULT false,
    respondido boolean DEFAULT false,
    fecha_envio timestamp with time zone DEFAULT now()
);


ALTER TABLE public.mensaje_contacto OWNER TO postgres;

--
-- TOC entry 316 (class 1259 OID 17551)
-- Name: perfil; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.perfil (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    nombre text NOT NULL,
    rol_titulo text NOT NULL,
    frase_diferenciadora text,
    bio_corta text,
    bio_larga text,
    foto_url text,
    cta_texto text,
    cta_link text,
    email text,
    github_url text,
    linkedin_url text,
    cv_url_activo text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.perfil OWNER TO postgres;

--
-- TOC entry 317 (class 1259 OID 17564)
-- Name: perfil_traduccion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.perfil_traduccion (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    perfil_id uuid NOT NULL,
    idioma public.idioma_enum NOT NULL,
    rol_titulo text NOT NULL,
    frase_diferenciadora text,
    bio_corta text,
    bio_larga text,
    cta_texto text
);


ALTER TABLE public.perfil_traduccion OWNER TO postgres;

--
-- TOC entry 319 (class 1259 OID 17590)
-- Name: proyecto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.proyecto (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    slug text NOT NULL,
    categoria text NOT NULL,
    repo_url text,
    demo_url text,
    gif_demo_url text,
    tiempo_desarrollo text,
    tipo_equipo public.tipo_equipo DEFAULT 'solo'::public.tipo_equipo,
    destacado boolean DEFAULT false,
    estado public.estado_enum DEFAULT 'borrador'::public.estado_enum,
    orden integer DEFAULT 0,
    vistas integer DEFAULT 0,
    og_image_url text,
    fecha_inicio date,
    fecha_fin date,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.proyecto OWNER TO postgres;

--
-- TOC entry 321 (class 1259 OID 17622)
-- Name: proyecto_imagen; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.proyecto_imagen (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    proyecto_id uuid NOT NULL,
    url text NOT NULL,
    caption text,
    orden integer DEFAULT 0
);


ALTER TABLE public.proyecto_imagen OWNER TO postgres;

--
-- TOC entry 322 (class 1259 OID 17636)
-- Name: proyecto_tecnologia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.proyecto_tecnologia (
    proyecto_id uuid NOT NULL,
    tecnologia_id uuid NOT NULL
);


ALTER TABLE public.proyecto_tecnologia OWNER TO postgres;

--
-- TOC entry 320 (class 1259 OID 17607)
-- Name: proyecto_traduccion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.proyecto_traduccion (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    proyecto_id uuid NOT NULL,
    idioma public.idioma_enum NOT NULL,
    titulo text NOT NULL,
    descripcion_corta text NOT NULL,
    problema text,
    solucion text,
    resultado text,
    retos_tecnicos text,
    meta_title text,
    meta_description text
);


ALTER TABLE public.proyecto_traduccion OWNER TO postgres;

--
-- TOC entry 318 (class 1259 OID 17579)
-- Name: tecnologia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tecnologia (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    nombre text NOT NULL,
    icono_url text,
    categoria public.categoria_tecnologia NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.tecnologia OWNER TO postgres;

--
-- TOC entry 333 (class 1259 OID 17874)
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios (
    id uuid NOT NULL,
    nombre text NOT NULL,
    rol text DEFAULT 'admin'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    CONSTRAINT usuarios_rol_check CHECK ((rol = 'admin'::text))
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- TOC entry 332 (class 1259 OID 17764)
-- Name: vista_analytics; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vista_analytics (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    proyecto_id uuid NOT NULL,
    session_id text,
    origen_trafico text,
    pais text,
    fecha timestamp with time zone DEFAULT now()
);


ALTER TABLE public.vista_analytics OWNER TO postgres;

--
-- TOC entry 3770 (class 2606 OID 17752)
-- Name: cv cv_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cv
    ADD CONSTRAINT cv_pkey PRIMARY KEY (id);


--
-- TOC entry 3764 (class 2606 OID 17727)
-- Name: educacion_certificacion educacion_certificacion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.educacion_certificacion
    ADD CONSTRAINT educacion_certificacion_pkey PRIMARY KEY (id);


--
-- TOC entry 3766 (class 2606 OID 17737)
-- Name: educacion_traduccion educacion_traduccion_educacion_id_idioma_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.educacion_traduccion
    ADD CONSTRAINT educacion_traduccion_educacion_id_idioma_key UNIQUE (educacion_id, idioma);


--
-- TOC entry 3768 (class 2606 OID 17735)
-- Name: educacion_traduccion educacion_traduccion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.educacion_traduccion
    ADD CONSTRAINT educacion_traduccion_pkey PRIMARY KEY (id);


--
-- TOC entry 3749 (class 2606 OID 17661)
-- Name: experiencia experiencia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.experiencia
    ADD CONSTRAINT experiencia_pkey PRIMARY KEY (id);


--
-- TOC entry 3756 (class 2606 OID 17681)
-- Name: experiencia_tecnologia experiencia_tecnologia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.experiencia_tecnologia
    ADD CONSTRAINT experiencia_tecnologia_pkey PRIMARY KEY (experiencia_id, tecnologia_id);


--
-- TOC entry 3751 (class 2606 OID 17671)
-- Name: experiencia_traduccion experiencia_traduccion_experiencia_id_idioma_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.experiencia_traduccion
    ADD CONSTRAINT experiencia_traduccion_experiencia_id_idioma_key UNIQUE (experiencia_id, idioma);


--
-- TOC entry 3753 (class 2606 OID 17669)
-- Name: experiencia_traduccion experiencia_traduccion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.experiencia_traduccion
    ADD CONSTRAINT experiencia_traduccion_pkey PRIMARY KEY (id);


--
-- TOC entry 3758 (class 2606 OID 17702)
-- Name: habilidad habilidad_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.habilidad
    ADD CONSTRAINT habilidad_pkey PRIMARY KEY (id);


--
-- TOC entry 3760 (class 2606 OID 17712)
-- Name: habilidad_traduccion habilidad_traduccion_habilidad_id_idioma_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.habilidad_traduccion
    ADD CONSTRAINT habilidad_traduccion_habilidad_id_idioma_key UNIQUE (habilidad_id, idioma);


--
-- TOC entry 3762 (class 2606 OID 17710)
-- Name: habilidad_traduccion habilidad_traduccion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.habilidad_traduccion
    ADD CONSTRAINT habilidad_traduccion_pkey PRIMARY KEY (id);


--
-- TOC entry 3773 (class 2606 OID 17763)
-- Name: mensaje_contacto mensaje_contacto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mensaje_contacto
    ADD CONSTRAINT mensaje_contacto_pkey PRIMARY KEY (id);


--
-- TOC entry 3723 (class 2606 OID 17560)
-- Name: perfil perfil_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perfil
    ADD CONSTRAINT perfil_pkey PRIMARY KEY (id);


--
-- TOC entry 3725 (class 2606 OID 17573)
-- Name: perfil_traduccion perfil_traduccion_perfil_id_idioma_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perfil_traduccion
    ADD CONSTRAINT perfil_traduccion_perfil_id_idioma_key UNIQUE (perfil_id, idioma);


--
-- TOC entry 3727 (class 2606 OID 17571)
-- Name: perfil_traduccion perfil_traduccion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perfil_traduccion
    ADD CONSTRAINT perfil_traduccion_pkey PRIMARY KEY (id);


--
-- TOC entry 3745 (class 2606 OID 17630)
-- Name: proyecto_imagen proyecto_imagen_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proyecto_imagen
    ADD CONSTRAINT proyecto_imagen_pkey PRIMARY KEY (id);


--
-- TOC entry 3736 (class 2606 OID 17604)
-- Name: proyecto proyecto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proyecto
    ADD CONSTRAINT proyecto_pkey PRIMARY KEY (id);


--
-- TOC entry 3738 (class 2606 OID 17606)
-- Name: proyecto proyecto_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proyecto
    ADD CONSTRAINT proyecto_slug_key UNIQUE (slug);


--
-- TOC entry 3747 (class 2606 OID 17640)
-- Name: proyecto_tecnologia proyecto_tecnologia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proyecto_tecnologia
    ADD CONSTRAINT proyecto_tecnologia_pkey PRIMARY KEY (proyecto_id, tecnologia_id);


--
-- TOC entry 3741 (class 2606 OID 17614)
-- Name: proyecto_traduccion proyecto_traduccion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proyecto_traduccion
    ADD CONSTRAINT proyecto_traduccion_pkey PRIMARY KEY (id);


--
-- TOC entry 3743 (class 2606 OID 17616)
-- Name: proyecto_traduccion proyecto_traduccion_proyecto_id_idioma_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proyecto_traduccion
    ADD CONSTRAINT proyecto_traduccion_proyecto_id_idioma_key UNIQUE (proyecto_id, idioma);


--
-- TOC entry 3729 (class 2606 OID 17589)
-- Name: tecnologia tecnologia_nombre_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tecnologia
    ADD CONSTRAINT tecnologia_nombre_key UNIQUE (nombre);


--
-- TOC entry 3731 (class 2606 OID 17587)
-- Name: tecnologia tecnologia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tecnologia
    ADD CONSTRAINT tecnologia_pkey PRIMARY KEY (id);


--
-- TOC entry 3779 (class 2606 OID 17883)
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);


--
-- TOC entry 3777 (class 2606 OID 17772)
-- Name: vista_analytics vista_analytics_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vista_analytics
    ADD CONSTRAINT vista_analytics_pkey PRIMARY KEY (id);


--
-- TOC entry 3754 (class 1259 OID 17782)
-- Name: idx_experiencia_traduccion_idioma; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_experiencia_traduccion_idioma ON public.experiencia_traduccion USING btree (experiencia_id, idioma);


--
-- TOC entry 3771 (class 1259 OID 17785)
-- Name: idx_mensaje_leido; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_mensaje_leido ON public.mensaje_contacto USING btree (leido);


--
-- TOC entry 3732 (class 1259 OID 17780)
-- Name: idx_proyecto_destacado; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_proyecto_destacado ON public.proyecto USING btree (destacado);


--
-- TOC entry 3733 (class 1259 OID 17779)
-- Name: idx_proyecto_estado; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_proyecto_estado ON public.proyecto USING btree (estado);


--
-- TOC entry 3734 (class 1259 OID 17778)
-- Name: idx_proyecto_slug; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_proyecto_slug ON public.proyecto USING btree (slug);


--
-- TOC entry 3739 (class 1259 OID 17781)
-- Name: idx_proyecto_traduccion_idioma; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_proyecto_traduccion_idioma ON public.proyecto_traduccion USING btree (proyecto_id, idioma);


--
-- TOC entry 3774 (class 1259 OID 17784)
-- Name: idx_vista_analytics_fecha; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_vista_analytics_fecha ON public.vista_analytics USING btree (fecha);


--
-- TOC entry 3775 (class 1259 OID 17783)
-- Name: idx_vista_analytics_proyecto; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_vista_analytics_proyecto ON public.vista_analytics USING btree (proyecto_id);


--
-- TOC entry 3794 (class 2620 OID 17789)
-- Name: experiencia trg_experiencia_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_experiencia_updated_at BEFORE UPDATE ON public.experiencia FOR EACH ROW EXECUTE FUNCTION public.actualizar_updated_at();


--
-- TOC entry 3792 (class 2620 OID 17787)
-- Name: perfil trg_perfil_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_perfil_updated_at BEFORE UPDATE ON public.perfil FOR EACH ROW EXECUTE FUNCTION public.actualizar_updated_at();


--
-- TOC entry 3793 (class 2620 OID 17788)
-- Name: proyecto trg_proyecto_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_proyecto_updated_at BEFORE UPDATE ON public.proyecto FOR EACH ROW EXECUTE FUNCTION public.actualizar_updated_at();


--
-- TOC entry 3789 (class 2606 OID 17738)
-- Name: educacion_traduccion educacion_traduccion_educacion_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.educacion_traduccion
    ADD CONSTRAINT educacion_traduccion_educacion_id_fkey FOREIGN KEY (educacion_id) REFERENCES public.educacion_certificacion(id) ON DELETE CASCADE;


--
-- TOC entry 3786 (class 2606 OID 17682)
-- Name: experiencia_tecnologia experiencia_tecnologia_experiencia_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.experiencia_tecnologia
    ADD CONSTRAINT experiencia_tecnologia_experiencia_id_fkey FOREIGN KEY (experiencia_id) REFERENCES public.experiencia(id) ON DELETE CASCADE;


--
-- TOC entry 3787 (class 2606 OID 17687)
-- Name: experiencia_tecnologia experiencia_tecnologia_tecnologia_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.experiencia_tecnologia
    ADD CONSTRAINT experiencia_tecnologia_tecnologia_id_fkey FOREIGN KEY (tecnologia_id) REFERENCES public.tecnologia(id) ON DELETE CASCADE;


--
-- TOC entry 3785 (class 2606 OID 17672)
-- Name: experiencia_traduccion experiencia_traduccion_experiencia_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.experiencia_traduccion
    ADD CONSTRAINT experiencia_traduccion_experiencia_id_fkey FOREIGN KEY (experiencia_id) REFERENCES public.experiencia(id) ON DELETE CASCADE;


--
-- TOC entry 3788 (class 2606 OID 17713)
-- Name: habilidad_traduccion habilidad_traduccion_habilidad_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.habilidad_traduccion
    ADD CONSTRAINT habilidad_traduccion_habilidad_id_fkey FOREIGN KEY (habilidad_id) REFERENCES public.habilidad(id) ON DELETE CASCADE;


--
-- TOC entry 3780 (class 2606 OID 17574)
-- Name: perfil_traduccion perfil_traduccion_perfil_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perfil_traduccion
    ADD CONSTRAINT perfil_traduccion_perfil_id_fkey FOREIGN KEY (perfil_id) REFERENCES public.perfil(id) ON DELETE CASCADE;


--
-- TOC entry 3782 (class 2606 OID 17631)
-- Name: proyecto_imagen proyecto_imagen_proyecto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proyecto_imagen
    ADD CONSTRAINT proyecto_imagen_proyecto_id_fkey FOREIGN KEY (proyecto_id) REFERENCES public.proyecto(id) ON DELETE CASCADE;


--
-- TOC entry 3783 (class 2606 OID 17641)
-- Name: proyecto_tecnologia proyecto_tecnologia_proyecto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proyecto_tecnologia
    ADD CONSTRAINT proyecto_tecnologia_proyecto_id_fkey FOREIGN KEY (proyecto_id) REFERENCES public.proyecto(id) ON DELETE CASCADE;


--
-- TOC entry 3784 (class 2606 OID 17646)
-- Name: proyecto_tecnologia proyecto_tecnologia_tecnologia_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proyecto_tecnologia
    ADD CONSTRAINT proyecto_tecnologia_tecnologia_id_fkey FOREIGN KEY (tecnologia_id) REFERENCES public.tecnologia(id) ON DELETE CASCADE;


--
-- TOC entry 3781 (class 2606 OID 17617)
-- Name: proyecto_traduccion proyecto_traduccion_proyecto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proyecto_traduccion
    ADD CONSTRAINT proyecto_traduccion_proyecto_id_fkey FOREIGN KEY (proyecto_id) REFERENCES public.proyecto(id) ON DELETE CASCADE;


--
-- TOC entry 3791 (class 2606 OID 17884)
-- Name: usuarios usuarios_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_id_fkey FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 3790 (class 2606 OID 17773)
-- Name: vista_analytics vista_analytics_proyecto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vista_analytics
    ADD CONSTRAINT vista_analytics_proyecto_id_fkey FOREIGN KEY (proyecto_id) REFERENCES public.proyecto(id) ON DELETE CASCADE;


--
-- TOC entry 3971 (class 3256 OID 17800)
-- Name: vista_analytics admin puede leer analytics; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "admin puede leer analytics" ON public.vista_analytics FOR SELECT USING ((auth.role() = 'authenticated'::text));


--
-- TOC entry 3985 (class 3256 OID 17833)
-- Name: educacion_traduccion admin puede todo en educacion_traduccion; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "admin puede todo en educacion_traduccion" ON public.educacion_traduccion USING ((auth.role() = 'authenticated'::text));


--
-- TOC entry 3987 (class 3256 OID 17841)
-- Name: experiencia_tecnologia admin puede todo en experiencia_tecnologia; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "admin puede todo en experiencia_tecnologia" ON public.experiencia_tecnologia USING ((auth.role() = 'authenticated'::text));


--
-- TOC entry 3983 (class 3256 OID 17831)
-- Name: experiencia_traduccion admin puede todo en experiencia_traduccion; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "admin puede todo en experiencia_traduccion" ON public.experiencia_traduccion USING ((auth.role() = 'authenticated'::text));


--
-- TOC entry 3984 (class 3256 OID 17832)
-- Name: habilidad_traduccion admin puede todo en habilidad_traduccion; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "admin puede todo en habilidad_traduccion" ON public.habilidad_traduccion USING ((auth.role() = 'authenticated'::text));


--
-- TOC entry 3968 (class 3256 OID 17797)
-- Name: mensaje_contacto admin puede todo en mensajes; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "admin puede todo en mensajes" ON public.mensaje_contacto USING ((auth.role() = 'authenticated'::text));


--
-- TOC entry 3979 (class 3256 OID 17827)
-- Name: perfil_traduccion admin puede todo en perfil_traduccion; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "admin puede todo en perfil_traduccion" ON public.perfil_traduccion USING ((auth.role() = 'authenticated'::text));


--
-- TOC entry 3981 (class 3256 OID 17829)
-- Name: proyecto_imagen admin puede todo en proyecto_imagen; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "admin puede todo en proyecto_imagen" ON public.proyecto_imagen USING ((auth.role() = 'authenticated'::text));


--
-- TOC entry 3982 (class 3256 OID 17830)
-- Name: proyecto_tecnologia admin puede todo en proyecto_tecnologia; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "admin puede todo en proyecto_tecnologia" ON public.proyecto_tecnologia USING ((auth.role() = 'authenticated'::text));


--
-- TOC entry 3967 (class 3256 OID 17796)
-- Name: proyecto admin puede todo en proyectos; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "admin puede todo en proyectos" ON public.proyecto USING ((auth.role() = 'authenticated'::text));


--
-- TOC entry 3980 (class 3256 OID 17828)
-- Name: tecnologia admin puede todo en tecnologia; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "admin puede todo en tecnologia" ON public.tecnologia USING ((auth.role() = 'authenticated'::text));


--
-- TOC entry 3957 (class 0 OID 17743)
-- Dependencies: 330
-- Name: cv; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.cv ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3955 (class 0 OID 17718)
-- Dependencies: 328
-- Name: educacion_certificacion; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.educacion_certificacion ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3956 (class 0 OID 17728)
-- Dependencies: 329
-- Name: educacion_traduccion; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.educacion_traduccion ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3950 (class 0 OID 17651)
-- Dependencies: 323
-- Name: experiencia; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.experiencia ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3952 (class 0 OID 17677)
-- Dependencies: 325
-- Name: experiencia_tecnologia; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.experiencia_tecnologia ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3951 (class 0 OID 17662)
-- Dependencies: 324
-- Name: experiencia_traduccion; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.experiencia_traduccion ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3953 (class 0 OID 17692)
-- Dependencies: 326
-- Name: habilidad; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.habilidad ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3954 (class 0 OID 17703)
-- Dependencies: 327
-- Name: habilidad_traduccion; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.habilidad_traduccion ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3958 (class 0 OID 17753)
-- Dependencies: 331
-- Name: mensaje_contacto; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.mensaje_contacto ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3943 (class 0 OID 17551)
-- Dependencies: 316
-- Name: perfil; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.perfil ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3944 (class 0 OID 17564)
-- Dependencies: 317
-- Name: perfil_traduccion; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.perfil_traduccion ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3946 (class 0 OID 17590)
-- Dependencies: 319
-- Name: proyecto; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.proyecto ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3948 (class 0 OID 17622)
-- Dependencies: 321
-- Name: proyecto_imagen; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.proyecto_imagen ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3949 (class 0 OID 17636)
-- Dependencies: 322
-- Name: proyecto_tecnologia; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.proyecto_tecnologia ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3947 (class 0 OID 17607)
-- Dependencies: 320
-- Name: proyecto_traduccion; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.proyecto_traduccion ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3969 (class 3256 OID 17798)
-- Name: mensaje_contacto publico puede insertar mensajes de contacto; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "publico puede insertar mensajes de contacto" ON public.mensaje_contacto FOR INSERT WITH CHECK (true);


--
-- TOC entry 3970 (class 3256 OID 17799)
-- Name: vista_analytics publico puede insertar vistas; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "publico puede insertar vistas" ON public.vista_analytics FOR INSERT WITH CHECK (true);


--
-- TOC entry 3966 (class 3256 OID 17795)
-- Name: educacion_certificacion publico puede leer educacion; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "publico puede leer educacion" ON public.educacion_certificacion FOR SELECT USING (true);


--
-- TOC entry 3978 (class 3256 OID 17826)
-- Name: educacion_traduccion publico puede leer educacion_traduccion; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "publico puede leer educacion_traduccion" ON public.educacion_traduccion FOR SELECT USING (true);


--
-- TOC entry 3964 (class 3256 OID 17793)
-- Name: experiencia publico puede leer experiencia; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "publico puede leer experiencia" ON public.experiencia FOR SELECT USING (true);


--
-- TOC entry 3986 (class 3256 OID 17840)
-- Name: experiencia_tecnologia publico puede leer experiencia_tecnologia; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "publico puede leer experiencia_tecnologia" ON public.experiencia_tecnologia FOR SELECT USING (true);


--
-- TOC entry 3976 (class 3256 OID 17824)
-- Name: experiencia_traduccion publico puede leer experiencia_traduccion; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "publico puede leer experiencia_traduccion" ON public.experiencia_traduccion FOR SELECT USING (true);


--
-- TOC entry 3977 (class 3256 OID 17825)
-- Name: habilidad_traduccion publico puede leer habilidad_traduccion; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "publico puede leer habilidad_traduccion" ON public.habilidad_traduccion FOR SELECT USING (true);


--
-- TOC entry 3965 (class 3256 OID 17794)
-- Name: habilidad publico puede leer habilidades; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "publico puede leer habilidades" ON public.habilidad FOR SELECT USING (true);


--
-- TOC entry 3974 (class 3256 OID 17822)
-- Name: proyecto_imagen publico puede leer imagenes de proyectos publicados; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "publico puede leer imagenes de proyectos publicados" ON public.proyecto_imagen FOR SELECT USING ((EXISTS ( SELECT 1
   FROM public.proyecto
  WHERE ((proyecto.id = proyecto_imagen.proyecto_id) AND (proyecto.estado = 'publicado'::public.estado_enum)))));


--
-- TOC entry 3963 (class 3256 OID 17792)
-- Name: perfil publico puede leer perfil; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "publico puede leer perfil" ON public.perfil FOR SELECT USING (true);


--
-- TOC entry 3972 (class 3256 OID 17820)
-- Name: perfil_traduccion publico puede leer perfil_traduccion; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "publico puede leer perfil_traduccion" ON public.perfil_traduccion FOR SELECT USING (true);


--
-- TOC entry 3975 (class 3256 OID 17823)
-- Name: proyecto_tecnologia publico puede leer proyecto_tecnologia de proyectos publicados; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "publico puede leer proyecto_tecnologia de proyectos publicados" ON public.proyecto_tecnologia FOR SELECT USING ((EXISTS ( SELECT 1
   FROM public.proyecto
  WHERE ((proyecto.id = proyecto_tecnologia.proyecto_id) AND (proyecto.estado = 'publicado'::public.estado_enum)))));


--
-- TOC entry 3961 (class 3256 OID 17790)
-- Name: proyecto publico puede leer proyectos publicados; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "publico puede leer proyectos publicados" ON public.proyecto FOR SELECT USING ((estado = 'publicado'::public.estado_enum));


--
-- TOC entry 3973 (class 3256 OID 17821)
-- Name: tecnologia publico puede leer tecnologias; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "publico puede leer tecnologias" ON public.tecnologia FOR SELECT USING (true);


--
-- TOC entry 3962 (class 3256 OID 17791)
-- Name: proyecto_traduccion publico puede leer traducciones de proyectos publicados; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "publico puede leer traducciones de proyectos publicados" ON public.proyecto_traduccion FOR SELECT USING ((EXISTS ( SELECT 1
   FROM public.proyecto
  WHERE ((proyecto.id = proyecto_traduccion.proyecto_id) AND (proyecto.estado = 'publicado'::public.estado_enum)))));


--
-- TOC entry 3945 (class 0 OID 17579)
-- Dependencies: 318
-- Name: tecnologia; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.tecnologia ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3989 (class 3256 OID 17890)
-- Name: usuarios usuario puede actualizar su propio perfil; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "usuario puede actualizar su propio perfil" ON public.usuarios FOR UPDATE USING ((auth.uid() = id));


--
-- TOC entry 3988 (class 3256 OID 17889)
-- Name: usuarios usuario puede ver su propio perfil; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "usuario puede ver su propio perfil" ON public.usuarios FOR SELECT USING ((auth.uid() = id));


--
-- TOC entry 3960 (class 0 OID 17874)
-- Dependencies: 333
-- Name: usuarios; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.usuarios ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3959 (class 0 OID 17764)
-- Dependencies: 332
-- Name: vista_analytics; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.vista_analytics ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3997 (class 0 OID 0)
-- Dependencies: 13
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT USAGE ON SCHEMA public TO postgres;
GRANT USAGE ON SCHEMA public TO anon;
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT USAGE ON SCHEMA public TO service_role;


--
-- TOC entry 3998 (class 0 OID 0)
-- Dependencies: 444
-- Name: FUNCTION actualizar_updated_at(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.actualizar_updated_at() TO anon;
GRANT ALL ON FUNCTION public.actualizar_updated_at() TO authenticated;
GRANT ALL ON FUNCTION public.actualizar_updated_at() TO service_role;


--
-- TOC entry 3999 (class 0 OID 0)
-- Dependencies: 330
-- Name: TABLE cv; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.cv TO anon;
GRANT ALL ON TABLE public.cv TO authenticated;
GRANT ALL ON TABLE public.cv TO service_role;


--
-- TOC entry 4000 (class 0 OID 0)
-- Dependencies: 328
-- Name: TABLE educacion_certificacion; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.educacion_certificacion TO anon;
GRANT ALL ON TABLE public.educacion_certificacion TO authenticated;
GRANT ALL ON TABLE public.educacion_certificacion TO service_role;


--
-- TOC entry 4001 (class 0 OID 0)
-- Dependencies: 329
-- Name: TABLE educacion_traduccion; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.educacion_traduccion TO anon;
GRANT ALL ON TABLE public.educacion_traduccion TO authenticated;
GRANT ALL ON TABLE public.educacion_traduccion TO service_role;


--
-- TOC entry 4002 (class 0 OID 0)
-- Dependencies: 323
-- Name: TABLE experiencia; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.experiencia TO anon;
GRANT ALL ON TABLE public.experiencia TO authenticated;
GRANT ALL ON TABLE public.experiencia TO service_role;


--
-- TOC entry 4003 (class 0 OID 0)
-- Dependencies: 325
-- Name: TABLE experiencia_tecnologia; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.experiencia_tecnologia TO anon;
GRANT ALL ON TABLE public.experiencia_tecnologia TO authenticated;
GRANT ALL ON TABLE public.experiencia_tecnologia TO service_role;


--
-- TOC entry 4004 (class 0 OID 0)
-- Dependencies: 324
-- Name: TABLE experiencia_traduccion; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.experiencia_traduccion TO anon;
GRANT ALL ON TABLE public.experiencia_traduccion TO authenticated;
GRANT ALL ON TABLE public.experiencia_traduccion TO service_role;


--
-- TOC entry 4005 (class 0 OID 0)
-- Dependencies: 326
-- Name: TABLE habilidad; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.habilidad TO anon;
GRANT ALL ON TABLE public.habilidad TO authenticated;
GRANT ALL ON TABLE public.habilidad TO service_role;


--
-- TOC entry 4006 (class 0 OID 0)
-- Dependencies: 327
-- Name: TABLE habilidad_traduccion; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.habilidad_traduccion TO anon;
GRANT ALL ON TABLE public.habilidad_traduccion TO authenticated;
GRANT ALL ON TABLE public.habilidad_traduccion TO service_role;


--
-- TOC entry 4007 (class 0 OID 0)
-- Dependencies: 331
-- Name: TABLE mensaje_contacto; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.mensaje_contacto TO anon;
GRANT ALL ON TABLE public.mensaje_contacto TO authenticated;
GRANT ALL ON TABLE public.mensaje_contacto TO service_role;


--
-- TOC entry 4008 (class 0 OID 0)
-- Dependencies: 316
-- Name: TABLE perfil; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.perfil TO anon;
GRANT ALL ON TABLE public.perfil TO authenticated;
GRANT ALL ON TABLE public.perfil TO service_role;


--
-- TOC entry 4009 (class 0 OID 0)
-- Dependencies: 317
-- Name: TABLE perfil_traduccion; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.perfil_traduccion TO anon;
GRANT ALL ON TABLE public.perfil_traduccion TO authenticated;
GRANT ALL ON TABLE public.perfil_traduccion TO service_role;


--
-- TOC entry 4010 (class 0 OID 0)
-- Dependencies: 319
-- Name: TABLE proyecto; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.proyecto TO anon;
GRANT ALL ON TABLE public.proyecto TO authenticated;
GRANT ALL ON TABLE public.proyecto TO service_role;


--
-- TOC entry 4011 (class 0 OID 0)
-- Dependencies: 321
-- Name: TABLE proyecto_imagen; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.proyecto_imagen TO anon;
GRANT ALL ON TABLE public.proyecto_imagen TO authenticated;
GRANT ALL ON TABLE public.proyecto_imagen TO service_role;


--
-- TOC entry 4012 (class 0 OID 0)
-- Dependencies: 322
-- Name: TABLE proyecto_tecnologia; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.proyecto_tecnologia TO anon;
GRANT ALL ON TABLE public.proyecto_tecnologia TO authenticated;
GRANT ALL ON TABLE public.proyecto_tecnologia TO service_role;


--
-- TOC entry 4013 (class 0 OID 0)
-- Dependencies: 320
-- Name: TABLE proyecto_traduccion; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.proyecto_traduccion TO anon;
GRANT ALL ON TABLE public.proyecto_traduccion TO authenticated;
GRANT ALL ON TABLE public.proyecto_traduccion TO service_role;


--
-- TOC entry 4014 (class 0 OID 0)
-- Dependencies: 318
-- Name: TABLE tecnologia; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.tecnologia TO anon;
GRANT ALL ON TABLE public.tecnologia TO authenticated;
GRANT ALL ON TABLE public.tecnologia TO service_role;


--
-- TOC entry 4015 (class 0 OID 0)
-- Dependencies: 333
-- Name: TABLE usuarios; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.usuarios TO anon;
GRANT ALL ON TABLE public.usuarios TO authenticated;
GRANT ALL ON TABLE public.usuarios TO service_role;


--
-- TOC entry 4016 (class 0 OID 0)
-- Dependencies: 332
-- Name: TABLE vista_analytics; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.vista_analytics TO anon;
GRANT ALL ON TABLE public.vista_analytics TO authenticated;
GRANT ALL ON TABLE public.vista_analytics TO service_role;


--
-- TOC entry 2439 (class 826 OID 16494)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 2440 (class 826 OID 16495)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 2438 (class 826 OID 16493)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 2442 (class 826 OID 16497)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 2437 (class 826 OID 16492)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO service_role;


--
-- TOC entry 2441 (class 826 OID 16496)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO service_role;


-- Completed on 2026-07-30 15:24:57

--
-- PostgreSQL database dump complete
--

\unrestrict 5JaGf6KwhGIOt26qOCn5dI3CccasQGi7OR5jh0Ydkq5tXrZiTGvP5EZETqEQSm6

