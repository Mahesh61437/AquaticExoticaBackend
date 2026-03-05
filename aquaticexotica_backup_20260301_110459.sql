--
-- PostgreSQL database dump
--

\restrict 5V3rnyVWSkqs91RTdqLUAYLPGy0LScL9p15gs7Js7ctA13Ze6Ddrmdi0x6W5OMM

-- Dumped from database version 17.8 (6108b59)
-- Dumped by pg_dump version 17.9 (Homebrew)

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

ALTER TABLE IF EXISTS ONLY public.payments_payupayment DROP CONSTRAINT IF EXISTS payments_payupayment_user_id_a9f0ef2b_fk_core_user_id;
ALTER TABLE IF EXISTS ONLY public.payments_payupayment DROP CONSTRAINT IF EXISTS payments_payupayment_order_id_3fddcc60_fk_core_order_id;
ALTER TABLE IF EXISTS ONLY public.core_stocknotification DROP CONSTRAINT IF EXISTS core_stocknotification_user_id_4aece4d9_fk_core_user_id;
ALTER TABLE IF EXISTS ONLY public.core_stocknotification DROP CONSTRAINT IF EXISTS core_stocknotification_product_id_0c592fcf_fk_core_product_id;
ALTER TABLE IF EXISTS ONLY public.core_productvariant DROP CONSTRAINT IF EXISTS core_productvariant_product_id_79c7de1b_fk_core_product_id;
ALTER TABLE IF EXISTS ONLY public.core_orderitem DROP CONSTRAINT IF EXISTS core_orderitem_variant_id_fc31f244_fk_core_productvariant_id;
ALTER TABLE IF EXISTS ONLY public.core_cartitem DROP CONSTRAINT IF EXISTS core_cartitem_variant_id_84e67bc6_fk_core_productvariant_id;
ALTER TABLE IF EXISTS ONLY public.core_cartitem DROP CONSTRAINT IF EXISTS core_cartitem_product_id_2640c4a2_fk_core_product_id;
ALTER TABLE IF EXISTS ONLY public.core_cartitem DROP CONSTRAINT IF EXISTS core_cartitem_cart_id_5256d769_fk_core_cart_id;
DROP INDEX IF EXISTS public.unique_phone_per_product;
DROP INDEX IF EXISTS public.unique_email_per_product;
DROP INDEX IF EXISTS public.token_blacklist_outstandingtoken_user_id_83bc629a;
DROP INDEX IF EXISTS public.token_blacklist_outstandingtoken_jti_hex_d9bdf6f7_like;
DROP INDEX IF EXISTS public.payments_payupayment_user_id_a9f0ef2b;
DROP INDEX IF EXISTS public.payments_payupayment_txnid_5e8d6988_like;
DROP INDEX IF EXISTS public.payments_payupayment_status_b9a294de_like;
DROP INDEX IF EXISTS public.payments_payupayment_status_b9a294de;
DROP INDEX IF EXISTS public.payments_payupayment_order_id_3fddcc60;
DROP INDEX IF EXISTS public.django_site_domain_a2e37b91_like;
DROP INDEX IF EXISTS public.django_session_session_key_c0390e0f_like;
DROP INDEX IF EXISTS public.django_session_expire_date_a5c62663;
DROP INDEX IF EXISTS public.django_aws_ses_unknownrecord_timestamp_137d6e70;
DROP INDEX IF EXISTS public.django_aws_ses_sendrecord_timestamp_5c148248;
DROP INDEX IF EXISTS public.django_aws_ses_sendrecord_destination_7eba4f0a_like;
DROP INDEX IF EXISTS public.django_aws_ses_sendrecord_destination_7eba4f0a;
DROP INDEX IF EXISTS public.django_aws_ses_complaintrecord_timestamp_90333dd8;
DROP INDEX IF EXISTS public.django_aws_ses_complaintrecord_email_a1980dd0_like;
DROP INDEX IF EXISTS public.django_aws_ses_complaintrecord_email_a1980dd0;
DROP INDEX IF EXISTS public.django_aws_ses_bouncerecord_timestamp_632073f9;
DROP INDEX IF EXISTS public.django_aws_ses_bouncerecord_email_a6dd5e2c_like;
DROP INDEX IF EXISTS public.django_aws_ses_bouncerecord_email_a6dd5e2c;
DROP INDEX IF EXISTS public.django_aws_ses_blacklisteddomains_timestamp_370919b2;
DROP INDEX IF EXISTS public.django_aws_ses_blacklisteddomains_domain_53c96db6_like;
DROP INDEX IF EXISTS public.django_aws__event_t_ca3517_idx;
DROP INDEX IF EXISTS public.django_aws__email_6bb737_idx;
DROP INDEX IF EXISTS public.django_aws__email_36ac11_idx;
DROP INDEX IF EXISTS public.django_aws__destina_e0db33_idx;
DROP INDEX IF EXISTS public.django_admin_log_user_id_c564eba6;
DROP INDEX IF EXISTS public.django_admin_log_content_type_id_c4bce8eb;
DROP INDEX IF EXISTS public.core_user_username_36e4f7f7_like;
DROP INDEX IF EXISTS public.core_user_user_permissions_user_id_085123d3;
DROP INDEX IF EXISTS public.core_user_user_permissions_permission_id_35ccf601;
DROP INDEX IF EXISTS public.core_user_groups_user_id_70b4d9b8;
DROP INDEX IF EXISTS public.core_user_groups_group_id_fe8c697f;
DROP INDEX IF EXISTS public.core_user_email_92a71487_like;
DROP INDEX IF EXISTS public.core_tag_name_5f34f44c_like;
DROP INDEX IF EXISTS public.core_stocknotification_user_id_4aece4d9;
DROP INDEX IF EXISTS public.core_stocknotification_product_id_0c592fcf;
DROP INDEX IF EXISTS public.core_shippingaddress_user_id_da3e3bad;
DROP INDEX IF EXISTS public.core_productvariant_product_id_79c7de1b;
DROP INDEX IF EXISTS public.core_productimage_product_id_10178291;
DROP INDEX IF EXISTS public.core_product_tags_tag_id_038dc8df;
DROP INDEX IF EXISTS public.core_product_tags_product_id_7fa1e736;
DROP INDEX IF EXISTS public.core_product_categories_product_id_419fa40f;
DROP INDEX IF EXISTS public.core_product_categories_category_id_1263db5a;
DROP INDEX IF EXISTS public.core_orderitem_variant_id_fc31f244;
DROP INDEX IF EXISTS public.core_orderitem_product_id_0c2047cd;
DROP INDEX IF EXISTS public.core_orderitem_order_id_30929c10;
DROP INDEX IF EXISTS public.core_order_user_id_b03bbffd;
DROP INDEX IF EXISTS public.core_order_shipping_address_id_8c054f15;
DROP INDEX IF EXISTS public.core_category_slug_384eca9c_like;
DROP INDEX IF EXISTS public.core_category_name_55b68161_like;
DROP INDEX IF EXISTS public.core_cartitem_variant_id_84e67bc6;
DROP INDEX IF EXISTS public.core_cartitem_product_id_2640c4a2;
DROP INDEX IF EXISTS public.core_cartitem_cart_id_5256d769;
DROP INDEX IF EXISTS public.core_cart_user_id_2ebeb843;
DROP INDEX IF EXISTS public.core_appnotification_user_id_444805b0;
DROP INDEX IF EXISTS public.auth_permission_content_type_id_2f476e4b;
DROP INDEX IF EXISTS public.auth_group_permissions_permission_id_84c5c92e;
DROP INDEX IF EXISTS public.auth_group_permissions_group_id_b120cbf9;
DROP INDEX IF EXISTS public.auth_group_name_a6ea08ec_like;
DROP INDEX IF EXISTS public."IDX_session_expire";
ALTER TABLE IF EXISTS ONLY public.token_blacklist_outstandingtoken DROP CONSTRAINT IF EXISTS token_blacklist_outstandingtoken_pkey;
ALTER TABLE IF EXISTS ONLY public.token_blacklist_outstandingtoken DROP CONSTRAINT IF EXISTS token_blacklist_outstandingtoken_jti_hex_d9bdf6f7_uniq;
ALTER TABLE IF EXISTS ONLY public.token_blacklist_blacklistedtoken DROP CONSTRAINT IF EXISTS token_blacklist_blacklistedtoken_token_id_key;
ALTER TABLE IF EXISTS ONLY public.token_blacklist_blacklistedtoken DROP CONSTRAINT IF EXISTS token_blacklist_blacklistedtoken_pkey;
ALTER TABLE IF EXISTS ONLY public.session DROP CONSTRAINT IF EXISTS session_pkey;
ALTER TABLE IF EXISTS ONLY public.payments_payupayment DROP CONSTRAINT IF EXISTS payments_payupayment_txnid_key;
ALTER TABLE IF EXISTS ONLY public.payments_payupayment DROP CONSTRAINT IF EXISTS payments_payupayment_pkey;
ALTER TABLE IF EXISTS ONLY public.django_site DROP CONSTRAINT IF EXISTS django_site_pkey;
ALTER TABLE IF EXISTS ONLY public.django_site DROP CONSTRAINT IF EXISTS django_site_domain_a2e37b91_uniq;
ALTER TABLE IF EXISTS ONLY public.django_session DROP CONSTRAINT IF EXISTS django_session_pkey;
ALTER TABLE IF EXISTS ONLY public.django_migrations DROP CONSTRAINT IF EXISTS django_migrations_pkey;
ALTER TABLE IF EXISTS ONLY public.django_content_type DROP CONSTRAINT IF EXISTS django_content_type_pkey;
ALTER TABLE IF EXISTS ONLY public.django_content_type DROP CONSTRAINT IF EXISTS django_content_type_app_label_model_76bd3d3b_uniq;
ALTER TABLE IF EXISTS ONLY public.django_aws_ses_unknownrecord DROP CONSTRAINT IF EXISTS django_aws_ses_unknownrecord_pkey;
ALTER TABLE IF EXISTS ONLY public.django_aws_ses_sesstat DROP CONSTRAINT IF EXISTS django_aws_ses_sesstat_pkey;
ALTER TABLE IF EXISTS ONLY public.django_aws_ses_sesstat DROP CONSTRAINT IF EXISTS django_aws_ses_sesstat_date_key;
ALTER TABLE IF EXISTS ONLY public.django_aws_ses_sendrecord DROP CONSTRAINT IF EXISTS django_aws_ses_sendrecord_pkey;
ALTER TABLE IF EXISTS ONLY public.django_aws_ses_complaintrecord DROP CONSTRAINT IF EXISTS django_aws_ses_complaintrecord_pkey;
ALTER TABLE IF EXISTS ONLY public.django_aws_ses_bouncerecord DROP CONSTRAINT IF EXISTS django_aws_ses_bouncerecord_pkey;
ALTER TABLE IF EXISTS ONLY public.django_aws_ses_blacklisteddomains DROP CONSTRAINT IF EXISTS django_aws_ses_blacklisteddomains_pkey;
ALTER TABLE IF EXISTS ONLY public.django_aws_ses_blacklisteddomains DROP CONSTRAINT IF EXISTS django_aws_ses_blacklisteddomains_domain_key;
ALTER TABLE IF EXISTS ONLY public.django_aws_ses_awssesuseraddon DROP CONSTRAINT IF EXISTS django_aws_ses_awssesuseraddon_user_id_key;
ALTER TABLE IF EXISTS ONLY public.django_aws_ses_awssesuseraddon DROP CONSTRAINT IF EXISTS django_aws_ses_awssesuseraddon_pkey;
ALTER TABLE IF EXISTS ONLY public.django_aws_ses_awssessettings DROP CONSTRAINT IF EXISTS django_aws_ses_awssessettings_site_id_key;
ALTER TABLE IF EXISTS ONLY public.django_aws_ses_awssessettings DROP CONSTRAINT IF EXISTS django_aws_ses_awssessettings_pkey;
ALTER TABLE IF EXISTS ONLY public.django_admin_log DROP CONSTRAINT IF EXISTS django_admin_log_pkey;
ALTER TABLE IF EXISTS ONLY public.core_user DROP CONSTRAINT IF EXISTS core_user_username_key;
ALTER TABLE IF EXISTS ONLY public.core_user_user_permissions DROP CONSTRAINT IF EXISTS core_user_user_permissions_user_id_permission_id_73ea0daa_uniq;
ALTER TABLE IF EXISTS ONLY public.core_user_user_permissions DROP CONSTRAINT IF EXISTS core_user_user_permissions_pkey;
ALTER TABLE IF EXISTS ONLY public.core_user DROP CONSTRAINT IF EXISTS core_user_pkey;
ALTER TABLE IF EXISTS ONLY public.core_user_groups DROP CONSTRAINT IF EXISTS core_user_groups_user_id_group_id_c82fcad1_uniq;
ALTER TABLE IF EXISTS ONLY public.core_user_groups DROP CONSTRAINT IF EXISTS core_user_groups_pkey;
ALTER TABLE IF EXISTS ONLY public.core_user DROP CONSTRAINT IF EXISTS core_user_email_92a71487_uniq;
ALTER TABLE IF EXISTS ONLY public.core_tag DROP CONSTRAINT IF EXISTS core_tag_pkey;
ALTER TABLE IF EXISTS ONLY public.core_tag DROP CONSTRAINT IF EXISTS core_tag_name_key;
ALTER TABLE IF EXISTS ONLY public.core_stocknotification DROP CONSTRAINT IF EXISTS core_stocknotification_pkey;
ALTER TABLE IF EXISTS ONLY public.core_shippingaddress DROP CONSTRAINT IF EXISTS core_shippingaddress_pkey;
ALTER TABLE IF EXISTS ONLY public.core_productvariant DROP CONSTRAINT IF EXISTS core_productvariant_product_id_category_31d38fb0_uniq;
ALTER TABLE IF EXISTS ONLY public.core_productvariant DROP CONSTRAINT IF EXISTS core_productvariant_pkey;
ALTER TABLE IF EXISTS ONLY public.core_productimage DROP CONSTRAINT IF EXISTS core_productimage_pkey;
ALTER TABLE IF EXISTS ONLY public.core_product_tags DROP CONSTRAINT IF EXISTS core_product_tags_product_id_tag_id_39182de5_uniq;
ALTER TABLE IF EXISTS ONLY public.core_product_tags DROP CONSTRAINT IF EXISTS core_product_tags_pkey;
ALTER TABLE IF EXISTS ONLY public.core_product DROP CONSTRAINT IF EXISTS core_product_pkey;
ALTER TABLE IF EXISTS ONLY public.core_product_categories DROP CONSTRAINT IF EXISTS core_product_categories_product_id_category_id_436581c3_uniq;
ALTER TABLE IF EXISTS ONLY public.core_product_categories DROP CONSTRAINT IF EXISTS core_product_categories_pkey;
ALTER TABLE IF EXISTS ONLY public.core_orderitem DROP CONSTRAINT IF EXISTS core_orderitem_pkey;
ALTER TABLE IF EXISTS ONLY public.core_order DROP CONSTRAINT IF EXISTS core_order_pkey;
ALTER TABLE IF EXISTS ONLY public.core_category DROP CONSTRAINT IF EXISTS core_category_slug_key;
ALTER TABLE IF EXISTS ONLY public.core_category DROP CONSTRAINT IF EXISTS core_category_pkey;
ALTER TABLE IF EXISTS ONLY public.core_category DROP CONSTRAINT IF EXISTS core_category_name_key;
ALTER TABLE IF EXISTS ONLY public.core_cartitem DROP CONSTRAINT IF EXISTS core_cartitem_pkey;
ALTER TABLE IF EXISTS ONLY public.core_cartitem DROP CONSTRAINT IF EXISTS core_cartitem_cart_id_product_id_variant_id_0f28d32d_uniq;
ALTER TABLE IF EXISTS ONLY public.core_cart DROP CONSTRAINT IF EXISTS core_cart_pkey;
ALTER TABLE IF EXISTS ONLY public.core_appnotification DROP CONSTRAINT IF EXISTS core_appnotification_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_permission DROP CONSTRAINT IF EXISTS auth_permission_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_permission DROP CONSTRAINT IF EXISTS auth_permission_content_type_id_codename_01ab375a_uniq;
ALTER TABLE IF EXISTS ONLY public.auth_group DROP CONSTRAINT IF EXISTS auth_group_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_group_permissions DROP CONSTRAINT IF EXISTS auth_group_permissions_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_group_permissions DROP CONSTRAINT IF EXISTS auth_group_permissions_group_id_permission_id_0cd325b0_uniq;
ALTER TABLE IF EXISTS ONLY public.auth_group DROP CONSTRAINT IF EXISTS auth_group_name_key;
DROP TABLE IF EXISTS public.token_blacklist_outstandingtoken;
DROP TABLE IF EXISTS public.token_blacklist_blacklistedtoken;
DROP TABLE IF EXISTS public.session;
DROP TABLE IF EXISTS public.payments_payupayment;
DROP TABLE IF EXISTS public.django_site;
DROP TABLE IF EXISTS public.django_session;
DROP TABLE IF EXISTS public.django_migrations;
DROP TABLE IF EXISTS public.django_content_type;
DROP TABLE IF EXISTS public.django_aws_ses_unknownrecord;
DROP TABLE IF EXISTS public.django_aws_ses_sesstat;
DROP TABLE IF EXISTS public.django_aws_ses_sendrecord;
DROP TABLE IF EXISTS public.django_aws_ses_complaintrecord;
DROP TABLE IF EXISTS public.django_aws_ses_bouncerecord;
DROP TABLE IF EXISTS public.django_aws_ses_blacklisteddomains;
DROP TABLE IF EXISTS public.django_aws_ses_awssesuseraddon;
DROP TABLE IF EXISTS public.django_aws_ses_awssessettings;
DROP TABLE IF EXISTS public.django_admin_log;
DROP TABLE IF EXISTS public.core_user_user_permissions;
DROP TABLE IF EXISTS public.core_user_groups;
DROP TABLE IF EXISTS public.core_user;
DROP TABLE IF EXISTS public.core_tag;
DROP TABLE IF EXISTS public.core_stocknotification;
DROP TABLE IF EXISTS public.core_shippingaddress;
DROP TABLE IF EXISTS public.core_productvariant;
DROP TABLE IF EXISTS public.core_productimage;
DROP TABLE IF EXISTS public.core_product_tags;
DROP TABLE IF EXISTS public.core_product_categories;
DROP TABLE IF EXISTS public.core_product;
DROP TABLE IF EXISTS public.core_orderitem;
DROP TABLE IF EXISTS public.core_order;
DROP TABLE IF EXISTS public.core_category;
DROP TABLE IF EXISTS public.core_cartitem;
DROP TABLE IF EXISTS public.core_cart;
DROP TABLE IF EXISTS public.core_appnotification;
DROP TABLE IF EXISTS public.auth_permission;
DROP TABLE IF EXISTS public.auth_group_permissions;
DROP TABLE IF EXISTS public.auth_group;
-- *not* dropping schema, since initdb creates it
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

-- *not* creating schema, since initdb creates it


--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS '';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.auth_group ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.auth_group_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.auth_permission ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: core_appnotification; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.core_appnotification (
    id integer NOT NULL,
    type character varying(50) NOT NULL,
    title character varying(200) NOT NULL,
    message text NOT NULL,
    data jsonb NOT NULL,
    is_read boolean NOT NULL,
    created_at timestamp with time zone NOT NULL,
    read_at timestamp with time zone,
    user_id bigint
);


