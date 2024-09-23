-- Schema for postgres database

CREATE EXTENSION IF NOT EXISTS "uuid-ossp"

-- Users table
CREATE TABLE IF NOT EXISTS users (
    id UUID PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash CHAR(60) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,w
    last_login TIMESTAMP WITH TIME ZONE,
    user_role VARCHAR(20) DEFAULT 'user',
    email_verified BOOLEAN DEFAULT FALSE
)

-- -- User details table
-- CREATE TABLE user_details (
--     user_id UUID PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE,
--     first_name VARCHAR(50),
--     last_name VARCHAR(50),
--     user_picture_url VARCHAR(255),
--     preferred_language VARCHAR(20) DEFAULT 'en',
--     preferred_theme VARCHAR(20) DEFAULT 'dark',
--     receive_newsletter BOOLEAN DEFAULT FALSE
-- )

-- -- Profiles table
-- CREATE TABLE profiles (
--     id UUID PRIMARY KEY,
--     profile_name VARCHAR(50),
--     profile_description TEXT,
--     profile_picture_url VARCHAR(255),
--     contact_email VARCHAR(100),
--     contact_phone VARCHAR(20),
--     created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
--     updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
--     currency_code CHAR(3) DEFAULT 'USD',
--     total_earned NUMERIC(15,2) DEFAULT 0.00
-- )

-- -- Join table for many-to-many relationship between users and profiles
-- CREATE TABLE user_profiles (
--     user_id UUID REFERENCES users(id) ON DELETE CASCADE,
--     profile_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
--     PRIMARY KEY (user_id, profile_id)
-- )

-- -- Social media accounts table
-- CREATE TABLE social_media_accounts (
--     id UUID PRIMARY KEY,
--     profile_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
--     platform_name VARCHAR(50) NOT NULL,
--     account_username VARCHAR(100) NOT NULL,
--     account_url VARCHAR(255),
--     access_token TEXT NOT NULL,
--     refresh_token TEXT,
--     token_expiry TIMESTAMP WITH TIME ZONE,
--     created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
--     updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
-- )

-- -- Projects table
-- CREATE TABLE projects (
--     id UUID PRIMARY KEY,
--     profile_id INTEGER REFERENCES profiles(id) ON DELETE CASCADE,
--     project_name VARCHAR(100) NOT NULL,
--     project_description TEXT,
--     project_status VARCHAR(20) DEFAULT 'active',
--     created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
--     updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
-- )


-- -- Text scripts table
-- CREATE TABLE text_scripts (
--     id UUID PRIMARY KEY,
--     project_id INTEGER REFERENCES projects(id) ON DELETE CASCADE,
--     script_name VARCHAR(100) NOT NULL,
--     script_content TEXT NOT NULL,
--     language VARCHAR(50) DEFAULT 'en'
--     version INTEGER DEFAULT 1, 
--     created_by INTEGER REFERENCES users(id), -- User who created the script
--     updated_by INTEGER REFERENCES users(id), -- User who last updated the script
--     created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
--     updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
-- )


-- -- Video assets table
-- CREATE TABLE video_assets (
--   id UUID PRIMARY KEY,
--   project_id INTEGER REFERENCES projects(id) ON DELETE CASCADE,
--   blob_url TEXT NOT NULL,
--   original_filename VARCHAR(255) NOT NULL,
--   duration NUMERIC(10, 2)
--   start_time NUMERIC(10, 2),
--   end_time NUMERIC(10, 2)
-- );

-- -- Audio assets table
-- CREATE TABLE audio_assets (
--   id UUID PRIMARY KEY,
--   project_id INTEGER REFERENCES projects(id) ON DELETE CASCADE,
--   blob_url TEXT NOT NULL,
--   original_filename VARCHAR(255) NOT NULL,
--   duration NUMERIC(10, 2), -- Duration of the audio file
--   start_time NUMERIC(10, 2), -- Start time of the edited segment
--   end_time NUMERIC(10, 2) -- End time of the edited segment
-- );


-- -- Posts table
-- CREATE TABLE posts (
--     id UUID PRIMARY KEY,
--     project_id INTEGER REFERENCES projects(id) ON DELETE CASCADE,
--     social_media_account_id INTEGER REFERENCES social_media_accounts(id) ON DELETE SET NULL,
--     post_title VARCHAR(255),
--     post_content TEXT NOT NULL,
--     post_url TEXT,
--     created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
--     updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
--     scheduled_at TIMESTAMP WITH TIME ZONE,
--     published_at TIMESTAMP WITH TIME ZONE
-- );

-- -- Thumbnails table
-- CREATE TABLE project_thumbnails (
--     id UUID PRIMARY KEY,
--     project_id INTEGER REFERENCES projects(id) ON DELETE CASCADE,
--     thumbnail_url TEXT NOT NULL, -- URL of the thumbnail image
--     prompt TEXT, -- Prompt used to generate the thumbnail
--     ai_model VARCHAR(100), -- AI model used to generate the thumbnail
--     metadata JSONB, -- Additional metadata in JSON format
--     created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
-- );