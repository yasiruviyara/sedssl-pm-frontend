-- Enums
CREATE TYPE gender_enum AS ENUM ('male', 'female', 'other');
CREATE TYPE account_status_enum AS ENUM ('pending', 'under_review', 'approved', 'rejected');
CREATE TYPE role_enum AS ENUM ('member', 'chapter-lead', 'division-head', 'board-member', 'admin');

CREATE TABLE members (
  id BIGSERIAL PRIMARY KEY,
  user_id UUID UNIQUE NOT NULL REFERENCES auth.users(id),
  initials TEXT NOT NULL,
  full_name TEXT NOT NULL,
  phone TEXT NOT NULL,
  gender gender_enum NOT NULL,
  dob DATE NOT NULL,
  cv TEXT NOT NULL,
  avatar TEXT,
  avatar_visibility TEXT CHECK (avatar_visibility IN ('public', 'private')) DEFAULT 'public',
  account_status account_status_enum DEFAULT 'pending',  
  submitted_at TIMESTAMPTZ DEFAULT now(),
  reviewed_at TIMESTAMPTZ,
  chapter TEXT, -- there is one value in an array
  division TEXT, -- there is one value in an array
  role role_enum DEFAULT 'member',
  position TEXT, -- there is one value in an array
);