--
-- Name: core_appnotification_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.core_appnotification ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.core_appnotification_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: core_cart; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.core_cart (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


--
-- Name: core_cart_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.core_cart ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.core_cart_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: core_cartitem; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.core_cartitem (
    id bigint NOT NULL,
    quantity integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    cart_id bigint NOT NULL,
    product_id bigint NOT NULL,
    variant_id bigint,
    CONSTRAINT core_cartitem_quantity_check CHECK ((quantity >= 0))
);


--
-- Name: core_cartitem_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.core_cartitem ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.core_cartitem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: core_category; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.core_category (
    id bigint NOT NULL,
    name character varying(100) NOT NULL,
    slug character varying(50) NOT NULL,
    description text,
    image_url character varying(1000) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


--
-- Name: core_category_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.core_category ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.core_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: core_order; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.core_order (
    id bigint NOT NULL,
    total_amount numeric(10,2) NOT NULL,
    shipping_cost numeric(10,2) NOT NULL,
    status character varying(20) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    user_id bigint NOT NULL,
    shipping_address_id bigint NOT NULL
);


--
-- Name: core_order_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.core_order ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.core_order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: core_orderitem; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.core_orderitem (
    id bigint NOT NULL,
    quantity integer NOT NULL,
    price numeric(10,2) NOT NULL,
    order_id bigint NOT NULL,
    product_id bigint NOT NULL,
    created_at timestamp with time zone,
    variant_id bigint,
    CONSTRAINT core_orderitem_quantity_check CHECK ((quantity >= 0))
);


--
-- Name: core_orderitem_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.core_orderitem ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.core_orderitem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: core_product; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.core_product (
    id bigint NOT NULL,
    name text NOT NULL,
    rating numeric(3,1) NOT NULL,
    is_new boolean NOT NULL,
    is_sale boolean NOT NULL,
    is_featured boolean NOT NULL,
    is_trending boolean NOT NULL,
    is_active boolean NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    image_url character varying(1000),
    thumbnail_url character varying(1000),
    description text,
    price numeric(10,2),
    compare_at_price numeric(10,2),
    stock integer
);


--
-- Name: core_product_categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.core_product_categories (
    id bigint NOT NULL,
    product_id bigint NOT NULL,
    category_id bigint NOT NULL
);


--
-- Name: core_product_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.core_product_categories ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.core_product_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: core_product_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.core_product ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.core_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: core_product_tags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.core_product_tags (
    id bigint NOT NULL,
    product_id bigint NOT NULL,
    tag_id bigint NOT NULL
);


--
-- Name: core_product_tags_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.core_product_tags ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.core_product_tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: core_productimage; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.core_productimage (
    id bigint NOT NULL,
    image_url character varying(1000) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    product_id bigint NOT NULL,
    "order" integer,
    type character varying(20) NOT NULL,
    CONSTRAINT core_productimage_order_check CHECK (("order" >= 0))
);


--
-- Name: core_productimage_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.core_productimage ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.core_productimage_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: core_productvariant; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.core_productvariant (
    id bigint NOT NULL,
    variant_type character varying(20) NOT NULL,
    description text,
    stock integer NOT NULL,
    original_price numeric(10,2),
    offer_price numeric(10,2),
    product_id bigint NOT NULL,
    CONSTRAINT core_productvariant_stock_check CHECK ((stock >= 0))
);


--
-- Name: core_productvariant_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.core_productvariant ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.core_productvariant_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: core_shippingaddress; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.core_shippingaddress (
    id bigint NOT NULL,
    address_line_1 character varying(255) NOT NULL,
    address_line_2 character varying(255),
    city character varying(100) NOT NULL,
    state character varying(100) NOT NULL,
    zip_code character varying(20) NOT NULL,
    country character varying(100) NOT NULL,
    recipient_name character varying(200),
    recipient_phone character varying(20),
    is_default boolean NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    user_id bigint NOT NULL,
    recipient_email character varying(254)
);


--
-- Name: core_shippingaddress_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.core_shippingaddress ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.core_shippingaddress_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: core_stocknotification; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.core_stocknotification (
    id bigint NOT NULL,
    email character varying(254),
    phone character varying(20),
    is_notified boolean NOT NULL,
    created_at timestamp with time zone NOT NULL,
    product_id bigint NOT NULL,
    user_id bigint
);


--
-- Name: core_stocknotification_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.core_stocknotification ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.core_stocknotification_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: core_tag; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.core_tag (
    id bigint NOT NULL,
    name character varying(50) NOT NULL,
    created_at timestamp with time zone NOT NULL
);


--
-- Name: core_tag_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.core_tag ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.core_tag_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: core_user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.core_user (
    id bigint NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    phone character varying(20),
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


--
-- Name: core_user_groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.core_user_groups (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    group_id integer NOT NULL
);


--
-- Name: core_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.core_user_groups ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.core_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: core_user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.core_user ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.core_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: core_user_user_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.core_user_user_permissions (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    permission_id integer NOT NULL
);


--
-- Name: core_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.core_user_user_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.core_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id bigint NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.django_admin_log ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_aws_ses_awssessettings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_aws_ses_awssessettings (
    id bigint NOT NULL,
    access_key character varying(255),
    secret_key character varying(255),
    region_name character varying(255),
    region_endpoint character varying(255),
    site_id integer NOT NULL
);


--
-- Name: django_aws_ses_awssessettings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.django_aws_ses_awssessettings ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_aws_ses_awssessettings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_aws_ses_awssesuseraddon; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_aws_ses_awssesuseraddon (
    id bigint NOT NULL,
    unsubscribe boolean NOT NULL,
    user_id bigint NOT NULL
);


--
-- Name: django_aws_ses_awssesuseraddon_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.django_aws_ses_awssesuseraddon ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_aws_ses_awssesuseraddon_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_aws_ses_blacklisteddomains; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_aws_ses_blacklisteddomains (
    id bigint NOT NULL,
    domain character varying(255) NOT NULL,
    "timestamp" timestamp with time zone NOT NULL
);


--
-- Name: django_aws_ses_blacklisteddomains_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.django_aws_ses_blacklisteddomains ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_aws_ses_blacklisteddomains_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_aws_ses_bouncerecord; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_aws_ses_bouncerecord (
    id bigint NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    email character varying(254) NOT NULL,
    bounce_type character varying(255),
    bounce_sub_type character varying(255),
    reporting_mta character varying(255),
    status character varying(255),
    action character varying(255),
    feedback_id text,
    diagnostic_code character varying(2048),
    cleared boolean NOT NULL
);


--
-- Name: django_aws_ses_bouncerecord_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.django_aws_ses_bouncerecord ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_aws_ses_bouncerecord_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_aws_ses_complaintrecord; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_aws_ses_complaintrecord (
    id bigint NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    email character varying(254) NOT NULL,
    sub_type character varying(255),
    feedback_id text,
    feedback_type character varying(255)
);


--
-- Name: django_aws_ses_complaintrecord_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.django_aws_ses_complaintrecord ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_aws_ses_complaintrecord_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_aws_ses_sendrecord; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_aws_ses_sendrecord (
    id bigint NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    source character varying(254) NOT NULL,
    destination character varying(254) NOT NULL,
    subject text,
    message_id text,
    aws_process_time integer NOT NULL,
    smtp_response character varying(255),
    status character varying(20)
);


--
-- Name: django_aws_ses_sendrecord_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.django_aws_ses_sendrecord ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_aws_ses_sendrecord_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_aws_ses_sesstat; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_aws_ses_sesstat (
    id bigint NOT NULL,
    date date NOT NULL,
    delivery_attempts integer NOT NULL,
    bounces integer NOT NULL,
    complaints integer NOT NULL,
    rejects integer NOT NULL,
    CONSTRAINT django_aws_ses_sesstat_bounces_check CHECK ((bounces >= 0)),
    CONSTRAINT django_aws_ses_sesstat_complaints_check CHECK ((complaints >= 0)),
    CONSTRAINT django_aws_ses_sesstat_delivery_attempts_check CHECK ((delivery_attempts >= 0)),
    CONSTRAINT django_aws_ses_sesstat_rejects_check CHECK ((rejects >= 0))
);


--
-- Name: django_aws_ses_sesstat_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.django_aws_ses_sesstat ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_aws_ses_sesstat_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_aws_ses_unknownrecord; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_aws_ses_unknownrecord (
    id bigint NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    event_type character varying(255),
    aws_data text
);


--
-- Name: django_aws_ses_unknownrecord_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.django_aws_ses_unknownrecord ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_aws_ses_unknownrecord_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.django_content_type ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.django_migrations ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


--
-- Name: django_site; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_site (
    id integer NOT NULL,
    domain character varying(100) NOT NULL,
    name character varying(50) NOT NULL
);


--
-- Name: django_site_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.django_site ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_site_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: payments_payupayment; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payments_payupayment (
    id bigint NOT NULL,
    txnid character varying(64) NOT NULL,
    amount numeric(10,2) NOT NULL,
    status character varying(20) NOT NULL,
    phone character varying(20),
    email character varying(254),
    mihpayid character varying(64),
    mode character varying(10),
    payu_response jsonb,
    verified boolean NOT NULL,
    error_message text,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    order_id bigint NOT NULL,
    user_id bigint
);


--
-- Name: payments_payupayment_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.payments_payupayment ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.payments_payupayment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.session (
    sid character varying NOT NULL,
    sess json NOT NULL,
    expire timestamp(6) without time zone NOT NULL
);


--
-- Name: token_blacklist_blacklistedtoken; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.token_blacklist_blacklistedtoken (
    id bigint NOT NULL,
    blacklisted_at timestamp with time zone NOT NULL,
    token_id bigint NOT NULL
);


--
-- Name: token_blacklist_blacklistedtoken_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.token_blacklist_blacklistedtoken ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.token_blacklist_blacklistedtoken_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: token_blacklist_outstandingtoken; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.token_blacklist_outstandingtoken (
    id bigint NOT NULL,
    token text NOT NULL,
    created_at timestamp with time zone,
    expires_at timestamp with time zone NOT NULL,
    user_id bigint,
    jti character varying(255) NOT NULL
);


--
-- Name: token_blacklist_outstandingtoken_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.token_blacklist_outstandingtoken ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.token_blacklist_outstandingtoken_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
6	Can add log entry	1	add_logentry
7	Can change log entry	1	change_logentry
8	Can delete log entry	1	delete_logentry
9	Can view log entry	1	view_logentry
10	Can add permission	2	add_permission
11	Can change permission	2	change_permission
12	Can delete permission	2	delete_permission
13	Can view permission	2	view_permission
14	Can add group	3	add_group
15	Can change group	3	change_group
16	Can delete group	3	delete_group
17	Can view group	3	view_group
18	Can add content type	4	add_contenttype
19	Can change content type	4	change_contenttype
20	Can delete content type	4	delete_contenttype
21	Can view content type	4	view_contenttype
22	Can add session	5	add_session
23	Can change session	5	change_session
24	Can delete session	5	delete_session
25	Can view session	5	view_session
26	Can add category	6	add_category
27	Can change category	6	change_category
28	Can delete category	6	delete_category
29	Can view category	6	view_category
30	Can add product	7	add_product
31	Can change product	7	change_product
32	Can delete product	7	delete_product
33	Can view product	7	view_product
34	Can add user	8	add_user
35	Can change user	8	change_user
36	Can delete user	8	delete_user
37	Can view user	8	view_user
38	Can add order	9	add_order
39	Can change order	9	change_order
40	Can delete order	9	delete_order
41	Can view order	9	view_order
42	Can add order item	10	add_orderitem
43	Can change order item	10	change_orderitem
44	Can delete order item	10	delete_orderitem
45	Can view order item	10	view_orderitem
46	Can add shipping address	11	add_shippingaddress
47	Can change shipping address	11	change_shippingaddress
48	Can delete shipping address	11	delete_shippingaddress
49	Can view shipping address	11	view_shippingaddress
50	Can add stock notification	12	add_stocknotification
51	Can change stock notification	12	change_stocknotification
52	Can delete stock notification	12	delete_stocknotification
53	Can view stock notification	12	view_stocknotification
54	Can add cart	13	add_cart
55	Can change cart	13	change_cart
56	Can delete cart	13	delete_cart
57	Can view cart	13	view_cart
58	Can add blacklisted token	14	add_blacklistedtoken
59	Can change blacklisted token	14	change_blacklistedtoken
60	Can delete blacklisted token	14	delete_blacklistedtoken
61	Can view blacklisted token	14	view_blacklistedtoken
62	Can add outstanding token	15	add_outstandingtoken
63	Can change outstanding token	15	change_outstandingtoken
64	Can delete outstanding token	15	delete_outstandingtoken
65	Can view outstanding token	15	view_outstandingtoken
66	Can add product image	16	add_productimage
67	Can change product image	16	change_productimage
68	Can delete product image	16	delete_productimage
69	Can view product image	16	view_productimage
70	Can add cart item	17	add_cartitem
71	Can change cart item	17	change_cartitem
72	Can delete cart item	17	delete_cartitem
73	Can view cart item	17	view_cartitem
74	Can add tag	18	add_tag
75	Can change tag	18	change_tag
76	Can delete tag	18	delete_tag
77	Can view tag	18	view_tag
78	Can add site	19	add_site
79	Can change site	19	change_site
80	Can delete site	19	delete_site
81	Can view site	19	view_site
82	Can add Blacklisted Domain	20	add_blacklisteddomains
83	Can change Blacklisted Domain	20	change_blacklisteddomains
84	Can delete Blacklisted Domain	20	delete_blacklisteddomains
85	Can view Blacklisted Domain	20	view_blacklisteddomains
86	Can add SES Statistic	21	add_sesstat
87	Can change SES Statistic	21	change_sesstat
88	Can delete SES Statistic	21	delete_sesstat
89	Can view SES Statistic	21	view_sesstat
90	Can add AWS SES Settings	22	add_awssessettings
91	Can change AWS SES Settings	22	change_awssessettings
92	Can delete AWS SES Settings	22	delete_awssessettings
93	Can view AWS SES Settings	22	view_awssessettings
94	Can add AWS SES User Addon	23	add_awssesuseraddon
95	Can change AWS SES User Addon	23	change_awssesuseraddon
96	Can delete AWS SES User Addon	23	delete_awssesuseraddon
97	Can view AWS SES User Addon	23	view_awssesuseraddon
98	Can add Bounce Record	24	add_bouncerecord
99	Can change Bounce Record	24	change_bouncerecord
100	Can delete Bounce Record	24	delete_bouncerecord
101	Can view Bounce Record	24	view_bouncerecord
102	Can add Complaint Record	25	add_complaintrecord
103	Can change Complaint Record	25	change_complaintrecord
104	Can delete Complaint Record	25	delete_complaintrecord
105	Can view Complaint Record	25	view_complaintrecord
106	Can add Send Record	26	add_sendrecord
107	Can change Send Record	26	change_sendrecord
108	Can delete Send Record	26	delete_sendrecord
109	Can view Send Record	26	view_sendrecord
110	Can add Unknown Record	27	add_unknownrecord
111	Can change Unknown Record	27	change_unknownrecord
112	Can delete Unknown Record	27	delete_unknownrecord
113	Can view Unknown Record	27	view_unknownrecord
114	Can add app notification	28	add_appnotification
115	Can change app notification	28	change_appnotification
116	Can delete app notification	28	delete_appnotification
117	Can view app notification	28	view_appnotification
118	Can add product variant	29	add_productvariant
119	Can change product variant	29	change_productvariant
120	Can delete product variant	29	delete_productvariant
121	Can view product variant	29	view_productvariant
122	Can add PayU Payment	30	add_payupayment
123	Can change PayU Payment	30	change_payupayment
124	Can delete PayU Payment	30	delete_payupayment
125	Can view PayU Payment	30	view_payupayment
\.


--
-- Data for Name: core_appnotification; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.core_appnotification (id, type, title, message, data, is_read, created_at, read_at, user_id) FROM stdin;
1	order_status_change	Order Status Updated	Your order #13 status changed to delivered.	{"order_id": 13, "new_status": "delivered", "old_status": "pending"}	f	2025-09-29 15:01:54.217+00	\N	7
2	order_status_change	Order Status Changed	Order #13 for  changed to delivered.	{"user_id": 7, "order_id": 13, "new_status": "delivered", "old_status": "pending"}	f	2025-09-29 15:01:54.231+00	\N	\N
3	order_status_change	Order Status Updated	Your order #15 status changed to delivered.	{"order_id": 15, "new_status": "delivered", "old_status": "pending"}	f	2025-10-07 13:19:48.393+00	\N	8
4	order_status_change	Order Status Changed	Order #15 for uhagangasani@gmail.com changed to delivered.	{"user_id": 8, "order_id": 15, "new_status": "delivered", "old_status": "pending"}	f	2025-10-07 13:19:48.396+00	\N	\N
5	order_status_change	Order Status Updated	Your order #14 status changed to delivered.	{"order_id": 14, "new_status": "delivered", "old_status": "pending"}	f	2025-10-07 13:19:53.584+00	\N	7
6	order_status_change	Order Status Changed	Order #14 for  changed to delivered.	{"user_id": 7, "order_id": 14, "new_status": "delivered", "old_status": "pending"}	f	2025-10-07 13:19:53.59+00	\N	\N
7	order_status_change	Order Status Updated	Your order #16 status changed to delivered.	{"order_id": 16, "new_status": "delivered", "old_status": "pending"}	f	2025-10-07 13:24:31.945+00	\N	8
8	order_status_change	Order Status Changed	Order #16 for uhagangasani@gmail.com changed to delivered.	{"user_id": 8, "order_id": 16, "new_status": "delivered", "old_status": "pending"}	f	2025-10-07 13:24:31.949+00	\N	\N
9	order_status_change	Order Status Updated	Your order #5 status changed to shipped.	{"order_id": 5, "new_status": "shipped", "old_status": "processing"}	f	2025-10-07 13:26:51.023+00	\N	7
10	order_status_change	Order Status Changed	Order #5 for  changed to shipped.	{"user_id": 7, "order_id": 5, "new_status": "shipped", "old_status": "processing"}	f	2025-10-07 13:26:51.027+00	\N	\N
11	order_status_change	Order Status Updated	Your order #15 status changed to processing.	{"order_id": 15, "new_status": "processing", "old_status": "delivered"}	f	2025-10-07 13:44:14.375+00	\N	8
12	order_status_change	Order Status Changed	Order #15 for uhagangasani@gmail.com changed to processing.	{"user_id": 8, "order_id": 15, "new_status": "processing", "old_status": "delivered"}	f	2025-10-07 13:44:14.38+00	\N	\N
13	order_status_change	Order Status Updated	Your order #14 status changed to processing.	{"order_id": 14, "new_status": "processing", "old_status": "delivered"}	f	2025-10-07 13:44:18.814+00	\N	7
14	order_status_change	Order Status Changed	Order #14 for  changed to processing.	{"user_id": 7, "order_id": 14, "new_status": "processing", "old_status": "delivered"}	f	2025-10-07 13:44:18.819+00	\N	\N
15	order_status_change	Order Status Updated	Your order #17 status changed to processing.	{"order_id": 17, "new_status": "processing", "old_status": "pending"}	f	2025-10-07 14:32:46.639+00	\N	8
16	order_status_change	Order Status Changed	Order #17 for uhagangasani@gmail.com changed to processing.	{"user_id": 8, "order_id": 17, "new_status": "processing", "old_status": "pending"}	f	2025-10-07 14:32:46.65+00	\N	\N
17	order_created	Your order has been placed	Order #13 was successfully created.	{"order_id": 13}	t	2025-09-28 00:26:33.543+00	2025-10-08 13:52:53.873+00	7
18	order_created	New order created	User mahesh babu placed Order #13	{"user_id": 7, "order_id": 13}	t	2025-09-28 00:26:33.552+00	2025-10-08 13:52:53.873+00	\N
19	user_signup	New User Registration	Devang   (devangadhikari17@gmail.com) has signed up.	{"user_id": 11, "user_name": "Devang  ", "user_email": "devangadhikari17@gmail.com"}	t	2025-10-07 09:17:40.317+00	2025-10-08 13:52:53.873+00	\N
20	order_created	Your order has been placed	Order #14 was successfully created.	{"order_id": 14}	t	2025-10-07 13:18:40.396+00	2025-10-08 13:52:53.873+00	7
21	order_created	Your order has been placed	Order #15 was successfully created.	{"order_id": 15}	t	2025-10-07 13:19:32.971+00	2025-10-08 13:52:53.873+00	8
22	order_created	New order created	User ooha  placed Order #15	{"user_id": 8, "order_id": 15}	t	2025-10-07 13:19:32.974+00	2025-10-08 13:52:53.873+00	\N
23	order_created	Your order has been placed	Order #16 was successfully created.	{"order_id": 16}	t	2025-10-07 13:21:28.415+00	2025-10-08 13:52:53.873+00	8
24	order_created	New order created	User ooha  placed Order #16	{"user_id": 8, "order_id": 16}	t	2025-10-07 13:21:28.422+00	2025-10-08 13:52:53.873+00	\N
25	user_signup	New User Registration	Karthik   (rkarthik110@gmail.com) has signed up.	{"user_id": 15, "user_name": "Karthik  ", "user_email": "rkarthik110@gmail.com"}	t	2025-10-09 18:47:14.024+00	2025-10-09 20:43:06.918+00	\N
26	low_stock	Low Stock Alert	Product 'Aridarum Narrow' is running low on stock (0 left).	{"stock": 0, "product_id": 3, "product_name": "Aridarum Narrow"}	t	2025-10-09 20:42:43.677+00	2025-10-09 20:43:06.918+00	\N
27	low_stock	Low Stock Alert	Product 'Goliath Silver' is running low on stock (0 left).	{"stock": 0, "product_id": 6, "product_name": "Goliath Silver"}	t	2025-10-09 20:42:59.996+00	2025-10-09 20:43:06.918+00	\N
28	order_status_change	Order Status Updated	Your order #14 status changed to delivered.	{"order_id": 14, "new_status": "delivered", "old_status": "processing"}	f	2025-10-09 22:38:21.381+00	\N	7
29	order_status_change	Order Status Changed	Order #14 for  changed to delivered.	{"user_id": 7, "order_id": 14, "new_status": "delivered", "old_status": "processing"}	f	2025-10-09 22:38:21.396+00	\N	\N
30	order_status_change	Order Status Updated	Your order #18 status changed to shipped.	{"order_id": 18, "new_status": "shipped", "old_status": "processing"}	f	2025-10-15 23:55:39.996+00	\N	13
31	order_status_change	Order Status Updated	Your order #17 status changed to shipped.	{"order_id": 17, "new_status": "shipped", "old_status": "processing"}	f	2025-10-08 21:19:19.057+00	\N	8
32	order_status_change	Order Status Changed	Order #17 for uhagangasani@gmail.com changed to shipped.	{"user_id": 8, "order_id": 17, "new_status": "shipped", "old_status": "processing"}	f	2025-10-08 21:19:19.072+00	\N	\N
33	order_status_change	Order Status Changed	Order #18 for pravinjackson16@gmail.com changed to shipped.	{"user_id": 13, "order_id": 18, "new_status": "shipped", "old_status": "processing"}	f	2025-10-15 23:55:39.999+00	\N	\N
34	order_created	Your order has been placed	Order #17 was successfully created.	{"order_id": 17}	t	2025-10-07 13:45:54.334+00	2025-10-08 13:52:53.873+00	8
35	order_status_change	Order Status Updated	Your order #17 status changed to delivered.	{"order_id": 17, "new_status": "delivered", "old_status": "shipped"}	f	2025-10-09 13:15:19.855+00	\N	8
36	order_status_change	Order Status Changed	Order #17 for uhagangasani@gmail.com changed to delivered.	{"user_id": 8, "order_id": 17, "new_status": "delivered", "old_status": "shipped"}	f	2025-10-09 13:15:19.87+00	\N	\N
37	user_signup	New User Registration	Prajwaal Borkar (borkarpp369@gmail.com) has signed up.	{"user_id": 12, "user_name": "Prajwaal Borkar", "user_email": "borkarpp369@gmail.com"}	t	2025-10-09 14:18:22.936+00	\N	\N
38	order_status_change	Order Status Updated	Your order #18 status changed to processing.	{"order_id": 18, "new_status": "processing", "old_status": "pending"}	f	2025-10-09 17:15:34.943+00	\N	13
39	order_status_change	Order Status Changed	Order #18 for pravinjackson16@gmail.com changed to processing.	{"user_id": 13, "order_id": 18, "new_status": "processing", "old_status": "pending"}	f	2025-10-09 17:15:34.948+00	\N	\N
40	user_signup	New User Registration	Pravin  (pravinjackson16@gmail.com) has signed up.	{"user_id": 13, "user_name": "Pravin ", "user_email": "pravinjackson16@gmail.com"}	t	2025-10-09 16:57:37.879+00	2025-10-09 17:44:45.59+00	\N
41	low_stock	Low Stock Alert	Product 'Bucephalandra Catherine' is running low on stock (0 left).	{"stock": 0, "product_id": 17, "product_name": "Bucephalandra Catherine"}	t	2025-10-09 17:06:53.363+00	2025-10-09 17:44:45.59+00	\N
42	order_created	Your order has been placed	Order #18 was successfully created.	{"order_id": 18}	t	2025-10-09 17:07:15.11+00	2025-10-09 17:44:45.59+00	13
43	order_created	New order created	User Pravin  placed Order #18	{"user_id": 13, "order_id": 18}	t	2025-10-09 17:07:15.114+00	2025-10-09 17:44:45.59+00	\N
44	user_signup	New User Registration	Shripad S (rkshri07@gmail.com) has signed up.	{"user_id": 14, "user_name": "Shripad S", "user_email": "rkshri07@gmail.com"}	t	2025-10-09 17:07:55.855+00	2025-10-09 17:44:45.59+00	\N
45	low_stock	Low Stock Alert	Product 'Bucephalandra Red Velvet' is running low on stock (2 left).	{"stock": 2, "product_id": 13, "product_name": "Bucephalandra Red Velvet"}	t	2025-10-09 17:23:58.346+00	2025-10-09 17:44:45.59+00	\N
46	user_signup	New User Registration	JLO2025  (jerrybol@gmx.fr) has signed up.	{"user_id": 16, "user_name": "JLO2025 ", "user_email": "jerrybol@gmx.fr"}	t	2025-10-10 20:18:02.624+00	2025-10-15 23:55:49.006+00	\N
47	user_signup	New User Registration	JLO1992  (inesaly2022@gmail.com) has signed up.	{"user_id": 17, "user_name": "JLO1992 ", "user_email": "inesaly2022@gmail.com"}	t	2025-10-10 20:19:36.633+00	2025-10-15 23:55:49.006+00	\N
48	low_stock	Low Stock Alert	Product 'Goliath Silver' is running low on stock (0 left).	{"stock": 0, "product_id": 6, "product_name": "Goliath Silver"}	t	2025-10-15 23:54:16.63+00	2025-10-15 23:55:49.006+00	\N
49	user_signup	New User Registration	John Christopher (johnchristopher3069@gmail.com) has signed up.	{"user_id": 18, "user_name": "John Christopher", "user_email": "johnchristopher3069@gmail.com"}	t	2025-10-16 11:53:01.226+00	2025-10-17 10:53:55.121+00	\N
50	user_signup	New User Registration	Abhishek   (abhishek24621@gmail.com) has signed up.	{"user_id": 19, "user_name": "Abhishek  ", "user_email": "abhishek24621@gmail.com"}	t	2025-10-16 13:02:52.419+00	2025-10-17 10:53:55.121+00	\N
51	user_signup	New User Registration	thocho  (thocho305@gmail.com) has signed up.	{"user_id": 20, "user_name": "thocho ", "user_email": "thocho305@gmail.com"}	t	2025-10-16 16:50:36.545+00	2025-10-17 10:53:55.121+00	\N
52	order_status_change	Order Status Updated	Your order #10000 status changed to processing.	{"order_id": 10000, "new_status": "processing", "old_status": "pending"}	f	2025-10-29 11:54:47.596+00	\N	25
53	order_status_change	Order Status Changed	Order #10000 for anilmehtain@gmail.com changed to processing.	{"user_id": 25, "order_id": 10000, "new_status": "processing", "old_status": "pending"}	f	2025-10-29 11:54:47.609+00	\N	\N
54	order_status_change	Order Status Updated	Your order #10003 status changed to processing.	{"order_id": 10003, "new_status": "processing", "old_status": "pending"}	f	2025-10-29 11:54:53.557+00	\N	29
55	order_status_change	Order Status Changed	Order #10003 for mahesh.rkumar79@gmail.com changed to processing.	{"user_id": 29, "order_id": 10003, "new_status": "processing", "old_status": "pending"}	f	2025-10-29 11:54:53.561+00	\N	\N
56	user_signup	New User Registration	akshay Taksande (akshaytak32@gmail.com) has signed up.	{"user_id": 21, "user_name": "akshay Taksande", "user_email": "akshaytak32@gmail.com"}	t	2025-10-18 14:03:30.998+00	2025-10-29 13:03:10.813+00	\N
57	user_signup	New User Registration	Jatin kulthia (jatinkulthia10d.dpsm@hmail.com) has signed up.	{"user_id": 22, "user_name": "Jatin kulthia", "user_email": "jatinkulthia10d.dpsm@hmail.com"}	t	2025-10-18 16:38:00.208+00	2025-10-29 13:03:10.813+00	\N
58	order_created	Your order has been placed	Order #9999 was successfully created.	{"order_id": 9999}	t	2025-10-18 16:42:22.144+00	2025-10-29 13:03:10.813+00	22
59	order_created	New order created	User Jatin kulthia placed Order #9999	{"user_id": 22, "order_id": 9999}	t	2025-10-18 16:42:22.147+00	2025-10-29 13:03:10.813+00	\N
60	user_signup	New User Registration	Santhanakrishnan  (santhanakrishnan.h@gmail.com) has signed up.	{"user_id": 23, "user_name": "Santhanakrishnan ", "user_email": "santhanakrishnan.h@gmail.com"}	t	2025-10-18 20:56:56.465+00	2025-10-29 13:03:10.813+00	\N
61	user_signup	New User Registration	divyansh pokhriyal (divyanshpokhriyalgtm@gmail.com) has signed up.	{"user_id": 24, "user_name": "divyansh pokhriyal", "user_email": "divyanshpokhriyalgtm@gmail.com"}	t	2025-10-20 00:14:59.703+00	2025-10-29 13:03:10.813+00	\N
62	user_signup	New User Registration	Anil Mehta (anilmehtain@gmail.com) has signed up.	{"user_id": 25, "user_name": "Anil Mehta", "user_email": "anilmehtain@gmail.com"}	t	2025-10-22 16:38:09.627+00	2025-10-29 13:03:10.813+00	\N
63	order_created	Your order has been placed	Order #10000 was successfully created.	{"order_id": 10000}	t	2025-10-22 16:41:27.246+00	2025-10-29 13:03:10.813+00	25
64	order_created	New order created	User Anil Mehta placed Order #10000	{"user_id": 25, "order_id": 10000}	t	2025-10-22 16:41:27.25+00	2025-10-29 13:03:10.813+00	\N
65	user_signup	New User Registration	Raghavendra Rakshith (raghvendra.rakshith.rr@gmail.com) has signed up.	{"user_id": 26, "user_name": "Raghavendra Rakshith", "user_email": "raghvendra.rakshith.rr@gmail.com"}	t	2025-10-22 19:20:41.669+00	2025-10-29 13:03:10.813+00	\N
66	user_signup	New User Registration	sdsd  (ausmrrzeb2@gmail.com) has signed up.	{"user_id": 27, "user_name": "sdsd ", "user_email": "ausmrrzeb2@gmail.com"}	t	2025-10-26 21:34:09.673+00	2025-10-29 13:03:10.813+00	\N
67	order_created	Your order has been placed	Order #10001 was successfully created.	{"order_id": 10001}	t	2025-10-26 21:34:40.519+00	2025-10-29 13:03:10.813+00	27
68	order_created	New order created	User sdsd  placed Order #10001	{"user_id": 27, "order_id": 10001}	t	2025-10-26 21:34:40.523+00	2025-10-29 13:03:10.813+00	\N
69	user_signup	New User Registration	Sanath   (sanathbu180@gmail.com) has signed up.	{"user_id": 28, "user_name": "Sanath  ", "user_email": "sanathbu180@gmail.com"}	t	2025-10-28 19:17:29.861+00	2025-10-29 13:03:10.813+00	\N
70	order_created	Your order has been placed	Order #10002 was successfully created.	{"order_id": 10002}	t	2025-10-28 19:19:27.443+00	2025-10-29 13:03:10.813+00	28
71	order_created	New order created	User Sanath   placed Order #10002	{"user_id": 28, "order_id": 10002}	t	2025-10-28 19:19:27.447+00	2025-10-29 13:03:10.813+00	\N
229	order_created	New order created	User k pavan placed Order #52	{"user_id": 45, "order_id": 52}	f	2026-01-25 17:05:35.395075+00	\N	\N
72	user_signup	New User Registration	Mahesh Kumar (mahesh.rkumar79@gmail.com) has signed up.	{"user_id": 29, "user_name": "Mahesh Kumar", "user_email": "mahesh.rkumar79@gmail.com"}	t	2025-10-29 07:40:17.152+00	2025-10-29 13:03:10.813+00	\N
73	order_created	Your order has been placed	Order #10003 was successfully created.	{"order_id": 10003}	t	2025-10-29 07:43:48.914+00	2025-10-29 13:03:10.813+00	29
74	order_created	New order created	User Mahesh Kumar placed Order #10003	{"user_id": 29, "order_id": 10003}	t	2025-10-29 07:43:48.918+00	2025-10-29 13:03:10.813+00	\N
75	user_signup	New User Registration	Rajdeep Singh (singhbhambra8@gmail.com) has signed up.	{"user_id": 30, "user_name": "Rajdeep Singh", "user_email": "singhbhambra8@gmail.com"}	t	2025-10-29 12:45:46.222+00	2025-10-29 13:03:10.813+00	\N
76	order_created	Your order has been placed	Order #10004 was successfully created.	{"order_id": 10004}	t	2025-10-29 12:47:18.272+00	2025-10-29 13:03:10.813+00	30
77	order_created	New order created	User Rajdeep Singh placed Order #10004	{"user_id": 30, "order_id": 10004}	t	2025-10-29 12:47:18.277+00	2025-10-29 13:03:10.813+00	\N
78	user_signup	New User Registration	Vishal Bhosale (malhartulja1015@gmail.com) has signed up.	{"user_id": 31, "user_name": "Vishal Bhosale", "user_email": "malhartulja1015@gmail.com"}	t	2025-10-29 12:57:42.354+00	2025-10-29 13:03:10.813+00	\N
79	user_signup	New User Registration	ANKIT SAHOO (ankitsahoo061@gmail.com) has signed up.	{"user_id": 32, "user_name": "ANKIT SAHOO", "user_email": "ankitsahoo061@gmail.com"}	t	2025-10-29 13:34:01.035+00	2025-10-29 14:09:53.949+00	\N
80	order_created	Your order has been placed	Order #10005 was successfully created.	{"order_id": 10005}	t	2025-10-29 13:39:55.545+00	2025-10-29 14:09:53.949+00	32
81	order_created	New order created	User ANKIT SAHOO placed Order #10005	{"user_id": 32, "order_id": 10005}	t	2025-10-29 13:39:55.549+00	2025-10-29 14:09:53.949+00	\N
82	user_signup	New User Registration	Sai Suman (saisuman.misala@gmail.com) has signed up.	{"user_id": 33, "user_name": "Sai Suman", "user_email": "saisuman.misala@gmail.com"}	t	2025-10-29 13:51:49.607+00	2025-10-29 14:09:53.949+00	\N
83	order_status_change	Order Status Updated	Your order #10005 status changed to cancelled.	{"order_id": 10005, "new_status": "cancelled", "old_status": "pending"}	f	2025-10-30 08:56:17.199+00	\N	32
84	order_status_change	Order Status Changed	Order #10005 for ankitsahoo061@gmail.com changed to cancelled.	{"user_id": 32, "order_id": 10005, "new_status": "cancelled", "old_status": "pending"}	f	2025-10-30 08:56:17.214+00	\N	\N
85	order_status_change	Order Status Updated	Your order #9999 status changed to cancelled.	{"order_id": 9999, "new_status": "cancelled", "old_status": "pending"}	f	2025-10-30 08:57:01.494+00	\N	22
86	order_status_change	Order Status Changed	Order #9999 for jatinkulthia10d.dpsm@hmail.com changed to cancelled.	{"user_id": 22, "order_id": 9999, "new_status": "cancelled", "old_status": "pending"}	f	2025-10-30 08:57:01.499+00	\N	\N
87	order_status_change	Order Status Updated	Your order #10001 status changed to cancelled.	{"order_id": 10001, "new_status": "cancelled", "old_status": "pending"}	f	2025-10-30 08:57:05.876+00	\N	27
88	order_status_change	Order Status Changed	Order #10001 for ausmrrzeb2@gmail.com changed to cancelled.	{"user_id": 27, "order_id": 10001, "new_status": "cancelled", "old_status": "pending"}	f	2025-10-30 08:57:05.88+00	\N	\N
89	order_status_change	Order Status Updated	Your order #10002 status changed to cancelled.	{"order_id": 10002, "new_status": "cancelled", "old_status": "pending"}	f	2025-10-30 08:57:09.434+00	\N	28
90	order_status_change	Order Status Changed	Order #10002 for sanathbu180@gmail.com changed to cancelled.	{"user_id": 28, "order_id": 10002, "new_status": "cancelled", "old_status": "pending"}	f	2025-10-30 08:57:09.439+00	\N	\N
91	user_signup	New User Registration	Ayan Dutta (d.ayandutta1308@gmail.com) has signed up.	{"user_id": 34, "user_name": "Ayan Dutta", "user_email": "d.ayandutta1308@gmail.com"}	t	2025-10-29 19:20:37.081+00	2025-10-30 10:19:55.905+00	\N
92	order_status_change	Order Status Updated	Your order #10004 status changed to cancelled.	{"order_id": 10004, "new_status": "cancelled", "old_status": "pending"}	f	2025-10-30 19:25:01.797+00	\N	30
93	order_status_change	Order Status Changed	Order #10004 for singhbhambra8@gmail.com changed to cancelled.	{"user_id": 30, "order_id": 10004, "new_status": "cancelled", "old_status": "pending"}	f	2025-10-30 19:25:01.812+00	\N	\N
94	low_stock	Low Stock Alert	Product 'Bucephalandra Black Cobra' is running low on stock (3 left).	{"stock": 3, "product_id": 9, "product_name": "Bucephalandra Black Cobra"}	t	2025-10-30 23:30:12.016+00	\N	\N
95	low_stock	Low Stock Alert	Product 'Bucephalandra Mini Melawi' is running low on stock (3 left).	{"stock": 3, "product_id": 8, "product_name": "Bucephalandra Mini Melawi"}	t	2025-10-30 23:29:53.03+00	\N	\N
96	user_signup	New User Registration	Arko Talukder (taluarko@gmail.com) has signed up.	{"user_id": 35, "user_name": "Arko Talukder", "user_email": "taluarko@gmail.com"}	t	2025-10-31 06:45:17.022+00	2025-10-31 10:49:02.087+00	\N
97	user_signup	New User Registration	Hari   (hari19blue@gmail.com) has signed up.	{"user_id": 36, "user_name": "Hari  ", "user_email": "hari19blue@gmail.com"}	t	2025-10-31 08:37:41.378+00	2025-10-31 10:49:02.087+00	\N
98	order_created	Your order has been placed	Order #10006 was successfully created.	{"order_id": 10006}	t	2025-10-31 08:39:01.91+00	2025-10-31 10:49:02.087+00	36
99	order_created	New order created	User Hari   placed Order #10006	{"user_id": 36, "order_id": 10006}	t	2025-10-31 08:39:01.915+00	2025-10-31 10:49:02.087+00	\N
100	order_status_change	Order Status Updated	Your order #10006 status changed to processing.	{"order_id": 10006, "new_status": "processing", "old_status": "pending"}	f	2025-10-31 12:20:23.207+00	\N	36
101	order_status_change	Order Status Changed	Order #10006 for hari19blue@gmail.com changed to processing.	{"user_id": 36, "order_id": 10006, "new_status": "processing", "old_status": "pending"}	f	2025-10-31 12:20:23.223+00	\N	\N
102	order_status_change	Order Status Updated	Your order #10007 status changed to processing.	{"order_id": 10007, "new_status": "processing", "old_status": "pending"}	f	2025-11-02 16:00:30.443+00	\N	37
103	order_status_change	Order Status Changed	Order #10007 for gotohasan2020@gmail.com changed to processing.	{"user_id": 37, "order_id": 10007, "new_status": "processing", "old_status": "pending"}	f	2025-11-02 16:00:30.459+00	\N	\N
104	user_signup	New User Registration	Mohamedhasan  (gotohasan2020@gmail.com) has signed up.	{"user_id": 37, "user_name": "Mohamedhasan ", "user_email": "gotohasan2020@gmail.com"}	t	2025-10-31 18:43:03.535+00	2025-11-02 18:51:48.411+00	\N
105	order_created	New order created	User Mohamedhasan  placed Order #10007	{"user_id": 37, "order_id": 10007}	t	2025-10-31 18:45:35.682+00	2025-11-02 18:51:48.411+00	\N
106	order_status_change	Order Status Updated	Your order #10008 status changed to processing.	{"order_id": 10008, "new_status": "processing", "old_status": "pending"}	f	2025-11-02 23:33:21.604+00	\N	38
107	order_status_change	Order Status Changed	Order #10008 for abhinavtrivedi2004@gmail.com changed to processing.	{"user_id": 38, "order_id": 10008, "new_status": "processing", "old_status": "pending"}	f	2025-11-02 23:33:21.684+00	\N	\N
108	user_signup	New User Registration	Abhinav Trivedi (abhinavtrivedi2004@gmail.com) has signed up.	{"user_id": 38, "user_name": "Abhinav Trivedi", "user_email": "abhinavtrivedi2004@gmail.com"}	t	2025-11-02 19:09:21.047+00	2025-11-02 23:33:33.728+00	\N
109	order_created	Your order has been placed	Order #10008 was successfully created.	{"order_id": 10008}	t	2025-11-02 19:10:47.033+00	2025-11-02 23:33:33.728+00	38
110	order_created	New order created	User Abhinav Trivedi placed Order #10008	{"user_id": 38, "order_id": 10008}	t	2025-11-02 19:10:47.073+00	2025-11-02 23:33:33.728+00	\N
111	order_status_change	Order Status Updated	Your order #15 status changed to delivered.	{"order_id": 15, "new_status": "delivered", "old_status": "processing"}	f	2025-11-02 23:34:07.105+00	\N	8
112	order_status_change	Order Status Changed	Order #15 for uhagangasani@gmail.com changed to delivered.	{"user_id": 8, "order_id": 15, "new_status": "delivered", "old_status": "processing"}	f	2025-11-02 23:34:07.143+00	\N	\N
113	order_status_change	Order Status Updated	Your order #18 status changed to delivered.	{"order_id": 18, "new_status": "delivered", "old_status": "shipped"}	f	2025-11-04 08:24:55.984+00	\N	13
114	order_status_change	Order Status Changed	Order #18 for pravinjackson16@gmail.com changed to delivered.	{"user_id": 13, "order_id": 18, "new_status": "delivered", "old_status": "shipped"}	f	2025-11-04 08:24:55.988+00	\N	\N
115	order_status_change	Order Status Updated	Your order #10007 status changed to shipped.	{"order_id": 10007, "new_status": "shipped", "old_status": "processing"}	f	2025-11-04 08:51:35.785+00	\N	37
116	order_status_change	Order Status Updated	Your order #10010 status changed to cancelled.	{"order_id": 10010, "new_status": "cancelled", "old_status": "pending"}	f	2025-11-03 08:50:24.427+00	\N	40
117	order_status_change	Order Status Changed	Order #10010 for shaji@gmail.com changed to cancelled.	{"user_id": 40, "order_id": 10010, "new_status": "cancelled", "old_status": "pending"}	f	2025-11-03 08:50:24.442+00	\N	\N
118	order_created	New order created	User Shaji. S placed Order #10010	{"user_id": 40, "order_id": 10010}	t	2025-11-03 07:40:22.081+00	\N	\N
119	order_status_change	Order Status Changed	Order #10007 for gotohasan2020@gmail.com changed to shipped.	{"user_id": 37, "order_id": 10007, "new_status": "shipped", "old_status": "processing"}	f	2025-11-04 08:51:35.79+00	\N	\N
120	order_created	New order created	User Shaji. S placed Order #10009	{"user_id": 40, "order_id": 10009}	t	2025-11-03 07:37:46.203+00	\N	\N
121	order_status_change	Order Status Updated	Your order #10009 status changed to cancelled.	{"order_id": 10009, "new_status": "cancelled", "old_status": "pending"}	f	2025-11-03 13:26:35.473+00	\N	40
122	order_status_change	Order Status Changed	Order #10009 for shaji@gmail.com changed to cancelled.	{"user_id": 40, "order_id": 10009, "new_status": "cancelled", "old_status": "pending"}	f	2025-11-03 13:26:35.489+00	\N	\N
123	order_created	New order created	User Raghav Poojari placed Order #10011	{"user_id": 41, "order_id": 10011}	t	2025-11-03 13:30:20.292+00	\N	\N
124	order_created	Your order has been placed	Order #10011 was successfully created.	{"order_id": 10011}	t	2025-11-03 13:30:20.289+00	\N	41
125	user_signup	New User Registration	Raghav Poojari (rpujari2501@gmail.com) has signed up.	{"user_id": 41, "user_name": "Raghav Poojari", "user_email": "rpujari2501@gmail.com"}	t	2025-11-03 13:28:48.838+00	\N	\N
126	order_status_change	Order Status Updated	Your order #10011 status changed to cancelled.	{"order_id": 10011, "new_status": "cancelled", "old_status": "pending"}	f	2025-11-04 07:43:18.207+00	\N	41
127	order_status_change	Order Status Changed	Order #10011 for rpujari2501@gmail.com changed to cancelled.	{"user_id": 41, "order_id": 10011, "new_status": "cancelled", "old_status": "pending"}	f	2025-11-04 07:43:18.219+00	\N	\N
128	order_status_change	Order Status Updated	Your order #10000 status changed to shipped.	{"order_id": 10000, "new_status": "shipped", "old_status": "processing"}	f	2025-11-04 08:04:35.061+00	\N	25
129	order_status_change	Order Status Changed	Order #10000 for anilmehtain@gmail.com changed to shipped.	{"user_id": 25, "order_id": 10000, "new_status": "shipped", "old_status": "processing"}	f	2025-11-04 08:04:35.067+00	\N	\N
130	order_status_change	Order Status Updated	Your order #10003 status changed to shipped.	{"order_id": 10003, "new_status": "shipped", "old_status": "processing"}	f	2025-11-04 08:08:03.623+00	\N	29
131	order_status_change	Order Status Changed	Order #10003 for mahesh.rkumar79@gmail.com changed to shipped.	{"user_id": 29, "order_id": 10003, "new_status": "shipped", "old_status": "processing"}	f	2025-11-04 08:08:03.627+00	\N	\N
132	order_status_change	Order Status Updated	Your order #10008 status changed to shipped.	{"order_id": 10008, "new_status": "shipped", "old_status": "processing"}	f	2025-11-04 11:38:02.157+00	\N	38
133	order_status_change	Order Status Changed	Order #10008 for abhinavtrivedi2004@gmail.com changed to shipped.	{"user_id": 38, "order_id": 10008, "new_status": "shipped", "old_status": "processing"}	f	2025-11-04 11:38:02.178+00	\N	\N
134	order_status_change	Order Status Updated	Your order #10006 status changed to delivered.	{"order_id": 10006, "new_status": "delivered", "old_status": "processing"}	f	2025-11-10 17:46:18.589+00	\N	36
135	order_status_change	Order Status Changed	Order #10006 for hari19blue@gmail.com changed to delivered.	{"user_id": 36, "order_id": 10006, "new_status": "delivered", "old_status": "processing"}	f	2025-11-10 17:46:18.611+00	\N	\N
136	order_status_change	Order Status Updated	Your order #10003 status changed to delivered.	{"order_id": 10003, "new_status": "delivered", "old_status": "shipped"}	f	2025-11-10 17:46:22.464+00	\N	29
137	order_status_change	Order Status Changed	Order #10003 for mahesh.rkumar79@gmail.com changed to delivered.	{"user_id": 29, "order_id": 10003, "new_status": "delivered", "old_status": "shipped"}	f	2025-11-10 17:46:22.468+00	\N	\N
138	order_status_change	Order Status Updated	Your order #10008 status changed to delivered.	{"order_id": 10008, "new_status": "delivered", "old_status": "shipped"}	f	2025-11-10 17:46:31.235+00	\N	38
139	order_status_change	Order Status Changed	Order #10008 for abhinavtrivedi2004@gmail.com changed to delivered.	{"user_id": 38, "order_id": 10008, "new_status": "delivered", "old_status": "shipped"}	f	2025-11-10 17:46:31.238+00	\N	\N
140	order_status_change	Order Status Updated	Your order #10007 status changed to delivered.	{"order_id": 10007, "new_status": "delivered", "old_status": "shipped"}	f	2025-11-10 17:46:33.742+00	\N	37
230	order_created	Your order has been placed	Order #53 was successfully created.	{"order_id": 53}	f	2026-01-25 17:07:16.407552+00	\N	45
141	order_status_change	Order Status Changed	Order #10007 for gotohasan2020@gmail.com changed to delivered.	{"user_id": 37, "order_id": 10007, "new_status": "delivered", "old_status": "shipped"}	f	2025-11-10 17:46:33.747+00	\N	\N
142	order_status_change	Order Status Updated	Your order #10000 status changed to delivered.	{"order_id": 10000, "new_status": "delivered", "old_status": "shipped"}	f	2025-11-10 17:46:43.8+00	\N	25
143	order_status_change	Order Status Changed	Order #10000 for anilmehtain@gmail.com changed to delivered.	{"user_id": 25, "order_id": 10000, "new_status": "delivered", "old_status": "shipped"}	f	2025-11-10 17:46:43.804+00	\N	\N
144	user_signup	New User Registration	Nirmala Terrence (nirmalaterrence@gmail.com) has signed up.	{"user_id": 44, "user_name": "Nirmala Terrence", "user_email": "nirmalaterrence@gmail.com"}	t	2025-12-23 12:44:39.313+00	\N	\N
145	user_signup	New User Registration	Maaz  (almaazin05@gmail.com) has signed up.	{"user_id": 43, "user_name": "Maaz ", "user_email": "almaazin05@gmail.com"}	t	2025-12-23 11:01:33.092+00	\N	\N
146	order_created	New order created	User Nirmala Terrence placed Order #10013	{"user_id": 44, "order_id": 10013}	t	2025-12-23 14:12:16.523+00	\N	\N
147	order_created	Your order has been placed	Order #10013 was successfully created.	{"order_id": 10013}	t	2025-12-23 14:12:16.513+00	\N	44
148	user_signup	New User Registration	Muhammad Roshan (roshroshan786@gmail.com) has signed up.	{"user_id": 42, "user_name": "Muhammad Roshan", "user_email": "roshroshan786@gmail.com"}	t	2025-12-22 15:49:06.493+00	2025-12-23 08:36:01.419+00	\N
149	order_created	New order created	User Muhammad Roshan placed Order #10012	{"user_id": 42, "order_id": 10012}	t	2025-12-22 15:52:46.147+00	2025-12-23 08:36:01.419+00	\N
150	order_status_change	Order Status Updated	Your order #10013 status changed to processing.	{"order_id": 10013, "new_status": "processing", "old_status": "pending"}	f	2025-12-23 21:14:07.082+00	\N	44
151	order_status_change	Order Status Changed	Order #10013 for nirmalaterrence@gmail.com changed to processing.	{"user_id": 44, "order_id": 10013, "new_status": "processing", "old_status": "pending"}	f	2025-12-23 21:14:07.138+00	\N	\N
152	order_created	New order created	User Anvita Biswal placed Order #10014	{"user_id": 45, "order_id": 10014}	t	2025-12-24 20:44:49.294+00	\N	\N
153	order_created	Your order has been placed	Order #10014 was successfully created.	{"order_id": 10014}	t	2025-12-24 20:44:49.289+00	\N	45
154	user_signup	New User Registration	Anvita Biswal (kim.seo.yoon1993@gmail.com) has signed up.	{"user_id": 45, "user_name": "Anvita Biswal", "user_email": "kim.seo.yoon1993@gmail.com"}	t	2025-12-24 20:41:37.023+00	\N	\N
155	order_status_change	Order Status Updated	Your order #10013 status changed to cancelled.	{"order_id": 10013, "new_status": "cancelled", "old_status": "processing"}	f	2025-12-25 12:49:22.195+00	\N	44
156	order_status_change	Order Status Changed	Order #10013 for nirmalaterrence@gmail.com changed to cancelled.	{"user_id": 44, "order_id": 10013, "new_status": "cancelled", "old_status": "processing"}	f	2025-12-25 12:49:22.2+00	\N	\N
157	user_signup	New User Registration	Aravind R (bh1ezy17m@mozmail.com) has signed up.	{"user_id": 46, "user_name": "Aravind R", "user_email": "bh1ezy17m@mozmail.com"}	t	2025-12-25 12:42:49.373+00	\N	\N
158	order_status_change	Order Status Updated	Your order #10014 status changed to processing.	{"order_id": 10014, "new_status": "processing", "old_status": "pending"}	f	2025-12-25 16:58:29.925+00	\N	45
159	order_status_change	Order Status Changed	Order #10014 for kim.seo.yoon1993@gmail.com changed to processing.	{"user_id": 45, "order_id": 10014, "new_status": "processing", "old_status": "pending"}	f	2025-12-25 16:58:29.943+00	\N	\N
160	order_status_change	Order Status Updated	Your order #10012 status changed to cancelled.	{"order_id": 10012, "new_status": "cancelled", "old_status": "pending"}	f	2025-12-25 16:58:37.274+00	\N	42
161	order_status_change	Order Status Changed	Order #10012 for roshroshan786@gmail.com changed to cancelled.	{"user_id": 42, "order_id": 10012, "new_status": "cancelled", "old_status": "pending"}	f	2025-12-25 16:58:37.279+00	\N	\N
162	order_created	New order created	User Jennifer Paynter placed Order #10015	{"user_id": 47, "order_id": 10015}	t	2025-12-26 09:33:21.327+00	\N	\N
163	order_created	Your order has been placed	Order #10015 was successfully created.	{"order_id": 10015}	t	2025-12-26 09:33:21.322+00	\N	47
164	user_signup	New User Registration	k pavan (pavankoneti161@gmail.com) has signed up.	{"user_id": 48, "user_name": "k pavan", "user_email": "pavankoneti161@gmail.com"}	t	2025-12-29 23:30:20.264+00	\N	\N
165	user_signup	New User Registration	Jennifer Paynter (jen_4everhere@yahoo.com) has signed up.	{"user_id": 47, "user_name": "Jennifer Paynter", "user_email": "jen_4everhere@yahoo.com"}	t	2025-12-26 09:24:33.757+00	\N	\N
166	order_status_change	Order Status Updated	Your order #10015 status changed to processing.	{"order_id": 10015, "new_status": "processing", "old_status": "pending"}	f	2025-12-27 18:48:19.427+00	\N	47
167	order_status_change	Order Status Changed	Order #10015 for jen_4everhere@yahoo.com changed to processing.	{"user_id": 47, "order_id": 10015, "new_status": "processing", "old_status": "pending"}	f	2025-12-27 18:48:19.44+00	\N	\N
168	order_created	Your order has been placed	Order #34 was successfully created.	{"order_id": 34}	t	2026-01-06 19:22:47.16251+00	2026-01-15 20:46:42.585036+00	45
169	order_created	New order created	User k pavan placed Order #34	{"user_id": 45, "order_id": 34}	t	2026-01-06 19:22:47.298362+00	2026-01-15 20:46:42.585036+00	\N
170	user_signup	New User Registration	k pavan (pavankoneti1@gmail.com) has signed up.	{"user_id": 46, "user_name": "k pavan", "user_email": "pavankoneti1@gmail.com"}	t	2026-01-07 17:39:05.44217+00	2026-01-15 20:46:42.585036+00	\N
171	low_stock	Low Stock Alert	Product 'Peperomia Raisinet' is running low on stock (4 left).	{"stock": 4, "product_id": 31, "product_name": "Peperomia Raisinet"}	t	2026-01-07 18:48:31.012346+00	2026-01-15 20:46:42.585036+00	\N
172	low_stock	Low Stock Alert	Product 'Peperomia Raisinet' is running low on stock (2 left).	{"stock": 2, "product_id": 53, "product_name": "Peperomia Raisinet"}	t	2026-01-07 18:48:31.326295+00	2026-01-15 20:46:42.585036+00	\N
173	low_stock	Low Stock Alert	Product 'Peperomia Raisinet' is running low on stock (0 left).	{"stock": 0, "product_id": 54, "product_name": "Peperomia Raisinet"}	t	2026-01-07 18:48:32.124401+00	2026-01-15 20:46:42.585036+00	\N
174	low_stock	Low Stock Alert	Product 'Peperomia Raisinet' is running low on stock (4 left).	{"stock": 4, "product_id": 31, "product_name": "Peperomia Raisinet"}	t	2026-01-07 18:50:46.362774+00	2026-01-15 20:46:42.585036+00	\N
175	low_stock	Low Stock Alert	Product 'Peperomia Raisinet' is running low on stock (2 left).	{"stock": 2, "product_id": 53, "product_name": "Peperomia Raisinet"}	t	2026-01-07 18:50:46.678823+00	2026-01-15 20:46:42.585036+00	\N
176	low_stock	Low Stock Alert	Product 'Peperomia Raisinet' is running low on stock (4 left).	{"stock": 4, "product_id": 31, "product_name": "Peperomia Raisinet"}	t	2026-01-07 18:51:21.963603+00	2026-01-15 20:46:42.585036+00	\N
177	low_stock	Low Stock Alert	Product 'Peperomia Raisinet' is running low on stock (2 left).	{"stock": 2, "product_id": 53, "product_name": "Peperomia Raisinet"}	t	2026-01-07 18:51:22.304312+00	2026-01-15 20:46:42.585036+00	\N
178	low_stock	Low Stock Alert	Product 'Peperomia Raisinet' is running low on stock (4 left).	{"stock": 4, "product_id": 31, "product_name": "Peperomia Raisinet"}	t	2026-01-07 19:01:59.866621+00	2026-01-15 20:46:42.585036+00	\N
179	low_stock	Low Stock Alert	Product 'Peperomia Raisinet' is running low on stock (2 left).	{"stock": 2, "product_id": 53, "product_name": "Peperomia Raisinet"}	t	2026-01-07 19:02:00.140005+00	2026-01-15 20:46:42.585036+00	\N
180	low_stock	Low Stock Alert	Product 'Peperomia Raisinet' is running low on stock (0 left).	{"stock": 0, "product_id": 55, "product_name": "Peperomia Raisinet"}	t	2026-01-07 19:02:00.797577+00	2026-01-15 20:46:42.585036+00	\N
181	order_created	Your order has been placed	Order #35 was successfully created.	{"order_id": 35}	t	2026-01-08 17:50:14.524955+00	2026-01-15 20:46:42.585036+00	45
182	order_created	New order created	User k pavan placed Order #35	{"user_id": 45, "order_id": 35}	t	2026-01-08 17:50:14.659549+00	2026-01-15 20:46:42.585036+00	\N
183	low_stock	Low Stock Alert	Product 'Peperomia Raisinet' is running low on stock (4 left).	{"stock": 4, "product_id": 31, "product_name": "Peperomia Raisinet"}	t	2026-01-08 18:49:57.995444+00	2026-01-15 20:46:42.585036+00	\N
184	low_stock	Low Stock Alert	Product 'Peperomia Raisinet' is running low on stock (2 left).	{"stock": 2, "product_id": 53, "product_name": "Peperomia Raisinet"}	t	2026-01-08 18:49:58.163343+00	2026-01-15 20:46:42.585036+00	\N
185	low_stock	Low Stock Alert	Product 'Peperomia Raisinet' is running low on stock (0 left).	{"stock": 0, "product_id": 55, "product_name": "Peperomia Raisinet"}	t	2026-01-08 18:49:58.295412+00	2026-01-15 20:46:42.585036+00	\N
186	low_stock	Low Stock Alert	Product 'Peperomia Raisinet' is running low on stock (0 left).	{"stock": 0, "product_id": 56, "product_name": "Peperomia Raisinet"}	t	2026-01-08 18:49:58.785858+00	2026-01-15 20:46:42.585036+00	\N
187	low_stock	Low Stock Alert	Product 'Pothos scandens (One Plant)' is running low on stock (0 left).	{"stock": 0, "product_id": 1, "product_name": "Pothos scandens (One Plant)"}	t	2026-01-08 19:20:19.773239+00	2026-01-15 20:46:42.585036+00	\N
188	low_stock	Low Stock Alert	Product 'Pothos scandens (One Plant)' is running low on stock (0 left).	{"stock": 0, "product_id": 1, "product_name": "Pothos scandens (One Plant)"}	t	2026-01-08 19:24:52.556726+00	2026-01-15 20:46:42.585036+00	\N
189	low_stock	Low Stock Alert	Product 'test plant' is running low on stock (0 left).	{"stock": 0, "product_id": 0, "product_name": "test plant"}	t	2026-01-09 18:08:47.619859+00	2026-01-15 20:46:42.585036+00	\N
190	low_stock	Low Stock Alert	Product 'test plant' is running low on stock (0 left).	{"stock": 0, "product_id": 0, "product_name": "test plant"}	t	2026-01-09 18:09:53.657813+00	2026-01-15 20:46:42.585036+00	\N
191	low_stock	Low Stock Alert	Product 'test plant' is running low on stock (0 left).	{"stock": 0, "product_id": 0, "product_name": "test plant"}	t	2026-01-09 18:13:07.475131+00	2026-01-15 20:46:42.585036+00	\N
192	low_stock	Low Stock Alert	Product 'test plant' is running low on stock (0 left).	{"stock": 0, "product_id": 0, "product_name": "test plant"}	t	2026-01-09 18:23:41.502619+00	2026-01-15 20:46:42.585036+00	\N
193	low_stock	Low Stock Alert	Product 'test plant' is running low on stock (0 left).	{"stock": 0, "product_id": 0, "product_name": "test plant"}	t	2026-01-09 18:24:27.064783+00	2026-01-15 20:46:42.585036+00	\N
194	low_stock	Low Stock Alert	Product 'test plant' is running low on stock (0 left).	{"stock": 0, "product_id": 0, "product_name": "test plant"}	t	2026-01-09 18:25:05.074412+00	2026-01-15 20:46:42.585036+00	\N
195	low_stock	Low Stock Alert	Product 'test plant' is running low on stock (0 left).	{"stock": 0, "product_id": 0, "product_name": "test plant"}	t	2026-01-09 18:26:31.613022+00	2026-01-15 20:46:42.585036+00	\N
197	order_created	New order created	User mahesh babu placed Order #36	{"user_id": 7, "order_id": 36}	t	2026-01-19 19:09:15.420314+00	\N	\N
196	order_created	Your order has been placed	Order #36 was successfully created.	{"order_id": 36}	t	2026-01-19 19:09:15.412375+00	\N	7
198	order_created	Your order has been placed	Order #37 was successfully created.	{"order_id": 37}	t	2026-01-20 17:34:01.691105+00	2026-01-20 17:38:01.784867+00	7
199	order_created	New order created	User mahesh babu placed Order #37	{"user_id": 7, "order_id": 37}	t	2026-01-20 17:34:01.698818+00	2026-01-20 17:38:01.784867+00	\N
200	order_created	Your order has been placed	Order #38 was successfully created.	{"order_id": 38}	t	2026-01-20 17:36:20.559279+00	2026-01-20 17:38:01.784867+00	7
201	order_created	New order created	User mahesh babu placed Order #38	{"user_id": 7, "order_id": 38}	t	2026-01-20 17:36:20.562908+00	2026-01-20 17:38:01.784867+00	\N
202	order_created	Your order has been placed	Order #39 was successfully created.	{"order_id": 39}	t	2026-01-20 17:39:28.961453+00	2026-01-20 17:50:22.66077+00	7
203	order_created	New order created	User mahesh babu placed Order #39	{"user_id": 7, "order_id": 39}	t	2026-01-20 17:39:28.965086+00	2026-01-20 17:50:22.66077+00	\N
204	order_created	Your order has been placed	Order #40 was successfully created.	{"order_id": 40}	t	2026-01-20 17:45:58.775226+00	2026-01-20 17:50:22.66077+00	7
205	order_created	New order created	User mahesh babu placed Order #40	{"user_id": 7, "order_id": 40}	t	2026-01-20 17:45:58.77921+00	2026-01-20 17:50:22.66077+00	\N
206	order_created	Your order has been placed	Order #41 was successfully created.	{"order_id": 41}	t	2026-01-20 17:50:33.174703+00	2026-01-21 03:11:12.594833+00	7
207	order_created	New order created	User mahesh babu placed Order #41	{"user_id": 7, "order_id": 41}	t	2026-01-20 17:50:33.178893+00	2026-01-21 03:11:12.594833+00	\N
208	order_created	Your order has been placed	Order #42 was successfully created.	{"order_id": 42}	t	2026-01-20 18:09:04.436989+00	2026-01-21 03:11:12.594833+00	7
209	order_created	New order created	User mahesh babu placed Order #42	{"user_id": 7, "order_id": 42}	t	2026-01-20 18:09:04.464428+00	2026-01-21 03:11:12.594833+00	\N
210	order_created	Your order has been placed	Order #43 was successfully created.	{"order_id": 43}	t	2026-01-21 02:46:25.101017+00	2026-01-21 03:11:12.594833+00	7
211	order_created	New order created	User mahesh babu placed Order #43	{"user_id": 7, "order_id": 43}	t	2026-01-21 02:46:25.114827+00	2026-01-21 03:11:12.594833+00	\N
212	order_created	Your order has been placed	Order #44 was successfully created.	{"order_id": 44}	f	2026-01-22 11:34:59.415815+00	\N	7
213	order_created	New order created	User mahesh babu placed Order #44	{"user_id": 7, "order_id": 44}	f	2026-01-22 11:34:59.424886+00	\N	\N
214	order_created	Your order has been placed	Order #45 was successfully created.	{"order_id": 45}	f	2026-01-22 11:41:10.575142+00	\N	7
215	order_created	New order created	User mahesh babu placed Order #45	{"user_id": 7, "order_id": 45}	f	2026-01-22 11:41:10.582834+00	\N	\N
216	order_created	Your order has been placed	Order #46 was successfully created.	{"order_id": 46}	f	2026-01-25 16:51:52.277737+00	\N	45
217	order_created	New order created	User k pavan placed Order #46	{"user_id": 45, "order_id": 46}	f	2026-01-25 16:51:52.453043+00	\N	\N
218	order_created	Your order has been placed	Order #47 was successfully created.	{"order_id": 47}	f	2026-01-25 16:52:21.84479+00	\N	45
219	order_created	New order created	User k pavan placed Order #47	{"user_id": 45, "order_id": 47}	f	2026-01-25 16:52:21.932495+00	\N	\N
220	order_created	Your order has been placed	Order #48 was successfully created.	{"order_id": 48}	f	2026-01-25 16:52:38.264388+00	\N	45
221	order_created	New order created	User k pavan placed Order #48	{"user_id": 45, "order_id": 48}	f	2026-01-25 16:52:38.341673+00	\N	\N
222	order_created	Your order has been placed	Order #49 was successfully created.	{"order_id": 49}	f	2026-01-25 16:54:23.892286+00	\N	45
223	order_created	New order created	User k pavan placed Order #49	{"user_id": 45, "order_id": 49}	f	2026-01-25 16:54:23.981295+00	\N	\N
224	order_created	Your order has been placed	Order #50 was successfully created.	{"order_id": 50}	f	2026-01-25 16:56:25.697974+00	\N	45
225	order_created	New order created	User k pavan placed Order #50	{"user_id": 45, "order_id": 50}	f	2026-01-25 16:56:25.789357+00	\N	\N
226	order_created	Your order has been placed	Order #51 was successfully created.	{"order_id": 51}	f	2026-01-25 17:00:01.061465+00	\N	45
227	order_created	New order created	User k pavan placed Order #51	{"user_id": 45, "order_id": 51}	f	2026-01-25 17:00:01.141292+00	\N	\N
228	order_created	Your order has been placed	Order #52 was successfully created.	{"order_id": 52}	f	2026-01-25 17:05:35.285468+00	\N	45
231	order_created	New order created	User k pavan placed Order #53	{"user_id": 45, "order_id": 53}	f	2026-01-25 17:07:16.486692+00	\N	\N
232	order_created	Your order has been placed	Order #54 was successfully created.	{"order_id": 54}	f	2026-01-25 17:13:25.09101+00	\N	45
233	order_created	New order created	User k pavan placed Order #54	{"user_id": 45, "order_id": 54}	f	2026-01-25 17:13:25.164738+00	\N	\N
234	order_created	Your order has been placed	Order #55 was successfully created.	{"order_id": 55}	f	2026-01-25 17:16:02.627506+00	\N	45
235	order_created	New order created	User k pavan placed Order #55	{"user_id": 45, "order_id": 55}	f	2026-01-25 17:16:02.7261+00	\N	\N
236	order_created	Your order has been placed	Order #56 was successfully created.	{"order_id": 56}	f	2026-01-25 17:31:22.748162+00	\N	45
237	order_created	New order created	User k pavan placed Order #56	{"user_id": 45, "order_id": 56}	f	2026-01-25 17:31:22.82079+00	\N	\N
238	order_created	Your order has been placed	Order #57 was successfully created.	{"order_id": 57}	f	2026-01-25 17:33:47.30949+00	\N	45
239	order_created	New order created	User k pavan placed Order #57	{"user_id": 45, "order_id": 57}	f	2026-01-25 17:33:47.395078+00	\N	\N
240	order_created	Your order has been placed	Order #58 was successfully created.	{"order_id": 58}	f	2026-01-25 17:41:49.412554+00	\N	45
241	order_created	New order created	User k pavan placed Order #58	{"user_id": 45, "order_id": 58}	f	2026-01-25 17:41:49.493846+00	\N	\N
242	order_created	Your order has been placed	Order #59 was successfully created.	{"order_id": 59}	f	2026-01-25 17:44:04.903374+00	\N	45
243	order_created	New order created	User k pavan placed Order #59	{"user_id": 45, "order_id": 59}	f	2026-01-25 17:44:04.987092+00	\N	\N
244	order_created	Your order has been placed	Order #60 was successfully created.	{"order_id": 60}	f	2026-01-25 18:22:52.241781+00	\N	45
245	order_created	New order created	User k pavan placed Order #60	{"user_id": 45, "order_id": 60}	f	2026-01-25 18:22:52.325324+00	\N	\N
246	order_created	Your order has been placed	Order #61 was successfully created.	{"order_id": 61}	f	2026-01-25 18:28:12.349699+00	\N	45
247	order_created	New order created	User k pavan placed Order #61	{"user_id": 45, "order_id": 61}	f	2026-01-25 18:28:12.498004+00	\N	\N
248	order_created	Your order has been placed	Order #62 was successfully created.	{"order_id": 62}	f	2026-01-25 18:30:18.417907+00	\N	45
249	order_created	New order created	User k pavan placed Order #62	{"user_id": 45, "order_id": 62}	f	2026-01-25 18:30:19.858146+00	\N	\N
250	order_created	Your order has been placed	Order #63 was successfully created.	{"order_id": 63}	f	2026-01-25 18:30:37.379329+00	\N	45
251	order_created	New order created	User k pavan placed Order #63	{"user_id": 45, "order_id": 63}	f	2026-01-25 18:30:37.483528+00	\N	\N
252	order_created	Your order has been placed	Order #64 was successfully created.	{"order_id": 64}	f	2026-01-25 18:33:33.254537+00	\N	45
253	order_created	New order created	User k pavan placed Order #64	{"user_id": 45, "order_id": 64}	f	2026-01-25 18:33:33.42563+00	\N	\N
254	order_created	Your order has been placed	Order #65 was successfully created.	{"order_id": 65}	f	2026-01-25 18:34:05.981834+00	\N	45
255	order_created	New order created	User k pavan placed Order #65	{"user_id": 45, "order_id": 65}	f	2026-01-25 18:34:06.131035+00	\N	\N
256	order_created	Your order has been placed	Order #66 was successfully created.	{"order_id": 66}	f	2026-01-25 18:37:54.418269+00	\N	45
257	order_created	New order created	User k pavan placed Order #66	{"user_id": 45, "order_id": 66}	f	2026-01-25 18:37:54.491297+00	\N	\N
258	order_created	Your order has been placed	Order #67 was successfully created.	{"order_id": 67}	f	2026-01-25 18:38:22.900703+00	\N	45
259	order_created	New order created	User k pavan placed Order #67	{"user_id": 45, "order_id": 67}	f	2026-01-25 18:38:23.000571+00	\N	\N
260	order_created	Your order has been placed	Order #68 was successfully created.	{"order_id": 68}	f	2026-01-25 18:42:23.982794+00	\N	45
261	order_created	New order created	User k pavan placed Order #68	{"user_id": 45, "order_id": 68}	f	2026-01-25 18:42:24.076628+00	\N	\N
262	order_created	Your order has been placed	Order #69 was successfully created.	{"order_id": 69}	f	2026-01-25 18:42:42.795887+00	\N	45
263	order_created	New order created	User k pavan placed Order #69	{"user_id": 45, "order_id": 69}	f	2026-01-25 18:42:42.872379+00	\N	\N
264	order_created	Your order has been placed	Order #70 was successfully created.	{"order_id": 70}	f	2026-01-25 18:44:25.515932+00	\N	45
265	order_created	New order created	User k pavan placed Order #70	{"user_id": 45, "order_id": 70}	f	2026-01-25 18:44:25.614713+00	\N	\N
266	order_created	Your order has been placed	Order #71 was successfully created.	{"order_id": 71}	f	2026-01-25 18:45:16.319+00	\N	45
267	order_created	New order created	User k pavan placed Order #71	{"user_id": 45, "order_id": 71}	f	2026-01-25 18:45:16.418661+00	\N	\N
268	order_created	Your order has been placed	Order #72 was successfully created.	{"order_id": 72}	f	2026-01-26 14:15:09.714276+00	\N	45
269	order_created	New order created	User k pavan placed Order #72	{"user_id": 45, "order_id": 72}	f	2026-01-26 14:15:09.822698+00	\N	\N
270	order_created	Your order has been placed	Order #73 was successfully created.	{"order_id": 73}	f	2026-01-26 14:17:56.48801+00	\N	45
271	order_created	New order created	User k pavan placed Order #73	{"user_id": 45, "order_id": 73}	f	2026-01-26 14:17:56.584218+00	\N	\N
272	order_created	Your order has been placed	Order #74 was successfully created.	{"order_id": 74}	f	2026-01-26 14:19:00.81157+00	\N	45
273	order_created	New order created	User k pavan placed Order #74	{"user_id": 45, "order_id": 74}	f	2026-01-26 14:19:00.900376+00	\N	\N
274	order_created	Your order has been placed	Order #75 was successfully created.	{"order_id": 75}	f	2026-01-26 14:23:53.764562+00	\N	45
275	order_created	New order created	User k pavan placed Order #75	{"user_id": 45, "order_id": 75}	f	2026-01-26 14:23:53.845282+00	\N	\N
276	order_created	Your order has been placed	Order #76 was successfully created.	{"order_id": 76}	f	2026-01-26 14:24:34.099422+00	\N	45
277	order_created	New order created	User k pavan placed Order #76	{"user_id": 45, "order_id": 76}	f	2026-01-26 14:24:34.204133+00	\N	\N
278	order_created	Your order has been placed	Order #77 was successfully created.	{"order_id": 77}	f	2026-01-26 14:25:03.846774+00	\N	45
279	order_created	New order created	User k pavan placed Order #77	{"user_id": 45, "order_id": 77}	f	2026-01-26 14:25:03.92956+00	\N	\N
280	order_created	Your order has been placed	Order #78 was successfully created.	{"order_id": 78}	f	2026-01-26 14:39:40.924115+00	\N	45
281	order_created	New order created	User k pavan placed Order #78	{"user_id": 45, "order_id": 78}	f	2026-01-26 14:39:41.002258+00	\N	\N
282	order_created	Your order has been placed	Order #79 was successfully created.	{"order_id": 79}	f	2026-01-26 14:43:13.152825+00	\N	45
283	order_created	New order created	User k pavan placed Order #79	{"user_id": 45, "order_id": 79}	f	2026-01-26 14:43:13.218475+00	\N	\N
284	order_created	Your order has been placed	Order #80 was successfully created.	{"order_id": 80}	f	2026-01-26 14:44:55.325327+00	\N	45
285	order_created	New order created	User k pavan placed Order #80	{"user_id": 45, "order_id": 80}	f	2026-01-26 14:44:55.41442+00	\N	\N
286	order_created	Your order has been placed	Order #81 was successfully created.	{"order_id": 81}	f	2026-01-26 14:46:25.039581+00	\N	45
287	order_created	New order created	User k pavan placed Order #81	{"user_id": 45, "order_id": 81}	f	2026-01-26 14:46:25.139022+00	\N	\N
288	order_created	Your order has been placed	Order #82 was successfully created.	{"order_id": 82}	f	2026-01-26 14:53:07.731183+00	\N	45
289	order_created	New order created	User k pavan placed Order #82	{"user_id": 45, "order_id": 82}	f	2026-01-26 14:53:07.809055+00	\N	\N
290	order_created	Your order has been placed	Order #83 was successfully created.	{"order_id": 83}	f	2026-01-26 14:53:49.053907+00	\N	45
291	order_created	New order created	User k pavan placed Order #83	{"user_id": 45, "order_id": 83}	f	2026-01-26 14:53:49.129714+00	\N	\N
292	order_created	Your order has been placed	Order #84 was successfully created.	{"order_id": 84}	f	2026-01-26 14:59:21.700275+00	\N	45
293	order_created	New order created	User k pavan placed Order #84	{"user_id": 45, "order_id": 84}	f	2026-01-26 14:59:21.7986+00	\N	\N
294	order_created	Your order has been placed	Order #85 was successfully created.	{"order_id": 85}	f	2026-01-26 15:00:15.271298+00	\N	45
295	order_created	New order created	User k pavan placed Order #85	{"user_id": 45, "order_id": 85}	f	2026-01-26 15:00:15.364895+00	\N	\N
296	order_created	Your order has been placed	Order #86 was successfully created.	{"order_id": 86}	f	2026-01-26 15:02:25.084972+00	\N	45
297	order_created	New order created	User k pavan placed Order #86	{"user_id": 45, "order_id": 86}	f	2026-01-26 15:02:25.179432+00	\N	\N
298	order_created	Your order has been placed	Order #87 was successfully created.	{"order_id": 87}	f	2026-01-26 15:08:30.51667+00	\N	45
299	order_created	New order created	User k pavan placed Order #87	{"user_id": 45, "order_id": 87}	f	2026-01-26 15:08:30.585377+00	\N	\N
300	order_created	Your order has been placed	Order #88 was successfully created.	{"order_id": 88}	f	2026-01-26 16:11:36.438856+00	\N	45
301	order_created	New order created	User k pavan placed Order #88	{"user_id": 45, "order_id": 88}	f	2026-01-26 16:11:36.536147+00	\N	\N
302	order_created	Your order has been placed	Order #89 was successfully created.	{"order_id": 89}	f	2026-01-26 16:15:14.852295+00	\N	45
303	order_created	New order created	User k pavan placed Order #89	{"user_id": 45, "order_id": 89}	f	2026-01-26 16:15:14.952119+00	\N	\N
304	order_created	Your order has been placed	Order #90 was successfully created.	{"order_id": 90}	f	2026-01-26 16:16:57.826463+00	\N	45
305	order_created	New order created	User k pavan placed Order #90	{"user_id": 45, "order_id": 90}	f	2026-01-26 16:16:57.910102+00	\N	\N
306	order_created	Your order has been placed	Order #91 was successfully created.	{"order_id": 91}	f	2026-01-26 16:19:50.170483+00	\N	45
307	order_created	New order created	User k pavan placed Order #91	{"user_id": 45, "order_id": 91}	f	2026-01-26 16:19:50.269008+00	\N	\N
308	order_created	Your order has been placed	Order #92 was successfully created.	{"order_id": 92}	f	2026-01-26 17:46:54.605974+00	\N	45
309	order_created	New order created	User k pavan placed Order #92	{"user_id": 45, "order_id": 92}	f	2026-01-26 17:46:54.708187+00	\N	\N
310	order_created	Your order has been placed	Order #93 was successfully created.	{"order_id": 93}	f	2026-01-26 17:50:00.339844+00	\N	45
311	order_created	New order created	User k pavan placed Order #93	{"user_id": 45, "order_id": 93}	f	2026-01-26 17:50:00.412826+00	\N	\N
312	order_created	Your order has been placed	Order #94 was successfully created.	{"order_id": 94}	f	2026-01-26 17:50:51.149748+00	\N	45
313	order_created	New order created	User k pavan placed Order #94	{"user_id": 45, "order_id": 94}	f	2026-01-26 17:50:51.233818+00	\N	\N
314	order_created	Your order has been placed	Order #95 was successfully created.	{"order_id": 95}	f	2026-01-26 18:06:19.374543+00	\N	45
315	order_created	New order created	User k pavan placed Order #95	{"user_id": 45, "order_id": 95}	f	2026-01-26 18:06:19.460152+00	\N	\N
316	order_created	Your order has been placed	Order #96 was successfully created.	{"order_id": 96}	f	2026-01-26 18:09:39.277436+00	\N	45
317	order_created	New order created	User k pavan placed Order #96	{"user_id": 45, "order_id": 96}	f	2026-01-26 18:09:39.353987+00	\N	\N
318	order_created	Your order has been placed	Order #97 was successfully created.	{"order_id": 97}	f	2026-01-26 18:12:39.283855+00	\N	45
319	order_created	New order created	User k pavan placed Order #97	{"user_id": 45, "order_id": 97}	f	2026-01-26 18:12:39.367523+00	\N	\N
320	order_created	Your order has been placed	Order #98 was successfully created.	{"order_id": 98}	f	2026-01-26 18:13:37.457324+00	\N	45
321	order_created	New order created	User k pavan placed Order #98	{"user_id": 45, "order_id": 98}	f	2026-01-26 18:13:37.541374+00	\N	\N
322	order_created	Your order has been placed	Order #99 was successfully created.	{"order_id": 99}	f	2026-01-26 18:15:19.561083+00	\N	45
323	order_created	New order created	User k pavan placed Order #99	{"user_id": 45, "order_id": 99}	f	2026-01-26 18:15:19.659643+00	\N	\N
324	order_created	Your order has been placed	Order #100 was successfully created.	{"order_id": 100}	f	2026-01-26 18:16:17.930686+00	\N	45
325	order_created	New order created	User k pavan placed Order #100	{"user_id": 45, "order_id": 100}	f	2026-01-26 18:16:17.997352+00	\N	\N
326	order_created	Your order has been placed	Order #101 was successfully created.	{"order_id": 101}	f	2026-01-26 18:21:00.111391+00	\N	45
327	order_created	New order created	User k pavan placed Order #101	{"user_id": 45, "order_id": 101}	f	2026-01-26 18:21:00.195759+00	\N	\N
328	order_created	Your order has been placed	Order #102 was successfully created.	{"order_id": 102}	f	2026-01-26 18:22:46.005251+00	\N	45
329	order_created	New order created	User k pavan placed Order #102	{"user_id": 45, "order_id": 102}	f	2026-01-26 18:22:46.090429+00	\N	\N
330	order_created	Your order has been placed	Order #103 was successfully created.	{"order_id": 103}	f	2026-01-26 18:24:03.954477+00	\N	45
331	order_created	New order created	User k pavan placed Order #103	{"user_id": 45, "order_id": 103}	f	2026-01-26 18:24:04.037856+00	\N	\N
332	order_created	Your order has been placed	Order #104 was successfully created.	{"order_id": 104}	f	2026-01-26 18:31:19.143393+00	\N	45
333	order_created	New order created	User k pavan placed Order #104	{"user_id": 45, "order_id": 104}	f	2026-01-26 18:31:19.266266+00	\N	\N
334	order_created	Your order has been placed	Order #105 was successfully created.	{"order_id": 105}	f	2026-01-26 18:35:06.843239+00	\N	45
335	order_created	New order created	User k pavan placed Order #105	{"user_id": 45, "order_id": 105}	f	2026-01-26 18:35:06.943558+00	\N	\N
336	order_created	Your order has been placed	Order #106 was successfully created.	{"order_id": 106}	f	2026-01-28 06:06:21.318299+00	\N	45
337	order_created	New order created	User k pavan placed Order #106	{"user_id": 45, "order_id": 106}	f	2026-01-28 06:06:21.424585+00	\N	\N
338	order_created	Your order has been placed	Order #107 was successfully created.	{"order_id": 107}	f	2026-01-28 06:07:56.439223+00	\N	45
339	order_created	New order created	User k pavan placed Order #107	{"user_id": 45, "order_id": 107}	f	2026-01-28 06:07:56.829599+00	\N	\N
340	order_created	Your order has been placed	Order #108 was successfully created.	{"order_id": 108}	f	2026-01-28 06:12:04.199623+00	\N	45
341	order_created	New order created	User k pavan placed Order #108	{"user_id": 45, "order_id": 108}	f	2026-01-28 06:12:04.316559+00	\N	\N
342	order_created	Your order has been placed	Order #109 was successfully created.	{"order_id": 109}	f	2026-01-28 06:12:51.58718+00	\N	45
343	order_created	New order created	User k pavan placed Order #109	{"user_id": 45, "order_id": 109}	f	2026-01-28 06:12:51.683517+00	\N	\N
344	low_stock	Low Stock Alert	Product 'Peperomia Raisinet' is running low on stock (2 left).	{"stock": 2, "product_id": 31, "product_name": "Peperomia Raisinet"}	f	2026-01-30 05:47:49.564997+00	\N	\N
345	low_stock	Low Stock Alert	Product 'Peperomia Raisinet' is running low on stock (0 left).	{"stock": 0, "product_id": 53, "product_name": "Peperomia Raisinet"}	f	2026-01-30 05:47:50.140302+00	\N	\N
346	low_stock	Low Stock Alert	Product 'Peperomia Raisinet' is running low on stock (0 left).	{"stock": 0, "product_id": 55, "product_name": "Peperomia Raisinet"}	f	2026-01-30 05:47:50.516073+00	\N	\N
347	low_stock	Low Stock Alert	Product 'Peperomia Raisinet' is running low on stock (0 left).	{"stock": 0, "product_id": 56, "product_name": "Peperomia Raisinet"}	f	2026-01-30 05:47:51.752091+00	\N	\N
348	low_stock	Low Stock Alert	Product 'Peperomia Raisinet' is running low on stock (2 left).	{"stock": 2, "product_id": 31, "product_name": "Peperomia Raisinet"}	f	2026-01-30 05:47:53.437349+00	\N	\N
349	low_stock	Low Stock Alert	Product 'Peperomia Raisinet' is running low on stock (0 left).	{"stock": 0, "product_id": 53, "product_name": "Peperomia Raisinet"}	f	2026-01-30 05:47:53.617931+00	\N	\N
350	low_stock	Low Stock Alert	Product 'Peperomia Raisinet' is running low on stock (0 left).	{"stock": 0, "product_id": 55, "product_name": "Peperomia Raisinet"}	f	2026-01-30 05:47:53.777881+00	\N	\N
351	low_stock	Low Stock Alert	Product 'Peperomia Raisinet' is running low on stock (0 left).	{"stock": 0, "product_id": 56, "product_name": "Peperomia Raisinet"}	f	2026-01-30 05:47:53.955946+00	\N	\N
352	low_stock	Low Stock Alert	Product 'Peperomia Raisinet' is running low on stock (2 left).	{"stock": 2, "product_id": 31, "product_name": "Peperomia Raisinet"}	f	2026-01-30 05:48:41.746661+00	\N	\N
353	low_stock	Low Stock Alert	Product 'Peperomia Raisinet' is running low on stock (0 left).	{"stock": 0, "product_id": 53, "product_name": "Peperomia Raisinet"}	f	2026-01-30 05:48:43.852402+00	\N	\N
354	low_stock	Low Stock Alert	Product 'Peperomia Raisinet' is running low on stock (0 left).	{"stock": 0, "product_id": 55, "product_name": "Peperomia Raisinet"}	f	2026-01-30 05:48:46.927481+00	\N	\N
355	low_stock	Low Stock Alert	Product 'Peperomia Raisinet' is running low on stock (0 left).	{"stock": 0, "product_id": 56, "product_name": "Peperomia Raisinet"}	f	2026-01-30 05:48:49.183182+00	\N	\N
356	low_stock	Low Stock Alert	Product 'Peperomia Raisinet' is running low on stock (2 left).	{"stock": 2, "product_id": 31, "product_name": "Peperomia Raisinet"}	f	2026-01-30 05:50:13.412693+00	\N	\N
357	low_stock	Low Stock Alert	Product 'Peperomia Raisinet' is running low on stock (0 left).	{"stock": 0, "product_id": 53, "product_name": "Peperomia Raisinet"}	f	2026-01-30 05:50:15.000619+00	\N	\N
358	low_stock	Low Stock Alert	Product 'Peperomia Raisinet' is running low on stock (0 left).	{"stock": 0, "product_id": 55, "product_name": "Peperomia Raisinet"}	f	2026-01-30 05:50:17.167703+00	\N	\N
359	low_stock	Low Stock Alert	Product 'Peperomia Raisinet' is running low on stock (0 left).	{"stock": 0, "product_id": 56, "product_name": "Peperomia Raisinet"}	f	2026-01-30 05:50:20.20183+00	\N	\N
360	low_stock	Low Stock Alert	Product 'Peperomia Raisinet' is running low on stock (2 left).	{"stock": 2, "product_id": 31, "product_name": "Peperomia Raisinet"}	f	2026-01-30 05:50:55.686229+00	\N	\N
361	low_stock	Low Stock Alert	Product 'Peperomia Raisinet' is running low on stock (0 left).	{"stock": 0, "product_id": 53, "product_name": "Peperomia Raisinet"}	f	2026-01-30 05:50:58.578409+00	\N	\N
362	low_stock	Low Stock Alert	Product 'Peperomia Raisinet' is running low on stock (0 left).	{"stock": 0, "product_id": 55, "product_name": "Peperomia Raisinet"}	f	2026-01-30 05:51:00.514915+00	\N	\N
363	low_stock	Low Stock Alert	Product 'Peperomia Raisinet' is running low on stock (0 left).	{"stock": 0, "product_id": 56, "product_name": "Peperomia Raisinet"}	f	2026-01-30 05:51:02.997402+00	\N	\N
364	low_stock	Low Stock Alert	Product 'Peperomia Raisinet' is running low on stock (2 left).	{"stock": 2, "product_id": 31, "product_name": "Peperomia Raisinet"}	f	2026-01-30 05:52:14.206075+00	\N	\N
365	low_stock	Low Stock Alert	Product 'Peperomia Raisinet' is running low on stock (0 left).	{"stock": 0, "product_id": 53, "product_name": "Peperomia Raisinet"}	f	2026-01-30 05:52:16.442425+00	\N	\N
366	low_stock	Low Stock Alert	Product 'Peperomia Raisinet' is running low on stock (0 left).	{"stock": 0, "product_id": 55, "product_name": "Peperomia Raisinet"}	f	2026-01-30 05:52:19.289844+00	\N	\N
367	low_stock	Low Stock Alert	Product 'Peperomia Raisinet' is running low on stock (0 left).	{"stock": 0, "product_id": 56, "product_name": "Peperomia Raisinet"}	f	2026-01-30 05:52:22.272303+00	\N	\N
368	low_stock	Low Stock Alert	Product 'Peperomia Raisinet' is running low on stock (2 left).	{"stock": 2, "product_id": 31, "product_name": "Peperomia Raisinet"}	f	2026-01-30 05:54:10.658453+00	\N	\N
369	low_stock	Low Stock Alert	Product 'Peperomia Raisinet' is running low on stock (0 left).	{"stock": 0, "product_id": 53, "product_name": "Peperomia Raisinet"}	f	2026-01-30 05:54:13.439343+00	\N	\N
370	low_stock	Low Stock Alert	Product 'Peperomia Raisinet' is running low on stock (0 left).	{"stock": 0, "product_id": 55, "product_name": "Peperomia Raisinet"}	f	2026-01-30 05:54:16.297318+00	\N	\N
371	low_stock	Low Stock Alert	Product 'Peperomia Raisinet' is running low on stock (0 left).	{"stock": 0, "product_id": 56, "product_name": "Peperomia Raisinet"}	f	2026-01-30 05:54:19.186002+00	\N	\N
372	low_stock	Low Stock Alert	Product 'Peperomia Raisinet' is running low on stock (2 left).	{"stock": 2, "product_id": 31, "product_name": "Peperomia Raisinet"}	f	2026-01-30 05:56:59.529988+00	\N	\N
373	low_stock	Low Stock Alert	Product 'Peperomia Raisinet' is running low on stock (0 left).	{"stock": 0, "product_id": 53, "product_name": "Peperomia Raisinet"}	f	2026-01-30 05:57:01.46671+00	\N	\N
374	low_stock	Low Stock Alert	Product 'Peperomia Raisinet' is running low on stock (0 left).	{"stock": 0, "product_id": 55, "product_name": "Peperomia Raisinet"}	f	2026-01-30 05:57:03.833035+00	\N	\N
375	low_stock	Low Stock Alert	Product 'Peperomia Raisinet' is running low on stock (0 left).	{"stock": 0, "product_id": 56, "product_name": "Peperomia Raisinet"}	f	2026-01-30 05:57:06.795307+00	\N	\N
376	low_stock	Low Stock Alert	Product 'Peperomia Raisinet' is running low on stock (2 left).	{"stock": 2, "product_id": 31, "product_name": "Peperomia Raisinet"}	f	2026-01-30 05:57:30.06388+00	\N	\N
377	low_stock	Low Stock Alert	Product 'Peperomia Raisinet' is running low on stock (0 left).	{"stock": 0, "product_id": 53, "product_name": "Peperomia Raisinet"}	f	2026-01-30 05:57:34.149038+00	\N	\N
378	low_stock	Low Stock Alert	Product 'Peperomia Raisinet' is running low on stock (0 left).	{"stock": 0, "product_id": 55, "product_name": "Peperomia Raisinet"}	f	2026-01-30 05:57:34.879545+00	\N	\N
379	low_stock	Low Stock Alert	Product 'Peperomia Raisinet' is running low on stock (0 left).	{"stock": 0, "product_id": 56, "product_name": "Peperomia Raisinet"}	f	2026-01-30 05:57:35.245381+00	\N	\N
380	low_stock	Low Stock Alert	Product 'test plant' is running low on stock (0 left).	{"stock": 0, "product_id": 0, "product_name": "test plant"}	f	2026-01-30 06:09:50.939754+00	\N	\N
381	low_stock	Low Stock Alert	Product 'test plant' is running low on stock (0 left).	{"stock": 0, "product_id": 0, "product_name": "test plant"}	f	2026-01-30 06:11:29.493932+00	\N	\N
382	low_stock	Low Stock Alert	Product 'test plant' is running low on stock (0 left).	{"stock": 0, "product_id": 0, "product_name": "test plant"}	f	2026-01-30 06:13:09.105786+00	\N	\N
383	low_stock	Low Stock Alert	Product 'test plant' is running low on stock (0 left).	{"stock": 0, "product_id": 0, "product_name": "test plant"}	f	2026-01-30 06:14:29.435173+00	\N	\N
384	low_stock	Low Stock Alert	Product 'test plant' is running low on stock (1 left).	{"stock": 1, "product_id": 0, "product_name": "test plant"}	f	2026-01-30 06:14:54.843784+00	\N	\N
385	low_stock	Low Stock Alert	Product 'test plant' is running low on stock (0 left).	{"stock": 0, "product_id": 0, "product_name": "test plant"}	f	2026-01-30 06:15:24.122971+00	\N	\N
386	low_stock	Low Stock Alert	Product 'test plant' is running low on stock (0 left).	{"stock": 0, "product_id": 0, "product_name": "test plant"}	f	2026-01-30 06:16:58.647884+00	\N	\N
\.


--
-- Data for Name: core_cart; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.core_cart (id, user_id, created_at, updated_at) FROM stdin;
1	7	2026-01-20 03:19:40.244131+00	2026-01-20 03:19:40.244148+00
2	46	2026-01-20 03:19:40.244131+00	2026-01-20 03:19:40.244131+00
3	45	2026-01-25 09:57:12.811752+00	2026-01-25 09:57:12.81177+00
\.


--
-- Data for Name: core_cartitem; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.core_cartitem (id, quantity, created_at, updated_at, cart_id, product_id, variant_id) FROM stdin;
8	1	2026-01-20 17:45:55.39741+00	2026-01-22 11:37:03.787373+00	1	46	52
9	1	2026-01-20 17:45:55.40822+00	2026-01-22 11:37:04.650209+00	1	45	2
11	1	2026-01-25 11:33:30.607277+00	2026-01-25 11:33:30.607277+00	2	35	31
170	1	2026-02-08 12:42:11.498978+00	2026-02-08 12:42:11.498978+00	3	35	31
\.


--
-- Data for Name: core_category; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.core_category (id, name, slug, description, image_url, created_at, updated_at) FROM stdin;
1	Indoor Plants	indoor-plants	\N	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/Asparagus%20Fern-%20Asparagus%20Plumosus.jpeg?alt=media	2025-07-08 19:33:21.300748+00	2025-07-08 19:33:21.300768+00
2	Exotic Plants	exotic-plants	\N	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/aridarumNarrow_1.jpeg?alt=media&token=dac76d4c-fef7-4aa4-90de-1bcd122f5598	2025-06-24 22:31:21.67053+00	2025-09-05 19:10:22.905127+00
3	Terrarium Plants	terrarium-plants	\N	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/terrarium.jpeg?alt=media&token=4f30bcbe-db45-45fc-a839-83a96bdc0637	2025-06-27 13:48:35.114218+00	2025-06-27 13:48:35.114239+00
4	Rhizome plants	rhizome-plants	\N	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/rhizomecategoryimg.jpeg?alt=media&token=450c7b4f-73b4-42ab-bb6e-938dd44edc5b	2025-06-24 21:54:15.529398+00	2025-06-27 13:47:38.067837+00
5	Aquatic Plants	aquatic-plants	\N	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/categories%2Faquaticcategory02.jpeg?alt=media&token=559dddef-0b30-40b6-abbb-6929f92ceb0e	2025-09-05 19:10:08.127519+00	2025-09-05 19:11:16.760967+00
6	Moss	terrarium-moss	\N	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/chusionmoss%2Fchusionmoss01.png?alt=media&token=f90ab354-5432-4981-b63a-be93316669e7	2025-09-18 06:43:53.339149+00	2025-12-21 19:34:55.812766+00
\.


--
-- Data for Name: core_order; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.core_order (id, total_amount, shipping_cost, status, created_at, updated_at, user_id, shipping_address_id) FROM stdin;
1	750.00	150.00	cancelled	2025-11-03 07:40:22.073+00	2025-11-03 08:50:24.446+00	40	15
2	0.00	150.00	pending	2025-06-28 00:12:13.901+00	2025-06-28 00:12:13.901+00	7	1
3	500.00	150.00	pending	2025-06-28 00:13:53.368+00	2025-06-28 00:13:53.511+00	7	1
4	500.00	150.00	pending	2025-06-28 00:18:44.277+00	2025-06-28 00:18:44.285+00	7	1
5	250.00	150.00	pending	2025-08-11 00:09:08.717+00	2025-08-11 00:09:08.74+00	7	1
6	500.00	150.00	cancelled	2025-11-03 07:37:46.185+00	2025-11-03 13:26:35.494+00	40	15
7	200.00	150.00	cancelled	2025-09-06 11:13:57.372+00	2025-09-09 08:45:32.557+00	7	1
8	100.00	150.00	cancelled	2025-09-09 08:48:19.224+00	2025-09-16 21:32:27.803+00	8	1
9	1234.00	150.00	delivered	2025-06-27 17:58:23.761+00	2025-09-16 21:32:41.061+00	7	1
10	0.00	150.00	shipped	2025-06-27 23:12:00.445+00	2025-09-16 21:32:46.087+00	7	1
11	0.00	150.00	delivered	2025-06-27 23:13:08.895+00	2025-09-16 21:32:58.934+00	7	1
12	410.00	150.00	cancelled	2025-11-03 13:30:20.28+00	2025-11-04 07:43:18.223+00	41	16
13	150.00	150.00	delivered	2025-09-28 00:26:33.52+00	2025-09-29 15:01:54.234+00	7	1
14	1000.00	150.00	delivered	2025-10-09 17:07:15.1+00	2025-11-04 08:24:55.991+00	13	4
15	250.00	150.00	delivered	2025-10-07 13:21:28.41+00	2025-10-07 13:24:31.953+00	8	3
16	0.00	150.00	shipped	2025-06-27 23:12:45.519+00	2025-10-07 13:26:51.031+00	7	1
17	400.00	150.00	delivered	2025-10-31 08:39:01.899+00	2025-11-10 17:46:18.615+00	36	12
18	500.00	150.00	delivered	2025-10-29 07:43:48.903+00	2025-11-10 17:46:26.109+00	29	9
19	430.00	150.00	delivered	2025-11-02 19:10:46.985+00	2025-11-10 17:46:31.242+00	38	14
20	550.00	150.00	delivered	2025-10-31 18:45:35.664+00	2025-11-10 17:46:33.752+00	37	13
21	2100.00	150.00	delivered	2025-10-07 13:45:54.33+00	2025-10-09 13:15:19.874+00	8	2
22	120.00	150.00	delivered	2025-10-22 16:41:27.235+00	2025-11-10 17:46:43.807+00	25	6
23	50.00	150.00	delivered	2025-10-07 13:18:40.385+00	2025-10-09 22:38:21.4+00	7	1
24	1520.00	150.00	cancelled	2025-12-23 14:12:16.498+00	2025-12-25 12:49:22.204+00	44	18
25	530.00	150.00	cancelled	2025-10-29 13:39:55.535+00	2025-10-30 08:56:17.219+00	32	11
26	250.00	150.00	cancelled	2025-10-18 16:42:22.136+00	2025-10-30 08:57:01.504+00	22	5
27	250.00	150.00	cancelled	2025-10-26 21:34:40.507+00	2025-10-30 08:57:05.884+00	27	7
28	200.00	150.00	cancelled	2025-10-28 19:19:27.432+00	2025-10-30 08:57:09.444+00	28	8
29	500.00	150.00	cancelled	2025-10-29 12:47:18.264+00	2025-10-30 19:25:01.815+00	30	10
30	500.00	150.00	processing	2025-12-24 20:44:49.276+00	2025-12-25 16:58:29.946+00	45	19
31	440.00	150.00	cancelled	2025-12-22 15:52:46.126+00	2025-12-25 16:58:37.283+00	42	17
32	100.00	150.00	delivered	2025-10-07 13:19:32.968+00	2025-11-02 23:34:07.182+00	8	2
33	720.00	150.00	processing	2025-12-26 09:33:21.27+00	2025-12-27 18:48:19.444+00	47	20
34	880.00	150.00	pending	2026-01-06 19:22:47.079775+00	2026-01-06 19:22:47.64516+00	45	21
59	180.00	150.00	pending	2026-01-25 17:44:04.828105+00	2026-01-25 17:44:05.421776+00	45	21
35	880.00	150.00	delivered	2026-01-08 17:50:14.058515+00	2026-01-08 17:50:15.014048+00	45	21
36	580.00	150.00	pending	2026-01-19 19:09:15.403965+00	2026-01-20 04:58:56.115445+00	7	1
37	94.00	150.00	pending	2026-01-20 17:34:01.673782+00	2026-01-20 17:34:01.718672+00	7	1
38	330.00	150.00	pending	2026-01-20 17:36:20.555487+00	2026-01-20 17:36:20.578088+00	7	1
39	232.00	150.00	pending	2026-01-20 17:39:28.957782+00	2026-01-20 17:39:28.978505+00	7	1
40	348.00	150.00	pending	2026-01-20 17:45:58.770833+00	2026-01-20 17:45:58.794428+00	7	1
41	174.00	150.00	pending	2026-01-20 17:50:33.169864+00	2026-01-20 17:50:33.195077+00	7	1
42	58.00	150.00	pending	2026-01-20 18:09:04.333084+00	2026-01-20 18:09:04.530691+00	7	1
43	58.00	150.00	pending	2026-01-21 02:46:25.080884+00	2026-01-21 02:46:25.148382+00	7	1
44	58.00	150.00	pending	2026-01-22 11:34:59.396328+00	2026-01-22 11:34:59.464122+00	7	1
45	58.00	150.00	pending	2026-01-22 11:41:10.569432+00	2026-01-22 11:41:10.597898+00	7	1
46	0.00	150.00	pending	2026-01-25 16:51:52.186007+00	2026-01-25 16:51:52.186007+00	45	21
47	0.00	150.00	pending	2026-01-25 16:52:21.756711+00	2026-01-25 16:52:21.756711+00	45	21
48	180.00	150.00	pending	2026-01-25 16:52:38.188562+00	2026-01-25 16:52:38.681901+00	45	21
49	180.00	150.00	pending	2026-01-25 16:54:23.790299+00	2026-01-25 16:54:24.355363+00	45	21
50	180.00	150.00	pending	2026-01-25 16:56:25.595263+00	2026-01-25 16:56:26.242367+00	45	21
51	180.00	150.00	pending	2026-01-25 17:00:00.974168+00	2026-01-25 17:00:01.658542+00	45	21
52	0.00	150.00	pending	2026-01-25 17:05:35.190681+00	2026-01-25 17:05:35.190681+00	45	21
53	360.00	150.00	pending	2026-01-25 17:07:16.323609+00	2026-01-25 17:07:16.836552+00	45	21
54	180.00	150.00	pending	2026-01-25 17:13:25.001401+00	2026-01-25 17:13:25.982087+00	45	21
55	180.00	150.00	pending	2026-01-25 17:16:02.542345+00	2026-01-25 17:16:05.758306+00	45	21
56	180.00	150.00	pending	2026-01-25 17:31:22.667051+00	2026-01-25 17:31:29.694586+00	45	21
57	180.00	150.00	pending	2026-01-25 17:33:47.224256+00	2026-01-25 17:33:52.682331+00	45	21
58	180.00	150.00	pending	2026-01-25 17:41:49.287642+00	2026-01-25 17:41:49.966528+00	45	21
60	180.00	150.00	pending	2026-01-25 18:22:52.158079+00	2026-01-25 18:22:52.811104+00	45	21
61	180.00	150.00	pending	2026-01-25 18:28:12.233943+00	2026-01-25 18:28:13.081259+00	45	21
62	180.00	150.00	pending	2026-01-25 18:30:16.837202+00	2026-01-25 18:30:26.235608+00	45	21
63	180.00	150.00	pending	2026-01-25 18:30:37.27769+00	2026-01-25 18:30:38.100659+00	45	21
64	180.00	150.00	pending	2026-01-25 18:33:33.154034+00	2026-01-25 18:33:34.087786+00	45	21
65	180.00	150.00	pending	2026-01-25 18:34:05.865514+00	2026-01-25 18:34:06.938012+00	45	21
66	180.00	150.00	pending	2026-01-25 18:37:54.325524+00	2026-01-25 18:37:54.775347+00	45	21
67	180.00	150.00	pending	2026-01-25 18:38:22.801672+00	2026-01-25 18:38:23.267818+00	45	21
68	180.00	150.00	pending	2026-01-25 18:42:23.871153+00	2026-01-25 18:42:24.376613+00	45	21
69	180.00	150.00	pending	2026-01-25 18:42:42.695731+00	2026-01-25 18:42:43.188092+00	45	21
70	180.00	150.00	pending	2026-01-25 18:44:25.414039+00	2026-01-25 18:44:25.930621+00	45	21
71	180.00	150.00	pending	2026-01-25 18:45:16.219832+00	2026-01-25 18:45:16.718513+00	45	21
72	180.00	150.00	pending	2026-01-26 14:15:09.606567+00	2026-01-26 14:15:10.129508+00	45	21
73	180.00	150.00	pending	2026-01-26 14:17:56.40056+00	2026-01-26 14:17:56.881993+00	45	21
74	180.00	150.00	pending	2026-01-26 14:19:00.716974+00	2026-01-26 14:19:01.183145+00	45	21
75	180.00	150.00	pending	2026-01-26 14:23:53.630573+00	2026-01-26 14:23:54.156409+00	45	21
76	180.00	150.00	pending	2026-01-26 14:24:33.988274+00	2026-01-26 14:24:34.824127+00	45	21
77	180.00	150.00	pending	2026-01-26 14:25:03.780693+00	2026-01-26 14:25:04.146199+00	45	21
78	180.00	150.00	pending	2026-01-26 14:39:40.820557+00	2026-01-26 14:39:41.269171+00	45	21
79	180.00	150.00	pending	2026-01-26 14:43:13.033971+00	2026-01-26 14:43:13.497374+00	45	21
80	180.00	150.00	pending	2026-01-26 14:44:55.242595+00	2026-01-26 14:44:55.708732+00	45	21
81	180.00	150.00	pending	2026-01-26 14:46:24.951996+00	2026-01-26 14:46:25.387493+00	45	21
82	180.00	150.00	pending	2026-01-26 14:53:07.640621+00	2026-01-26 14:53:08.056218+00	45	21
83	180.00	150.00	pending	2026-01-26 14:53:48.964711+00	2026-01-26 14:53:49.414871+00	45	21
84	180.00	150.00	pending	2026-01-26 14:59:21.617115+00	2026-01-26 14:59:22.049725+00	45	21
85	180.00	150.00	pending	2026-01-26 15:00:15.205424+00	2026-01-26 15:00:15.611739+00	45	21
86	400.00	150.00	pending	2026-01-26 15:02:25.005675+00	2026-01-26 15:02:25.488314+00	45	21
87	620.00	150.00	pending	2026-01-26 15:08:30.42604+00	2026-01-26 15:08:30.91861+00	45	21
88	180.00	150.00	pending	2026-01-26 16:11:36.322505+00	2026-01-26 16:11:36.821609+00	45	21
89	180.00	150.00	pending	2026-01-26 16:15:14.773776+00	2026-01-26 16:15:15.23628+00	45	21
90	180.00	150.00	pending	2026-01-26 16:16:57.726399+00	2026-01-26 16:16:58.177156+00	45	21
91	180.00	150.00	pending	2026-01-26 16:19:50.085864+00	2026-01-26 16:19:50.535918+00	45	21
92	260.00	150.00	pending	2026-01-26 17:46:54.475973+00	2026-01-26 17:46:55.123794+00	45	21
93	180.00	150.00	pending	2026-01-26 17:50:00.263856+00	2026-01-26 17:50:00.660398+00	45	21
94	180.00	150.00	pending	2026-01-26 17:50:51.068224+00	2026-01-26 17:50:51.467172+00	45	21
95	180.00	150.00	pending	2026-01-26 18:06:19.305826+00	2026-01-26 18:06:19.741259+00	45	21
96	180.00	150.00	pending	2026-01-26 18:09:39.192864+00	2026-01-26 18:09:39.612732+00	45	21
97	180.00	150.00	pending	2026-01-26 18:12:39.200986+00	2026-01-26 18:12:39.634126+00	45	21
98	180.00	150.00	pending	2026-01-26 18:13:37.373593+00	2026-01-26 18:13:37.820264+00	45	21
99	180.00	150.00	pending	2026-01-26 18:15:19.480548+00	2026-01-26 18:15:19.925804+00	45	21
100	180.00	150.00	pending	2026-01-26 18:16:17.782247+00	2026-01-26 18:16:18.266164+00	45	21
101	180.00	150.00	pending	2026-01-26 18:21:00.027537+00	2026-01-26 18:21:00.483398+00	45	21
102	180.00	150.00	pending	2026-01-26 18:22:45.905315+00	2026-01-26 18:22:46.339903+00	45	21
103	180.00	150.00	pending	2026-01-26 18:24:03.852495+00	2026-01-26 18:24:04.31838+00	45	21
104	800.00	150.00	pending	2026-01-26 18:31:19.016147+00	2026-01-26 18:31:19.698008+00	45	21
105	420.00	150.00	pending	2026-01-26 18:35:06.678302+00	2026-01-26 18:35:07.475729+00	45	21
106	0.00	150.00	pending	2026-01-28 06:06:21.201446+00	2026-01-28 06:06:21.201446+00	45	21
107	180.00	150.00	pending	2026-01-28 06:07:56.253189+00	2026-01-28 06:07:57.447153+00	45	21
108	180.00	150.00	pending	2026-01-28 06:12:03.962148+00	2026-01-28 06:12:04.815908+00	45	21
109	160.00	150.00	pending	2026-01-28 06:12:51.486192+00	2026-01-28 06:12:52.201752+00	45	21
\.


--
-- Data for Name: core_orderitem; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.core_orderitem (id, quantity, price, order_id, product_id, created_at, variant_id) FROM stdin;
71	4	180.00	34	35	2026-01-06 19:22:47.378928+00	\N
72	2	80.00	34	35	2026-01-06 19:22:47.496562+00	\N
73	4	180.00	35	35	2026-01-08 17:50:14.731142+00	\N
74	2	80.00	35	35	2026-01-08 17:50:14.843163+00	\N
76	10	40.00	36	45	2026-01-19 19:09:15.434698+00	2
75	8	18.00	36	46	2026-01-19 19:09:15.424611+00	52
77	3	18.00	37	46	2026-01-20 17:34:01.702411+00	52
78	1	40.00	37	45	2026-01-20 17:34:01.712724+00	2
79	5	18.00	38	46	2026-01-20 17:36:20.567078+00	52
80	6	40.00	38	45	2026-01-20 17:36:20.571073+00	2
81	4	40.00	39	45	2026-01-20 17:39:28.96879+00	2
82	4	18.00	39	46	2026-01-20 17:39:28.972573+00	52
83	6	18.00	40	46	2026-01-20 17:45:58.78345+00	52
84	6	40.00	40	45	2026-01-20 17:45:58.787519+00	2
85	3	18.00	41	46	2026-01-20 17:50:33.183358+00	52
86	3	40.00	41	45	2026-01-20 17:50:33.187759+00	2
87	1	18.00	42	46	2026-01-20 18:09:04.468209+00	52
88	1	40.00	42	45	2026-01-20 18:09:04.515543+00	2
89	1	18.00	43	46	2026-01-21 02:46:25.119292+00	52
90	1	40.00	43	45	2026-01-21 02:46:25.137574+00	2
91	1	18.00	44	46	2026-01-22 11:34:59.428988+00	52
92	1	40.00	44	45	2026-01-22 11:34:59.444667+00	2
93	1	18.00	45	46	2026-01-22 11:41:10.586555+00	52
94	1	40.00	45	45	2026-01-22 11:41:10.590289+00	2
95	1	180.00	48	35	2026-01-25 16:52:38.509917+00	\N
99	2	180.00	53	35	2026-01-25 17:07:16.668622+00	\N
100	1	180.00	54	35	2026-01-25 17:13:25.783864+00	\N
101	1	180.00	55	35	2026-01-25 17:16:05.568937+00	\N
102	1	180.00	56	35	2026-01-25 17:31:29.516581+00	\N
103	1	180.00	57	35	2026-01-25 17:33:52.510407+00	\N
104	1	180.00	58	35	2026-01-25 17:41:49.767759+00	\N
105	1	180.00	59	35	2026-01-25 17:44:05.253009+00	\N
106	1	180.00	60	35	2026-01-25 18:22:52.608823+00	\N
107	1	180.00	61	35	2026-01-25 18:28:12.850342+00	\N
108	1	180.00	62	35	2026-01-25 18:30:24.122308+00	\N
109	1	180.00	63	35	2026-01-25 18:30:37.819389+00	\N
54	1	350.00	10012	46	2025-12-22 15:52:46.168+00	1
60	1	350.00	10013	46	2025-12-23 14:12:16.553+00	1
56	1	350.00	10013	45	2025-12-23 14:12:16.527+00	2
58	1	350.00	10013	44	2025-12-23 14:12:16.546+00	3
57	1	120.00	10013	38	2025-12-23 14:12:16.542+00	5
64	2	80.00	10015	47	2025-12-26 09:33:21.346+00	6
59	1	350.00	10013	48	2025-12-23 14:12:16.55+00	8
70	1	150.00	10015	49	2025-12-26 09:33:21.373+00	9
65	1	70.00	10015	50	2025-12-26 09:33:21.351+00	10
63	1	150.00	10015	51	2025-12-26 09:33:21.332+00	13
8	1	100.00	13	24	2025-09-28 00:26:33.556+00	17
32	1	100.00	10004	24	2025-10-29 12:47:18.281+00	17
50	1	100.00	10011	24	2025-11-03 13:30:20.295+00	17
55	1	30.00	10012	39	2025-12-22 15:52:46.173+00	21
66	1	30.00	10015	39	2025-12-26 09:33:21.355+00	21
9	1	50.00	13	23	2025-09-28 00:26:33.57+00	25
12	1	50.00	15	23	2025-10-07 13:19:32.98+00	25
14	2	50.00	17	23	2025-10-07 13:45:54.342+00	25
29	1	50.00	10002	23	2025-10-28 19:19:27.467+00	25
33	2	50.00	10004	23	2025-10-29 12:47:18.29+00	25
41	2	50.00	10006	23	2025-10-31 08:39:01.936+00	25
43	1	50.00	10007	23	2025-10-31 18:45:35.7+00	25
46	2	50.00	10008	23	2025-11-02 19:10:47.16+00	25
7	1	50.00	12	21	2025-09-09 08:48:19.238+00	26
11	1	50.00	15	21	2025-10-07 13:19:32.977+00	26
34	1	50.00	10004	21	2025-10-29 12:47:18.295+00	26
39	1	50.00	10006	21	2025-10-31 08:39:01.92+00	26
5	1	200.00	11	17	2025-09-06 11:13:57.393+00	30
15	2	250.00	17	17	2025-10-07 13:45:54.346+00	30
4	1	250.00	10	18	2025-08-11 00:09:08.73+00	32
62	1	250.00	10014	18	2025-12-24 20:44:49.312+00	32
47	1	150.00	10008	4	2025-11-02 19:10:47.2+00	37
6	1	50.00	12	22	2025-09-09 08:48:19.231+00	38
118	1	180.00	72	35	2026-01-26 14:15:09.925021+00	\N
119	1	180.00	73	35	2026-01-26 14:17:56.705732+00	\N
120	1	180.00	74	35	2026-01-26 14:19:00.982734+00	\N
121	1	180.00	75	35	2026-01-26 14:23:53.962938+00	\N
122	1	180.00	76	35	2026-01-26 14:24:34.30427+00	\N
123	1	180.00	77	35	2026-01-26 14:25:04.012766+00	\N
124	1	180.00	78	35	2026-01-26 14:39:41.101706+00	\N
126	1	180.00	80	35	2026-01-26 14:44:55.542593+00	\N
128	1	180.00	82	35	2026-01-26 14:53:07.890753+00	\N
129	1	180.00	83	35	2026-01-26 14:53:49.230914+00	\N
134	3	180.00	87	35	2026-01-26 15:08:30.668886+00	\N
135	2	40.00	87	45	2026-01-26 15:08:30.751895+00	\N
136	1	180.00	88	35	2026-01-26 16:11:36.62055+00	\N
137	1	180.00	89	35	2026-01-26 16:15:15.035716+00	\N
140	1	180.00	92	35	2026-01-26 17:46:54.808174+00	\N
141	1	80.00	92	35	2026-01-26 17:46:54.924353+00	\N
142	1	180.00	93	35	2026-01-26 17:50:00.495365+00	\N
143	1	180.00	94	35	2026-01-26 17:50:51.318852+00	\N
146	1	180.00	97	35	2026-01-26 18:12:39.45081+00	31
147	1	180.00	98	35	2026-01-26 18:13:37.633566+00	31
148	1	180.00	99	35	2026-01-26 18:15:19.746562+00	31
150	1	180.00	101	35	2026-01-26 18:21:00.311234+00	31
151	1	180.00	102	35	2026-01-26 18:22:46.169077+00	31
152	1	180.00	103	35	2026-01-26 18:24:04.132857+00	31
158	1	180.00	106	35	2026-01-28 06:06:21.535376+00	31
159	1	180.00	107	35	2026-01-28 06:07:56.95903+00	31
160	1	180.00	108	35	2026-01-28 06:12:04.423345+00	31
161	2	80.00	109	35	2026-01-28 06:12:51.795822+00	53
10	1	50.00	14	22	2025-10-07 13:18:40.406+00	38
67	1	50.00	10015	22	2025-12-26 09:33:21.36+00	38
19	1	250.00	18	9	2025-10-09 17:07:15.117+00	39
30	1	250.00	10003	9	2025-10-29 07:43:48.921+00	39
37	1	250.00	10005	9	2025-10-29 13:39:55.564+00	39
42	1	250.00	10007	9	2025-10-31 18:45:35.687+00	39
44	1	250.00	10007	7	2025-10-31 18:45:35.704+00	40
1	1	100.00	1	1	2025-06-27 18:04:18.113+00	41
2	1	500.00	8	1	2025-06-28 00:13:53.435+00	41
3	1	500.00	9	1	2025-06-28 00:18:44.281+00	41
24	2	30.00	10000	11	2025-10-22 16:41:27.254+00	42
28	3	30.00	10002	11	2025-10-28 19:19:27.463+00	42
45	6	30.00	10008	11	2025-11-02 19:10:47.113+00	42
52	2	30.00	10011	11	2025-11-03 13:30:20.306+00	42
53	2	30.00	10012	11	2025-12-22 15:52:46.152+00	42
69	1	50.00	10015	10	2025-12-26 09:33:21.369+00	43
13	1	250.00	16	14	2025-10-07 13:21:28.427+00	45
17	2	250.00	17	14	2025-10-07 13:45:54.354+00	45
20	1	250.00	18	14	2025-10-09 17:07:15.131+00	45
31	1	250.00	10003	14	2025-10-29 07:43:48.932+00	45
36	1	250.00	10005	14	2025-10-29 13:39:55.554+00	45
40	1	250.00	10006	14	2025-10-31 08:39:01.932+00	45
18	2	250.00	17	15	2025-10-07 13:45:54.358+00	47
22	1	250.00	18	15	2025-10-09 17:07:15.138+00	47
23	1	250.00	9999	15	2025-10-18 16:42:22.151+00	47
16	2	250.00	17	12	2025-10-07 13:45:54.35+00	48
26	1	250.00	10001	12	2025-10-26 21:34:40.527+00	48
35	1	250.00	10004	12	2025-10-29 12:47:18.3+00	48
48	2	250.00	10009	12	2025-11-03 07:37:46.207+00	48
49	3	250.00	10010	12	2025-11-03 07:40:22.085+00	48
51	1	250.00	10011	12	2025-11-03 13:30:20.302+00	48
61	1	250.00	10014	12	2025-12-24 20:44:49.298+00	48
21	1	250.00	18	13	2025-10-09 17:07:15.135+00	49
25	2	30.00	10000	5	2025-10-22 16:41:27.266+00	50
27	2	30.00	10002	5	2025-10-28 19:19:27.451+00	50
38	1	30.00	10005	5	2025-10-29 13:39:55.567+00	50
68	2	30.00	10015	5	2025-12-26 09:33:21.364+00	50
96	1	180.00	49	35	2026-01-25 16:54:24.155443+00	\N
97	1	180.00	50	35	2026-01-25 16:56:26.064573+00	\N
98	1	180.00	51	35	2026-01-25 17:00:01.492595+00	\N
110	1	180.00	64	35	2026-01-25 18:33:33.85775+00	\N
111	1	180.00	65	35	2026-01-25 18:34:06.53365+00	\N
112	1	180.00	66	35	2026-01-25 18:37:54.591301+00	\N
113	1	180.00	67	35	2026-01-25 18:38:23.100293+00	\N
114	1	180.00	68	35	2026-01-25 18:42:24.176589+00	\N
115	1	180.00	69	35	2026-01-25 18:42:42.988697+00	\N
116	1	180.00	70	35	2026-01-25 18:44:25.73023+00	\N
117	1	180.00	71	35	2026-01-25 18:45:16.518017+00	\N
125	1	180.00	79	35	2026-01-26 14:43:13.317423+00	\N
127	1	180.00	81	35	2026-01-26 14:46:25.230672+00	\N
130	1	180.00	84	35	2026-01-26 14:59:21.882789+00	\N
131	1	180.00	85	35	2026-01-26 15:00:15.43867+00	\N
132	2	180.00	86	35	2026-01-26 15:02:25.25573+00	\N
133	1	40.00	86	45	2026-01-26 15:02:25.322077+00	\N
138	1	180.00	90	35	2026-01-26 16:16:57.993532+00	\N
139	1	180.00	91	35	2026-01-26 16:19:50.370394+00	\N
144	1	180.00	95	35	2026-01-26 18:06:19.560124+00	31
145	1	180.00	96	35	2026-01-26 18:09:39.438143+00	31
149	1	180.00	100	35	2026-01-26 18:16:18.097198+00	31
153	4	180.00	104	35	2026-01-26 18:31:19.365888+00	31
154	1	80.00	104	35	2026-01-26 18:31:19.481286+00	53
155	1	180.00	105	35	2026-01-26 18:35:07.045255+00	31
156	1	80.00	105	35	2026-01-26 18:35:07.142353+00	53
157	4	40.00	105	45	2026-01-26 18:35:07.242123+00	2
\.


--
-- Data for Name: core_product; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.core_product (id, name, rating, is_new, is_sale, is_featured, is_trending, is_active, created_at, updated_at, image_url, thumbnail_url, description, price, compare_at_price, stock) FROM stdin;
17	Christmas Moss	5.0	f	f	t	f	t	2025-09-18 06:42:29.89409+00	2025-12-25 07:21:26.880571+00	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/ChristmasMoss%2FChristmasMoss.jpeg?alt=media&token=4e436c96-7efa-4fae-a874-888757724cb8	\N	\N	300.00	550.00	0
2	Dwarf Mondo Grass	5.0	t	f	f	f	t	2025-07-08 22:20:47.273981+00	2025-09-08 16:57:17.502219+00	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/Dwarf%20Mondo%20Grass.jpeg?alt=media	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/Dwarf%20Mondo%20Grass.jpeg?alt=media	\N	30.00	100.00	10
7	Bucephalandra Red Velvet (3 Rhizomes)	5.0	f	t	f	f	t	2025-07-09 07:40:57.712204+00	2025-12-25 08:38:00.959935+00	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/red-velvet%2Fredvelvet01.jpeg?alt=media&token=4d372056-6bfc-4e58-af73-d4b188b06364	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/red-velvet%2Fredvelvet01.jpeg?alt=media&token=4d372056-6bfc-4e58-af73-d4b188b06364	\N	300.00	550.00	0
8	Bucephalandra Pygmea (3 Rhizomes)	5.0	f	t	f	f	t	2025-07-09 07:40:57.712204+00	2025-12-25 08:38:14.613452+00	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/pygmea%2Fpygmea01.jpeg?alt=media&token=2906af07-bdce-4df8-b044-a47c90dd51b0	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/pygmea%2Fpygmea01.jpeg?alt=media&token=2906af07-bdce-4df8-b044-a47c90dd51b0	\N	300.00	550.00	0
19	Bucephalandra Super Catherine (One Rhizome)	5.0	f	f	f	t	t	2025-12-21 17:47:53.833454+00	2025-12-21 20:32:21.337574+00	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/SuperCatherine%2Fsupercathrine.jpeg?alt=media&token=0f15be31-b747-40a5-aef8-e3e02d556b48	\N	\N	350.00	700.00	5
20	Syngonium Pink Arrowhead	5.0	f	t	f	f	t	2025-09-08 17:12:23.499313+00	2025-09-08 17:12:23.499329+00	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/SyngoniumPinkArrowhead%2FSyngoniumPinkArrowhead1.jpeg?alt=media&token=edff1725-5818-4e39-bb88-7370df9f4b91	\N	\N	50.00	80.00	10
1	Bucephalandra Boyan (3 Rhizomes)	5.0	f	t	t	f	t	2025-07-09 07:40:57.712204+00	2025-12-25 08:37:26.840109+00	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/boyan%2Fboyan01.jpeg?alt=media&token=fc126447-296b-4ba5-8990-9a5b45e3f86e	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/boyan%2Fboyan01.jpeg?alt=media&token=fc126447-296b-4ba5-8990-9a5b45e3f86e	\N	250.00	500.00	1
3	Bucephalandra Mini Melawi (3 Rhizomes)	5.0	f	t	f	f	t	2025-07-09 07:40:57.712204+00	2025-12-25 08:38:44.339711+00	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/mini-melawi%2Fminimelawi01.jpeg?alt=media&token=607a37e0-cb24-4938-9bf4-609656bdc935	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/mini-melawi%2Fminimelawi01.jpeg?alt=media&token=607a37e0-cb24-4938-9bf4-609656bdc935	\N	750.00	1000.00	5
4	Bucephalandra Star Glitz (3 Rhizomes)	5.0	f	t	f	f	t	2025-07-09 07:40:57.712204+00	2025-12-25 07:27:48.234058+00	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/star-glitz%2Fstargliz01.jpeg?alt=media&token=c135db46-373e-4c31-9c88-398b99207ebf	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/star-glitz%2Fstargliz01.jpeg?alt=media&token=c135db46-373e-4c31-9c88-398b99207ebf	\N	150.00	250.00	20
40	Bucephalandra Black Angel (3 Rhizomes)	5.0	f	f	f	t	t	2025-12-21 17:36:44.253732+00	2025-12-21 18:28:20.893521+00	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/BlackAngel%2Fblackangel01.jpeg?alt=media&token=74c1ae6d-a730-448d-adca-d2d2f617190b	\N	\N	50.00	70.00	5
5	Aridarum Narrow	5.0	t	t	f	t	t	2025-07-08 19:17:44.162277+00	2025-12-21 18:30:08.696189+00	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/aridarumNarrow_1.jpeg?alt=media&token=dac76d4c-fef7-4aa4-90de-1bcd122f5598	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/aridarumNarrow_1.jpeg?alt=media&token=dac76d4c-fef7-4aa4-90de-1bcd122f5598	\N	30.00	50.00	50
6	Eye Lash Fern	5.0	t	t	f	t	t	2025-06-25 15:27:42.191679+00	2025-12-21 18:29:58.446738+00	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/EyelashFernPlant.jpeg?alt=media&token=d14f585b-a671-48b2-9ddf-1c64b7f0f942	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/EyelashFernPlant.jpeg?alt=media&token=d14f585b-a671-48b2-9ddf-1c64b7f0f942	\N	700.00	950.00	0
41	Fittonia (Single Plant)	5.0	f	f	f	t	t	2025-12-21 18:36:59.502359+00	2025-12-21 18:37:39.415957+00	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/Fittonia%2Ffittonia05.jpeg?alt=media&token=a7eb88cc-a443-4420-8aa3-a4e0f4166922	\N	\N	220.00	500.00	0
9	Bucephalandra Mini Coin (3 Rhizomes)	5.0	f	t	f	f	t	2025-07-09 07:40:57.712204+00	2025-12-25 07:29:02.879271+00	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/mini-coin%2Fminicoin01.jpeg?alt=media&token=c4402e8a-8ac2-4bcf-b778-48eed8ce3ab9	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/mini-coin%2Fminicoin01.jpeg?alt=media&token=c4402e8a-8ac2-4bcf-b778-48eed8ce3ab9	\N	300.00	550.00	0
10	Bucephalandra Catherine (3 Rhizomes)	5.0	f	t	f	f	t	2025-07-09 07:40:57.712204+00	2025-12-25 08:37:37.858627+00	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/catherine%2Fcatherine01.jpeg?alt=media&token=9a51efc4-d5d7-49d5-8819-75b41ccb01dc	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/catherine%2Fcatherine01.jpeg?alt=media&token=9a51efc4-d5d7-49d5-8819-75b41ccb01dc	\N	50.00	100.00	10
11	Bucephalandra Black Cobra (3 Rhizomes)	5.0	f	t	f	f	t	2025-07-09 07:40:57.712204+00	2025-12-25 08:38:32.170177+00	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/black-cobra%2Fblackcobra01.jpeg?alt=media&token=6c9de34e-779a-4d5a-b1d4-cb3cd96fb93f	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/black-cobra%2Fblackcobra01.jpeg?alt=media&token=6c9de34e-779a-4d5a-b1d4-cb3cd96fb93f	\N	30.00	50.00	10
12	Creeping fig (Ficus pumila)	5.0	f	f	f	t	t	2025-07-08 22:20:47.273981+00	2025-09-29 11:18:24.490767+00	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/CreepingFigPlant%2FCreepingfigPlant1.jpeg?alt=media&token=4e76cedf-9c7e-4227-b1df-ae604abc4128	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/CreepingFigPlant%2FCreepingfigPlant1.jpeg?alt=media&token=4e76cedf-9c7e-4227-b1df-ae604abc4128	\N	300.00	550.00	2
13	Asparagus Fern	5.0	f	t	t	f	t	2025-07-08 19:35:16.001345+00	2025-09-05 19:09:22.265496+00	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/Asparagus%20Fern-%20Asparagus%20Plumosus.jpeg?alt=media	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/Asparagus%20Fern-%20Asparagus%20Plumosus.jpeg?alt=media	\N	300.00	550.00	0
14	Goliath Silver	5.0	f	f	f	t	t	2025-07-08 22:28:17.72771+00	2025-10-15 18:24:16.616002+00	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/Goliath%20Silver.webp?alt=media	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/Goliath%20Silver.webp?alt=media	\N	300.00	550.00	15
15	Peperomia Green Creeper	5.0	t	f	f	t	t	2025-07-08 22:20:47.273981+00	2025-10-01 04:48:28.515432+00	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/PeperomiaGreenCreeper%2FPeperomia%20Green%20Creeper.jpeg?alt=media&token=d757ddf6-7c96-4448-9756-ae20eb6e8fee	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/PeperomiaGreenCreeper%2FPeperomia%20Green%20Creeper.jpeg?alt=media&token=d757ddf6-7c96-4448-9756-ae20eb6e8fee	\N	300.00	550.00	8
16	Bucephalandra Brownie (3 Rhizomes)	5.0	f	t	f	f	t	2025-07-09 07:25:13.189286+00	2025-12-25 08:36:52.961877+00	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/brownie%2Fbrownie01.jpeg?alt=media&token=7a237373-7062-4b11-8e56-432b7d64869f	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/brownie%2Fbrownie01.jpeg?alt=media&token=7a237373-7062-4b11-8e56-432b7d64869f	\N	300.00	350.00	10
18	Syngonium Tiffany	5.0	f	t	f	f	t	2025-09-08 17:17:10.721789+00	2025-12-25 07:21:43.435781+00	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/SyngoniumTiffany%2FSyngoniumTiffany3.jpeg?alt=media&token=3aa67011-fd9a-4c64-aea5-6f8d24fb3933	\N	\N	300.00	400.00	0
21	Bucephalandra PinkLady (One rhizome)	5.0	f	f	f	t	t	2025-12-21 17:40:54.622881+00	2025-12-21 17:40:54.622904+00	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/PinkLady%2Fpinklady1.jpeg?alt=media&token=e9a03678-1e93-4800-b5fd-b5e0f145bc40	\N	\N	100.00	200.00	10
22	Bucephalandra Red Cherry (3 Rhizomes)	5.0	f	t	f	f	t	2025-07-09 07:40:57.712204+00	2025-12-25 08:37:12.438302+00	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/red-cherry%2Fredcherry01.jpeg?alt=media&token=29d80ecf-7a7c-4d26-9668-0ce73a6a32b0	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/red-cherry%2Fredcherry01.jpeg?alt=media&token=29d80ecf-7a7c-4d26-9668-0ce73a6a32b0	\N	50.00	80.00	10
23	Bucephalandra Skeleton King (One rhizome)	5.0	f	f	f	t	t	2025-12-21 17:42:47.141251+00	2025-12-21 17:42:47.141273+00	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/SkeletonKing%2Fskeletonking1.jpeg?alt=media&token=2b7dc598-ba85-4cdf-b0b2-0a23c61f6f25	\N	\N	120.00	250.00	10
24	Duck Weed	5.0	f	f	f	t	t	2025-12-21 18:01:05.157463+00	2025-12-21 18:01:05.15748+00	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/DuckWeed%2FDuckWeed.jpg?alt=media&token=31b046f8-1481-41ab-9b88-30a025e1d17a	\N	\N	100.00	250.00	4
25	Java Fern	5.0	f	f	f	t	t	2025-12-21 18:03:54.987771+00	2025-12-21 18:03:54.987792+00	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/JavaFern%2FJavaFern.jpeg?alt=media&token=d630d903-be55-40c9-bf81-483a489bc66a	\N	\N	300.00	600.00	20
26	Bucephalandra Red Chilli ( 3 Rhizomes)	5.0	f	f	f	t	t	2025-12-21 17:53:57.17496+00	2025-12-25 07:25:37.414696+00	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/RedChilli%2Fredchilli1.jpeg?alt=media&token=ad024d88-eaa9-4b43-ad15-7ac8fc9c8c11	\N	\N	300.00	600.00	20
27	Peperomia caperata	5.0	f	t	f	f	t	2025-09-08 17:13:52.580373+00	2025-12-30 11:19:04.308022+00	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/PeperomiaCaperata%2FPeperomia%20caperata.jpeg?alt=media&token=d4c88e3a-fcb5-4ac7-8976-6e8995aa0953	\N	\N	300.00	600.00	5
28	Pilea nummulariifolia (Creeping Charlie 3 Cuttings)	5.0	f	f	f	t	t	2025-12-21 18:05:31.180292+00	2025-12-21 19:56:33.30011+00	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/PileaNummulariifolia%2FPileaNummulariifolia.jpeg?alt=media&token=5cb9b25c-d6cb-41d3-819c-7594987402ae	\N	\N	650.00	1300.00	4
29	Bucephalandra Splendor Purple (One rhizome)	5.0	f	f	f	t	t	2025-12-21 17:46:12.630458+00	2025-12-21 20:32:37.469698+00	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/SplendorPurple%2Fsplendorpurple1.jpeg?alt=media&token=14ec8367-0f6c-44d6-844b-251de0c5ae06	\N	\N	700.00	1400.00	5
30	Bucephalandra Upper Ghost (One rhizome)	5.0	f	f	f	t	t	2025-12-21 17:44:38.265279+00	2025-12-21 20:33:20.13291+00	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/UpperGhost%2Fupperghost1.jpeg?alt=media&token=1bfb2ee9-299e-491c-87e3-aaa1581f66e9	\N	\N	300.00	1200.00	5
31	Bucephalandra Godzilla (One rhizome)	5.0	f	f	f	f	t	2025-12-21 17:38:49.680277+00	2025-12-21 20:33:49.997314+00	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/Ghodzilla%2Fghodzilla.jpeg?alt=media&token=258ca660-0b5d-4e5c-945d-c607bbbfcb5f	\N	\N	350.00	1400.00	5
32	Bucephalandra Deep Purple (3 Rhizomes)	5.0	f	f	f	t	t	2025-12-21 17:35:02.075203+00	2025-12-21 20:34:09.029452+00	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/DeepPurple%2FdeepPurple01.jpg?alt=media&token=e74ec5d0-4345-484f-935f-557f4ae7e7d0	\N	\N	300.00	1200.00	6
33	String of Frogs	5.0	f	f	f	t	t	2025-12-21 17:58:46.283708+00	2025-12-25 07:20:42.744906+00	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/StringOfFrogs%2FStringofFrogs.jpeg?alt=media&token=cd14c230-6457-4861-8da5-7a9b4735e377	\N	\N	350.00	700.00	20
34	Bucephalandra Helena 2014 (3 Rhizomes)	5.0	f	f	f	t	t	2025-12-21 17:52:20.200628+00	2025-12-25 07:25:59.441266+00	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/Helena2014%2Fhelena2014.jpeg?alt=media&token=168c0e0b-1949-45b1-b8c5-9545674e7687	\N	\N	300.00	500.00	20
36	Bacopa caroliniana ( 6 Stems)	5.0	f	f	f	t	t	2025-12-21 18:08:16.115069+00	2025-12-21 18:08:16.115093+00	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/BacopaCarolinana%2FBacopaCarolinana.jpeg?alt=media&token=2c657bbf-b85f-44cd-aa8f-325eeb289d18	\N	\N	360.00	700.00	0
37	Rotala rotundifolia "Green" ( 6 Stems)	5.0	f	f	f	t	t	2025-12-21 18:11:37.170015+00	2025-12-21 18:11:37.170035+00	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/RotalaRondafoliaGreen%2FRotalaRondafoliaGreen.jpeg?alt=media&token=9589022d-4413-45b0-a633-69ecab32382d	\N	\N	10.00	10.00	5
38	Heart Leaf Fern	5.0	f	f	f	t	t	2025-12-21 19:55:05.159159+00	2025-12-21 19:55:05.159174+00	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/heartleaffern%2Fheartleaffern01.png?alt=media&token=176a2ae6-21c2-4c33-b1c5-a7ee7864ffba	\N	\N	120.00	150.00	7
39	Bucephalandra Galileo (3 Rhizomes)	5.0	f	f	f	t	t	2025-12-21 17:50:40.059425+00	2025-12-21 20:32:58.085317+00	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/Galileo%2Fgalileo1.jpeg?alt=media&token=e7846f1f-adad-42b5-bd13-9cfa9540d297	\N	\N	30.00	70.00	5
42	Boston Fern	5.0	f	f	f	t	t	2025-12-23 14:05:25.797383+00	2025-12-23 14:05:25.797406+00	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/BostonFern%2Fboston02.jpeg?alt=media&token=d28da41c-45ab-459a-9fd7-46edc71ca2fe	\N	\N	50.00	70.00	10
44	Cryptanthus "Pink Starlight"	5.0	t	f	f	f	t	2025-12-25 11:35:01.699675+00	2025-12-25 11:53:42.656069+00	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/PinkStarlite%2FPinkStarlite01.jpeg?alt=media&token=cbd4e834-cbdf-4b09-9474-7cf6de0d2c10	\N	\N	350.00	700.00	0
47	Cushion Moss	5.0	f	f	f	t	t	2025-12-21 18:43:48.431613+00	2025-12-25 07:19:45.065386+00	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/chusionmoss%2Fchusionmoss01.png?alt=media&token=f90ab354-5432-4981-b63a-be93316669e7	\N	\N	80.00	120.00	2
48	Sheet Moss (12 x 12 Inch)	5.0	f	f	f	t	t	2025-12-21 18:26:04.911511+00	2025-12-25 07:19:55.419884+00	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/sheetmoss%2FSheetMoss.jpeg?alt=media&token=3fde1b38-2b98-46f8-a189-398ffe1b3dc4	\N	\N	350.00	700.00	0
49	Fern Moss (12 x12 inch)	5.0	f	f	f	t	t	2025-12-21 18:23:50.262697+00	2025-12-25 07:20:03.581715+00	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/fernmoss%2Ffernmoss.jpg?alt=media&token=533c544c-82a4-4268-94cc-39bdad661bc8	\N	\N	150.00	300.00	10
50	Mood Moss (6 x 6 inch)	5.0	f	f	f	t	t	2025-12-21 18:20:18.398526+00	2025-12-25 07:20:14.477302+00	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/moodmoss%2Fmoodmoss2.jpg?alt=media&token=c98f0518-b90f-4071-9c61-0619b4909383	\N	\N	70.00	140.00	10
51	Marcgravia Umbellata	5.0	f	f	f	t	t	2025-12-21 18:10:14.371311+00	2025-12-25 07:20:28.22507+00	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/MarcgraviaUmbellata%2FMarcgraviaUmbellata.jpeg?alt=media&token=c4538814-9856-4cfc-bfd8-b751beabfc22	\N	\N	150.00	250.00	10
43	Isabella Bushy Spikemoss ( 8cm x 8cm)	5.0	f	f	f	t	t	2025-12-21 18:17:21.49578+00	2026-01-03 17:44:18.200333+00	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/spikemoss%2Fspikemoss01.jpeg?alt=media&token=c041639c-6cec-44ba-a0dd-00a086de389b	\N	good	250.00	500.00	5
46	Pothos scandens (One Plant)	5.0	f	f	t	f	t	2025-12-29 12:43:46.794216+00	2026-01-08 19:24:52.149468+00	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/PothosScandens%2FPothosScandens.jpeg?alt=media&token=c7c5f34a-bd11-4b3d-befe-303fe24c6173	\N	good product	350.00	700.00	0
45	Seleganella Krussiana (One Plant)	5.0	f	f	t	f	t	2025-12-29 12:25:59.381605+00	2026-01-19 19:08:50.364889+00	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/SeleganellaKrussiana%2FSelaginellaKraussiana.jpg?alt=media&token=c09b1dd3-1c83-470e-9304-686a6095879e	\N	xyz	350.00	700.00	0
35	Peperomia Raisinet	5.0	f	t	f	f	t	2025-09-08 17:58:55.070081+00	2026-01-30 05:57:24.151757+00	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/Peperomia%20caperata%20red%2FPeperomia%20Raisinet.jpeg?alt=media&token=bb21888f-409c-4ba8-b15e-b98d25c6f397	\N	laddu kavala nayana	300.00	500.00	5
52	test plant	1.0	t	f	f	f	t	2026-01-09 18:08:46.683834+00	2026-01-30 06:16:57.965451+00	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/PothosScandens%2FPothosScandens.jpeg?alt=media&token=c7c5f34a-bd11-4b3d-befe-303fe24c6173	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/SeleganellaKrussiana%2FSelaginellaKraussiana.jpg?alt=media&token=c09b1dd3-1c83-470e-9304-686a6095879e	just test	70.00	200.00	100
\.


--
-- Data for Name: core_product_categories; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.core_product_categories (id, product_id, category_id) FROM stdin;
1	14	2
2	14	1
3	13	2
4	15	2
5	17	1
6	17	2
7	15	1
8	16	1
9	16	2
10	8	1
11	8	2
12	18	1
13	18	2
14	9	1
15	9	2
16	12	1
17	12	2
18	7	1
19	7	2
20	13	1
21	6	2
22	10	3
23	10	4
24	11	3
25	11	4
26	5	3
27	5	4
28	4	3
29	4	4
30	3	2
31	1	2
32	5	5
33	20	3
34	20	4
35	21	3
36	21	4
37	22	3
38	22	4
39	23	3
40	23	4
41	24	3
42	24	5
43	24	6
44	25	1
45	25	2
46	25	3
47	25	5
48	26	1
49	26	2
50	26	3
51	26	5
52	27	1
53	27	2
54	27	3
55	27	5
56	28	1
57	28	2
58	28	3
59	28	5
60	29	1
61	29	2
62	29	3
63	29	5
64	30	1
65	30	2
66	30	3
67	30	5
68	31	1
69	31	2
70	31	3
71	31	5
72	32	1
73	32	2
74	32	3
75	32	5
76	33	1
77	33	2
78	33	3
79	33	5
80	34	1
81	34	2
82	34	3
83	34	5
87	35	5
88	36	2
89	36	3
90	37	5
91	38	1
92	38	3
93	38	5
94	39	3
95	39	4
96	40	5
97	41	2
98	41	3
99	42	5
100	43	3
101	44	3
102	45	3
103	46	3
104	47	3
105	47	4
106	48	3
107	48	6
108	46	6
109	45	6
110	44	6
111	49	2
112	49	3
113	49	4
114	50	3
115	50	4
116	51	3
117	51	4
118	52	3
119	53	3
\.


--
-- Data for Name: core_product_tags; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.core_product_tags (id, product_id, tag_id) FROM stdin;
1	1	2
2	1	4
3	1	5
4	3	1
5	3	2
6	3	3
7	3	4
8	4	4
9	4	5
10	5	4
11	5	5
12	6	1
13	6	2
14	6	3
15	6	4
16	7	1
17	7	3
18	8	1
19	14	1
20	14	3
21	9	1
22	9	3
23	15	1
24	15	3
25	16	1
26	16	3
27	12	1
28	12	3
29	18	1
30	18	3
31	8	3
32	13	1
33	13	3
34	17	1
35	17	3
36	20	4
37	20	5
38	21	4
39	21	5
40	22	4
41	22	5
42	23	4
43	23	5
44	24	3
45	24	4
46	24	6
47	25	1
48	25	2
49	25	3
50	25	4
51	26	1
52	26	2
53	26	3
54	26	4
55	27	1
56	27	2
57	27	3
58	27	4
59	28	1
60	28	2
61	28	3
62	28	4
63	29	1
64	29	2
65	29	3
66	29	4
67	30	1
68	30	2
69	30	3
70	30	4
71	31	1
72	31	2
73	31	3
74	31	4
75	32	1
76	32	2
77	32	3
78	32	4
79	33	1
80	33	2
81	33	3
82	33	4
83	34	1
84	34	2
85	34	3
86	34	4
87	35	1
88	35	2
89	35	3
90	35	4
91	36	2
92	36	4
93	37	3
94	38	3
95	38	4
96	39	4
97	39	5
98	40	3
99	41	2
100	41	4
101	42	3
102	43	4
103	44	4
104	45	4
105	46	4
106	47	4
107	47	5
108	48	4
109	49	2
110	49	4
111	50	4
112	50	5
113	51	4
114	51	5
116	53	4
117	52	1
118	45	2
119	45	3
\.


--
-- Data for Name: core_productimage; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.core_productimage (id, image_url, created_at, product_id, "order", type) FROM stdin;
1	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/EyelashFernPlant.jpeg?alt=media&token=d14f585b-a671-48b2-9ddf-1c64b7f0f942	2025-07-03 21:29:23.902545+00	1	1	product_image
5	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/black-cobra%2Fblackcobra01.jpeg?alt=media&token=6c9de34e-779a-4d5a-b1d4-cb3cd96fb93f	2025-09-03 19:42:09.68685+00	9	1	product_image
6	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/boyan%2Fboyan01.jpeg?alt=media&token=fc126447-296b-4ba5-8990-9a5b45e3f86e	2025-09-03 19:42:09.68685+00	15	1	product_image
7	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/brownie%2Fbrownie01.jpeg?alt=media&token=7a237373-7062-4b11-8e56-432b7d64869f	2025-09-03 19:42:09.68685+00	7	1	product_image
8	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/mini-coin%2Fminicoin01.jpeg?alt=media&token=c4402e8a-8ac2-4bcf-b778-48eed8ce3ab9	2025-09-03 19:42:09.68685+00	18	1	product_image
9	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/mini-melawi%2Fminimelawi01.jpeg?alt=media&token=607a37e0-cb24-4938-9bf4-609656bdc935	2025-09-03 19:42:09.68685+00	8	1	product_image
10	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/pygmea%2Fpygmea01.jpeg?alt=media&token=2906af07-bdce-4df8-b044-a47c90dd51b0	2025-09-03 19:42:09.68685+00	12	1	product_image
11	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/red-cherry%2Fredcherry01.jpeg?alt=media&token=29d80ecf-7a7c-4d26-9668-0ce73a6a32b0	2025-09-03 19:42:09.68685+00	14	1	product_image
12	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/red-velvet%2Fredvelvet01.jpeg?alt=media&token=4d372056-6bfc-4e58-af73-d4b188b06364	2025-09-03 19:42:09.68685+00	13	1	product_image
13	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/star-glitz%2Fstargliz01.jpeg?alt=media&token=c135db46-373e-4c31-9c88-398b99207ebf	2025-09-03 19:42:09.68685+00	16	1	product_image
14	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/catherine%2Fcatherine01.jpeg?alt=media&token=9a51efc4-d5d7-49d5-8819-75b41ccb01dc	2025-09-03 19:42:09.68685+00	17	1	product_image
2	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/DwarfMondoGrass1.jpeg?alt=media&token=cd2ff5c9-d3a5-4284-8057-873910de4192	2025-07-08 21:38:01.748453+00	35	2	product_image
3	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/DwarfMondoGrass2.jpeg?alt=media&token=d984c5c7-bab1-4810-afa2-7c216403e94f	2025-07-08 21:38:01.821678+00	35	3	product_image
4	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/Dwarf%20Mondo%20Grass.jpeg?alt=media&token=f57e30a9-a082-4914-89c2-4ee29db5ed76	2025-07-08 22:22:21.233409+00	35	1	product_image
15	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/PothosScandens%2FPothosScandens.jpeg?alt=media&token=c7c5f34a-bd11-4b3d-befe-303fe24c6173	2026-01-08 19:24:52.915912+00	46	0	product_image
16	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/PothosScandens%2FPothosScandens.jpeg?alt=media&token=c7c5f34a-bd11-4b3d-befe-303fe24c6173	2026-01-08 19:24:53.029138+00	46	1	product_image
21	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/PothosScandens%2FPothosScandens.jpeg?alt=media&token=c7c5f34a-bd11-4b3d-befe-303fe24c6173	2026-01-09 18:26:31.9614+00	52	0	product_image
22	https://firebasestorage.googleapis.com/v0/b/aqua-india-61437.firebasestorage.app/o/PothosScandens%2FPothosScandens.jpeg?alt=media&token=c7c5f34a-bd11-4b3d-befe-303fe24c6173	2026-01-09 18:26:32.048385+00	52	1	product_image
\.


--
-- Data for Name: core_productvariant; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.core_productvariant (id, variant_type, description, stock, original_price, offer_price, product_id) FROM stdin;
3	medium	\N	0	0.00	\N	44
4	medium	\N	0	0.00	\N	42
5	medium	\N	0	0.00	\N	38
6	medium	\N	0	0.00	\N	47
7	medium	\N	0	0.00	\N	41
8	medium	\N	0	0.00	\N	48
9	medium	\N	0	0.00	\N	49
10	medium	\N	0	0.00	\N	50
11	medium	\N	0	0.00	\N	43
12	medium	\N	0	0.00	\N	37
13	medium	\N	0	0.00	\N	51
14	medium	\N	0	0.00	\N	36
15	medium	\N	0	0.00	\N	28
16	medium	\N	0	0.00	\N	25
17	medium	\N	0	0.00	\N	24
18	medium	\N	0	0.00	\N	33
19	medium	\N	0	0.00	\N	26
20	medium	\N	0	0.00	\N	34
21	medium	\N	0	0.00	\N	39
22	medium	\N	0	0.00	\N	19
23	medium	\N	0	0.00	\N	29
24	medium	\N	0	0.00	\N	30
25	medium	\N	0	0.00	\N	23
26	medium	\N	0	0.00	\N	21
27	medium	\N	0	0.00	\N	31
28	medium	\N	0	0.00	\N	40
29	medium	\N	0	0.00	\N	32
30	medium	\N	0	0.00	\N	17
32	medium	\N	0	0.00	\N	18
33	medium	\N	0	0.00	\N	27
34	medium	\N	0	0.00	\N	20
35	medium	\N	0	0.00	\N	8
36	medium	\N	0	0.00	\N	3
37	medium	\N	0	0.00	\N	4
38	medium	\N	0	0.00	\N	22
39	medium	\N	0	0.00	\N	9
40	medium	\N	0	0.00	\N	7
41	medium	\N	0	0.00	\N	1
42	medium	\N	0	0.00	\N	11
43	medium	\N	0	0.00	\N	10
44	medium	\N	0	0.00	\N	16
45	medium	\N	0	0.00	\N	14
46	medium	\N	0	0.00	\N	2
47	medium	\N	0	0.00	\N	15
48	medium	\N	0	0.00	\N	12
49	medium	\N	0	0.00	\N	13
50	medium	\N	0	0.00	\N	5
51	medium	\N	0	0.00	\N	6
31	medium	hello	2	200.00	180.00	35
53	rhizome	good	0	100.00	80.00	35
55	clump	2 leaves	0	52.00	85.00	35
56	small	chinnadhi	0	400.00	10.00	35
1	medium	\N	0	0.00	\N	46
52	rhizome	2 leaves	10	20.00	18.00	46
0	small	chinnadhi	0	100.00	80.00	52
2	medium	medium size	10	110.00	40.00	45
\.


--
-- Data for Name: core_shippingaddress; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.core_shippingaddress (id, address_line_1, address_line_2, city, state, zip_code, country, recipient_name, recipient_phone, is_default, created_at, updated_at, user_id, recipient_email) FROM stdin;
1	xyzhgcfhjcxccbhcchbkggjhbhjvhgkvhjvjgvkhgv	sdfghjklkjhgjhgchgchghgabc	Chittoor	Andhra Pradesh	517002	India	Mahesh	8087236348	t	2025-06-27 12:27:32.668383+00	2025-06-28 23:57:25.642019+00	7	mahesh@gmail.com
2	Sree krishna shradha nilaya	\N	Bangalore	Karnataka	560066	IN	Ooha	7659883176	t	2025-10-07 07:49:32.962482+00	2025-10-07 07:49:32.962503+00	8	\N
3	Sre krishna shradha nilaya	\N	Bangalore	Karnataka	560066	IN	Ooha	8147412168	f	2025-10-07 07:51:28.405308+00	2025-10-07 07:51:28.405331+00	8	\N
4	4/16, Shanmuganagar, Karattumedu, Visuvasapuram	\N	Coimbatore	Tamil Nadu	641035	IN	Pravin	8838186363	t	2025-10-09 11:37:15.094164+00	2025-10-09 11:37:15.09418+00	13	\N
5	43 shyam nagar road natural city block j flat 9a	\N	Kolkata	West Bengal	700055	IN	Jatin kulthia	9331377848	f	2025-10-18 11:12:22.129961+00	2025-10-18 11:12:22.129977+00	22	\N
6	Flat 1D Sukh Shanti .. 7/1a Loudon Street	\N	Kolkata	West Bengal	700017	IN	Anil Mehta	9831002826	t	2025-10-22 11:11:27.227823+00	2025-10-22 11:11:27.227841+00	25	\N
7	3172 Colonial Drive	\N	Hyderabad	Telangana	500013	IN	mrr	9798070561	f	2025-10-26 16:04:40.498262+00	2025-10-26 16:04:40.498299+00	27	\N
8	Manik’s Apartment, 8/2, 1st C Main Rd, Angalamma, Koramangala 8th Block, Koramangala, Bengaluru, Karnataka	\N	Bangalore	Karnataka	560095	IN	Sanath	8660275257	f	2025-10-28 13:49:27.424015+00	2025-10-28 13:49:27.424031+00	28	\N
9	DS Max Swiss Castle Apartment Flat no 15 4th Floor 7th Cross Malleswaram	\N	Bangalore	Karnataka	560003	IN	R Mahesh Kumar	9591941397	f	2025-10-29 02:13:48.895561+00	2025-10-29 02:13:48.895582+00	29	\N
10	571, Amairah pg for girls, sector 17, lane 8	\N	Gurgaon	Haryana	122007	IN	Rajdeep Singh	7734840002	t	2025-10-29 07:17:18.257625+00	2025-10-29 07:17:18.257648+00	30	\N
11	Sankrail Industrial Park , max mor , radhika 2 , Cabcon India Pvt Ltd ( unit 4 )	\N	Howrah	West Bengal	711302	IN	ANKIT SAHOO	6295960267	f	2025-10-29 08:09:55.496166+00	2025-10-29 08:09:55.496183+00	32	\N
12	60 Abdul Kalam street, Dhanakoti Nagar extension, Dharmapuri	\N	Pondicherry	Pondicherry	605009	IN	S Hari	9952474522	t	2025-10-31 03:09:01.890464+00	2025-10-31 03:09:01.890482+00	36	\N
13	Kodolkargalli	\N	Belgaum	Karnataka	590001	IN	Mohamedhasan	9916900967	f	2025-10-31 13:15:35.652605+00	2025-10-31 13:15:35.652637+00	37	\N
14	1201 Tower 7 Omaxe Nile Sector 49	\N	Gurgaon	Haryana	122018	IN	Abhinav Trivedi	9873732180	t	2025-11-02 13:40:46.942159+00	2025-11-02 13:40:46.942179+00	38	\N
15	SR.. Bhavan OottukuzhiVilappilsala Cherukodu Kattakkada Rd	\N	Thiruvananthapuram	Kerala	695573	IN	Shaji	9567154382	t	2025-11-03 02:07:46.177019+00	2025-11-03 02:07:46.177041+00	40	\N
16	43,2nd floor, Byraveshwara Nilaya, MSR green city layout Whitefield	\N	Bangalore	Karnataka	560067	IN	Raghav Poojari	7022134053	t	2025-11-03 08:00:20.274408+00	2025-11-03 08:00:20.274425+00	41	\N
17	#37, 2nd cross, Bhuvaneshwari Nagar, R.T nagar post, near Vijaya Bharathi Public School	\N	Bangalore	Karnataka	560032	IN	Muhammad Roshan	9035257660	t	2025-12-22 10:22:46.116573+00	2025-12-22 10:22:46.116593+00	42	\N
18	A704, Amoda Valmark Apt, Doddakammanahalli Road, Off Banneraghatta	\N	Bangalore	Karnataka	560083	IN	Nirmala Terrence	9566291645	t	2025-12-23 08:42:16.437647+00	2025-12-23 08:42:16.437663+00	44	\N
19	Mathura-Prema Nivas, 1st Line, Jayaprakash Nagar, Near Axis Bank, Engineering School Road, Berhampur	\N	Ganjam	Odisha	760010	IN	Anvita Biswal	7799592148	f	2025-12-24 15:14:49.267803+00	2025-12-24 15:14:49.267823+00	45	\N
20	VSJ Villa, XI/673-D, Thrikkakara P.O, Padamugal		Ernakulam	Kerala	682021	India	Jennifer Paynter	9846980884	t	2025-12-26 03:56:08.249497+00	2025-12-26 03:56:08.249522+00	47	jen_4everhere@yahoo.com
21	1-16,	\N	yadamari	Andhra Pradesh	517128	IN	k pavan	7013811044	f	2026-01-06 19:22:46.562291+00	2026-01-06 19:22:46.562291+00	45	\N
\.


--
-- Data for Name: core_stocknotification; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.core_stocknotification (id, email, phone, is_notified, created_at, product_id, user_id) FROM stdin;
29	test@gmail.com	\N	f	2026-02-08 12:50:32.467129+00	20	\N
31	test1@gmail.com	\N	f	2026-02-08 12:51:25.06727+00	20	\N
32	test@gmail.com	\N	f	2026-02-08 12:51:48.047475+00	4	\N
\.


--
-- Data for Name: core_tag; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.core_tag (id, name, created_at) FROM stdin;
1	Exotic Plants	2025-06-27 19:04:21.390508+00
2	Terrarium Plants	2025-07-08 19:02:26.113815+00
3	Aquatic Plants	2025-07-08 19:02:18.70882+00
4	Indoor Plants	2025-07-08 19:02:37.499988+00
5	Rhizomes	2025-06-27 14:35:26.611531+00
6	Aquatic Moss	2025-09-18 06:44:02.90966+00
\.


--
-- Data for Name: core_user; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.core_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined, phone, created_at, updated_at) FROM stdin;
1	pbkdf2_sha256$1000000$v0garI8m1x5tx9B5uBjssE$33Y3vv5LbzI/iMPnClpyxhI6LkL3lrSMGOts1Kl7pFQ=	\N	f	raghvendra.rakshith.rr@gmail.com	Raghavendra	Rakshith	raghvendra.rakshith.rr@gmail.com	f	t	2025-10-22 13:50:41.381507+00	\N	2025-10-22 13:50:41.653775+00	2025-10-22 13:50:41.653784+00
2	pbkdf2_sha256$1000000$2N4wyJ5kvvU1OkYxiC2anp$ooVfdc9aCn03tq/eyWQdFJLXxLAg32X3+4CufEr+U64=	\N	f	ausmrrzeb2@gmail.com	sdsd		ausmrrzeb2@gmail.com	f	t	2025-10-26 16:04:09.329349+00	\N	2025-10-26 16:04:09.657741+00	2025-10-26 16:04:09.657756+00
3	pbkdf2_sha256$1000000$ACgSbjbpZYyi2401DvK2Hx$W0SGj+q8A/kti1tR/KKspjIhpvovQIRVAMIf/eNjItQ=	\N	f	sanathbu180@gmail.com	Sanath 		sanathbu180@gmail.com	f	t	2025-10-28 13:47:29.525707+00	\N	2025-10-28 13:47:29.84374+00	2025-10-28 13:47:29.843749+00
4	pbkdf2_sha256$1000000$cuJiKVB271XAzSi6VmzqSQ$ESRh4dsfGrVrBA+3G6e4kCKbSwmJGcFfFyCbquUhfcw=	\N	f	mahesh61437mahe@gmail.com	Mahesh		mahesh61437mahe@gmail.com	t	t	2025-06-07 21:45:16.03329+00	\N	2025-06-07 21:45:16.203099+00	2025-06-27 13:39:49.38598+00
5	pbkdf2_sha256$1000000$FNN028sNteaHNW5A1EH2IU$gOftjEJN95uBnjm3OaDOtIQnkYuxGqPFUGhJHTkPyAQ=	\N	t	Mahesh Babu	Mahesh	Babu	mahesh@aquaticexotica.com	t	t	2025-06-07 22:02:23.391957+00	8074751370	2025-06-07 22:02:23.392056+00	2025-06-07 22:02:23.392059+00
6	pbkdf2_sha256$1000000$VuJSUQ0oNt3hhRR9AkLLFh$LdDvhp+tmSf1grtYom+WUCUirygOGmdrhZYiE+9ChTg=	\N	f	mahesh.rkumar79@gmail.com	Mahesh	Kumar	mahesh.rkumar79@gmail.com	f	t	2025-10-29 02:10:16.839278+00	\N	2025-10-29 02:10:17.13415+00	2025-10-29 02:10:17.134162+00
9	pbkdf2_sha256$1000000$iOadNuRJ5V51G6kDwXl5uN$WQLHM07dGPgJQ1xWheATv8IAAnOnYbnXSuvpaiTkEqc=	\N	f	uhagangasani@gmail.com	ooha		uhagangasani@gmail.com	f	t	2025-09-09 03:17:33.608261+00	\N	2025-09-09 03:17:33.863983+00	2025-09-09 03:17:33.863998+00
10	pbkdf2_sha256$1000000$sBvy54oJerpBHZ6UubfrdP$mU0sg/LHvNuFVNP3m1iyaDdAWVgkQD/rpFxwxPKdeko=	\N	f	testadmin@example.com	Test	Admin	testadmin@example.com	f	t	2025-09-19 07:32:06.463214+00	\N	2025-09-19 07:32:06.773058+00	2025-09-19 07:32:06.773072+00
11	pbkdf2_sha256$1000000$1ruIoLkBrMokxGRvQeuD0b$nvIQpmzR3Tfw09o48Dyj12DHPH/HgkgqjfdyxGw+Bg0=	\N	f	adminuser@test.com	Admin	User	adminuser@test.com	f	t	2025-09-19 07:32:10.830679+00	\N	2025-09-19 07:32:11.09893+00	2025-09-19 07:32:11.098941+00
12	pbkdf2_sha256$1000000$ObvJsDVudFzspwBCuZVUZD$nH6K9W6u7ea2U7KfbghZPEp+9773lxyH2mX/OVWPofQ=	\N	f	devangadhikari17@gmail.com	Devang 		devangadhikari17@gmail.com	f	t	2025-10-07 03:47:40.017593+00	\N	2025-10-07 03:47:40.300722+00	2025-10-07 03:47:40.300733+00
13	pbkdf2_sha256$1000000$BLiK1HJpFjIF85bIOSjj7Q$JceCS1fy6o2vaPl889SBe27iT5wedAMDTbkXu2zm7D8=	\N	f	borkarpp369@gmail.com	Prajwaal	Borkar	borkarpp369@gmail.com	f	t	2025-10-09 08:48:22.619712+00	\N	2025-10-09 08:48:22.918316+00	2025-10-09 08:48:22.918328+00
14	pbkdf2_sha256$1000000$M5MiIsExLskGhct19a424a$cfpdiBMskbZiSdXc3h6CeXTQEsOtXArNCwxeZCLFCKo=	\N	f	pravinjackson16@gmail.com	Pravin		pravinjackson16@gmail.com	f	t	2025-10-09 11:27:37.595382+00	\N	2025-10-09 11:27:37.862159+00	2025-10-09 11:27:37.862173+00
15	pbkdf2_sha256$1000000$Ddu8JbirXIHfWaSocjhMk0$7ZHP7c+iWdDUg4PFwiCNP2OZTXYFqT8WmQnvgIE61jA=	\N	f	rkshri07@gmail.com	Shripad	S	rkshri07@gmail.com	f	t	2025-10-09 11:37:55.550892+00	\N	2025-10-09 11:37:55.85123+00	2025-10-09 11:37:55.85124+00
16	pbkdf2_sha256$1000000$HLCzeJ2g92myStTmzYaSqU$AFF/AZih5BMNMzAP8H5C0MWttE2urzNjn7q31pYB6OQ=	\N	f	rkarthik110@gmail.com	Karthik 		rkarthik110@gmail.com	f	t	2025-10-09 13:17:13.698141+00	\N	2025-10-09 13:17:14.009265+00	2025-10-09 13:17:14.009275+00
17	pbkdf2_sha256$1000000$CFkXN6j1CercG5G63LmtPD$emAxRxQ8PToVrxUj2tZVKKgqbCC4wToIh2TrmfboTps=	\N	f	jerrybol@gmx.fr	JLO2025		jerrybol@gmx.fr	f	t	2025-10-10 14:48:02.354587+00	\N	2025-10-10 14:48:02.598918+00	2025-10-10 14:48:02.598928+00
18	pbkdf2_sha256$1000000$7TjXW8td6t1AYb2iGHAWiU$x4ZIzNBDbfxe1rmJiVqb0MkQJFs/aijGrYEtcDxsc0E=	\N	f	inesaly2022@gmail.com	JLO1992		inesaly2022@gmail.com	f	t	2025-10-10 14:49:36.3731+00	\N	2025-10-10 14:49:36.629285+00	2025-10-10 14:49:36.629295+00
19	pbkdf2_sha256$1000000$bwdZ1cGORTNakdjaQ3N1Ty$PjOH0xPNcLAwtdfzynT3s6GMXmAofiqRD3S0Efg3xHU=	\N	f	johnchristopher3069@gmail.com	John	Christopher	johnchristopher3069@gmail.com	f	t	2025-10-16 06:23:00.932311+00	\N	2025-10-16 06:23:01.209181+00	2025-10-16 06:23:01.209193+00
20	pbkdf2_sha256$1000000$G9S6r3GlPSymv4N6QdsW8C$yYU6sfRaPlRS+Dj1CaKzOAbxCN5KTQye8yRydd6StsE=	\N	f	abhishek24621@gmail.com	Abhishek 		abhishek24621@gmail.com	f	t	2025-10-16 07:32:52.120191+00	\N	2025-10-16 07:32:52.389576+00	2025-10-16 07:32:52.389589+00
21	pbkdf2_sha256$1000000$QBFk2X0LCcdDwE1CHfSXRd$gQchLN2xZmWehMWVR4k+esDihbTj701Nvkn59EUe+EU=	\N	f	thocho305@gmail.com	thocho		thocho305@gmail.com	f	t	2025-10-16 11:20:36.234724+00	\N	2025-10-16 11:20:36.527358+00	2025-10-16 11:20:36.527367+00
22	pbkdf2_sha256$1000000$J6GWgTBVQcoAJXc9qW29wM$/5C0ALJsF9C7FC9n4b9PmqL7izgMgbzWcREBzqoQWr8=	\N	f	akshaytak32@gmail.com	akshay	Taksande	akshaytak32@gmail.com	f	t	2025-10-18 08:33:30.718017+00	\N	2025-10-18 08:33:30.979258+00	2025-10-18 08:33:30.979271+00
23	pbkdf2_sha256$1000000$OoDiKFelFutBl9cvoY0Ft5$y7Dm2ukuyhpWv7IjUqFlz+WsRGKqGAFu4UuDlxlCTjA=	\N	f	jatinkulthia10d.dpsm@hmail.com	Jatin	kulthia	jatinkulthia10d.dpsm@hmail.com	f	t	2025-10-18 11:07:59.892657+00	\N	2025-10-18 11:08:00.157992+00	2025-10-18 11:08:00.158003+00
24	pbkdf2_sha256$1000000$cdxpJT0LKlllU1PkxRQm3t$gdcbFLAXG1+sWqYJ90NfuHnOzz++nFyX4YNKUyJHoug=	\N	f	santhanakrishnan.h@gmail.com	Santhanakrishnan		santhanakrishnan.h@gmail.com	f	t	2025-10-18 15:26:56.171519+00	\N	2025-10-18 15:26:56.448584+00	2025-10-18 15:26:56.448599+00
25	pbkdf2_sha256$1000000$ydsS32VBHYriS4IMCwM6Xc$UqEBHyXa4A0IJYElfL8IwL99cTyF0+HeJ8Z2Lr5xCrE=	\N	f	divyanshpokhriyalgtm@gmail.com	divyansh	pokhriyal	divyanshpokhriyalgtm@gmail.com	f	t	2025-10-19 18:44:59.424702+00	\N	2025-10-19 18:44:59.687889+00	2025-10-19 18:44:59.687898+00
26	pbkdf2_sha256$1000000$n5q6lTURxiOhBtT1uuFNH9$glzCHQBkoxPas1flRZs0Xb48hqHLDuChc0RkqA1QkEE=	\N	f	anilmehtain@gmail.com	Anil	Mehta	anilmehtain@gmail.com	f	t	2025-10-22 11:08:09.329729+00	\N	2025-10-22 11:08:09.607661+00	2025-10-22 11:08:09.607672+00
27	pbkdf2_sha256$1000000$R9cG2Q2AK53omYt8co5Z0N$S/ge16zRKRhJVCKhwRupcNopJUm7JG5gXTKBeK14cFs=	\N	f	singhbhambra8@gmail.com	Rajdeep	Singh	singhbhambra8@gmail.com	f	t	2025-10-29 07:15:45.880987+00	\N	2025-10-29 07:15:46.170931+00	2025-10-29 07:15:46.170941+00
28	pbkdf2_sha256$1000000$avAkG1ud0VXLzkf5cuiNu2$R9QSOHqCkcOTk8QOu/NZ+rbR/OiSQawdo8vAPRdtmgc=	\N	f	malhartulja1015@gmail.com	Vishal	Bhosale	malhartulja1015@gmail.com	f	t	2025-10-29 07:27:42.046875+00	\N	2025-10-29 07:27:42.33419+00	2025-10-29 07:27:42.334206+00
29	pbkdf2_sha256$1000000$GTerfXbdR6GOtfNv1ZuQbz$kSPJCgmB1qmyrMWmGK6pWBfMp5k6XGQUqJcJNqpiR6s=	\N	f	ankitsahoo061@gmail.com	ANKIT	SAHOO	ankitsahoo061@gmail.com	f	t	2025-10-29 08:04:00.71368+00	\N	2025-10-29 08:04:01.016286+00	2025-10-29 08:04:01.016295+00
30	pbkdf2_sha256$1000000$m2xdm6gO4PHHRaexJp9BN0$31a9Ne6UNTdljOggjVEZ7YkBmfV0pVI2UZXte/iCjQQ=	\N	f	saisuman.misala@gmail.com	Sai	Suman	saisuman.misala@gmail.com	f	t	2025-10-29 08:21:49.320602+00	\N	2025-10-29 08:21:49.601603+00	2025-10-29 08:21:49.601616+00
31	pbkdf2_sha256$1000000$g30VhI6tYdEIkVcdnqII0G$Z2GgsWcLVApfHvEVjx0/0n69HZHGONzvS102/ZBzdxQ=	\N	f	d.ayandutta1308@gmail.com	Ayan	Dutta	d.ayandutta1308@gmail.com	f	t	2025-10-29 13:50:36.733182+00	\N	2025-10-29 13:50:37.065269+00	2025-10-29 13:50:37.065282+00
32	pbkdf2_sha256$1000000$fUvilLSWsEy00EcfgfkTxy$rXPVfTo42c7f5Hz4cMvOBei5FeIUCO+DO2wt9cJIsFQ=	\N	f	taluarko@gmail.com	Arko	Talukder	taluarko@gmail.com	f	t	2025-10-31 01:15:16.654167+00	\N	2025-10-31 01:15:17.006447+00	2025-10-31 01:15:17.006456+00
33	pbkdf2_sha256$1000000$NtLQtjpeEEVPT6LR1I87JG$4bYqzvNTOeYMQhaHwngIfqOXUxrp+m1dz3yBn/plWoA=	\N	f	hari19blue@gmail.com	Hari 		hari19blue@gmail.com	f	t	2025-10-31 03:07:41.037422+00	\N	2025-10-31 03:07:41.328826+00	2025-10-31 03:07:41.328836+00
34	pbkdf2_sha256$1000000$9SbyGkIGsJjNRRaAZ3ScLL$zddTygvHC8ZC2dsW7+SrfdS6lwIVc6Tx3uwbWUJHaq4=	\N	f	gotohasan2020@gmail.com	Mohamedhasan		gotohasan2020@gmail.com	f	t	2025-10-31 13:13:03.197625+00	\N	2025-10-31 13:13:03.474579+00	2025-10-31 13:13:03.474591+00
35	pbkdf2_sha256$1000000$FaKU0HRFX5DLwz5uk2lJRq$8sofRZnXXG1a2tVjz2W8vQy+swjgSFm3Mc9GmcTM6kw=	\N	f	abhinavtrivedi2004@gmail.com	Abhinav	Trivedi	abhinavtrivedi2004@gmail.com	f	t	2025-11-02 13:39:20.747647+00	\N	2025-11-02 13:39:21.029256+00	2025-11-02 13:39:21.029268+00
36	pbkdf2_sha256$1000000$C8nTSyg0HpuM78H5Jf6bYO$VmX8nmHnvKnCyWAcXJnckzMJ1QCdDM3IUYdj7rDEdV0=	\N	f	gautiimanoj@gmail.com	Gautham	m	gautiimanoj@gmail.com	f	t	2025-11-02 18:24:02.32662+00	\N	2025-11-02 18:24:02.59205+00	2025-11-02 18:24:02.592059+00
37	pbkdf2_sha256$1000000$qHXPVnsE1SJjSXS98ieacJ$+cRt4GyRC0ygiz9VAh2kCWwyMv9h2hWpEJ/jbAdc0Ho=	\N	f	shaji@gmail.com	Shaji.	S	shaji@gmail.com	f	t	2025-11-03 02:03:51.851441+00	\N	2025-11-03 02:03:52.129913+00	2025-11-03 02:03:52.129926+00
38	pbkdf2_sha256$1000000$PPxTwHsI4XtEQqGjswUVod$CdkYgBDoOh4IQF/zyK+qA3HEjK8Dpdj0gteaWDFtfrE=	\N	f	rpujari2501@gmail.com	Raghav	Poojari	rpujari2501@gmail.com	f	t	2025-11-03 07:58:48.480465+00	\N	2025-11-03 07:58:48.825915+00	2025-11-03 07:58:48.825926+00
39	pbkdf2_sha256$1000000$Qn2o4lqe9nN8BxACw42APv$u0SyVMbZJR1F712o/mYPwST0Bn73matxcJDgunQzDwI=	\N	f	roshroshan786@gmail.com	Muhammad	Roshan	roshroshan786@gmail.com	f	t	2025-12-22 10:19:06.182732+00	\N	2025-12-22 10:19:06.472021+00	2025-12-22 10:19:06.47203+00
40	pbkdf2_sha256$1000000$W6wTxRDHyO97t096zMueE0$l85QU5dBNHhHDuS2CZ1T+Q1D4XhxMy446sYR7sUgNgw=	\N	f	almaazin05@gmail.com	Maaz		almaazin05@gmail.com	f	t	2025-12-23 05:31:32.762018+00	\N	2025-12-23 05:31:33.070522+00	2025-12-23 05:31:33.070536+00
41	pbkdf2_sha256$1000000$AcBL1tM3eCQriIHnQMJ27e$nXUWKbG1JqKUxzZ7zgVo4tYOlmKT+GR8Ez2Ce/7etfk=	\N	f	nirmalaterrence@gmail.com	Nirmala	Terrence	nirmalaterrence@gmail.com	f	t	2025-12-23 07:14:38.989169+00	\N	2025-12-23 07:14:39.294056+00	2025-12-23 07:14:39.294065+00
42	pbkdf2_sha256$1000000$gKkt72yd4uyAVH8gNTnwXg$jYeQZQJ/g3+fdH6OihzZiYr80rpJlePU0alfXPZV6/k=	\N	f	kim.seo.yoon1993@gmail.com	Anvita	Biswal	kim.seo.yoon1993@gmail.com	f	t	2025-12-24 15:11:36.683523+00	\N	2025-12-24 15:11:37.003929+00	2025-12-24 15:11:37.003942+00
43	pbkdf2_sha256$1000000$H4lXGNo3zDhg5CySHswMlR$tqwGPXUbs/hzKpUgDkjhNKc7BC9F3hscsUrs/9OAomY=	\N	f	bh1ezy17m@mozmail.com	Aravind	R	bh1ezy17m@mozmail.com	f	t	2025-12-25 07:12:49.055326+00	\N	2025-12-25 07:12:49.352721+00	2025-12-25 07:12:49.352735+00
44	pbkdf2_sha256$1000000$vv7izbq7XPIKjQzjtBTBVj$0iNCWVPDidgZtiGBhZpyiuKUvR/tp2AWAjXdriaOI54=	\N	f	jen_4everhere@yahoo.com	Jennifer	Paynter	jen_4everhere@yahoo.com	f	t	2025-12-26 03:54:33.413012+00	\N	2025-12-26 03:54:33.737095+00	2025-12-26 03:54:33.737125+00
46	pbkdf2_sha256$1000000$EHtWH823xlz7YyKxEilzBP$eSxxTj4td12j2LLl7+/rgh7bi9Q2xK/i94JFk6trLmw=	\N	f	pavankoneti1@gmail.com	k	pavan	pavankoneti1@gmail.com	f	t	2026-01-07 17:39:02.39186+00	\N	2026-01-07 17:39:04.932713+00	2026-01-07 17:39:04.932713+00
47	pbkdf2_sha256$1000000$iGvvqQYEW5K0TFQDkZC7ph$vMp4/fV+dcSUel3q7OdhNhqvE0KzQ4AkSdBUVFG87EY=	\N	f	test@gmail.com	test		test@gmail.com	f	t	2026-01-09 18:42:19.877215+00	\N	2026-01-09 18:42:21.973788+00	2026-01-09 18:42:21.973788+00
7	pbkdf2_sha256$1000000$FNN028sNteaHNW5A1EH2IU$gOftjEJN95uBnjm3OaDOtIQnkYuxGqPFUGhJHTkPyAQ=	2025-07-14 13:08:09.991057+00	f	mahesh1@gmail.com	mahesh	babu		t	f	2025-06-24 20:45:17.868874+00	\N	2025-06-24 20:45:18.097086+00	2025-06-24 20:45:18.097096+00
8	pbkdf2_sha256$1000000$1C59xbRDY2ARIYmjrHdDZJ$kVbXE9ut+GEYJr/Qjbgem41xX0X2GJ8468ZwW+F+YkU=	2025-07-18 03:44:29.47603+00	t	mahesh			mahesh@gmail.com	t	f	2025-06-07 21:00:50.509985+00	\N	2025-06-07 21:00:50.670907+00	2025-06-07 21:00:50.670912+00
45	pbkdf2_sha256$1000000$SZEtmvRNirQVvm9hZ7VLuC$I02qFGpe3NiZJo7WVx1JMAqmXjJ8d8C9nF/B716zGyA=	\N	f	pavankoneti161@gmail.com	k	pavan	pavankoneti161@gmail.com	t	t	2025-12-29 18:00:19.218099+00	\N	2025-12-29 18:00:20.147112+00	2026-01-28 07:46:19.491684+00
\.


--
-- Data for Name: core_user_groups; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.core_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: core_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.core_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- Data for Name: django_aws_ses_awssessettings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_aws_ses_awssessettings (id, access_key, secret_key, region_name, region_endpoint, site_id) FROM stdin;
\.


--
-- Data for Name: django_aws_ses_awssesuseraddon; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_aws_ses_awssesuseraddon (id, unsubscribe, user_id) FROM stdin;
\.


--
-- Data for Name: django_aws_ses_blacklisteddomains; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_aws_ses_blacklisteddomains (id, domain, "timestamp") FROM stdin;
\.


--
-- Data for Name: django_aws_ses_bouncerecord; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_aws_ses_bouncerecord (id, "timestamp", email, bounce_type, bounce_sub_type, reporting_mta, status, action, feedback_id, diagnostic_code, cleared) FROM stdin;
\.


--
-- Data for Name: django_aws_ses_complaintrecord; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_aws_ses_complaintrecord (id, "timestamp", email, sub_type, feedback_id, feedback_type) FROM stdin;
\.


--
-- Data for Name: django_aws_ses_sendrecord; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_aws_ses_sendrecord (id, "timestamp", source, destination, subject, message_id, aws_process_time, smtp_response, status) FROM stdin;
\.


--
-- Data for Name: django_aws_ses_sesstat; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_aws_ses_sesstat (id, date, delivery_attempts, bounces, complaints, rejects) FROM stdin;
\.


--
-- Data for Name: django_aws_ses_unknownrecord; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_aws_ses_unknownrecord (id, "timestamp", event_type, aws_data) FROM stdin;
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	contenttypes	contenttype
5	sessions	session
6	core	category
7	core	product
8	core	user
9	core	order
10	core	orderitem
11	core	shippingaddress
12	core	stocknotification
13	core	cart
14	token_blacklist	blacklistedtoken
15	token_blacklist	outstandingtoken
16	core	productimage
17	core	cartitem
18	core	tag
19	sites	site
20	django_aws_ses	blacklisteddomains
21	django_aws_ses	sesstat
22	django_aws_ses	awssessettings
23	django_aws_ses	awssesuseraddon
24	django_aws_ses	bouncerecord
25	django_aws_ses	complaintrecord
26	django_aws_ses	sendrecord
27	django_aws_ses	unknownrecord
28	core	appnotification
29	core	productvariant
30	payments	payupayment
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2025-06-07 20:56:24.299792+00
2	contenttypes	0002_remove_content_type_name	2025-06-07 20:56:24.303875+00
3	auth	0001_initial	2025-06-07 20:56:24.326607+00
4	auth	0002_alter_permission_name_max_length	2025-06-07 20:56:24.329425+00
5	auth	0003_alter_user_email_max_length	2025-06-07 20:56:24.3306+00
6	auth	0004_alter_user_username_opts	2025-06-07 20:56:24.331969+00
7	auth	0005_alter_user_last_login_null	2025-06-07 20:56:24.333106+00
8	auth	0006_require_contenttypes_0002	2025-06-07 20:56:24.333497+00
9	auth	0007_alter_validators_add_error_messages	2025-06-07 20:56:24.334783+00
10	auth	0008_alter_user_username_max_length	2025-06-07 20:56:24.335978+00
11	auth	0009_alter_user_last_name_max_length	2025-06-07 20:56:24.337412+00
12	auth	0010_alter_group_name_max_length	2025-06-07 20:56:24.339498+00
13	auth	0011_update_proxy_permissions	2025-06-07 20:56:24.340454+00
14	auth	0012_alter_user_first_name_max_length	2025-06-07 20:56:24.341801+00
15	core	0001_initial	2025-06-07 20:56:24.415744+00
16	admin	0001_initial	2025-06-07 20:56:24.426515+00
17	admin	0002_logentry_remove_auto_add	2025-06-07 20:56:24.429747+00
18	admin	0003_logentry_add_action_flag_choices	2025-06-07 20:56:24.432345+00
19	sessions	0001_initial	2025-06-07 20:56:24.436411+00
20	token_blacklist	0001_initial	2025-06-07 20:56:24.452279+00
21	token_blacklist	0002_outstandingtoken_jti_hex	2025-06-07 20:56:24.455814+00
22	token_blacklist	0003_auto_20171017_2007	2025-06-07 20:56:24.460736+00
23	token_blacklist	0004_auto_20171017_2013	2025-06-07 20:56:24.465629+00
24	token_blacklist	0005_remove_outstandingtoken_jti	2025-06-07 20:56:24.468929+00
25	token_blacklist	0006_auto_20171017_2113	2025-06-07 20:56:24.472145+00
26	token_blacklist	0007_auto_20171017_2214	2025-06-07 20:56:24.486848+00
27	token_blacklist	0008_migrate_to_bigautofield	2025-06-07 20:56:24.50768+00
28	token_blacklist	0010_fix_migrate_to_bigautofield	2025-06-07 20:56:24.515178+00
29	token_blacklist	0011_linearizes_history	2025-06-07 20:56:24.516417+00
30	token_blacklist	0012_alter_outstandingtoken_user	2025-06-07 20:56:24.519823+00
31	core	0002_productimage	2025-06-07 21:19:22.533995+00
32	core	0003_alter_user_email	2025-06-07 21:57:01.213022+00
33	core	0004_create_superadmin	2025-06-07 22:02:23.394281+00
34	core	0005_alter_cart_options_alter_orderitem_options_and_more	2025-06-24 10:22:50.969162+00
35	core	0006_remove_category_updated_at	2025-06-24 10:22:50.970063+00
36	core	0007_category_updated_at	2025-06-24 10:23:17.311957+00
37	core	0008_remove_product_category	2025-06-25 10:29:07.441332+00
38	core	0009_product_category	2025-06-25 10:29:57.396935+00
39	core	0010_product_image_url	2025-06-25 15:36:18.38045+00
40	core	0011_alter_orderitem_options_remove_orderitem_created_at	2025-06-27 12:33:32.302063+00
41	core	0012_alter_orderitem_options_orderitem_created_at	2025-06-27 12:34:18.340637+00
42	core	0013_tag_remove_product_tags_product_tags	2025-06-27 14:34:16.340564+00
43	core	0014_shippingaddress_recipient_email	2025-06-28 20:13:38.82098+00
44	core	0015_alter_productimage_options_and_more	2025-07-03 21:22:45.122025+00
45	core	0016_delete_cartitem	2025-07-08 19:12:57.493342+00
46	core	0017_cartitem	2025-07-08 19:13:15.476191+00
47	core	0018_productimage_status	2025-07-08 19:23:49.471849+00
48	core	0019_rename_status_productimage_type	2025-07-08 19:24:18.936901+00
49	core	0020_alter_category_image_url_alter_product_image_url_and_more	2025-07-08 19:32:43.50933+00
50	sites	0001_initial	2025-07-17 08:20:48.226211+00
51	sites	0002_alter_domain_unique	2025-07-17 08:20:50.024417+00
52	django_aws_ses	0001_initial	2025-07-17 08:21:31.591442+00
53	core	0021_remove_product_category_product_categories	2025-09-03 20:09:41.729791+00
54	core	0022_appnotification	2025-09-18 07:03:12.859746+00
55	core	0023_appnotification_user	2025-09-19 04:49:56.77367+00
56	core	0024_set_order_pk_sequence	2025-10-09 12:18:48.9394+00
60	core	0025_remove_product_compare_at_price_and_more	2026-01-03 07:03:30.876166+00
61	core	0026_alter_productvariant_category	2026-01-03 07:09:27.715108+00
62	core	0027_rename_category_productvariant_variant_type_and_more	2026-01-03 11:17:00.360836+00
63	core	0028_alter_productvariant_options	2026-01-20 17:20:25.725461+00
64	core	0029_alter_order_status	2026-01-20 17:20:25.875806+00
65	payments	0001_initial	2026-01-20 17:20:26.606849+00
66	core	0030_delete_stocknotification	2026-02-08 09:16:04.153183+00
67	core	0031_stocknotification	2026-02-08 09:17:19.375668+00
68	core	0032_stocknotification_unique_email_per_product_and_more	2026-02-08 12:39:40.875167+00
69	core	0033_alter_stocknotification_unique_together	2026-02-08 12:41:07.830848+00
70	core	0030_alter_stocknotification_unique_together_and_more	2026-02-08 13:01:58.090849+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
q2bn23u7lqhytt8fz42gbzmue0u9dfzc	.eJxVjMEOwiAQBf-FsyHAAgWP3v0GAssiVQNJaU_Gf9cmPej1zcx7sRC3tYZt0BLmzM5MstPvliI-qO0g32O7dY69rcuc-K7wgw5-7Zmel8P9O6hx1G-ti9JQYCoSZQQLIjtjIBsHTmiRbZkIrULrPZhImgx6dKqQcgmLlYm9P8hTN7E:1uO0zt:2lld3rVaIrQv-vmrPNbMrvOp15L1QLXIDxvb8wriGiM	2025-06-21 21:22:37.10829+00
6xei0907uirxsqmkyq1h10hb8rg6qeak	.eJxVjMEOwiAQBf-FsyHAAgWP3v0GAssiVQNJaU_Gf9cmPej1zcx7sRC3tYZt0BLmzM5MstPvliI-qO0g32O7dY69rcuc-K7wgw5-7Zmel8P9O6hx1G-ti9JQYCoSZQQLIjtjIBsHTmiRbZkIrULrPZhImgx6dKqQcgmLlYm9P8hTN7E:1uO11l:tUaij6YQh9mb8ga4Sy4lvwZgH88xwt8pbo-urue4tiI	2025-06-21 21:24:33.2988+00
ry6hlw6yiemrd60u0iyhetxj2fdn1txj	.eJxVjDsOwjAQBe_iGlnxL7Yp6TmDtdn14gCypTipEHeHSCmgfTPzXiLBtpa09bykmcRZeHH63SbAR647oDvUW5PY6rrMk9wVedAur43y83K4fwcFevnWA0fNjgyMTKycRhc0WjIhDDiy9VGjZ-tCVCo7rbxBZg-oo43gWUXx_gDiGTeX:1ubIuf:PoaQwy_c9fq_9jsWcjORLWFpzf0g0FaICrpXkIoarac	2025-07-28 13:08:09.998772+00
ixkk4jubot1nmhz10f6tjy2sgzl2wgaf	.eJxVjMEOwiAQBf-FsyHAAgWP3v0GAssiVQNJaU_Gf9cmPej1zcx7sRC3tYZt0BLmzM5MstPvliI-qO0g32O7dY69rcuc-K7wgw5-7Zmel8P9O6hx1G-ti9JQYCoSZQQLIjtjIBsHTmiRbZkIrULrPZhImgx6dKqQcgmLlYm9P8hTN7E:1ucc1N:KUZaxElLsYNQEJbdJSaMFvrPbh5VtV-1ZJxU6N62IkU	2025-08-01 03:44:29.65399+00
\.


--
-- Data for Name: django_site; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_site (id, domain, name) FROM stdin;
1	example.com	example.com
\.


--
-- Data for Name: payments_payupayment; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.payments_payupayment (id, txnid, amount, status, phone, email, mihpayid, mode, payu_response, verified, error_message, created_at, updated_at, order_id, user_id) FROM stdin;
1	9bfe76ed3ca340faba5f	244.00	initiated	8087236348		\N	\N	\N	f	\N	2026-01-20 17:34:02.160885+00	2026-01-20 17:34:02.160905+00	37	7
2	66ab0e4bcd334dbabc94	480.00	initiated	8087236348		\N	\N	\N	f	\N	2026-01-20 17:36:20.852496+00	2026-01-20 17:36:20.852517+00	38	7
3	29dcc390a76d4f0184cd	382.00	initiated	8087236348		\N	\N	\N	f	\N	2026-01-20 17:39:29.295185+00	2026-01-20 17:39:29.295209+00	39	7
4	fb530144fef2434ab63a	498.00	initiated	8087236348		\N	\N	\N	f	\N	2026-01-20 17:45:59.074957+00	2026-01-20 17:45:59.074971+00	40	7
5	3fe3328b926346b98f66	324.00	initiated	8087236348		\N	\N	\N	f	\N	2026-01-20 17:50:33.468303+00	2026-01-20 17:50:33.468323+00	41	7
6	7fc26780c0894abe8eb3	208.00	initiated	8087236348		\N	\N	\N	f	\N	2026-01-20 18:09:04.897928+00	2026-01-20 18:09:04.897947+00	42	7
7	35d8cdf0cbad408d96fa	208.00	initiated	8087236348		\N	\N	\N	f	\N	2026-01-21 02:46:25.618097+00	2026-01-21 02:46:25.618111+00	43	7
8	04b864dfd5e44640800a	208.00	initiated	8087236348		\N	\N	\N	f	\N	2026-01-22 11:34:59.674813+00	2026-01-22 11:34:59.674831+00	44	7
9	0f6f50e5f61f4fe0bf4d	208.00	initiated	8087236348		\N	\N	\N	f	\N	2026-01-22 11:41:11.07575+00	2026-01-22 11:41:11.07577+00	45	7
10	365d02dbe84a4db9b8d4	950.00	initiated	7013811044	pavankoneti161@gmail.com	\N	\N	\N	f	\N	2026-01-26 18:31:28.106204+00	2026-01-26 18:31:28.106204+00	104	45
11	41f5f1a7a13141679211	330.00	initiated	7013811044	pavankoneti161@gmail.com	\N	\N	\N	f	\N	2026-01-28 06:08:00.179928+00	2026-01-28 06:08:00.179928+00	107	45
12	ad344b0dec2745fa9ded	330.00	initiated	7013811044	pavankoneti161@gmail.com	\N	\N	\N	f	\N	2026-01-28 06:12:07.684995+00	2026-01-28 06:12:07.684995+00	108	45
13	51b46b644cc446019dbd	310.00	initiated	7013811044	pavankoneti161@gmail.com	\N	\N	\N	f	\N	2026-01-28 06:12:54.433346+00	2026-01-28 06:12:54.433346+00	109	45
\.


--
-- Data for Name: session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.session (sid, sess, expire) FROM stdin;
4qVjq-ojs6RGoPV4_b2x9LnD4TIIKoiE	{"cookie":{"originalMaxAge":604800000,"expires":"2025-06-04T16:20:32.958Z","secure":false,"httpOnly":true,"path":"/","sameSite":"lax"},"userId":2}	2025-06-04 21:50:34
s6SXPGL0sR4jrZIFBEQSweTQESi-meoe	{"cookie":{"originalMaxAge":604800000,"expires":"2025-06-02T07:46:22.717Z","secure":false,"httpOnly":true,"path":"/","sameSite":"lax"},"userId":1}	2025-06-04 17:07:46
kfmFquFboCh-0hP7-y_1mxNp15YqutEC	{"cookie":{"originalMaxAge":604800000,"expires":"2025-06-10T17:04:49.478Z","secure":false,"httpOnly":true,"path":"/","sameSite":"lax"},"userId":4}	2025-06-10 22:56:22
\.


--
-- Data for Name: token_blacklist_blacklistedtoken; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.token_blacklist_blacklistedtoken (id, blacklisted_at, token_id) FROM stdin;
\.


--
-- Data for Name: token_blacklist_outstandingtoken; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.token_blacklist_outstandingtoken (id, token, created_at, expires_at, user_id, jti) FROM stdin;
1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc0OTQxOTIyMiwiaWF0IjoxNzQ5MzMyODIyLCJqdGkiOiJlMDFkM2I2YTM1NzA0YmIyYWYwNTI4YzgwMjI2YjUyZCIsInVzZXJfaWQiOjJ9.UW9ZghUnISzZdggQnpCHqOidc6VlFLT453bo9DROSqY	2025-06-07 21:47:02.706724+00	2025-06-08 21:47:02+00	2	e01d3b6a35704bb2af0528c80226b52d
2	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1MDg0NzEyNCwiaWF0IjoxNzUwNzYwNzI0LCJqdGkiOiIxY2UyYWZhNjlhM2M0MjQ2ODMzOTA3YmVkOGMzMDA4OSIsInVzZXJfaWQiOjJ9.4RZV4-wAQbBlPC4Wn4_zAC00u2WgBahQHyElJlYTFW4	2025-06-24 10:25:24.553744+00	2025-06-25 10:25:24+00	2	1ce2afa69a3c4246833907bed8c30089
3	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1MDg4NDMzNSwiaWF0IjoxNzUwNzk3OTM1LCJqdGkiOiI2ZGUzZmRmYzZiMTQ0YmYyOGJlMWEzNWMxYTMzYThlOCIsInVzZXJfaWQiOjd9.YIh6Yv-Zro30HXkoIAadrogo7Xb5n-ot8AkcJS0msbg	2025-06-24 20:45:35.5391+00	2025-06-25 20:45:35+00	7	6de3fdfc6b144bf28be1a35c1a33a8e8
4	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1MDg4NDM4MSwiaWF0IjoxNzUwNzk3OTgxLCJqdGkiOiJlNzJiNmY4NzM2ZmM0OGEwOTBkYzc1ZWZmZjQ0YzdmNyIsInVzZXJfaWQiOjd9.CpxWmLOSas8pD6fgOt_eCRnTRrRzt5sEEQT9D5VrYds	2025-06-24 20:46:21.841386+00	2025-06-25 20:46:21+00	7	e72b6f8736fc48a090dc75efff44c7f7
5	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1MDg4NDQwNCwiaWF0IjoxNzUwNzk4MDA0LCJqdGkiOiJmN2I2OGQyMTdkYzY0NDU2OTA0YTg3Y2M2MTQ4OTgzYyIsInVzZXJfaWQiOjd9.RoHFw55rlXaxjBCh5ZMwsKQEiylo0KUmvv7XlZ8vzpU	2025-06-24 20:46:44.949081+00	2025-06-25 20:46:44+00	7	f7b68d217dc64456904a87cc6148983c
6	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1MDg4NTIxMSwiaWF0IjoxNzUwNzk4ODExLCJqdGkiOiI2ODFiMDdhYTFhMjk0NGI3YjkwYjAwOTBiMTIwMmRkYiIsInVzZXJfaWQiOjd9.pS6r2-8mJcdEk7Jk5Ompo8Pr7fzNAvnOtmpB25S1WkU	2025-06-24 21:00:11.992817+00	2025-06-25 21:00:11+00	7	681b07aa1a2944b7b90b0090b1202ddb
7	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1MDg4NTIyOCwiaWF0IjoxNzUwNzk4ODI4LCJqdGkiOiI1YzU0ZjE4MTM3ZjA0YmU3YTc3ZWM1Mjk4ZDQ5YWUzMyIsInVzZXJfaWQiOjd9.IJJmxlay9G6Tr-pM3ltC9SZ9zSWPWhqn4EpwB20dz8c	2025-06-24 21:00:28.561547+00	2025-06-25 21:00:28+00	7	5c54f18137f04be7a77ec5298d49ae33
8	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1MDg4NjE3NSwiaWF0IjoxNzUwNzk5Nzc1LCJqdGkiOiI4MzcwZDQzOTUzOWQ0ZDMzYWRmM2FiNDcyNjdkMDBhMSIsInVzZXJfaWQiOjd9.8MgP8K_lv4Z2evZdh8Vi5LbIA1YzPDfnww1WTn745yM	2025-06-24 21:16:15.692355+00	2025-06-25 21:16:15+00	7	8370d439539d4d33adf3ab47267d00a1
9	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1MDg4Njc0NiwiaWF0IjoxNzUwODAwMzQ2LCJqdGkiOiI3MTZmY2ZiYjYxNmU0Nzc1OThmZjE1MGRhYzljNmJmYyIsInVzZXJfaWQiOjd9.56tAfrxFDK8ATwS81F3vC0xR6Pr0IFpRbKEK7Hrnqe8	2025-06-24 21:25:46.834561+00	2025-06-25 21:25:46+00	7	716fcfbb616e477598ff150dac9c6bfc
10	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1MDg4NzA5MywiaWF0IjoxNzUwODAwNjkzLCJqdGkiOiJmNWUwNzJiOWU4MTQ0ZGEwOWU2NzQzNjM0N2JjYzFjMiIsInVzZXJfaWQiOjd9.FPPHOn2XUIXsO6Wi-Ai8z8CULAElOddO4Y_gX75BzpE	2025-06-24 21:31:33.218836+00	2025-06-25 21:31:33+00	7	f5e072b9e8144da09e67436347bcc1c2
11	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1MDg4ODM1MCwiaWF0IjoxNzUwODAxOTUwLCJqdGkiOiI4ZTZjZGVmNzM5M2Q0NThlOTIxZDgyZDY3N2NmZWZlYiIsInVzZXJfaWQiOjJ9.8XZQPTk5tk9Vt6xlQ7qqoFk_pqMROITIbkTtVG0Fn1s	2025-06-24 21:52:30.809298+00	2025-06-25 21:52:30+00	2	8e6cdef7393d458e921d82d677cfefeb
12	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1MDg4ODQ0MSwiaWF0IjoxNzUwODAyMDQxLCJqdGkiOiI1ZmVhZjA5ZGZhOTQ0NDFkODJhNzhmZjU4NWU1OGYzMyIsInVzZXJfaWQiOjd9.xucEzSWbHKJV9iJPqmSr2I8l9cet0tmiZRocCZQAaLk	2025-06-24 21:54:01.557443+00	2025-06-25 21:54:01+00	7	5feaf09dfa94441d82a78ff585e58f33
13	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1MDg5MDU0OCwiaWF0IjoxNzUwODA0MTQ4LCJqdGkiOiJlZDMyOGQ2MzE3NmE0MDA5YWFjMzdlOGU3MmY5ZDU5MSIsInVzZXJfaWQiOjd9.ynRZORku_oVlTwzRF85Ueb1rj1Gd5Eabln01fBHMLc8	2025-06-24 22:29:08.428219+00	2025-06-25 22:29:08+00	7	ed328d63176a4009aac37e8e72f9d591
14	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1MDg5MDY0NiwiaWF0IjoxNzUwODA0MjQ2LCJqdGkiOiJlNzM4YWM4ZDg3NDA0YmNiODhlYTI5YWEwMzM2NTQ2MSIsInVzZXJfaWQiOjd9._XyDd806QDu8HHTLkjsLh_Ku7CZMEWsiHh8SkH83WUQ	2025-06-24 22:30:46.461963+00	2025-06-25 22:30:46+00	7	e738ac8d87404bcb88ea29aa03365461
15	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1MDkzMzIwMCwiaWF0IjoxNzUwODQ2ODAwLCJqdGkiOiI5YzE3NTJhZDgzZmI0MmY0OWFjYjBjZGFkZjk4OGRmMiIsInVzZXJfaWQiOjd9.WIoR4M1GtMhXyT310WiIYvN9HyiD4JVuXocMpRiQ2Mg	2025-06-25 10:20:00.710297+00	2025-06-26 10:20:00+00	7	9c1752ad83fb42f49acb0cdadf988df2
16	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1MDkzMzM5OCwiaWF0IjoxNzUwODQ2OTk4LCJqdGkiOiJiNTY1ZTBjOWM5YjY0ZWFjYTczYzczOWMxMGNjOGI2YSIsInVzZXJfaWQiOjd9.Rc8vJ8qHb7As1w2CqG3pmF-u-h8geEz_VOIS2UX6YmY	2025-06-25 10:23:18.516512+00	2025-06-26 10:23:18+00	7	b565e0c9c9b64eaca73c739c10cc8b6a
17	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1MDkzMzQ2NiwiaWF0IjoxNzUwODQ3MDY2LCJqdGkiOiI1ODEwZmE3Nzc3MTc0MGI0YTg1ZjU4ODY0NzcxYWNlOSIsInVzZXJfaWQiOjd9.7WraZK4U6S1NTjxBTcaE9WjO4_Ynz6eL-K3y6u7xvu0	2025-06-25 10:24:26.020782+00	2025-06-26 10:24:26+00	7	5810fa77771740b4a85f58864771ace9
18	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1MDkzMzQ4NiwiaWF0IjoxNzUwODQ3MDg2LCJqdGkiOiIzMzJhMjJlZTFhMDY0ZWU3ODM4NGU1ODE2MjczNWY2YyIsInVzZXJfaWQiOjd9.7Yc6NSo5Tk0A6zygz66CKyYuS0GHrdGUVzM4vd_gPAk	2025-06-25 10:24:46.657907+00	2025-06-26 10:24:46+00	7	332a22ee1a064ee78384e58162735f6c
19	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1MDkzNDI3OSwiaWF0IjoxNzUwODQ3ODc5LCJqdGkiOiIzMTc2YzYzYjcyZGY0MWRhOTA0OGM1YWZhNjQ5YjgyMyIsInVzZXJfaWQiOjd9.Dddzr4HFBSb2qmsX3mU7k19_UMDHz922g0gNFmSeOpU	2025-06-25 10:37:59.819697+00	2025-06-26 10:37:59+00	7	3176c63b72df41da9048c5afa649b823
20	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1MDkzNDI5MiwiaWF0IjoxNzUwODQ3ODkyLCJqdGkiOiJjMDRhNDZlN2VlYzY0NDdiYWE1NjE0YjVlODQ3N2I1MiIsInVzZXJfaWQiOjd9.wfAsAtlq9Fv4w1VLEH7Pd0tWNdlQqT1CmTTNEt39wac	2025-06-25 10:38:12.827995+00	2025-06-26 10:38:12+00	7	c04a46e7eec6447baa5614b5e8477b52
21	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1MDk1MTM2MiwiaWF0IjoxNzUwODY0OTYyLCJqdGkiOiI3MTQ4ZTBiNzNiYmU0YjA3OTEzMmIyYWRjMjlhMDY0YSIsInVzZXJfaWQiOjd9.c98n2oZXMEWNhgu_tcho9gMROHzXDzP-KM7aMKa8j5g	2025-06-25 15:22:42.252229+00	2025-06-26 15:22:42+00	7	7148e0b73bbe4b079132b2adc29a064a
22	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1MzQ4NDkwNywiaWF0IjoxNzUwODkyOTA3LCJqdGkiOiI0ZDIyNzg3OTRmNWE0MDc1OGY2ZTJmNGYzZTBhMDIxNiIsInVzZXJfaWQiOjd9.2iJXsDUxU9GbQjCm80lpLbPO6ph5T_F8APzJF14-YK0	2025-06-25 23:08:27.309677+00	2025-07-25 23:08:27+00	7	4d2278794f5a40758f6e2f4f3e0a0216
23	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1MzQ4NTAxMiwiaWF0IjoxNzUwODkzMDEyLCJqdGkiOiI0ODQxYjBkY2FlZTA0MmFmYTE1Yjc5YjExNGJkZjNkZSIsInVzZXJfaWQiOjd9.blQ0yBSa6QPQ1QGMZfC0Y3LysXDLRetMOfhOrdpdJCw	2025-06-25 23:10:12.791398+00	2025-07-25 23:10:12+00	7	4841b0dcaee042afa15b79b114bdf3de
24	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1MzYxOTQwNSwiaWF0IjoxNzUxMDI3NDA1LCJqdGkiOiJmOWMzZWM4NWE2YmM0MTY5YjM1NTNkNGUxMDdjN2NhNSIsInVzZXJfaWQiOjd9.LPtwHj8qBfnDOhw8Vs7yrfIl99yWBXgblPZWX-0nO9o	2025-06-27 12:30:05.452577+00	2025-07-27 12:30:05+00	7	f9c3ec85a6bc4169b3553d4e107c7ca5
25	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1MzY0NzM1MywiaWF0IjoxNzUxMDU1MzUzLCJqdGkiOiIzYTQ4OTBiMzAwYWM0Y2Q3YjA1Y2IwODc4M2JlZDdjNiIsInVzZXJfaWQiOjd9.EHUCS4gPZu_O-awQBPD1_gylk5gX8IH0UV_WkJesHIU	2025-06-27 20:15:53.378222+00	2025-07-27 20:15:53+00	7	3a4890b300ac4cd7b05cb08783bed7c6
26	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1NDQ1ODEwMiwiaWF0IjoxNzUxODY2MTAyLCJqdGkiOiI3ZjM2YzNlOTM0NDY0MmE0ODk5ODFkYTlhODhmNThmMCIsInVzZXJfaWQiOjd9.ssxT2oTiedUhZcPrSb4JdfInV5VKqat5ZV2h8oq1r5M	2025-07-07 05:28:22.429658+00	2025-08-06 05:28:22+00	7	7f36c3e9344642a489981da9a88f58f0
27	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1NDQ1ODY4MiwiaWF0IjoxNzUxODY2NjgyLCJqdGkiOiJkMTI3MDhjMzcwNjU0NzA1YTRjYTg2ZTIyOTMyYjEzMyIsInVzZXJfaWQiOjd9.PdHJiEXXfDRrHBgtjCTB9ijy4kJaktrYjNALCFB4_Gs	2025-07-07 05:38:02.051576+00	2025-08-06 05:38:02+00	7	d12708c370654705a4ca86e22932b133
28	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1NTE1MTE4NywiaWF0IjoxNzUyNTU5MTg3LCJqdGkiOiJmZjA5ZjFlMmFmOTI0YjE0YjcyN2Q4ZGJlNGM4OWZlMCIsInVzZXJfaWQiOjd9.R9iOs7jEAs5KIy-i-3vC4J37G73oLTC0MNofsM-pGpg	2025-07-15 05:59:47.520087+00	2025-08-14 05:59:47+00	7	ff09f1e2af924b14b727d8dbe4c89fe0
29	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1NTU3OTQ2NCwiaWF0IjoxNzUyOTg3NDY0LCJqdGkiOiJhN2M3YzBjODBkOWI0Y2NmOTEzMDE2NjgzYTAyNDQ1YiIsInVzZXJfaWQiOjd9.7pUOgq1CItwIksuPUQuFwkbuzuvhCyYZETdTHP_4_NQ	2025-07-20 04:57:44.234216+00	2025-08-19 04:57:44+00	7	a7c7c0c80d9b4ccf913016683a02445b
30	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1NTYyNjkzNywiaWF0IjoxNzUzMDM0OTM3LCJqdGkiOiJiNjZlOWM4NTU1YTg0ZjYyOTE2MTgxMjMzYjU0YzllNiIsInVzZXJfaWQiOjd9.csJhyjROvbf6popuTwcZ3tJecVwjyB70gndJ-_64nm0	2025-07-20 18:08:57.867455+00	2025-08-19 18:08:57+00	7	b66e9c8555a84f62916181233b54c9e6
31	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1NjU3MzQwOSwiaWF0IjoxNzUzOTgxNDA5LCJqdGkiOiI1NmE3MjBmMWQ1M2U0OTUyODRjMWFmOTFkZTcxZjQ3YiIsInVzZXJfaWQiOjd9.nwFUg0IG77OMZRXADfi0-iz_BYV21S9Zv1P9mRKo_-Y	2025-07-31 17:03:29.752319+00	2025-08-30 17:03:29+00	7	56a720f1d53e495284c1af91de71f47b
32	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1NzEzOTk0NSwiaWF0IjoxNzU0NTQ3OTQ1LCJqdGkiOiJiY2FkNGVmZjQ2NWM0NzdmYWU4MjA1NGE1MTYzNmQ3YyIsInVzZXJfaWQiOjd9.rIqZeIInFi-inrSbrJ2v5zDsTV_XAl-zlxNztRfb6Oc	2025-08-07 06:25:45.001104+00	2025-09-06 06:25:45+00	7	bcad4eff465c477fae82054a51636d7c
33	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1NzEzOTk4OSwiaWF0IjoxNzU0NTQ3OTg5LCJqdGkiOiI5MThiMDFhYWZiZWY0MGIxYmNhOTMwNDY0ZTExMzhlYSIsInVzZXJfaWQiOjd9.gmmdWkcAbCs43UW7ptSzaMegaXrdhFcQJ3SnWoEtC9I	2025-08-07 06:26:29.11809+00	2025-09-06 06:26:29+00	7	918b01aafbef40b1bca930464e1138ea
34	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1NzE0MTc1NSwiaWF0IjoxNzU0NTQ5NzU1LCJqdGkiOiI5OTZmNTA4MzVjNDQ0ZmM1YTM1MDI3NDc4YWZlM2EyNSIsInVzZXJfaWQiOjd9.YFrwns0QOUdh6XPARMWf58vlAs1BSlDqffDgJAxynbA	2025-08-07 06:55:55.869287+00	2025-09-06 06:55:55+00	7	996f50835c444fc5a35027478afe3a25
35	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1NzIyNzE5NSwiaWF0IjoxNzU0NjM1MTk1LCJqdGkiOiIyMzdmNDQ5MjJiOTY0NGQwYmE2ZWJhMmM4Nzg1MDAyNCIsInVzZXJfaWQiOjd9.Zm09LpBUo_5Uvoaq_nB_oJpxsG4qko6GAWXiiy7TWtw	2025-08-08 06:39:55.361557+00	2025-09-07 06:39:55+00	7	237f44922b9644d0ba6eba2c87850024
36	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1NzIzMjEzNywiaWF0IjoxNzU0NjQwMTM3LCJqdGkiOiJiM2ExYzdhMGRlMTA0OTVmYTgyZmFlZTdmNjU4ZDRhMSIsInVzZXJfaWQiOjd9.uYYtByz1AlhpT3UgM5CYBYDTPZFTWJitFoyLIRgJvWs	2025-08-08 08:02:17.655196+00	2025-09-07 08:02:17+00	7	b3a1c7a0de10495fa82faee7f658d4a1
37	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1NzQ0MzEyNiwiaWF0IjoxNzU0ODUxMTI2LCJqdGkiOiJkZGYxNmVhYjM2OTc0ODgzOTFmMTA2NWIxNTZjYjRkMyIsInVzZXJfaWQiOjd9.eTQJS5ipqy1je67NzLjGST4ypmGUhSuiCP72WCYraBs	2025-08-10 18:38:46.968297+00	2025-09-09 18:38:46+00	7	ddf16eab3697488391f1065b156cb4d3
38	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1NzU5MzIxMCwiaWF0IjoxNzU1MDAxMjEwLCJqdGkiOiI0MTc5ODc2NmE0Njg0MzEyYmE4YTM4MDU4YmZmYTZmZCIsInVzZXJfaWQiOjd9.j856orybq6-LgHCqjnSWx-9w8EbuygLgsMf8GWsx7sg	2025-08-12 12:20:10.322842+00	2025-09-11 12:20:10+00	7	41798766a4684312ba8a38058bffa6fd
39	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1NzU5Mzg3MiwiaWF0IjoxNzU1MDAxODcyLCJqdGkiOiJhYTM0M2YyYzYwNjI0YzE2YTIzYzJlNzA1NGIzYzA3OSIsInVzZXJfaWQiOjd9.u38qZUjSa1JD3kSzbxpngIHfxMiBnQZN0WiCx0iR3rs	2025-08-12 12:31:12.630365+00	2025-09-11 12:31:12+00	7	aa343f2c60624c16a23c2e7054b3c079
40	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1NzYwMDg4NiwiaWF0IjoxNzU1MDA4ODg2LCJqdGkiOiI1MDhhM2I2YjJhODk0NWMyYWMyZGM0Y2FkN2FlOTVlMCIsInVzZXJfaWQiOjd9.tb5f2SzBar0g5LpVMhSF6VLHo1WKxuLf-R2O0YtiorQ	2025-08-12 14:28:06.478882+00	2025-09-11 14:28:06+00	7	508a3b6b2a8945c2ac2dc4cad7ae95e0
41	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1ODQzNzE1NiwiaWF0IjoxNzU1ODQ1MTU2LCJqdGkiOiIxYzI0ZDBkZTAzNGI0MzM3YjU3MzQ0NDE3OWNlYjQwNiIsInVzZXJfaWQiOjd9.mXnQdxd8zMEtqM035UDpQNqNCRfyBut9Mhw5kqbYEMc	2025-08-22 06:45:56.754364+00	2025-09-21 06:45:56+00	7	1c24d0de034b4337b573444179ceb406
42	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTUwMDA5MiwiaWF0IjoxNzU2OTA4MDkyLCJqdGkiOiIwMzEyMTE1NjEwNjY0YTNiYWRkODgzN2Q0ZDA1NjdmZSIsInVzZXJfaWQiOjd9.4Rxtx5wjWo6MK-GZSK4MdVf_GoQesutV9ICbbroD-I0	2025-09-03 14:01:32.734841+00	2025-10-03 14:01:32+00	7	0312115610664a3badd8837d4d0567fe
43	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTU3NjIyNywiaWF0IjoxNzU2OTg0MjI3LCJqdGkiOiI2ZTc5NjkxMGEzZTQ0M2YwYjE4MGZiNTlkOTU5ODRkMyIsInVzZXJfaWQiOjd9.NHPjj4gdjeDT1qIUoL9Ce2EHDoBokIkba2DBBtJILVs	2025-09-04 11:10:27.709554+00	2025-10-04 11:10:27+00	7	6e796910a3e443f0b180fb59d95984d3
44	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTU3NjY5NCwiaWF0IjoxNzU2OTg0Njk0LCJqdGkiOiJlNmQ4MmY0MzkzZTA0MWY3OTg4MTQ0OWVhMDNhMTg3ZCIsInVzZXJfaWQiOjd9.7KDOqVKqtdOrgJ1e5YIe679e-bnGbUy-Jc9iY7uMKiA	2025-09-04 11:18:14.42472+00	2025-10-04 11:18:14+00	7	e6d82f4393e041f79881449ea03a187d
45	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTY4NDQxNSwiaWF0IjoxNzU3MDkyNDE1LCJqdGkiOiJkNzE3YTI3MmZlOWI0NzE1YTZjNzczYjEzNTE5M2Q5OSIsInVzZXJfaWQiOjd9.TCm0Lc5U50FPTAzrTMwhXdDMN5IjIxF3L7sWENN58S4	2025-09-05 17:13:35.200651+00	2025-10-05 17:13:35+00	7	d717a272fe9b4715a6c773b135193d99
46	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTY5MTE5OCwiaWF0IjoxNzU3MDk5MTk4LCJqdGkiOiJhZmM5MDA0MTc0NDM0M2RhOWJiN2U5MjU2MjY2OGM5NiIsInVzZXJfaWQiOjd9.fLpD9HNr1Za5SKQecpm3PQOZ3oHdMaqXFD9X73BxBVo	2025-09-05 19:06:38.794145+00	2025-10-05 19:06:38+00	7	afc90041744343da9bb7e92562668c96
47	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTY5MTQ4NywiaWF0IjoxNzU3MDk5NDg3LCJqdGkiOiI0MzQzYWFiNWYzMmU0N2E2OWVhMjM5ZjYyZTE5MWZjNyIsInVzZXJfaWQiOjd9.xJyahGVO4A4Ug_vRghq4VysKoHUjdv089RWl62Orao8	2025-09-05 19:11:27.580162+00	2025-10-05 19:11:27+00	7	4343aab5f32e47a69ea239f62e191fc7
48	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTY5MTYyOSwiaWF0IjoxNzU3MDk5NjI5LCJqdGkiOiJiMGQ1ODZiMzI4ZjM0OTcwYTkzM2ViMGQ4MzViZDRmYiIsInVzZXJfaWQiOjd9.c-AnlBwu2xQ1wEZltY1iKedDEDy8awpZQpmKqeHSkaE	2025-09-05 19:13:49.3777+00	2025-10-05 19:13:49+00	7	b0d586b328f34970a933eb0d835bd4fb
49	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTk0MTA2OSwiaWF0IjoxNzU3MzQ5MDY5LCJqdGkiOiI4NWI3ZjY3MDMxNzc0ZjFlODE4NDNlYjM3NWZhOGRjZSIsInVzZXJfaWQiOjd9.lc811ZdbevMXk4SK6lnG8IhIde1FJzCOfO5OyN28ZcY	2025-09-08 16:31:09.628423+00	2025-10-08 16:31:09+00	7	85b7f67031774f1e81843eb375fa8dce
50	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTk0MTA4MiwiaWF0IjoxNzU3MzQ5MDgyLCJqdGkiOiJlMTYzMzBkNzMxMzI0ODE3YWQwMjFlNjdmNDViZDJlZSIsInVzZXJfaWQiOjd9.ShtRIJd0Th7RXvxxk1O4XUWF3lLZ4FVnu5IbgQ3yo4w	2025-09-08 16:31:22.706018+00	2025-10-08 16:31:22+00	7	e16330d731324817ad021e67f45bd2ee
51	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTk0MTM1NiwiaWF0IjoxNzU3MzQ5MzU2LCJqdGkiOiI4OGI0ZDQyY2E2NmU0ZTRiYTBiNjZkN2E3N2I1ZmQwMCIsInVzZXJfaWQiOjd9.K0RQdZXfcxnF2k1sPBusVSR89kRbwdSj1SfHtZ1eU08	2025-09-08 16:35:56.623548+00	2025-10-08 16:35:56+00	7	88b4d42ca66e4e4ba0b66d7a77b5fd00
52	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTk0MTYyNiwiaWF0IjoxNzU3MzQ5NjI2LCJqdGkiOiI1YTZmMGEwOTNjZjk0Y2RhOTM3ZDk3YmYwY2YxNTQ2ZCIsInVzZXJfaWQiOjd9.B6n2OH3JQqwTM0yBcLDuYZpKkNFfGsWifEuC90yDTsU	2025-09-08 16:40:26.031349+00	2025-10-08 16:40:26+00	7	5a6f0a093cf94cda937d97bf0cf1546d
53	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTk3OTg4MywiaWF0IjoxNzU3Mzg3ODgzLCJqdGkiOiI2ZDUyNjc2ZjE1ZmQ0Y2Q3OWZiYTMzYTk3MWNmOGUyMiIsInVzZXJfaWQiOjh9.OFjxbCL05-eE_i3b_WXtRnQcZya54BDNh18Om5zQXk8	2025-09-09 03:18:03.218926+00	2025-10-09 03:18:03+00	8	6d52676f15fd4cd79fba33a971cf8e22
54	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTk4MDEwNCwiaWF0IjoxNzU3Mzg4MTA0LCJqdGkiOiJiMDRhMWUxNGIxMTE0Njc0YmIwZTdmMzQ5YjJjZjAxYiIsInVzZXJfaWQiOjd9.3e1X8ZaKUz8YsbXXoozxGKjEFI526AdKb_RjiqTD7Vw	2025-09-09 03:21:44.529537+00	2025-10-09 03:21:44+00	7	b04a1e14b1114674bb0e7f349b2cf01b
55	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2MDYzMDUzNSwiaWF0IjoxNzU4MDM4NTM1LCJqdGkiOiI4NjQ3MGQyY2E4ZDQ0OTkyOWI0MjIyNzFlNjE5OWQxYSIsInVzZXJfaWQiOjd9.73nDUVQUUbI6ATLFFhYs45gQK0AcPwpTIXUg8A7M2Tk	2025-09-16 16:02:15.799352+00	2025-10-16 16:02:15+00	7	86470d2ca8d449929b422271e6199d1a
56	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2MDc3NDQxMywiaWF0IjoxNzU4MTgyNDEzLCJqdGkiOiJmYzRmMDk1OTA4Njg0N2M4YjQ5NTcwMzllZGNiMTIwYiIsInVzZXJfaWQiOjd9.xukdhtvIY3KIHTFAKczOzf8eBjvsK5v6lJ_nqIWudaY	2025-09-18 08:00:13.648816+00	2025-10-18 08:00:13+00	7	fc4f0959086847c8b4957039edcb120b
57	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2MDg1OTExMiwiaWF0IjoxNzU4MjY3MTEyLCJqdGkiOiI3YjJkNmJiMjAxNzI0MmE2OGVmM2U0NzZkZTE2OWYwNiIsInVzZXJfaWQiOjd9.i7CCPdLa2dux76qtSyEig0fZXfAhcDHl4ldmsRUMDLA	2025-09-19 07:31:52.495307+00	2025-10-19 07:31:52+00	7	7b2d6bb2017242a68ef3e476de169f06
58	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2MDg1OTE0MywiaWF0IjoxNzU4MjY3MTQzLCJqdGkiOiI2NzIzZDA1OGVjNWI0ZTc5YmUzZjYyMDE3ZDIxMjYwZCIsInVzZXJfaWQiOjd9.E2xGgnqIVzIPhNaqm7qKvfkq6u2AoCLuUibksQ0MrjI	2025-09-19 07:32:23.569558+00	2025-10-19 07:32:23+00	7	6723d058ec5b4e79be3f62017d21260d
59	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2MDg5MjU4NywiaWF0IjoxNzU4MzAwNTg3LCJqdGkiOiJhM2NiYTRiNzZmNWU0Yzc2ODdhOTk4YTg2NjExOGMyOCIsInVzZXJfaWQiOjd9.Z0TmVPmSi--QVD4ZY6aPTPAUyZmvU5Jk5EKSnuYQiRI	2025-09-19 16:49:47.034602+00	2025-10-19 16:49:47+00	7	a3cba4b76f5e4c7687a998a866118c28
60	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2MTE5OTgxOSwiaWF0IjoxNzU4NjA3ODE5LCJqdGkiOiJmODBiZTkyMTUwOTE0MzIzYmYzYzBjZGY0YjlkZDMyOCIsInVzZXJfaWQiOjd9.-GODU4gZ7PQ2_4Up2ehx0r69xgnEyOxxtYHhq5idMVE	2025-09-23 06:10:19.226523+00	2025-10-23 06:10:19+00	7	f80be92150914323bf3c0cdf4b9dd328
61	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2MTg4NjA4NywiaWF0IjoxNzU5Mjk0MDg3LCJqdGkiOiJjMmM2MDM3YjUwNWQ0YzI5OWY3OTAzYmRiMjFkZDI3MyIsInVzZXJfaWQiOjd9.JSXOvgoqjhMo1lgVTbl0eMfkjDLNfmQwS-1SMmMf2Xk	2025-10-01 04:48:07.508169+00	2025-10-31 04:48:07+00	7	c2c6037b505d4c299f7903bdb21dd273
62	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2MTg5NDgyNCwiaWF0IjoxNzU5MzAyODI0LCJqdGkiOiIwOTAzMWVjOGY5NmQ0OGFhYWRhOWNiYzg1YWIxZTcyNiIsInVzZXJfaWQiOjd9.brg-tiMI0sIagyBRJPiUhzbUIX2e3WBb8pZpoJQfVLE	2025-10-01 07:13:44.915346+00	2025-10-31 07:13:44+00	7	09031ec8f96d48aaada9cbc85ab1e726
63	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2MjQwMDg4NSwiaWF0IjoxNzU5ODA4ODg1LCJqdGkiOiJkNWYyZjEyOTVkODk0ODQ3YTIxMTIwYWVlN2VjZTg0YyIsInVzZXJfaWQiOjExfQ.cazwXWajNJHQpUTi6-hN92xTMtnJyTRwCptJ4VWOuoI	2025-10-07 03:48:05.822374+00	2025-11-06 03:48:05+00	11	d5f2f1295d894847a21120aee7ece84c
64	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2MjQxNTI5MywiaWF0IjoxNzU5ODIzMjkzLCJqdGkiOiJhNTQ3M2UwYTM3ZGU0Y2EyYjcxOGJlZGM2NDJlZmY1NCIsInVzZXJfaWQiOjh9.Ld_lKSn6uvd3dqoWQQjZzfbkH58yEABRB9rcDPO8QzU	2025-10-07 07:48:13.478624+00	2025-11-06 07:48:13+00	8	a5473e0a37de4ca2b718bedc642eff54
65	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2MjUwMjQyNCwiaWF0IjoxNzU5OTEwNDI0LCJqdGkiOiIxM2EzODMzMjM5Mzc0OGZjYjJlZjY4ZDljMmM0NjdkYiIsInVzZXJfaWQiOjd9.j9kg5aDmQW8_W7fzBMQCeYZ4SOYvUQV8UNmd7ma8zY8	2025-10-08 08:00:24.307268+00	2025-11-07 08:00:24+00	7	13a38332393748fcb2ef68d9c2c467db
66	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2MjU5MTcyNiwiaWF0IjoxNzU5OTk5NzI2LCJqdGkiOiJmNmEwY2Y3NTA1NzI0ZGE5OTczMTJlNzIwMGZiNTU4NCIsInVzZXJfaWQiOjEyfQ.48VNDU0Gk92lJ7vTZS3N6RGkW7zvp_jVdr4LsTIA4xc	2025-10-09 08:48:46.331361+00	2025-11-08 08:48:46+00	12	f6a0cf7505724da997312e7200fb5584
67	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2MjYwMTMyMywiaWF0IjoxNzYwMDA5MzIzLCJqdGkiOiJkZWQ3NjRkZjZmYmI0NGNhODU0MGM2ZmRhMTVmMTFlMSIsInVzZXJfaWQiOjEzfQ.jt0ANx5DNOPu5yK08PSonuACeN_Ihnl1xGcQjr-4WNs	2025-10-09 11:28:43.050321+00	2025-11-08 11:28:43+00	13	ded764df6fbb44ca8540c6fda15f11e1
68	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2MjYwMTg5NCwiaWF0IjoxNzYwMDA5ODk0LCJqdGkiOiIzZGI5Zjc5OGU4MDI0NjIyYjQ1NmU4MWIxMWQ5ZmQ4YiIsInVzZXJfaWQiOjE0fQ.-SE3xhrdKCZAqf8YU8kRer4h86PzfxaU5Zlkh239Mog	2025-10-09 11:38:14.691379+00	2025-11-08 11:38:14+00	14	3db9f798e8024622b456e81b11d9fd8b
69	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2MjYwNzg1MiwiaWF0IjoxNzYwMDE1ODUyLCJqdGkiOiJmMWJiZjFmNGE0YTM0MDJlYmY5MDIyZGU0YTViZTM3MCIsInVzZXJfaWQiOjE1fQ.u845un0LEgAl6WfF_Lrs5O7dyJVxPEhUFLvMjIKz9EM	2025-10-09 13:17:32.254058+00	2025-11-08 13:17:32+00	15	f1bbf1f4a4a3402ebf9022de4a5be370
70	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2MjYxNTUyMSwiaWF0IjoxNzYwMDIzNTIxLCJqdGkiOiI3MGI3YTRiMjdiYjY0M2U3YTlmOWMxY2UzMTlhZDE0NiIsInVzZXJfaWQiOjd9.TUkettgez8VuD2LA8YFZoTsumIZarAAVOzpMmYihfkM	2025-10-09 15:25:21.698216+00	2025-11-08 15:25:21+00	7	70b7a4b27bb643e7a9f9c1ce319ad146
71	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Mjg4NDk2NSwiaWF0IjoxNzYwMjkyOTY1LCJqdGkiOiJmZWNhZjRjODFlMWE0MmM2OTkxZWY5ZTMyN2M2Y2RkNCIsInVzZXJfaWQiOjd9.0KBz7ACm6XXxzCTNSViejUu9HtuhuFcdCUXzLgJbgZ4	2025-10-12 18:16:05.755027+00	2025-11-11 18:16:05+00	7	fecaf4c81e1a42c6991ef9e327c6cdd4
72	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Mjk2MjQwMCwiaWF0IjoxNzYwMzcwNDAwLCJqdGkiOiI1MTliYzFhNTk0MGM0ZjVmYTk2ZGRmYWI1OTAwZjE2MyIsInVzZXJfaWQiOjEzfQ.aroiCcFStOp4gw-6hzJSo5W7YQfMWlQHb62tFte-lzU	2025-10-13 15:46:40.497768+00	2025-11-12 15:46:40+00	13	519bc1a5940c4f5fa96ddfab5900f163
73	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2MzE4NzgwMCwiaWF0IjoxNzYwNTk1ODAwLCJqdGkiOiJiOGQzNWFjNjRiYjI0YjZjODYwYjIzZTg4ZjE5N2VhNiIsInVzZXJfaWQiOjE4fQ.IfoqF62eyj5cC_WKcUAzyVaVoq8XeVVWNBtVwIH8nc0	2025-10-16 06:23:20.820354+00	2025-11-15 06:23:20+00	18	b8d35ac64bb24b6c860b23e88f197ea6
74	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2MzE5MTk5MywiaWF0IjoxNzYwNTk5OTkzLCJqdGkiOiJmZjc5YTZmODBjY2U0YTNmYWUzYzM0NzMxMmIyZmRmMiIsInVzZXJfaWQiOjE5fQ.8-NzVoQhllDjX6UAFWUXxF713EwVTqVpWx7P3rKJ6rQ	2025-10-16 07:33:13.422053+00	2025-11-15 07:33:13+00	19	ff79a6f80cce4a3fae3c347312b2fdf2
75	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2MzIwNTY1OSwiaWF0IjoxNzYwNjEzNjU5LCJqdGkiOiJmNjQ5NDEwYmY2MTk0MWEwODQ4ZTQzZmE5MmE0NDc4NSIsInVzZXJfaWQiOjIwfQ.32OEu8BWYyQI0-xWFn0sak7L17xN4xp0rqOMWCplwEM	2025-10-16 11:20:59.577068+00	2025-11-15 11:20:59+00	20	f649410bf61941a0848e43fa92a44785
76	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2MzM2ODQzMCwiaWF0IjoxNzYwNzc2NDMwLCJqdGkiOiI2MTEzNmRhMjNiMTI0NTYxOTJjMTcyZWEwMjNiNTI3OCIsInVzZXJfaWQiOjIxfQ.D84C6XmhTAvL_3pxsEousbO5A_9fj5nMFAP59-FWIhI	2025-10-18 08:33:50.618138+00	2025-11-17 08:33:50+00	21	61136da23b12456192c172ea023b5278
77	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2MzM3NDU1NSwiaWF0IjoxNzYwNzgyNTU1LCJqdGkiOiIxOGY3MWU1ODQ0NTU0N2FiOTE5ODIwOGEzYTEwMjY2MyIsInVzZXJfaWQiOjEzfQ.owvHUl0HteGhE5YKy9GKrYttsCXv6B8cqOzO-TzpgeM	2025-10-18 10:15:55.549961+00	2025-11-17 10:15:55+00	13	18f71e58445547ab9198208a3a102663
78	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2MzM3NzgxMCwiaWF0IjoxNzYwNzg1ODEwLCJqdGkiOiI4ZmMxNzdmODZjNWU0MjZhOGQ2MjMzMjkxOGUxN2U4ZSIsInVzZXJfaWQiOjIyfQ.tCbBeUskFYe-hfpNxXSjpqeNzjCyru5NDpmVOHgmUG8	2025-10-18 11:10:10.159203+00	2025-11-17 11:10:10+00	22	8fc177f86c5e426a8d62332918e17e8e
79	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2MzM5MzIzNCwiaWF0IjoxNzYwODAxMjM0LCJqdGkiOiIyYTcwY2YwZDY5ZDk0YjEzYmIyNjEyYzNjMjI2MDFkYyIsInVzZXJfaWQiOjIzfQ.QfIFOsVdlAgKPntsl5Tg8xXGC0E8aJmV9tq5MTOuuDQ	2025-10-18 15:27:14.441448+00	2025-11-17 15:27:14+00	23	2a70cf0d69d94b13bb2612c3c22601dc
80	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2MzQ5MTUxMCwiaWF0IjoxNzYwODk5NTEwLCJqdGkiOiJjZDZjNjE4NWQwN2I0MTY4YjAxZWFhYTZkOTgyMTZkOSIsInVzZXJfaWQiOjI0fQ.cIio2c9CW71NjG7h7U6u8Phr7UEm5t_iVurlU2Mf2ws	2025-10-19 18:45:10.664287+00	2025-11-18 18:45:10+00	24	cd6c6185d07b4168b01eaaa6d98216d9
81	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2MzcyMzMyMSwiaWF0IjoxNzYxMTMxMzIxLCJqdGkiOiI0MzcyMTgxZTU2MzE0MGQwYmEwMGEzYzRhYjlhYzY1OCIsInVzZXJfaWQiOjI1fQ.MOCiXqFbNxVd-36tyGpFEJqxavDEMSucezZ7CdzZCLY	2025-10-22 11:08:41.178407+00	2025-11-21 11:08:41+00	25	4372181e563140d0ba00a3c4ab9ac658
82	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2MzczMzA1NywiaWF0IjoxNzYxMTQxMDU3LCJqdGkiOiI0MDM0NjM3ODIxY2I0NDRiYTI4ZjAwZjY1NTVkMDI5YyIsInVzZXJfaWQiOjI2fQ.ikOlJORryR6QmNkU6i0HoTeslWGt27jhbglhwRrxDz4	2025-10-22 13:50:57.203071+00	2025-11-21 13:50:57+00	26	4034637821cb444ba28f00f6555d029c
83	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Mzc0MzE4MiwiaWF0IjoxNzYxMTUxMTgyLCJqdGkiOiI0YzAyZTdiNTNjNGE0MjViYWUwOGE0OThiN2Q0NzQzYiIsInVzZXJfaWQiOjI1fQ.LNFsXH_Wx-5VhKKHsFaOjScMiDrcOo5Mxq1ssrjbHRc	2025-10-22 16:39:42.722132+00	2025-11-21 16:39:42+00	25	4c02e7b53c4a425bae08a498b7d4743b
84	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Mzc0MzY0NCwiaWF0IjoxNzYxMTUxNjQ0LCJqdGkiOiJjNWFkNzBkZWE0Y2I0ZDE0YWZhMjQ5ZjE2NzJlOTJiOSIsInVzZXJfaWQiOjI1fQ.xTrPSMItX2JkbZ9xv_9FBnOYDEx1rlkBURWt7hNhamA	2025-10-22 16:47:24.934598+00	2025-11-21 16:47:24+00	25	c5ad70dea4cb4d14afa249f1672e92b9
85	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDA4NjY1MywiaWF0IjoxNzYxNDk0NjUzLCJqdGkiOiI1Y2NkZDc3MzRlYTk0NTAzOTkwN2YyZjc2MTEyZGYzMiIsInVzZXJfaWQiOjI3fQ.X7cmrZ1OQC_QePEIgxrRElq0sX-eSlQF0-Bq9Sw0K4I	2025-10-26 16:04:13.242177+00	2025-11-25 16:04:13+00	27	5ccdd7734ea945039907f2f76112df32
86	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDI1MTI1OSwiaWF0IjoxNzYxNjU5MjU5LCJqdGkiOiI3OTZlZjQwZWIzOWY0MzJkYjY1NDNkMmFhMjllNzI4YiIsInVzZXJfaWQiOjI4fQ.vE3Ezw7XiS2pCgKBpJTLl62ek7YwXq8soOPueONzoac	2025-10-28 13:47:39.492149+00	2025-11-27 13:47:39+00	28	796ef40eb39f432db6543d2aa29e728b
87	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDI5NTgzMywiaWF0IjoxNzYxNzAzODMzLCJqdGkiOiIxYTljZjhjZDZjMGU0MTc5YWM3YzlhMjc4Y2VlZGJkYyIsInVzZXJfaWQiOjI5fQ.W1hsP_DqTD7GH2slnGm0TBlBPpHDIuR1qS5l1zBZsxU	2025-10-29 02:10:33.885087+00	2025-11-28 02:10:33+00	29	1a9cf8cd6c0e4179ac7c9a278ceedbdc
88	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDMwNjE0NywiaWF0IjoxNzYxNzE0MTQ3LCJqdGkiOiJhMDBlNGJmNTY0Yjc0ZDYyOTU2NjM3YzU0MzdlY2I4NiIsInVzZXJfaWQiOjd9.1dem8su_tgZRU4B5SExoBgsupYqF9gbvb-CjMa6bTR8	2025-10-29 05:02:27.321254+00	2025-11-28 05:02:27+00	7	a00e4bf564b74d62956637c5437ecb86
89	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDMxNDE2MSwiaWF0IjoxNzYxNzIyMTYxLCJqdGkiOiJmMGRjZDRiYTcwNzU0OGU2OThlNDExNTFjODgwMzhkOSIsInVzZXJfaWQiOjMwfQ.XBpIJ2PJlKOTpmMx7Z6ufUBsbFBnBfbQqQdwae8yR9s	2025-10-29 07:16:01.648413+00	2025-11-28 07:16:01+00	30	f0dcd4ba707548e698e41151c88038d9
90	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDMxNDQ3OSwiaWF0IjoxNzYxNzIyNDc5LCJqdGkiOiI4OTQwN2ZhNTk3ODM0OWQ2YmE5ZjVhMmM0NDRkYzZlZSIsInVzZXJfaWQiOjMwfQ.fJFm0he7ONboIWHImRzcZKVvjGde6r-0Hc6osahgqZU	2025-10-29 07:21:19.315583+00	2025-11-28 07:21:19+00	30	89407fa5978349d6ba9f5a2c444dc6ee
91	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDMxNDg3NSwiaWF0IjoxNzYxNzIyODc1LCJqdGkiOiJiZmYxZDliMjQxYzQ0Yzk3YjkzMTIzYjU1ZDZmMWE2ZSIsInVzZXJfaWQiOjMxfQ.npr9DKeZQlLYu26Tb_hQIBohcmMNWG6eUiiZbJPkQ0M	2025-10-29 07:27:55.642315+00	2025-11-28 07:27:55+00	31	bff1d9b241c44c97b93123b55d6f1a6e
92	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDMxNzA1NiwiaWF0IjoxNzYxNzI1MDU2LCJqdGkiOiI4ZmQzOTA3MTkxNmQ0NDNlYTE3YmQyZWQ5ZjJhYmM3MyIsInVzZXJfaWQiOjMyfQ.MyXv6K7aM7EKI7Oskhr674J_gzFLmDUAFmPCs0hXK_I	2025-10-29 08:04:16.091982+00	2025-11-28 08:04:16+00	32	8fd39071916d443ea17bd2ed9f2abc73
93	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDMxODEyMSwiaWF0IjoxNzYxNzI2MTIxLCJqdGkiOiI5MDJiOGViNWMzMGE0Mzg4YjdkNWI1MjQxMzk4NWE0ZCIsInVzZXJfaWQiOjMzfQ.IBlH5mUr6fqp-oOEjFWG4RWLbpKldN0gpXnBE2FQwGs	2025-10-29 08:22:01.477623+00	2025-11-28 08:22:01+00	33	902b8eb5c30a4388b7d5b52413985a4d
94	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDMxODQ5OSwiaWF0IjoxNzYxNzI2NDk5LCJqdGkiOiJjNmEzNjZlMzVhNWY0ODFkOWZkYzM1MzhmMzhhZjE1ZSIsInVzZXJfaWQiOjMyfQ.FeHfRvgg8oEHbm6ICoMxVKy9kS-4i5Nr2EMkr0bqFbY	2025-10-29 08:28:19.758995+00	2025-11-28 08:28:19+00	32	c6a366e35a5f481d9fdc3538f38af15e
95	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDMzNzg0MiwiaWF0IjoxNzYxNzQ1ODQyLCJqdGkiOiI1Nzk0MTIxMDg0MDE0N2MyYWQxYmE3MDc0MDM2ODFhOCIsInVzZXJfaWQiOjM0fQ.f9jSdD74FSfJlFECjI-7UrRSLy3xNeGyq2QALYDy_XM	2025-10-29 13:50:42.628189+00	2025-11-28 13:50:42+00	34	57941210840147c2ad1ba707403681a8
96	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDM5MTY1MiwiaWF0IjoxNzYxNzk5NjUyLCJqdGkiOiI3MzcyMzM3ZTM0NWE0MWY3YjFjNDA1MTIwOTNkZmEyNyIsInVzZXJfaWQiOjd9.tNticEFfem6fzjlI2MJbSgi-6cK1PPUglKvyViXoq5I	2025-10-30 04:47:32.720103+00	2025-11-29 04:47:32+00	7	7372337e345a41f7b1c40512093dfa27
97	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQ2NTMyOSwiaWF0IjoxNzYxODczMzI5LCJqdGkiOiJhMjRkNzcwZmFmMTU0MmUwODIzZDIwMzdiYjM0Njg2ZCIsInVzZXJfaWQiOjM1fQ.SoFQD1u6MR9xN24A_lY2P-J_oGE4T_IOssBX_aRWLCg	2025-10-31 01:15:29.206271+00	2025-11-30 01:15:29+00	35	a24d770faf1542e0823d2037bb34686d
98	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDQ3MjA4MSwiaWF0IjoxNzYxODgwMDgxLCJqdGkiOiIwYjdjMDgxYmY2NWY0OWJiODEyMWY0ZmI2YTFlZDY1ZiIsInVzZXJfaWQiOjM2fQ.tevw74bi60l8EiiozpvGBPXV4fXXXo-02kz4USJVd1w	2025-10-31 03:08:01.191897+00	2025-11-30 03:08:01+00	36	0b7c081bf65f49bb8121f4fb6a1ed65f
99	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDUwODM5OSwiaWF0IjoxNzYxOTE2Mzk5LCJqdGkiOiIxYWNhMWZmZTRmMDI0MzI0YWJhYmQzZTFjNDQxZjZlYSIsInVzZXJfaWQiOjM3fQ.R28l0kHVRHjxZY9sWLHvmimCtXNpkePrn5fPIKYZCP0	2025-10-31 13:13:19.502128+00	2025-11-30 13:13:19+00	37	1aca1ffe4f024324ababd3e1c441f6ea
100	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDY4Mjc3NywiaWF0IjoxNzYyMDkwNzc3LCJqdGkiOiI3N2JlNmZjYTYzODM0ODQwOWFhODBiZGRjNTAwZDQ5NiIsInVzZXJfaWQiOjM4fQ.qCVjUb3_EK4d5fXEAbb6X11i0DfIHubNPUZ8auqAjUI	2025-11-02 13:39:37.870025+00	2025-12-02 13:39:37+00	38	77be6fca638348409aa80bddc500d496
101	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDY5OTg3MywiaWF0IjoxNzYyMTA3ODczLCJqdGkiOiJhZTU2MjFlM2Y2ZTE0ZDc1YjFiNjk4NTM1NGIzYzVhNiIsInVzZXJfaWQiOjM5fQ.R5ImJrH1b94BrLNdDHdNvsFng7ciWUW1CH0z-oKVAu8	2025-11-02 18:24:33.607566+00	2025-12-02 18:24:33+00	39	ae5621e3f6e14d75b1b6985354b3c5a6
102	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDcyNzQ2OSwiaWF0IjoxNzYyMTM1NDY5LCJqdGkiOiJlOTE2NWYwMzdiMDc0OTA2YTM3ZGJmMmUzZjc1NTYwNiIsInVzZXJfaWQiOjQwfQ.ctqkNd0FJQMPlGoKFcf4SVsm2H_v8p_l-8mHsxWM9Pw	2025-11-03 02:04:29.903306+00	2025-12-03 02:04:29+00	40	e9165f037b074906a37dbf2e3f755606
103	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDc0ODczOSwiaWF0IjoxNzYyMTU2NzM5LCJqdGkiOiIxMzRlMWJmNDc4M2M0Y2Y5YWQzYWJlYjJhZDg1NWI0YSIsInVzZXJfaWQiOjQxfQ._deVyZ3jNkHqg1Ns4tUxTnX_-s6geXPbVgo1OqIFPqQ	2025-11-03 07:58:59.716832+00	2025-12-03 07:58:59+00	41	134e1bf4783c4cf9ad3abeb2ad855b4a
104	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDkzOTQ3MSwiaWF0IjoxNzYyMzQ3NDcxLCJqdGkiOiJkZjcyODhkM2MzNDY0NWFiOGYxYzI3ZmExZDY4NGNiMyIsInVzZXJfaWQiOjd9.jhPWRZNAbazA2Unt3OH4g24LfAoSTBvOMs2pf6OCrbM	2025-11-05 12:57:51.552847+00	2025-12-05 12:57:51+00	7	df7288d3c34645ab8f1c27fa1d684cb3
105	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTY1NjUyMywiaWF0IjoxNzYzMDY0NTIzLCJqdGkiOiJjN2I5OTRjODM5YTM0NjZlODZmNTY4ZGI0ZGQ1Y2I2OCIsInVzZXJfaWQiOjd9.2aLJdWdd_RcSDY9uH95aXID5WT20ksxrBwgMbXvF220	2025-11-13 20:08:43.85743+00	2025-12-13 20:08:43+00	7	c7b994c839a3466e86f568db4dd5cb68
106	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTc3ODcxMSwiaWF0IjoxNzYzMTg2NzExLCJqdGkiOiI1ZGUzMzliZTdlOGU0NDBlYTdkMmJlMzliYjE0NmZmZCIsInVzZXJfaWQiOjd9.AYuct8wjmCwib7YZToy0-fSBVlmx8dPMrq3rxjnFXUM	2025-11-15 06:05:11.589387+00	2025-12-15 06:05:11+00	7	5de339be7e8e440ea7d2be39bb146ffd
107	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Njg5NTYyOCwiaWF0IjoxNzY0MzAzNjI4LCJqdGkiOiJmODM2NmYxOTM2MTA0NTc0OTQyZjk4NDQ4OTM2ZjQzMSIsInVzZXJfaWQiOjd9.L61OFJzlrKshZvFK5HzKhyU5BB0HQobXnemWWfVvizU	2025-11-28 04:20:28.280136+00	2025-12-28 04:20:28+00	7	f8366f1936104574942f98448936f431
108	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzAwMTU4MCwiaWF0IjoxNzY0NDA5NTgwLCJqdGkiOiI4Yjk4YjMwMDQ1NGU0ODI4OTFmNGRmZjgyMGI5NTJlNiIsInVzZXJfaWQiOjh9.-96YnDfXzIGKaOYPeXWnrOPSwc_1kUyPRIseZnQn1F0	2025-11-29 09:46:20.266465+00	2025-12-29 09:46:20+00	8	8b98b300454e482891f4dff820b952e6
109	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzgwMDAxNCwiaWF0IjoxNzY1MjA4MDE0LCJqdGkiOiI2NDVkMDU3NWVjY2Q0MGQ1OThkMDMxZTE1MWU4MWMxYiIsInVzZXJfaWQiOjd9.JBumRoLFJUXHzWjdCL79GBHLBHpACqfRk4XNfjtb3Ww	2025-12-08 15:33:34.290893+00	2026-01-07 15:33:34+00	7	645d0575eccd40d598d031e151e81c1b
110	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2ODQ1MTgwNSwiaWF0IjoxNzY1ODU5ODA1LCJqdGkiOiJkYjMwNGI4ZmMxMjA0NjhmOGZjMjMwOGI1NzgyNjM3MCIsInVzZXJfaWQiOjd9.eNLAQ1W0ezcxq7-L6QPmGnWAP6ba2_-Smne7AwYE-yQ	2025-12-16 04:36:45.446997+00	2026-01-15 04:36:45+00	7	db304b8fc120468f8fc2308b57826370
111	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2ODk3OTI2NCwiaWF0IjoxNzY2Mzg3MjY0LCJqdGkiOiI2YTI2ZDZlNjc3ZTY0MDc0YTJhZDIxZDYxOTU4ZjFlNCIsInVzZXJfaWQiOjI2fQ.6MkF_nk0pyznv0J7mk28LZiMJIKhveCRG_hxbhxemWk	2025-12-22 07:07:44.942106+00	2026-01-21 07:07:44+00	26	6a26d6e677e64074a2ad21d61958f1e4
112	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2ODk5MDc1OCwiaWF0IjoxNzY2Mzk4NzU4LCJqdGkiOiIxYTU4ZDQ4ZDgwYWE0N2Q0YjQ3MWU5ODVkZDYzMjQ2MSIsInVzZXJfaWQiOjQyfQ.0F0Qwq64rbQTWm5fhuH3Bt5CmanwEX_radhY1YqoS_4	2025-12-22 10:19:18.793683+00	2026-01-21 10:19:18+00	42	1a58d48d80aa47d4b471e985dd632461
113	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2OTA1OTkwMiwiaWF0IjoxNzY2NDY3OTAyLCJqdGkiOiJmNjMwYjczOWU2OTA0NzJlOWI2NjdhNGEwMThjNDVlNSIsInVzZXJfaWQiOjQzfQ.rn0AgDnXLErm-bXm0dVMkZvkN0JAfNOh6XGR_519xrg	2025-12-23 05:31:42.046897+00	2026-01-22 05:31:42+00	43	f630b739e690472e9b667a4a018c45e5
114	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2OTA2MjkwNiwiaWF0IjoxNzY2NDcwOTA2LCJqdGkiOiIxODhmODg4ODYxMmQ0M2JhOTAxZjM5N2Q4MGFmMTE3NyIsInVzZXJfaWQiOjd9.xifJYyB1iPw-I2yZtuBJdaca0PJWo7q2Altm8v3DmOM	2025-12-23 06:21:46.65777+00	2026-01-22 06:21:46+00	7	188f8888612d43ba901f397d80af1177
115	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2OTA2Njk4OCwiaWF0IjoxNzY2NDc0OTg4LCJqdGkiOiI3ODE2MmNmYjY4YTQ0MzhjODZhMzkyYmQ2ZDUzYTVhZCIsInVzZXJfaWQiOjQ0fQ.yYwIARB__vA--toiNRxebLvgSy78oJCRUxpCoG-BszE	2025-12-23 07:29:48.509674+00	2026-01-22 07:29:48+00	44	78162cfb68a4438c86a392bd6d53a5ad
116	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2OTA5MDY4NSwiaWF0IjoxNzY2NDk4Njg1LCJqdGkiOiI4ZjAyMjU2MjJhYjA0MGEwYTZlOTFjZDAwNjZkNDRjYSIsInVzZXJfaWQiOjd9.u-b8bfqfPNQQnnOFhGhJ1SaL5fu2E8A5pAXfzDUXLhY	2025-12-23 14:04:45.526492+00	2026-01-22 14:04:45+00	7	8f0225622ab040a0a6e91cd0066d44ca
117	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2OTE4MTEyMywiaWF0IjoxNzY2NTg5MTIzLCJqdGkiOiIwMjI4MjExYmU3N2M0NmU4OGUwNTFhMGEzYjcwNjYzYyIsInVzZXJfaWQiOjQ1fQ.nZtgVDZnlDsSBJ0X30c9sk2HtCswn0JmbAnfv47XqRs	2025-12-24 15:12:03.626749+00	2026-01-23 15:12:03+00	45	0228211be77c46e88e051a0a3b70663c
118	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2OTIzODc3MywiaWF0IjoxNzY2NjQ2NzczLCJqdGkiOiI5NGNiZGZhMWNiYTE0YmNjYjk0YzBkNWI0MTQ2NTU4YSIsInVzZXJfaWQiOjQ2fQ.8t9Fiv02LEmtmjqK7fEj_XBfgzgVeWNuZaPx_FMjvWM	2025-12-25 07:12:53.810478+00	2026-01-24 07:12:53+00	46	94cbdfa1cba14bccb94c0d5b4146558a
119	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2OTIzOTM2NSwiaWF0IjoxNzY2NjQ3MzY1LCJqdGkiOiIwYTdiOTJjY2U0ZDc0MmFiYjRlZWMwODMxMDI4MjU3OSIsInVzZXJfaWQiOjd9.jM9ac96VQNXTX80VurJ_0Rc57vvYovWjVQ-Kih-qrrY	2025-12-25 07:22:45.56263+00	2026-01-24 07:22:45+00	7	0a7b92cce4d742abb4eec08310282579
120	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2OTMxMzI4OSwiaWF0IjoxNzY2NzIxMjg5LCJqdGkiOiI4ZThiMjZkMTE3ZWQ0ZWVjOGQ2YzVhYzVhNzZmYzg5YSIsInVzZXJfaWQiOjQ3fQ.5kj-x1sytEWMfFUQ8m8lnhdWxXV2-X2JxHMdGNO8Zvw	2025-12-26 03:54:49.878345+00	2026-01-25 03:54:49+00	47	8e8b26d117ed4eec8d6c5ac5a76fc89a
121	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2OTYyMzI0NiwiaWF0IjoxNzY3MDMxMjQ2LCJqdGkiOiI5MmNhM2FjNDAwMGU0NTlkYTQxZGZkMTc5YzIxM2U1YSIsInVzZXJfaWQiOjQ4fQ.-cVy6H8dkbWsLGpwhLTS0PE1QYhOw_sQXxeYgB_l7Yo	2025-12-29 18:00:46.751628+00	2026-01-28 18:00:46+00	48	92ca3ac4000e459da41dfd179c213e5a
122	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2OTkyNzg2MSwiaWF0IjoxNzY3MzM1ODYxLCJqdGkiOiI3Y2FlOTM5MzVmNWQ0YTY0YWYyYmNkMmMyMDk1NjFiYiIsInVzZXJfaWQiOjQ1fQ.0v2RXd5q7c6BgVNvz_3QMrIhx37dmbwSPbPUn1nt6UY	2026-01-02 06:37:41.784679+00	2026-02-01 06:37:41+00	45	7cae93935f5d4a64af2bcd2c209561bb
123	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MDAxMzUwNiwiaWF0IjoxNzY3NDIxNTA2LCJqdGkiOiJhNmRjN2RjOGJmMjY0MzRiYjI4YzU3MWU0MTU5YjEwNiIsInVzZXJfaWQiOjQ1fQ.pOW2Y_beQB-9ivC7MKKx8b_Rn6SaFJ61YvqyxWZHndQ	2026-01-03 06:25:06.730394+00	2026-02-02 06:25:06+00	45	a6dc7dc8bf26434bb28c571e4159b106
124	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MDM5OTU1NiwiaWF0IjoxNzY3ODA3NTU2LCJqdGkiOiJiOTJlZjg5NDgzYzM0ZGRlOTA0YTM1N2MyYjU2YTQzYSIsInVzZXJfaWQiOjQ2fQ.d6Ff5rV2qi4sWVfOY1r6hasxfku5Qv80EAaO6P3bm60	2026-01-07 17:39:16.202344+00	2026-02-06 17:39:16+00	46	b92ef89483c34dde904a357c2b56a43a
125	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MDM5OTYwMiwiaWF0IjoxNzY3ODA3NjAyLCJqdGkiOiIzZjAzZmNiMmNjY2Y0ZWI4YjA3ODk4NTNhYzRmOTgyNyIsInVzZXJfaWQiOjQ1fQ._mdX2lWygeD5V7AH3mJ0ikM99K2EpyNrMPNIIit_iC8	2026-01-07 17:40:02.095492+00	2026-02-06 17:40:02+00	45	3f03fcb2cccf4eb8b0789853ac4f9827
126	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MDQ4NjgzMSwiaWF0IjoxNzY3ODk0ODMxLCJqdGkiOiJjMzgxZmYyZTliYzE0MzYyYTAxNThkODU5Y2IyMjk2YSIsInVzZXJfaWQiOjQ1fQ.-n17iTV5XPobxURO-CaeseAI04WXVA2IaF6Qv3NAcsI	2026-01-08 17:53:51.344946+00	2026-02-07 17:53:51+00	45	c381ff2e9bc14362a0158d859cb2296a
127	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MDQ4ODUzMiwiaWF0IjoxNzY3ODk2NTMyLCJqdGkiOiIwZDZjMmQ1ZjY4NTM0ODgzYTgyN2FiNzNhNjFkYWFmZiIsInVzZXJfaWQiOjQ1fQ.Hspc1dEDvs5cco1ftiiBXyy6MwNub89Ye-rvTMrr4J8	2026-01-08 18:22:12.594857+00	2026-02-07 18:22:12+00	45	0d6c2d5f68534883a827ab73a61daaff
128	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MTEwMTk2NiwiaWF0IjoxNzY4NTA5OTY2LCJqdGkiOiI1N2MzNTk1MDhhZGM0N2E3ODI2M2RiYWIwNzE5MmIyNyIsInVzZXJfaWQiOjd9.qayXvUmXxQTFbnkIQ063Hc9JWIvZELHK8lMiqdMgq0o	2026-01-15 20:46:06.110554+00	2026-02-14 20:46:06+00	7	57c359508adc47a78263dbab07192b27
129	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MTY1NDAzMCwiaWF0IjoxNzY5MDYyMDMwLCJqdGkiOiI4N2RkMjkyMTBiYWU0MzYyOWZhOTUzNjc0OWY1NzcxOCIsInVzZXJfaWQiOjQ2fQ.sYfIez9Yox1fCpErs-5iDtmd9lzeRB7B40SeEZHPo-w	2026-01-22 06:07:10.53284+00	2026-02-21 06:07:10+00	46	87dd29210bae43629fa9536749f57718
130	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MTkyNzAzMiwiaWF0IjoxNzY5MzM1MDMyLCJqdGkiOiI4OGNhMDJlMTQ0YzQ0YTcxYjcwYTE5Yzc2MmQwNjhkOCIsInVzZXJfaWQiOjQ1fQ.SuTXANOlWDAkMIu0xNRwBoQP5R3J6PRgMQ36KYNrM8o	2026-01-25 09:57:12.358346+00	2026-02-24 09:57:12+00	45	88ca02e144c44a71b70a19c762d068d8
131	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MTk1MTg4NywiaWF0IjoxNzY5MzU5ODg3LCJqdGkiOiI1MWM4ZTIyMmIzOTI0ZDRkYmY2YmM2M2FkZmNlNzlhMSIsInVzZXJfaWQiOjQ1fQ.1rW3A9np8cXgn3VuNe6HGU5yY9fZUN__NLzfFigmrB4	2026-01-25 16:51:27.571195+00	2026-02-24 16:51:27+00	45	51c8e222b3924d4dbf6bc63adfce79a1
132	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MTk1NzIwMywiaWF0IjoxNzY5MzY1MjAzLCJqdGkiOiJmZWU1YTUwZDViZDA0M2M1OTM3MTI2MDYxZDI3MjRmMSIsInVzZXJfaWQiOjQ1fQ.UVy-xLPY8onVSEKYyp-ZSa0gQbBwg0qGWav350Z6Npw	2026-01-25 18:20:03.214809+00	2026-02-24 18:20:03+00	45	fee5a50d5bd043c5937126061d2724f1
133	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MjE3ODQwNiwiaWF0IjoxNzY5NTg2NDA2LCJqdGkiOiIzOGRjMjkxMDJlNjE0MDBmODcwOGI1ZTBhOTE3Zjk4YyIsInVzZXJfaWQiOjQ1fQ.c44Tnb23pKjaPZACfoFyNPmuCsCFoYTG8G8olD81rVk	2026-01-28 07:46:46.194001+00	2026-02-27 07:46:46+00	45	38dc29102e61400f8708b5e0a917f98c
134	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MjU1NDA2MSwiaWF0IjoxNzY5OTYyMDYxLCJqdGkiOiIzZWJmYzg1MDEwN2U0OTlhYjc5ZjU0OWNjMDZkMTA2NCIsInVzZXJfaWQiOjQ1fQ.4oZq8HJTx3iTbD0qFnmBZrvs51rAPV2ntu6TK1BcuXw	2026-02-01 16:07:41.596779+00	2026-03-03 16:07:41+00	45	3ebfc850107e499ab79f549cc06d1064
135	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3Mjc4MzgyNCwiaWF0IjoxNzcwMTkxODI0LCJqdGkiOiJkM2JmZGE2NGJhZjA0N2Q2OTVhNmIyYWIwMGFkMzhiZiIsInVzZXJfaWQiOjQ1fQ.lGZ9GsEJP7xEFsqyMHqyraFbxIVJuKxdAh-oxw2_i5s	2026-02-04 07:57:04.133218+00	2026-03-06 07:57:04+00	45	d3bfda64baf047d695a6b2ab00ad38bf
136	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MzE0NjY1NSwiaWF0IjoxNzcwNTU0NjU1LCJqdGkiOiI2Njk2ZWVlYWVjYzE0ODE1YTI0MmM5YjJhM2FlMDM1OSIsInVzZXJfaWQiOjQ1fQ.TSCQkXsSicXUCiF7hslT6fSV6p3fq9bZg6LFTFng8L8	2026-02-08 12:44:15.821645+00	2026-03-10 12:44:15+00	45	6696eeeaecc14815a242c9b2a3ae0359
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 125, true);


--
-- Name: core_appnotification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.core_appnotification_id_seq', 386, true);


--
-- Name: core_cart_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.core_cart_id_seq', 3, true);


--
-- Name: core_cartitem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.core_cartitem_id_seq', 170, true);


--
-- Name: core_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.core_category_id_seq', 6, true);


--
-- Name: core_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.core_order_id_seq', 109, true);


--
-- Name: core_orderitem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.core_orderitem_id_seq', 161, true);


--
-- Name: core_product_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.core_product_categories_id_seq', 119, true);


--
-- Name: core_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.core_product_id_seq', 52, true);


--
-- Name: core_product_tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.core_product_tags_id_seq', 119, true);


--
-- Name: core_productimage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.core_productimage_id_seq', 22, true);


--
-- Name: core_productvariant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.core_productvariant_id_seq', 56, true);


--
-- Name: core_shippingaddress_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.core_shippingaddress_id_seq', 21, true);


--
-- Name: core_stocknotification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.core_stocknotification_id_seq', 32, true);


--
-- Name: core_tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.core_tag_id_seq', 6, true);


--
-- Name: core_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.core_user_groups_id_seq', 1, false);


--
-- Name: core_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.core_user_id_seq', 47, true);


--
-- Name: core_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.core_user_user_permissions_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1, false);


