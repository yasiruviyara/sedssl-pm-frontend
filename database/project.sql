-- Enums
CREATE TYPE proposer_type_enum AS ENUM ('chapter', 'division');
CREATE TYPE proposal_status_enum AS ENUM ('draft', 'submitted', 'under_review', 'returned', 'approved', 'rejected');
CREATE TYPE project_status_enum AS ENUM ('pending', 'to_do', 'in_progress', 'finalizing', 'completed', 'stopped', 'cancelled');

-- Main Projects Table
CREATE TABLE projects (
  id BIGSERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT,
  timeline_start DATE NOT NULL,
  timeline_end DATE NOT NULL,
  timeline_duration INTERVAL GENERATED ALWAYS AS (timeline_end - timeline_start) STORED,
  budget NUMERIC(15,2),

  proposer_type proposer_type_enum NOT NULL,
  proposer TEXT NOT NULL,
  proposer_submitter BIGINT NOT NULL REFERENCES members(id),
  proposal_status proposal_status_enum DEFAULT 'draft',
  project_status project_status_enum DEFAULT 'pending',
  reject_reasons TEXT[], -- proposal_status = 'rejected'
  return_details TEXT[], -- proposal_status = 'returned'
  
  objectives TEXT[],
  document_links TEXT[],

  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- project Members
CREATE TABLE project_members (
  id BIGSERIAL PRIMARY KEY,
  project_id BIGINT NOT NULL REFERENCES projects(id) ON DELETE CASCADE,
  member_id BIGINT NOT NULL REFERENCES members(id),
  role TEXT NOT NULL,
  is_active BOOLEAN DEFAULT TRUE
);

-- Comments
CREATE TABLE project_comments (
  id BIGSERIAL PRIMARY KEY,
  project_id BIGINT NOT NULL REFERENCES projects(id) ON DELETE CASCADE,
  commenter_id BIGINT REFERENCES members(id),
  comment TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- Feedbacks
CREATE TABLE project_feedbacks (
  id BIGSERIAL PRIMARY KEY,
  project_id BIGINT NOT NULL REFERENCES projects(id) ON DELETE CASCADE,
  feedback TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT now()
);
