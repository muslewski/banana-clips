-- Schema for postgres database

-- Users table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash CHAR(60) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    last_login TIMESTAMP WITH TIME ZONE,
    user_role VARCHAR(20) DEFAULT 'user',
    email_verified BOOLEAN DEFAULT FALSE, 
)

-- User details table
CREATE TABLE user_details (
    user_id INTEGER PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    user_picture_url VARCHAR(255),
    preferred_language VARCHAR(20) DEFAULT 'en',
    preferred_theme VARCHAR(20) DEFAULT 'dark',
    receive_newsletter BOOLEAN DEFAULT FALSE,
)

-- Profiles table
CREATE TABLE profiles (
    id SERIAL PRIMARY KEY,
    profile_name VARCHAR(50),
    profile_description TEXT,
    profile_picture_url VARCHAR(255),
    contact_email VARCHAR(100),
    contact_phone VARCHAR(20),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    currency_code VARCHAR(10) DEFAULT 'USD',
    total_earned DECIMAL(12, 2) DEFAULT 0.00,
)

-- Join table for many-to-many relationship between users and profiles
CREATE TABLE user_profiles (
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    profile_id INTEGER REFERENCES profiles(id) ON DELETE CASCADE,
    PRIMARY KEY (user_id, profile_id)
)

-- Social media accounts table
CREATE TABLE social_media_accounts (
    id SERIAL PRIMARY KEY,
    profile_id INTEGER REFERENCES profiles(id) ON DELETE CASCADE,
    platform_name VARCHAR(50) NOT NULL,
    account_username VARCHAR(100) NOT NULL,
    account_url VARCHAR(255),
    access_token TEXT NOT NULL,
    refresh_token TEXT,
    token_expiry TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
)

-- Projects table
CREATE TABLE projects (
    id SERIAL PRIMARY KEY,
    profile_id INTEGER REFERENCES profiles(id) ON DELETE CASCADE,
    project_name VARCHAR(100) NOT NULL,
    project_description TEXT,
    project_status VARCHAR(20) DEFAULT 'active',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
)

-- Thumbnails table
CREATE TABLE project_thumbnails (
    id SERIAL PRIMARY KEY,
    project_id INTEGER REFERENCES projects(id) ON DELETE CASCADE,
    thumbnail_url TEXT NOT NULL, -- URL of the thumbnail image
    prompt TEXT, -- Prompt used to generate the thumbnail
    ai_model VARCHAR(100), -- AI model used to generate the thumbnail
    metadata JSONB, -- Additional metadata in JSON format
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Video assets table
CREATE TABLE video_assets (
  id SERIAL PRIMARY KEY,
  project_id INTEGER REFERENCES projects(id),
  blob_url TEXT NOT NULL,
  original_filename VARCHAR(255) NOT NULL,
  duration NUMERIC(10, 2)
  start_time NUMERIC(10, 2),
  end_time NUMERIC(10, 2)
);

-- Audio assets table
CREATE TABLE audio_assets (
  id SERIAL PRIMARY KEY,
  project_id INTEGER REFERENCES projects(id),
  blob_url TEXT NOT NULL,
  original_filename VARCHAR(255) NOT NULL,
  duration NUMERIC(10, 2), -- Duration of the audio file
  start_time NUMERIC(10, 2), -- Start time of the edited segment
  end_time NUMERIC(10, 2) -- End time of the edited segment
);


-- Posts table
CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    project_id INTEGER REFERENCES projects(id) ON DELETE CASCADE,
    social_media_account_id INTEGER REFERENCES social_media_accounts(id) ON DELETE SET NULL,
    platform_name VARCHAR(50) REFERENCES social_media_accounts(platform_name),
    post_title VARCHAR(255),
    post_content TEXT NOT NULL,
    post_url TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    scheduled_at TIMESTAMP WITH TIME ZONE,
    published_at TIMESTAMP WITH TIME ZONE
);