--
-- Name: django_aws_ses_awssessettings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.django_aws_ses_awssessettings_id_seq', 1, false);


--
-- Name: django_aws_ses_awssesuseraddon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.django_aws_ses_awssesuseraddon_id_seq', 1, false);


--
-- Name: django_aws_ses_blacklisteddomains_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.django_aws_ses_blacklisteddomains_id_seq', 1, false);


--
-- Name: django_aws_ses_bouncerecord_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.django_aws_ses_bouncerecord_id_seq', 1, false);


--
-- Name: django_aws_ses_complaintrecord_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.django_aws_ses_complaintrecord_id_seq', 1, false);


--
-- Name: django_aws_ses_sendrecord_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.django_aws_ses_sendrecord_id_seq', 1, false);


--
-- Name: django_aws_ses_sesstat_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.django_aws_ses_sesstat_id_seq', 1, false);


--
-- Name: django_aws_ses_unknownrecord_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.django_aws_ses_unknownrecord_id_seq', 1, false);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 30, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 70, true);


--
-- Name: django_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.django_site_id_seq', 1, true);


--
-- Name: payments_payupayment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.payments_payupayment_id_seq', 13, true);


--
-- Name: token_blacklist_blacklistedtoken_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.token_blacklist_blacklistedtoken_id_seq', 1, false);


