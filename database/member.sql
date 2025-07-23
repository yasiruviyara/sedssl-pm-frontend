CREATE TABLE members (
  id BIGSERIAL PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) UNIQUE NOT NULL,
  initials TEXT NOT NULL,
  full_name TEXT NOT NULL,
  phone TEXT NOT NULL,
  gender TEXT CHECK (gender IN ('male', 'female', 'other')) NOT NULL,
  dob DATE NOT NULL,
  cv TEXT NOT NULL,
  avatar TEXT,
  avatar_visibility TEXT CHECK (
    avatar_visibility IN ('public', 'private')
  ) DEFAULT 'public',
  account_status DEFAULT 'pending' CHECK (
    account_status IN ('pending', 'under_review', 'approved', 'rejected')
  ),  
  submitted_at TIMESTAMPTZ DEFAULT now(),
  reviewed_at TIMESTAMPTZ,
  chapter TEXT, -- there is one value in an array
  division TEXT, -- there is one value in an array
  role TEXT CHECK (
    role IN ('member', 'chapter-lead', 'division-head', 'board-member', 'admin')
  ) DEFAULT 'member',
  position TEXT, -- there is one value in an array
);