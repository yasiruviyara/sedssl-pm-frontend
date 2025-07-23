## 🧾 Members Table

### 🔗 Relationships
- `user_id` references the `auth.users` table and is unique per member.

### 🎯 Fields

| Column            | Type        | Description |
|-------------------|-------------|-------------|
| id                | BIGSERIAL   | Primary key |
| user_id           | UUID        | FK to `auth.users` |
| initials          | TEXT        | Member initials |
| full_name         | TEXT        | Member’s full name |
| phone             | TEXT        | Phone number |
| gender            | TEXT        | 'male', 'female', or 'other' |
| dob               | DATE        | Date of birth |
| cv                | TEXT        | Link of CV |
| avatar            | TEXT        | Profile picture URL |
| avatar_visibility | TEXT        | 'public' or 'private' |
| account_status    | TEXT        | Status of application |
| submitted_at      | TIMESTAMPTZ | When the profile was submitted |
| reviewed_at       | TIMESTAMPTZ | When the profile was reviewed |
| chapter           | TEXT        | Which chapter is the member in  |
| division          | TEXT        | Which division is the member in  |
| role              | TEXT        | 'member', 'chapter-lead', 'division-head',  'board-member', 'admin' |
| position          | TEXT        | Member position (secretary, project manager) |