--
-- Name: token_blacklist_outstandingtoken_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.token_blacklist_outstandingtoken_id_seq', 136, true);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: core_appnotification core_appnotification_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.core_appnotification
    ADD CONSTRAINT core_appnotification_pkey PRIMARY KEY (id);


--
-- Name: core_cart core_cart_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.core_cart
    ADD CONSTRAINT core_cart_pkey PRIMARY KEY (id);


--
-- Name: core_cartitem core_cartitem_cart_id_product_id_variant_id_0f28d32d_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.core_cartitem
    ADD CONSTRAINT core_cartitem_cart_id_product_id_variant_id_0f28d32d_uniq UNIQUE (cart_id, product_id, variant_id);


--
-- Name: core_cartitem core_cartitem_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.core_cartitem
    ADD CONSTRAINT core_cartitem_pkey PRIMARY KEY (id);


--
-- Name: core_category core_category_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.core_category
    ADD CONSTRAINT core_category_name_key UNIQUE (name);


--
-- Name: core_category core_category_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.core_category
    ADD CONSTRAINT core_category_pkey PRIMARY KEY (id);


--
-- Name: core_category core_category_slug_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.core_category
    ADD CONSTRAINT core_category_slug_key UNIQUE (slug);


--
-- Name: core_order core_order_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.core_order
    ADD CONSTRAINT core_order_pkey PRIMARY KEY (id);


