--
-- PostgreSQL database dump
--



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