--
-- Name: core_orderitem core_orderitem_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.core_orderitem
    ADD CONSTRAINT core_orderitem_pkey PRIMARY KEY (id);


--
-- Name: core_product_categories core_product_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.core_product_categories
    ADD CONSTRAINT core_product_categories_pkey PRIMARY KEY (id);


--
-- Name: core_product_categories core_product_categories_product_id_category_id_436581c3_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.core_product_categories
    ADD CONSTRAINT core_product_categories_product_id_category_id_436581c3_uniq UNIQUE (product_id, category_id);


--
-- Name: core_product core_product_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.core_product
    ADD CONSTRAINT core_product_pkey PRIMARY KEY (id);


--
-- Name: core_product_tags core_product_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.core_product_tags
    ADD CONSTRAINT core_product_tags_pkey PRIMARY KEY (id);


--
-- Name: core_product_tags core_product_tags_product_id_tag_id_39182de5_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.core_product_tags
    ADD CONSTRAINT core_product_tags_product_id_tag_id_39182de5_uniq UNIQUE (product_id, tag_id);


--
-- Name: core_productimage core_productimage_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.core_productimage
    ADD CONSTRAINT core_productimage_pkey PRIMARY KEY (id);


--
-- Name: core_productvariant core_productvariant_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.core_productvariant
    ADD CONSTRAINT core_productvariant_pkey PRIMARY KEY (id);


--
-- Name: core_productvariant core_productvariant_product_id_category_31d38fb0_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.core_productvariant
    ADD CONSTRAINT core_productvariant_product_id_category_31d38fb0_uniq UNIQUE (product_id, variant_type);


--
-- Name: core_shippingaddress core_shippingaddress_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.core_shippingaddress
    ADD CONSTRAINT core_shippingaddress_pkey PRIMARY KEY (id);


--
-- Name: core_stocknotification core_stocknotification_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.core_stocknotification
    ADD CONSTRAINT core_stocknotification_pkey PRIMARY KEY (id);


--
-- Name: core_tag core_tag_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.core_tag
    ADD CONSTRAINT core_tag_name_key UNIQUE (name);


--
-- Name: core_tag core_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.core_tag
    ADD CONSTRAINT core_tag_pkey PRIMARY KEY (id);


--
-- Name: core_user core_user_email_92a71487_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.core_user
    ADD CONSTRAINT core_user_email_92a71487_uniq UNIQUE (email);


--
-- Name: core_user_groups core_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.core_user_groups
    ADD CONSTRAINT core_user_groups_pkey PRIMARY KEY (id);


--
-- Name: core_user_groups core_user_groups_user_id_group_id_c82fcad1_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.core_user_groups
    ADD CONSTRAINT core_user_groups_user_id_group_id_c82fcad1_uniq UNIQUE (user_id, group_id);


--
-- Name: core_user core_user_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.core_user
    ADD CONSTRAINT core_user_pkey PRIMARY KEY (id);


--
-- Name: core_user_user_permissions core_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.core_user_user_permissions
    ADD CONSTRAINT core_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: core_user_user_permissions core_user_user_permissions_user_id_permission_id_73ea0daa_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.core_user_user_permissions
    ADD CONSTRAINT core_user_user_permissions_user_id_permission_id_73ea0daa_uniq UNIQUE (user_id, permission_id);


--
-- Name: core_user core_user_username_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.core_user
    ADD CONSTRAINT core_user_username_key UNIQUE (username);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_aws_ses_awssessettings django_aws_ses_awssessettings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_aws_ses_awssessettings
    ADD CONSTRAINT django_aws_ses_awssessettings_pkey PRIMARY KEY (id);


--
-- Name: django_aws_ses_awssessettings django_aws_ses_awssessettings_site_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_aws_ses_awssessettings
    ADD CONSTRAINT django_aws_ses_awssessettings_site_id_key UNIQUE (site_id);


--
-- Name: django_aws_ses_awssesuseraddon django_aws_ses_awssesuseraddon_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_aws_ses_awssesuseraddon
    ADD CONSTRAINT django_aws_ses_awssesuseraddon_pkey PRIMARY KEY (id);


--
-- Name: django_aws_ses_awssesuseraddon django_aws_ses_awssesuseraddon_user_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_aws_ses_awssesuseraddon
    ADD CONSTRAINT django_aws_ses_awssesuseraddon_user_id_key UNIQUE (user_id);


--
-- Name: django_aws_ses_blacklisteddomains django_aws_ses_blacklisteddomains_domain_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_aws_ses_blacklisteddomains
    ADD CONSTRAINT django_aws_ses_blacklisteddomains_domain_key UNIQUE (domain);


--
-- Name: django_aws_ses_blacklisteddomains django_aws_ses_blacklisteddomains_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_aws_ses_blacklisteddomains
    ADD CONSTRAINT django_aws_ses_blacklisteddomains_pkey PRIMARY KEY (id);


--
-- Name: django_aws_ses_bouncerecord django_aws_ses_bouncerecord_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_aws_ses_bouncerecord
    ADD CONSTRAINT django_aws_ses_bouncerecord_pkey PRIMARY KEY (id);


--
-- Name: django_aws_ses_complaintrecord django_aws_ses_complaintrecord_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_aws_ses_complaintrecord
    ADD CONSTRAINT django_aws_ses_complaintrecord_pkey PRIMARY KEY (id);


--
-- Name: django_aws_ses_sendrecord django_aws_ses_sendrecord_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_aws_ses_sendrecord
    ADD CONSTRAINT django_aws_ses_sendrecord_pkey PRIMARY KEY (id);


--
-- Name: django_aws_ses_sesstat django_aws_ses_sesstat_date_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_aws_ses_sesstat
    ADD CONSTRAINT django_aws_ses_sesstat_date_key UNIQUE (date);


--
-- Name: django_aws_ses_sesstat django_aws_ses_sesstat_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_aws_ses_sesstat
    ADD CONSTRAINT django_aws_ses_sesstat_pkey PRIMARY KEY (id);


--
-- Name: django_aws_ses_unknownrecord django_aws_ses_unknownrecord_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_aws_ses_unknownrecord
    ADD CONSTRAINT django_aws_ses_unknownrecord_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: django_site django_site_domain_a2e37b91_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_site
    ADD CONSTRAINT django_site_domain_a2e37b91_uniq UNIQUE (domain);


--
-- Name: django_site django_site_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_site
    ADD CONSTRAINT django_site_pkey PRIMARY KEY (id);


--
-- Name: payments_payupayment payments_payupayment_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments_payupayment
    ADD CONSTRAINT payments_payupayment_pkey PRIMARY KEY (id);


--
-- Name: payments_payupayment payments_payupayment_txnid_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments_payupayment
    ADD CONSTRAINT payments_payupayment_txnid_key UNIQUE (txnid);


--
-- Name: session session_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.session
    ADD CONSTRAINT session_pkey PRIMARY KEY (sid);


--
-- Name: token_blacklist_blacklistedtoken token_blacklist_blacklistedtoken_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.token_blacklist_blacklistedtoken
    ADD CONSTRAINT token_blacklist_blacklistedtoken_pkey PRIMARY KEY (id);


--
-- Name: token_blacklist_blacklistedtoken token_blacklist_blacklistedtoken_token_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.token_blacklist_blacklistedtoken
    ADD CONSTRAINT token_blacklist_blacklistedtoken_token_id_key UNIQUE (token_id);


--
-- Name: token_blacklist_outstandingtoken token_blacklist_outstandingtoken_jti_hex_d9bdf6f7_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.token_blacklist_outstandingtoken
    ADD CONSTRAINT token_blacklist_outstandingtoken_jti_hex_d9bdf6f7_uniq UNIQUE (jti);


--
-- Name: token_blacklist_outstandingtoken token_blacklist_outstandingtoken_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.token_blacklist_outstandingtoken
    ADD CONSTRAINT token_blacklist_outstandingtoken_pkey PRIMARY KEY (id);


--
-- Name: IDX_session_expire; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_session_expire" ON public.session USING btree (expire);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: core_appnotification_user_id_444805b0; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX core_appnotification_user_id_444805b0 ON public.core_appnotification USING btree (user_id);


--
-- Name: core_cart_user_id_2ebeb843; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX core_cart_user_id_2ebeb843 ON public.core_cart USING btree (user_id);


--
-- Name: core_cartitem_cart_id_5256d769; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX core_cartitem_cart_id_5256d769 ON public.core_cartitem USING btree (cart_id);


--
-- Name: core_cartitem_product_id_2640c4a2; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX core_cartitem_product_id_2640c4a2 ON public.core_cartitem USING btree (product_id);


--
-- Name: core_cartitem_variant_id_84e67bc6; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX core_cartitem_variant_id_84e67bc6 ON public.core_cartitem USING btree (variant_id);


--
-- Name: core_category_name_55b68161_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX core_category_name_55b68161_like ON public.core_category USING btree (name);


--
-- Name: core_category_slug_384eca9c_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX core_category_slug_384eca9c_like ON public.core_category USING btree (slug);


--
-- Name: core_order_shipping_address_id_8c054f15; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX core_order_shipping_address_id_8c054f15 ON public.core_order USING btree (shipping_address_id);


--
-- Name: core_order_user_id_b03bbffd; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX core_order_user_id_b03bbffd ON public.core_order USING btree (user_id);


--
-- Name: core_orderitem_order_id_30929c10; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX core_orderitem_order_id_30929c10 ON public.core_orderitem USING btree (order_id);


--
-- Name: core_orderitem_product_id_0c2047cd; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX core_orderitem_product_id_0c2047cd ON public.core_orderitem USING btree (product_id);


--
-- Name: core_orderitem_variant_id_fc31f244; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX core_orderitem_variant_id_fc31f244 ON public.core_orderitem USING btree (variant_id);


--
-- Name: core_product_categories_category_id_1263db5a; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX core_product_categories_category_id_1263db5a ON public.core_product_categories USING btree (category_id);


--
-- Name: core_product_categories_product_id_419fa40f; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX core_product_categories_product_id_419fa40f ON public.core_product_categories USING btree (product_id);


--
-- Name: core_product_tags_product_id_7fa1e736; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX core_product_tags_product_id_7fa1e736 ON public.core_product_tags USING btree (product_id);


--
-- Name: core_product_tags_tag_id_038dc8df; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX core_product_tags_tag_id_038dc8df ON public.core_product_tags USING btree (tag_id);


--
-- Name: core_productimage_product_id_10178291; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX core_productimage_product_id_10178291 ON public.core_productimage USING btree (product_id);


--
-- Name: core_productvariant_product_id_79c7de1b; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX core_productvariant_product_id_79c7de1b ON public.core_productvariant USING btree (product_id);


--
-- Name: core_shippingaddress_user_id_da3e3bad; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX core_shippingaddress_user_id_da3e3bad ON public.core_shippingaddress USING btree (user_id);


--
-- Name: core_stocknotification_product_id_0c592fcf; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX core_stocknotification_product_id_0c592fcf ON public.core_stocknotification USING btree (product_id);


--
-- Name: core_stocknotification_user_id_4aece4d9; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX core_stocknotification_user_id_4aece4d9 ON public.core_stocknotification USING btree (user_id);


--
-- Name: core_tag_name_5f34f44c_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX core_tag_name_5f34f44c_like ON public.core_tag USING btree (name);


--
-- Name: core_user_email_92a71487_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX core_user_email_92a71487_like ON public.core_user USING btree (email);


--
-- Name: core_user_groups_group_id_fe8c697f; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX core_user_groups_group_id_fe8c697f ON public.core_user_groups USING btree (group_id);


--
-- Name: core_user_groups_user_id_70b4d9b8; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX core_user_groups_user_id_70b4d9b8 ON public.core_user_groups USING btree (user_id);


--
-- Name: core_user_user_permissions_permission_id_35ccf601; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX core_user_user_permissions_permission_id_35ccf601 ON public.core_user_user_permissions USING btree (permission_id);


--
-- Name: core_user_user_permissions_user_id_085123d3; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX core_user_user_permissions_user_id_085123d3 ON public.core_user_user_permissions USING btree (user_id);


--
-- Name: core_user_username_36e4f7f7_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX core_user_username_36e4f7f7_like ON public.core_user USING btree (username);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_aws__destina_e0db33_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_aws__destina_e0db33_idx ON public.django_aws_ses_sendrecord USING btree (destination, "timestamp");


--
-- Name: django_aws__email_36ac11_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_aws__email_36ac11_idx ON public.django_aws_ses_complaintrecord USING btree (email, "timestamp");


--
-- Name: django_aws__email_6bb737_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_aws__email_6bb737_idx ON public.django_aws_ses_bouncerecord USING btree (email, "timestamp");


--
-- Name: django_aws__event_t_ca3517_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_aws__event_t_ca3517_idx ON public.django_aws_ses_unknownrecord USING btree (event_type, "timestamp");


--
-- Name: django_aws_ses_blacklisteddomains_domain_53c96db6_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_aws_ses_blacklisteddomains_domain_53c96db6_like ON public.django_aws_ses_blacklisteddomains USING btree (domain);


--
-- Name: django_aws_ses_blacklisteddomains_timestamp_370919b2; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_aws_ses_blacklisteddomains_timestamp_370919b2 ON public.django_aws_ses_blacklisteddomains USING btree ("timestamp");


--
-- Name: django_aws_ses_bouncerecord_email_a6dd5e2c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_aws_ses_bouncerecord_email_a6dd5e2c ON public.django_aws_ses_bouncerecord USING btree (email);


--
-- Name: django_aws_ses_bouncerecord_email_a6dd5e2c_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_aws_ses_bouncerecord_email_a6dd5e2c_like ON public.django_aws_ses_bouncerecord USING btree (email);


--
-- Name: django_aws_ses_bouncerecord_timestamp_632073f9; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_aws_ses_bouncerecord_timestamp_632073f9 ON public.django_aws_ses_bouncerecord USING btree ("timestamp");


--
-- Name: django_aws_ses_complaintrecord_email_a1980dd0; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_aws_ses_complaintrecord_email_a1980dd0 ON public.django_aws_ses_complaintrecord USING btree (email);


--
-- Name: django_aws_ses_complaintrecord_email_a1980dd0_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_aws_ses_complaintrecord_email_a1980dd0_like ON public.django_aws_ses_complaintrecord USING btree (email);


--
-- Name: django_aws_ses_complaintrecord_timestamp_90333dd8; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_aws_ses_complaintrecord_timestamp_90333dd8 ON public.django_aws_ses_complaintrecord USING btree ("timestamp");


--
-- Name: django_aws_ses_sendrecord_destination_7eba4f0a; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_aws_ses_sendrecord_destination_7eba4f0a ON public.django_aws_ses_sendrecord USING btree (destination);


--
-- Name: django_aws_ses_sendrecord_destination_7eba4f0a_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_aws_ses_sendrecord_destination_7eba4f0a_like ON public.django_aws_ses_sendrecord USING btree (destination);


--
-- Name: django_aws_ses_sendrecord_timestamp_5c148248; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_aws_ses_sendrecord_timestamp_5c148248 ON public.django_aws_ses_sendrecord USING btree ("timestamp");


--
-- Name: django_aws_ses_unknownrecord_timestamp_137d6e70; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_aws_ses_unknownrecord_timestamp_137d6e70 ON public.django_aws_ses_unknownrecord USING btree ("timestamp");


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key);


--
-- Name: django_site_domain_a2e37b91_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_site_domain_a2e37b91_like ON public.django_site USING btree (domain);


--
-- Name: payments_payupayment_order_id_3fddcc60; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX payments_payupayment_order_id_3fddcc60 ON public.payments_payupayment USING btree (order_id);


--
-- Name: payments_payupayment_status_b9a294de; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX payments_payupayment_status_b9a294de ON public.payments_payupayment USING btree (status);


--
-- Name: payments_payupayment_status_b9a294de_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX payments_payupayment_status_b9a294de_like ON public.payments_payupayment USING btree (status varchar_pattern_ops);


--
-- Name: payments_payupayment_txnid_5e8d6988_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX payments_payupayment_txnid_5e8d6988_like ON public.payments_payupayment USING btree (txnid varchar_pattern_ops);


--
-- Name: payments_payupayment_user_id_a9f0ef2b; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX payments_payupayment_user_id_a9f0ef2b ON public.payments_payupayment USING btree (user_id);


--
-- Name: token_blacklist_outstandingtoken_jti_hex_d9bdf6f7_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX token_blacklist_outstandingtoken_jti_hex_d9bdf6f7_like ON public.token_blacklist_outstandingtoken USING btree (jti);


--
-- Name: token_blacklist_outstandingtoken_user_id_83bc629a; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX token_blacklist_outstandingtoken_user_id_83bc629a ON public.token_blacklist_outstandingtoken USING btree (user_id);


--
-- Name: unique_email_per_product; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX unique_email_per_product ON public.core_stocknotification USING btree (product_id, email) WHERE (email IS NOT NULL);


--
-- Name: unique_phone_per_product; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX unique_phone_per_product ON public.core_stocknotification USING btree (product_id, phone) WHERE (phone IS NOT NULL);


--
-- Name: core_cartitem core_cartitem_cart_id_5256d769_fk_core_cart_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.core_cartitem
    ADD CONSTRAINT core_cartitem_cart_id_5256d769_fk_core_cart_id FOREIGN KEY (cart_id) REFERENCES public.core_cart(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_cartitem core_cartitem_product_id_2640c4a2_fk_core_product_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.core_cartitem
    ADD CONSTRAINT core_cartitem_product_id_2640c4a2_fk_core_product_id FOREIGN KEY (product_id) REFERENCES public.core_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_cartitem core_cartitem_variant_id_84e67bc6_fk_core_productvariant_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.core_cartitem
    ADD CONSTRAINT core_cartitem_variant_id_84e67bc6_fk_core_productvariant_id FOREIGN KEY (variant_id) REFERENCES public.core_productvariant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_orderitem core_orderitem_variant_id_fc31f244_fk_core_productvariant_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.core_orderitem
    ADD CONSTRAINT core_orderitem_variant_id_fc31f244_fk_core_productvariant_id FOREIGN KEY (variant_id) REFERENCES public.core_productvariant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_productvariant core_productvariant_product_id_79c7de1b_fk_core_product_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.core_productvariant
    ADD CONSTRAINT core_productvariant_product_id_79c7de1b_fk_core_product_id FOREIGN KEY (product_id) REFERENCES public.core_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_stocknotification core_stocknotification_product_id_0c592fcf_fk_core_product_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.core_stocknotification
    ADD CONSTRAINT core_stocknotification_product_id_0c592fcf_fk_core_product_id FOREIGN KEY (product_id) REFERENCES public.core_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_stocknotification core_stocknotification_user_id_4aece4d9_fk_core_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.core_stocknotification
    ADD CONSTRAINT core_stocknotification_user_id_4aece4d9_fk_core_user_id FOREIGN KEY (user_id) REFERENCES public.core_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: payments_payupayment payments_payupayment_order_id_3fddcc60_fk_core_order_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments_payupayment
    ADD CONSTRAINT payments_payupayment_order_id_3fddcc60_fk_core_order_id FOREIGN KEY (order_id) REFERENCES public.core_order(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: payments_payupayment payments_payupayment_user_id_a9f0ef2b_fk_core_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments_payupayment
    ADD CONSTRAINT payments_payupayment_user_id_a9f0ef2b_fk_core_user_id FOREIGN KEY (user_id) REFERENCES public.core_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

\unrestrict 5V3rnyVWSkqs91RTdqLUAYLPGy0LScL9p15gs7Js7ctA13Ze6Ddrmdi0x6W5OMM

